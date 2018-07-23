Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbeGWW7i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 18:59:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so2149120wrp.0
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jul 2018 14:56:24 -0700 (PDT)
Date: Mon, 23 Jul 2018 15:56:20 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723215620.GH532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jul 23, 2018 at 02:38:08PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 02:13 PM, James Bottomley wrote:
> > The current patch does, you even provided a use case in your last email
> >  (it's do command to get sizing followed by do command with correctly
> > sized buffer). 
> 
> The example I provided was: #1 send a command, #2 read the response header
> (10 bytes), get the actual response size from the header and then #3 read
> the full response (response size - size of the header bytes).

The proposed patch doesn't clear the data_pending if the entire buffer
is not consumed, so of course it is ABI breaking, that really isn't OK.

> > However, if you tie it to O_NONBLOCK, it won't because no-one currently
> > opens the TPM device non blocking so it's an ABI conformant
> > discriminator of the uses.  Tying to O_NONBLOCK should be simple
> > because it's in file->f_flags.
> 
> I think that it might be an option. Especially that I have this on top of
> the async patch. Let's discuss this when Jarkko is back.

Maybe you could do this by requiring the userspace to call pread()
with a non-zero offset to get the trailing segment of the last
executed command and leave normal read/pread(off=0) with the semantics
as they have today.

Jason
