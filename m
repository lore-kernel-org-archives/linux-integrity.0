Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39977 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdLQSSh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Dec 2017 13:18:37 -0500
Received: by mail-wr0-f171.google.com with SMTP id q9so12136109wre.7
        for <linux-integrity@vger.kernel.org>; Sun, 17 Dec 2017 10:18:37 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Ken Goldman <kgold@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
 <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
 <425a45d4-7d44-333e-0d7f-21a931c9d81d@redhat.com>
 <20171217164738.agn3bfcc2huv3mdb@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <77a9b236-28b4-f998-f29b-af6ba5c9c402@redhat.com>
Date: Sun, 17 Dec 2017 19:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171217164738.agn3bfcc2huv3mdb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jarkko,

On 12/17/2017 05:47 PM, Jarkko Sakkinen wrote:
> Ken, Javier,
> 
> Here's my counterpart to you :-) Sorry for the delay. I'm quite busy
> upstreaming SGX ATM.
>

No worries, thanks for your feedback.
 
>> I agree with you. As I said in this thread, I don't understand the security
>> implications that Jason says. The patch in $SUBJECT just avoids all the TPM
>> spaces code paths and sends the command that user-space passed to the kernel
>> to the real TPM2 hardware as it would do when writing to /dev/tpm? directly.
>>
>> The kernel should provide mechanism and not policy in my opinion, so it should
>> be up to user-space to decide what programs are allowed to access the chardevs
>> or not. In any case, I'm also OK with the solution that was suggested and was
>> merged.
> 
> I would say kernel should keep the amount of policy minimal. Your
> statement is a "textbook definition" what kernel should do. Sandbox

Yes, sorry for attempting to simplify. We certainly have a lot of places in the
kernel where policies are defined.

> always requires some policy.
> 
> We do not have TPMA_CC entry for unknown command so we don't know how it
> might change the TPM state so obviously we must block such command and
> not let it through. There is no other option when doing an RM
> implementation.
>
> If we ignore security implications, it can at least completely break the
> in-kernel RM state.
>

My point was that the patch bypassed all the TPM spaces code paths so it should
not break the in-kernel RM state.

But you are right that due lack of a TPMA_CC for the unknown command, we have
no way to know what will be the side effects of sending the command to the TPM
so the in-kernel RM and TPM states can get out of sync.

It's actually a very good point and something that I didn't think about before.

> I did not really get the Ken's comment about incompatibility with
> different RM's. I guess all TPM user spaces should be able to handle
> TPM_RC_COMMAND_CODE and top bits are part of the TCG standard
> (TSS2_RESMGR_TPM_RC_LAYER):
>

My understanding is that Ken was referring to returning -EINVAL instead of a
proper response with a TPM_RC_COMMAND_CODE code. But that got fixed with the
patch you merged so I don't think he will have a problem with that solution.

> https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf
> 
> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
