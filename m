Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932940AbeFUUxv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 16:53:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LKnNvV137839
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 16:53:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrjqpsjfk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 16:53:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 21:53:49 +0100
Subject: Re: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM
 functions using it
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org
Date: Thu, 21 Jun 2018 16:53:45 -0400
In-Reply-To: <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
         <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1529614425.23843.20.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-06-20 at 16:42 -0400, Stefan Berger wrote:
> Rather than accessing the TPM functions using a NULL pointer, which
> causes a lookup for a suitable chip every time, get a hold of a tpm_chip
> and access the TPM functions using this chip. We call the tpm_chip
> ima_tpm_chip and protect it, once initialization is done, using a
> rw_semaphore called ima_tpm_chip_lock.
> 
> Use ima_shutdown to release the tpm_chip.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima.h        |  3 +++
>  security/integrity/ima/ima_crypto.c | 12 ++++++++++--
>  security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
>  security/integrity/ima/ima_queue.c  |  7 +++++--
>  4 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 354bb5716ce3..53a88d578ca5 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -24,6 +24,7 @@
>  #include <linux/hash.h>
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
> +#include <linux/rwsem.h>
>  #include <crypto/hash_info.h>
> 
>  #include "../integrity.h"
> @@ -56,6 +57,8 @@ extern int ima_policy_flag;
>  extern int ima_used_chip;
>  extern int ima_hash_algo;
>  extern int ima_appraise;
> +extern struct rw_semaphore ima_tpm_chip_lock;
> +extern struct tpm_chip *ima_tpm_chip;


ima_add_templatE_entry() synchronizes appending a measurement to the
measurement list and extending the TPM by taking a lock.  Do we really
need to introduce another lock?

Mimi

> 
>  /* IMA event related data */
>  struct ima_event_data {
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 4e085a17124f..da7715240476 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -631,10 +631,18 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
> 
>  static void __init ima_pcrread(int idx, u8 *pcr)
>  {
> +	int result = 0;
> +
> +	down_read(&ima_tpm_chip_lock);
> +
>  	if (!ima_used_chip)
> -		return;
> +		goto out;
> +
> +	result = tpm_pcr_read(ima_tpm_chip, idx, pcr);
> +out:
> +	up_read(&ima_tpm_chip_lock);
> 
> -	if (tpm_pcr_read(NULL, idx, pcr) != 0)
> +	if (result != 0)
>  		pr_err("Error Communicating to TPM chip\n");
>  }
> 
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 8a5258eb32b6..24db06c4f463 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -28,6 +28,8 @@
>  /* name for boot aggregate entry */
>  static const char *boot_aggregate_name = "boot_aggregate";
>  int ima_used_chip;
> +struct rw_semaphore ima_tpm_chip_lock = __RWSEM_INITIALIZER(ima_tpm_chip_lock);
> +struct tpm_chip *ima_tpm_chip;
> 
>  /* Add the boot aggregate to the IMA measurement list and extend
>   * the PCR register.
> @@ -108,6 +110,13 @@ void __init ima_load_x509(void)
>  static int ima_shutdown(struct notifier_block *this, unsigned long action,
>  			void *data)
>  {
> +	down_write(&ima_tpm_chip_lock);
> +	if (ima_tpm_chip) {
> +		tpm_chip_put(ima_tpm_chip);
> +		ima_tpm_chip = NULL;
> +		ima_used_chip = 0;
> +	}
> +	up_write(&ima_tpm_chip_lock);
>  	return NOTIFY_DONE;
>  }
> 
> @@ -118,19 +127,15 @@ static struct notifier_block ima_reboot_notifier = {
> 
>  int __init ima_init(void)
>  {
> -	u8 pcr_i[TPM_DIGEST_SIZE];
>  	int rc;
> 
>  	register_reboot_notifier(&ima_reboot_notifier);
> 
> -	ima_used_chip = 0;
> -	rc = tpm_pcr_read(NULL, 0, pcr_i);
> -	if (rc == 0)
> -		ima_used_chip = 1;
> +	ima_tpm_chip = tpm_chip_find();
> 
> +	ima_used_chip = (ima_tpm_chip != NULL);
>  	if (!ima_used_chip)
> -		pr_info("No TPM chip found, activating TPM-bypass! (rc=%d)\n",
> -			rc);
> +		pr_info("No TPM chip found, activating TPM-bypass!\n");
> 
>  	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
>  	if (rc)
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 418f35e38015..6c9427939a28 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -142,10 +142,13 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
>  {
>  	int result = 0;
> 
> +	down_read(&ima_tpm_chip_lock);
>  	if (!ima_used_chip)
> -		return result;
> +		goto out;
> 
> -	result = tpm_pcr_extend(NULL, pcr, hash);
> +	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
> +out:
> +	up_read(&ima_tpm_chip_lock);
>  	if (result != 0)
>  		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>  	return result;
