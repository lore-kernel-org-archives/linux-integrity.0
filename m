Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbdKTXTY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:19:24 -0500
Date: Tue, 21 Nov 2017 01:19:20 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120231920.hewcmv2h76rqltes@linux.intel.com>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 06:52:13PM +0000, Shaikh, Azhar wrote:
> 
> 
> >-----Original Message-----
> >From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> >Sent: Monday, November 20, 2017 10:35 AM
> >To: Shaikh, Azhar <azhar.shaikh@intel.com>
> >Cc: jarkko.sakkinen@linux.intel.com; peterhuewe@gmx.de; linux-
> >integrity@vger.kernel.org
> >Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
> >duration of transmit_cmd()
> >
> >On Wed, Nov 15, 2017 at 02:07:11PM -0800, Azhar Shaikh wrote:
> >
> >> -static void tpm_platform_begin_xfer(void)
> >> +static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
> >>  {
> >>  	u32 clkrun_val;
> >> +	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> >>
> >> -	if (!is_bsw())
> >> +	if (!is_bsw() || ((data->flags & TPM_TIS_CLK_ENABLE) &&
> >> +					phy->begin_xfer_done))
> >>  		return;
> >
> >I think everything looks OK now, but I was reading over the series again, and I
> >admit I don't quite get it..
> >
> >Why do we continue to have tpm_platform_begin_xfer after you added
> >clk_toggle?
> >
> 
> We want to have the CLKRUN disabled for any/all TPM transactions.
> The clk_toggle handles only the case while a TPM command is being sent and received.
> We have to take into consideration other places too where TPM access is happening outside the TPM command flow. For eg: request_locality, check_locality, release_locality, wait_startup which might be called outside the flow of a TPM command.
> 
> >Why not just directly enable CLK_RUN in clk_toggle and get rid of
> >tpm_platform_begin_xfer/etc ??
> >
> >Is there some reason we still need to to per transfer stuff???
> >
> >clk_enable or device_enable would also be a better name than clock_toggle.
> >
> 
> Will change it to clk_enable.
> Should I then upload the next patch for review and remove the "RFC" tag now? And if so, should I retain the change history of the patch versions?

Please do and keep my reviewed-by.

/Jarkko
