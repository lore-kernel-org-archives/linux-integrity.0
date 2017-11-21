Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdKUU3J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 15:29:09 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Date: Tue, 21 Nov 2017 20:29:07 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
In-Reply-To: <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, November 21, 2017 4:30 AM
> To: Javier Martinez Canillas <javierm@redhat.com>
> Cc: linux-kernel@vger.kernel.org; Peter Huewe <peterhuewe@gmx.de>; Tricca,
> Philip B <philip.b.tricca@intel.com>; Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com>; linux-integrity@vger.kernel.org; Roberts,
> William C <william.c.roberts@intel.com>
> Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
> fails
> 
> On Tue, Nov 21, 2017 at 10:07:34AM +0100, Javier Martinez Canillas wrote:
> > As mentioned, I think this should be documented. I guess most people
> > would see the in-kernel resource manager as a virtualized TPM, since
> > the "TSS TAB and Resource Manager Specification" [0] explains the RM
> > making an analogy with a virtual memory manager:
> >
> > "The Resource Manager (RM) manages the TPM context in a manner similar
> > to a virtual memory manager. It swaps objects, sessions, and sequences
> > in and out of the limited TPM memory as needed."
> 
> A process in virtual memory has a different environment than code running on
> bare metal without page table, doesn't it?
> 
> > And even your latest LPC presentation mention that the handles in the
> > in-kernel resource manager are virtualized [1].
> >
> > And I disagree that it does not matter, since the same spec says:
> >
> > "This layer is mostly transparent to the upper layers of the TSS and
> > is not required."
> >
> > But returning -EINVAL instead of a proper TPM command response with a
> > TPM_RC_COMMAND_CODE code makes it not transparent to the upper layer.
> 
> *mostly*
> 
> > If the TPM spaces infrastructure is not compliant with the spec, then
> > I think that should also be documented.
> 
> TPM specification is not a formal specification AFAIK.

The published parts are, granted many things are changing.

> 
> > > matters less than breaking the sandbox.
> > >
> >
> > Yes, sorry for that. It wasn't clear to me that there was a sandbox
> > and my lack of familiarity with the code was the reason why I posted
> > as a RFC in the first place.
> >
> > Do you agree with Jason's suggestion to send a synthesized TPM command
> > in the that the command isn't supported?
> 
> Nope.

We should update the elf loader to make sure that ELF files don't contain
Incorrect instructions. We shouldn't have this type of policy in the driver
considering that the tpm is designed to handle it. Obviously you disagree,
just understand you're wrong :-P

> 
> /Jarkko
