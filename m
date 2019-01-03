Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABAC43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4086C20815
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfACNGD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:06:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:65333 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfACNGD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 08:06:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 05:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="307162309"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.238])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2019 05:06:00 -0800
Date:   Thu, 3 Jan 2019 15:05:58 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH REVIEW 1/2] tpm: provide a way to override the chip
 returned durations
Message-ID: <20190103130558.GB10491@linux.intel.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214132115.26223-1-aklimov@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 14, 2018 at 01:21:14PM +0000, Alexey Klimov wrote:
> Patch adds method ->update_durations to override returned
> durations in case TPM chip misbehaves for TPM 1.2 drivers.
> 
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 18 ++++++++++++++++++
>  include/linux/tpm.h              |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 129f640424b7..5cb90918938d 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -768,6 +768,7 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  {
>  	cap_t cap;
>  	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
> +	unsigned long durations[3];
>  	ssize_t rc;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
> @@ -877,6 +878,23 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
>  	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
>  
> +	/*
> +	 * Provide ability for vendor overrides of duration values in case
> +	 * of misreporting.
> +	 */
> +	if (chip->ops->update_durations != NULL)
> +		chip->duration_adjusted =
> +			chip->ops->update_durations(chip, durations);
> +
> +	/* Report and set adjusted timeouts */
> +	if (chip->duration_adjusted) {
> +

Can you remove the extra newline?

> +		dev_info(&chip->dev, HW_ERR "Adjusting reported durations\n");
> +		chip->duration[TPM_SHORT] = durations[0];
> +		chip->duration[TPM_MEDIUM] = durations[1];
> +		chip->duration[TPM_LONG] = durations[2];
> +	}
> +
>  	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
>  	 * value wrong and apparently reports msecs rather than usecs. So we
>  	 * fix up the resulting too-small TPM_SHORT value to make things work.
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4609b94142d4..d6018431b478 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -43,6 +43,8 @@ struct tpm_class_ops {
>  	u8 (*status) (struct tpm_chip *chip);
>  	bool (*update_timeouts)(struct tpm_chip *chip,
>  				unsigned long *timeout_cap);
> +	bool (*update_durations)(struct tpm_chip *chip,
> +				unsigned long *durations_cap);
>  	int (*go_idle)(struct tpm_chip *chip);
>  	int (*cmd_ready)(struct tpm_chip *chip);
>  	int (*request_locality)(struct tpm_chip *chip, int loc);
> -- 
> 2.14.4
> 

/Jarkko
