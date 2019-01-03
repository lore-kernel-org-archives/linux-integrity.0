Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C52EC43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE58206C0
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 12:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfACM7I (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:59:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:58407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfACM7I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 07:59:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 04:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="135008677"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.238])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2019 04:59:05 -0800
Date:   Thu, 3 Jan 2019 14:59:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Message-ID: <20190103125904.GA10491@linux.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546280851.3079.2.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 31, 2018 at 10:27:31AM -0800, James Bottomley wrote:
> Ever since 627448e85c766 "tpm: separate cmd_ready/go_idle from
> runtime_pm" we have been returning success from tpm_try_transmit()
> even if an error occurred.  The reason is that the introduction of rc
> = tpm_go_idle() at the end of processing overwrites the value of rc if
> it contains an error code (mostly with success).  Fix this by writing
> the return to a new variable rc1 instead.
> 
> Fixes: 627448e85c766 "tpm: separate cmd_ready/go_idle from runtime_pm"
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> Note: the goto out looks fishy as well.  The only go_idle implementor
> is tpm_crb and that can return a timeout as -ETIME, so it looks like it
> would then loop forever
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 129f640424b7..ac7ebab6140c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -432,7 +432,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  				unsigned int flags)
>  {
>  	struct tpm_output_header *header = (void *)buf;
> -	int rc;
> +	int rc, rc1;
>  	ssize_t len = 0;
>  	u32 count, ordinal;
>  	unsigned long stop;
> @@ -547,8 +547,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
>  
>  out:
> -	rc = tpm_go_idle(chip, flags);
> -	if (rc)
> +	rc1 = tpm_go_idle(chip, flags);
> +	if (rc1)
>  		goto out;
>  
>  	if (need_locality)

Thanks James and sorry for latency (holiday season). Just a small
suggestion. I would just:

if (tpm_go_idle(chip, flags))
	goto out;

What do you think?

/Jarkko
