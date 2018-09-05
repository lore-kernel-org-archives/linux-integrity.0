Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbeIERqW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 13:46:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85DEFuv039375
        for <linux-integrity@vger.kernel.org>; Wed, 5 Sep 2018 09:16:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maf6m262d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 05 Sep 2018 09:16:06 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 09:16:06 -0400
Subject: Re: [PATCH] tpm: fix response size validation in tpm_get_random()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 5 Sep 2018 09:16:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b3fdb8d4-0e50-389b-86e1-d74761ca325e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 09/02/2018 09:10 PM, Jarkko Sakkinen wrote:
> When checking whether the response is large enough to be able to contain
> the received random bytes in tpm_get_random() and tpm2_get_random(),
> they fail to take account the header size, which should be added to the
> minimum size. This commit fixes this issue.
>
> Cc: stable@vger.kernel.org
> Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-interface.c | 3 ++-
>   drivers/char/tpm/tpm2-cmd.c      | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..318a7078b2ba 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1321,7 +1321,8 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>   		}
>
>   		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> -		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> +		if (rlength < TPM_HEADER_SIZE +
> +			      offsetof(struct tpm_getrandom_out, rng_data) +
>   			      recd) {
>   			total = -EFAULT;
>   			break;
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c31b490bd41d..3acf4fd4e5a5 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -329,7 +329,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>   			&buf.data[TPM_HEADER_SIZE];
>   		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
>   		if (tpm_buf_length(&buf) <
> -		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
> +		    TPM_HEADER_SIZE +
> +		    offsetof(struct tpm2_get_random_out, buffer) +
> +		    recd) {
>   			err = -EFAULT;
>   			goto out;
>   		}

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
