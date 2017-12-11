Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752470AbdLKRcd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 12:32:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBBHVkLC063257
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 12:32:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2esw0p5mme-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 12:32:32 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 11 Dec 2017 17:22:19 -0000
Subject: Re: IMA keyctl problems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Paul R. Tagliamonte" <paultag@gmail.com>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 11 Dec 2017 12:22:14 -0500
In-Reply-To: <CAO6P2QQe_gX3MYz-YwQF2=YCk1-Bna+Phg8Rz_-yp5rKtG1SzA@mail.gmail.com>
References: <CAO6P2QT3n0WphLHP-e2cyLFMcp_i4PXv3Atezpksdtn4nfVmPA@mail.gmail.com>
         <1512915528.3846.29.camel@linux.vnet.ibm.com>
         <CAO6P2QQfeay18Fg13YGfE-EysiVT6UerSPJvoKdqmTSeLiMD8A@mail.gmail.com>
         <1512921715.3846.33.camel@linux.vnet.ibm.com>
         <CAO6P2QTnCaGJXrDKy4jWnqRJzcb1YCSfvbQ+PrR-4h5_UJC0vw@mail.gmail.com>
         <CAO6P2QTFRnSor10C01QvDoD9-uVoszKbN49u12owzMcvRvA-6g@mail.gmail.com>
         <CAO6P2QTRfOYMiB1HEbaYghsH+2bw1tyHrGsMt6G8jbQKHQKETA@mail.gmail.com>
         <1513000117.3846.122.camel@linux.vnet.ibm.com>
         <CAO6P2QQ2J--2hyz-L78uAOcDZQ3VKzbtiYO7oSFxD7Z0Yo+V9Q@mail.gmail.com>
         <1513007322.3846.146.camel@linux.vnet.ibm.com>
         <CAO6P2QQe_gX3MYz-YwQF2=YCk1-Bna+Phg8Rz_-yp5rKtG1SzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1513012934.3846.197.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-12-11 at 11:01 -0500, Paul R. Tagliamonte wrote:
> > Great!  And if you replaced the "uid=0" with "fowner=0" the appraisal
> > would succeed whether or not you're running as root.
> 
> I was looking to appraise any binaries that a single user is running,
> not anything any user runs that's owned by root.
> 
> > Different files can be signed with different keys, but all keys should
> > be loaded onto the same _ima keyring.  (This will change once IMA is
> > namespaced.)
> 
> Yes. Good copy on that.
> 
> My question was about how to ensure the _ima keyring is present in all
> user's keyrings, if the IMA module is searching the user executing the
> program's keyring. See the terminal output in my last mail.

It shouldn't need to search multiple keyrings as all keys should be on
the one and only IMA keyring.

> Once again, the kernel is throwing errors if I try to appraise
> binaries that uid 1000 is running unless the _ima keyring is linked to
> uid 1000's @u keyring. Is this expected behavior, and if so, where can
> I read more about this?

This is definitely not expected behavior.

> > The policy defines which files should be appraised.  If you want to
> > verify files owned by uid 1000, the policy would include an appraise
> > rule fowner=1000.
> 
> I want to appraise anything run by user 1000, regardless of file
> owner. I can only seem to do this if uid 1000's @u has a _ima keyring
> under it, and **not** if uid 0's @u has an _ima keyring under it. Is
> this expected behavior?

The builtin measurement policy measures all files executed (eg.
measure func=BPRM_CHECK).  A similar rule could be defined to appraise
everything executed (eg. audit func=BPRM_CHECK), but the builtin
policy can't do that since it would require knowing and signing all
executables, including scripts, on the file system.  For this reason,
we've defined the builtin appraise TCB policy to appraise only files
owned by root.

> > Normally one starts with something that is known to work, before
> > attempting/complaining something different doesn't work.
> 
> Cheers, thanks for that.
> 
> I'd like to point out that at no point have I complained, even about
> things fully deserving of it, such as the lack of documentation or
> opaque errors.

Agreed, the wiki and documentation definitely need to be updated.
 It's on my "todo" list.  I'm hoping to work my way through it, when
things quiet down.

> I've been courteous and tried to provide helpful
> information and context proactively. To be honest, I'm a bit
> disappointed and frustrated at this side-comment.

Basically you're asking me to replicate your environment to figure out
why your environment isn't working, before you've tried the "normal"
method of creating a keyring/loading keys (eg. dracut/systemd) and
booting the system with a builtin policy.

> I understand you must be frustrated, and I appreciate you replied on a
> weekend and it's not your job to provide support, but as a newcomer, I
> am just as frustrated with this interaction.

>From my perspective, I need to understand if you're reporting a
regression or a new usecase scenario.

> A bit of empathy would be nice.

You definitely have my empathy!  Until files come signed, enabling
IMA-appraisal is difficult.

For now, create the keyring and load the keys in the initramfs, as you
described.  Boot with the builtin policies by adding the
ima_policy="tcb|appraise_tcb" on the boot commnad line.

Only afterwards, replace the builtin "appraise_tcb" policy with a
custom policy, which appraises all executables not just those owned by
root.

Instead of "appraise func=BPRM_CHECK fowner=0 appraise_type=imasig"
the appraise rule would be "appraise func=BPRM_CHECK
appraise_type=imasig".

Mimi
