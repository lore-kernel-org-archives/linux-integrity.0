Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38797 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdKTSer (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 13:34:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id z75so7635557wrc.5
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 10:34:46 -0800 (PST)
Date: Mon, 20 Nov 2017 11:34:41 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120183441.GC29075@ziepe.ca>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 15, 2017 at 02:07:11PM -0800, Azhar Shaikh wrote:

> -static void tpm_platform_begin_xfer(void)
> +static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
>  {
>  	u32 clkrun_val;
> +	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
>  
> -	if (!is_bsw())
> +	if (!is_bsw() || ((data->flags & TPM_TIS_CLK_ENABLE) &&
> +					phy->begin_xfer_done))
>  		return;

I think everything looks OK now, but I was reading over the series
again, and I admit I don't quite get it..

Why do we continue to have tpm_platform_begin_xfer after you added
clk_toggle?

Why not just directly enable CLK_RUN in clk_toggle and get rid of
tpm_platform_begin_xfer/etc ??

Is there some reason we still need to to per transfer stuff???

clk_enable or device_enable would also be a better name than
clock_toggle.

Jason
