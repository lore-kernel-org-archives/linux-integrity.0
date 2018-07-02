Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752174AbeGBPMC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 11:12:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FAk1s104061
        for <linux-integrity@vger.kernel.org>; Mon, 2 Jul 2018 11:12:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jym8fp2vv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 11:12:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 16:11:59 +0100
Subject: Re: [PATCH v7 5/5] ima: Get rid of ima_used_chip and use
 ima_tpm_chip != NULL instead
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 02 Jul 2018 11:11:44 -0400
In-Reply-To: <20180626190933.2508821-6-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
         <20180626190933.2508821-6-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530544304.3709.40.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Stefan,

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> Get rid of ima_used_chip and use ima_tpm_chip variable instead for
> determining whether to use the TPM chip.

I don't see a need for separating this change from the previous patch.
Could you squash this patch with the previous one?

As Jarkko has already queued the TPM patches, there's no need for
posting them.  Posting just this one IMA patch is fine.

thanks!

Mimi

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  security/integrity/ima/ima.h        | 1 -
>  security/integrity/ima/ima_crypto.c | 2 +-
>  security/integrity/ima/ima_init.c   | 7 ++-----
>  security/integrity/ima/ima_queue.c  | 2 +-
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 35409461a3f2..2ab1affffa36 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -53,7 +53,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
>  extern int ima_policy_flag;
> 
>  /* set during initialization */
> -extern int ima_used_chip;
>  extern int ima_hash_algo;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 88082f35adb2..7e7e7e7c250a 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -631,7 +631,7 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
> 
>  static void __init ima_pcrread(int idx, u8 *pcr)
>  {
> -	if (!ima_used_chip)
> +	if (!ima_tpm_chip)
>  		return;
> 
>  	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 1437ed3dbccc..faac9ecaa0ae 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -26,7 +26,6 @@
> 
>  /* name for boot aggregate entry */
>  static const char *boot_aggregate_name = "boot_aggregate";
> -int ima_used_chip;
>  struct tpm_chip *ima_tpm_chip;
> 
>  /* Add the boot aggregate to the IMA measurement list and extend
> @@ -65,7 +64,7 @@ static int __init ima_add_boot_aggregate(void)
>  	iint->ima_hash->algo = HASH_ALGO_SHA1;
>  	iint->ima_hash->length = SHA1_DIGEST_SIZE;
> 
> -	if (ima_used_chip) {
> +	if (ima_tpm_chip) {
>  		result = ima_calc_boot_aggregate(&hash.hdr);
>  		if (result < 0) {
>  			audit_cause = "hashing_error";
> @@ -110,9 +109,7 @@ int __init ima_init(void)
>  	int rc;
> 
>  	ima_tpm_chip = tpm_default_chip();
> -
> -	ima_used_chip = ima_tpm_chip != NULL;
> -	if (!ima_used_chip)
> +	if (!ima_tpm_chip)
>  		pr_info("No TPM chip found, activating TPM-bypass!\n");
> 
>  	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index c6303fa19a49..b186819bd5aa 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -142,7 +142,7 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
>  {
>  	int result = 0;
> 
> -	if (!ima_used_chip)
> +	if (!ima_tpm_chip)
>  		return result;
> 
>  	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
