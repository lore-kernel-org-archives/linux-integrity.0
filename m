Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752536AbeGAU2r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Jul 2018 16:28:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w61KSj7m121241
        for <linux-integrity@vger.kernel.org>; Sun, 1 Jul 2018 16:28:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jxq3h35n3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 01 Jul 2018 16:28:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 1 Jul 2018 21:28:41 +0100
Subject: Re: [PATCH] ima-evm-utils: check the return code from
 tpm_pcr_read() in ima_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: George Wilson <gcwilson@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 01 Jul 2018 16:28:27 -0400
In-Reply-To: <20180626162718.4916-1-gcwilson@linux.ibm.com>
References: <20180626162718.4916-1-gcwilson@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530476907.3388.17.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi George,

On Tue, 2018-06-26 at 10:27 -0600, George Wilson wrote:
> Don't log garbage when neither /sys/class/tpm/tpm0/device/pcrs nor
> /sys/class/misc/tpm0/device/pcrs can be read and exit nicely with a
> value of 1.
> 
> Signed-off-by: George Wilson <gcwilson@linux.ibm.com>

Thanks, this patch has been pushed to master.

Mimi

> ---
>  src/evmctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2ffee78..a5c6221 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1514,7 +1514,8 @@ static int ima_measurement(const char *file)
>  		log_info("PCRAgg %.2d: ", i);
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> 
> -		tpm_pcr_read(i, hwpcr, sizeof(hwpcr));
> +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> +			exit(1);
>  		log_info("HW PCR-%d: ", i);
>  		log_dump(hwpcr, sizeof(hwpcr));
> 
