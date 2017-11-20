Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:45133 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdKTX0I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:26:08 -0500
Received: by mail-wm0-f51.google.com with SMTP id 9so21879823wme.4
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 15:26:08 -0800 (PST)
Date: Mon, 20 Nov 2017 16:26:04 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120232604.GS29075@ziepe.ca>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
 <20171120193829.GM29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896EA2E@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582896EA2E@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 09:19:37PM +0000, Shaikh, Azhar wrote:

> -> tpm_tis_core_init()

Yes, and IIRC, this covers tpm_tis_update_timeouts() too?

> -> tpm_tis_plat_remove()

This should be in tpm_tis_remove and a little rework would be needed
here

> -> tpm_tis_reenable_interrupts()
> -> tpm_transmit_cmd() [ Already implemented in this patch ]

Yes

> >You could add a debug to ensure that read/write is never without clk_enable
> >being held.
> 
> Sorry, but I didn't get this, adding a debug part.

Just check a flag in the read/write functions to see if clkrun is on
and WARN if not

Not sure if this is going to be overall better than what you have or
not.. But considering the nature of the bug it seems safer to have a
wider range when CLKRUN is working?

Jason
