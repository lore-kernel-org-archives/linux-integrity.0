Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35527 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdKTTid (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 14:38:33 -0500
Received: by mail-wm0-f47.google.com with SMTP id y80so20974883wmd.0
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 11:38:32 -0800 (PST)
Date: Mon, 20 Nov 2017 12:38:29 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120193829.GM29075@ziepe.ca>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 07:34:07PM +0000, Shaikh, Azhar wrote:

> >However, why not have check_locality, release_locality, wait_startup use
> >clk_toggle instead? That seems better to me??
> >
> 
> I think, better to have the clk disable/enable at one place instead
> of adding it all locations where TPM access is done. The clk_toggle
> is kind of a special case where, for the complete duration of the
> TPM command processing, the CLKRUN protocol was supposed to be
> disabled. For rest of the places we can disable and re-enable the
> clkrun as soon as possible.

> Also since it is part of the read/write APIs we won't miss any other
> location in the code where TPM access is done.

But I wonder if you will hit the same bug that motivated this change
in the other places?

It seems clearer to me to have a strong guard of the clock across the
entire high level action, since this hardware is so broken.

You could add a debug to ensure that read/write is never without
clk_enable being held.

Jason
