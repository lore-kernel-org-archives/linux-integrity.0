Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32464 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbdLQQrm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Dec 2017 11:47:42 -0500
Date: Sun, 17 Dec 2017 18:47:38 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Ken Goldman <kgold@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171217164738.agn3bfcc2huv3mdb@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
 <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
 <425a45d4-7d44-333e-0d7f-21a931c9d81d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <425a45d4-7d44-333e-0d7f-21a931c9d81d@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Ken, Javier,

Here's my counterpart to you :-) Sorry for the delay. I'm quite busy
upstreaming SGX ATM.

> I agree with you. As I said in this thread, I don't understand the security
> implications that Jason says. The patch in $SUBJECT just avoids all the TPM
> spaces code paths and sends the command that user-space passed to the kernel
> to the real TPM2 hardware as it would do when writing to /dev/tpm? directly.
> 
> The kernel should provide mechanism and not policy in my opinion, so it should
> be up to user-space to decide what programs are allowed to access the chardevs
> or not. In any case, I'm also OK with the solution that was suggested and was
> merged.

I would say kernel should keep the amount of policy minimal. Your
statement is a "textbook definition" what kernel should do. Sandbox
always requires some policy.

We do not have TPMA_CC entry for unknown command so we don't know how it
might change the TPM state so obviously we must block such command and
not let it through. There is no other option when doing an RM
implementation.

If we ignore security implications, it can at least completely break the
in-kernel RM state.

I did not really get the Ken's comment about incompatibility with
different RM's. I guess all TPM user spaces should be able to handle
TPM_RC_COMMAND_CODE and top bits are part of the TCG standard
(TSS2_RESMGR_TPM_RC_LAYER):

https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf

/Jarkko
