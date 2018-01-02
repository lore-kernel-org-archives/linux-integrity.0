Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:42223 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeABO5l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 09:57:41 -0500
Received: by mail-wm0-f43.google.com with SMTP id b141so15002049wme.1
        for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2018 06:57:40 -0800 (PST)
Date: Tue, 2 Jan 2018 07:57:35 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] tpm_tis: Move ilb_base_addr to tpm_tis_data
Message-ID: <20180102145735.GB29208@ziepe.ca>
References: <1514865944-95086-1-git-send-email-azhar.shaikh@intel.com>
 <1514865944-95086-2-git-send-email-azhar.shaikh@intel.com>
 <20180102044044.GA29208@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582898A03C@ORSMSX109.amr.corp.intel.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582898A05E@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582898A05E@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 02, 2018 at 05:31:30AM +0000, Shaikh, Azhar wrote:
> >>On Mon, Jan 01, 2018 at 08:05:43PM -0800, Azhar Shaikh wrote:
> >>
> >>> -	return tpm_chip_register(chip);
> >>> +	rc = tpm_chip_register(chip);
> >>> +	if (rc && is_bsw())
> >>> +		iounmap(priv->ilb_base_addr);
> >>> +
> >>> +	return rc;
> >>>  out_err:
> >>>  	tpm_tis_remove(chip);
> >>> +	if (is_bsw())
> >>> +		iounmap(priv->ilb_base_addr);
> >>> +
> >>>  	return rc;
> >>>  }
> >>
> >>I thought you were resending this to fix the above, why is is it still wonky?
> >>
> >
> >Oh! I fixed it in the second patch ("tpm: Keep CLKRUN enabled throughout
> >the duration of transmit_cmd()"). Should have fixed in this patch instead. My
> >bad, didn't see it was introduced in this patch. I thought it was part of second
> >patch. Will fix this.
> >
> 
> On checking, the ops->clk_enable is not still introduced yet. It is introduced in the second patch. The cleanup is done in the next patch.
> So do you want me to still fix this here?

Try hard to not edit your own patches in your series. No reason why
iounmap cannot be put into tpm_tis_remove in the first place

Jason
