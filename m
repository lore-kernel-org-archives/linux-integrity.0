Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:44764 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdKFWjf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 17:39:35 -0500
Received: by mail-it0-f66.google.com with SMTP id n195so4987740itg.1
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2017 14:39:35 -0800 (PST)
Date: Mon, 6 Nov 2017 15:39:32 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration of
 transmit_cmd()
Message-ID: <20171106223932.GA21466@ziepe.ca>
References: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
 <20171106170741.GH26011@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896ADAB@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582896ADAB@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 06, 2017 at 10:11:39PM +0000, Shaikh, Azhar wrote:

> >Why are you using a mixture of callbacks and linked functions to
> >solve this problem?
> >
> >Can't you do everything with callbacks?
> >
> 
> I have set the flag TPM_TIS_CLK_ENABLE in the callback. But then in
> tpm_platform_begin_xfer() I want it to run once to disable clkrun
> and then return for all other instances, till the the flag is
> cleared.  If I just set the flag in tpm_tis_clkrun_toggle(), then
> for any TPM transaction after that the clkrun will not be disabled
> with current implementation. Hence calling it once before setting
> the flag so that it is kept enabled for the next transaction.

I mean, why do we have global functions called tpm_platform_begin_xfer
at all, everything should be in a callback, not some mixture.

The static function sort of made sense when it was only ever called by
the tis driver, but now that you are hoisting things up a layer it is
not okay anymore, you need to add new driver callbacks instead.

> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -140,6 +140,7 @@ static int check_acpi_tpm2(struct device *dev)
>  #define LPC_CLKRUN_EN                   (1 << 2)
> 
>  static void __iomem *ilb_base_addr;
> +static bool run_once;

No global statics. The ilb_base_addr global is really ugly you should
move it to struct tpm_tis_tcg_phy

Jason
