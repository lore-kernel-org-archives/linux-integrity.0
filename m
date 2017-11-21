Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7634 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdKUMaJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 07:30:09 -0500
Date: Tue, 21 Nov 2017 14:30:06 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 10:07:34AM +0100, Javier Martinez Canillas wrote:
> As mentioned, I think this should be documented. I guess most people
> would see the in-kernel resource manager as a virtualized TPM, since
> the "TSS TAB and Resource Manager Specification" [0] explains the RM
> making an analogy with a virtual memory manager: 
> 
> "The Resource Manager (RM) manages the TPM context in a manner similar
> to a virtual memory manager. It swaps objects, sessions, and sequences
> in and out of the limited TPM memory as needed."

A process in virtual memory has a different environment than code
running on bare metal without page table, doesn't it?

> And even your latest LPC presentation mention that the handles in the
> in-kernel resource manager are virtualized [1].
> 
> And I disagree that it does not matter, since the same spec says:
> 
> "This layer is mostly transparent to the upper layers of the TSS and is
> not required."
> 
> But returning -EINVAL instead of a proper TPM command response with a
> TPM_RC_COMMAND_CODE code makes it not transparent to the upper layer.

*mostly*

> If the TPM spaces infrastructure is not compliant with the spec, then I
> think that should also be documented.

TPM specification is not a formal specification AFAIK.

> > matters less than breaking the sandbox.
> >
> 
> Yes, sorry for that. It wasn't clear to me that there was a sandbox and my
> lack of familiarity with the code was the reason why I posted as a RFC in
> the first place.
> 
> Do you agree with Jason's suggestion to send a synthesized TPM command in
> the that the command isn't supported?

Nope.

/Jarkko
