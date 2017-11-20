Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:40070 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdKTTVV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 14:21:21 -0500
Received: by mail-wr0-f173.google.com with SMTP id s41so3659081wrc.7
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 11:21:21 -0800 (PST)
Date: Mon, 20 Nov 2017 12:21:17 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171120192117.GJ29075@ziepe.ca>
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

> We want to have the CLKRUN disabled for any/all TPM transactions.
> The clk_toggle handles only the case while a TPM command is being
> sent and received.  We have to take into consideration other places
> too where TPM access is happening outside the TPM command flow. For
> eg: request_locality, check_locality, release_locality, wait_startup
> which might be called outside the flow of a TPM command.

Okay, this makes sense, and would be good to touch on in the commit
description if it stays this way, IMHO.

However, why not have check_locality, release_locality, wait_startup
use clk_toggle instead? That seems better to me??

> Will change it to clk_enable.  Should I then upload the next patch
> for review and remove the "RFC" tag now? And if so, should I retain
> the change history of the patch versions?

Yes for both.

I think we are well past the RFC stage now :)

Jason
