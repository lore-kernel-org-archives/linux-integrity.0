Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24321 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbdKZOGw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 09:06:52 -0500
Date: Sun, 26 Nov 2017 16:06:46 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 08:29:07PM +0000, Roberts, William C wrote:
> > TPM specification is not a formal specification AFAIK.
> 
> The published parts are, granted many things are changing.

Yes, how it defines the protocol, you are correct. It does not have a
formal definition of RM behavior or at least I haven't found it.

> > > Yes, sorry for that. It wasn't clear to me that there was a sandbox
> > > and my lack of familiarity with the code was the reason why I posted
> > > as a RFC in the first place.
> > >
> > > Do you agree with Jason's suggestion to send a synthesized TPM command
> > > in the that the command isn't supported?
> > 
> > Nope.
> 
> We should update the elf loader to make sure that ELF files don't contain
> Incorrect instructions. We shouldn't have this type of policy in the driver
> considering that the tpm is designed to handle it. Obviously you disagree,
> just understand you're wrong :-P

I think -EINVAL is better than synthetizing commands that are not really
from the TPM. And we would break backwards compatability by doing this.

As I said in an earlier response I would rather compare resource
manager to virtual memory than virtual machine.

/Jarkko
