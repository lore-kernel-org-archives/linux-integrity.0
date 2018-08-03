Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbeHCVpa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 17:45:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73JcrgS128576
        for <linux-integrity@vger.kernel.org>; Fri, 3 Aug 2018 15:47:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmuj8m6pw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Aug 2018 15:47:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 20:47:45 +0100
Subject: Re: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
From: Mimi Zohar <zohar@linux.ibm.com>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric Richter <erichte@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>
Date: Fri, 03 Aug 2018 15:47:30 -0400
In-Reply-To: <20180803161636.GX3001@ubuntu-xps13>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
         <20180725233200.761-4-erichte@linux.vnet.ibm.com>
         <20180803131129.GS3001@ubuntu-xps13>
         <1533308099.4337.424.camel@linux.ibm.com>
         <20180803161636.GX3001@ubuntu-xps13>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1533325650.4337.527.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-08-03 at 11:16 -0500, Seth Forshee wrote:
> On Fri, Aug 03, 2018 at 10:54:59AM -0400, Mimi Zohar wrote:
> > On Fri, 2018-08-03 at 08:11 -0500, Seth Forshee wrote:
> > > On Wed, Jul 25, 2018 at 06:31:59PM -0500, Eric Richter wrote:
> > > > IMA can verify the signature of kernel images loaded with kexec_file_load,
> > > > but can not verify images loaded with the regular kexec_load syscall.
> > > > Therefore, the appraisal will automatically fail during kexec_load when an
> > > > appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
> > > > to effectively disable the kexec_load syscall, while still allowing the
> > > > kexec_file_load to operate so long as the target kernel image is signed.
> > > > 
> > > > However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
> > > > enabled and there is an appraise rule set, then the target kernel would
> > > > have to be verifiable by both IMA and the architecture specific kernel
> > > > verification procedure.
> > > > 
> > > > This patch adds a new func= for IMA appraisal specifically for the original
> > > > kexec_load syscall. Therefore, the kexec_load syscall can be effectively
> > > > disabled via IMA policy, leaving the kexec_file_load syscall able to do its
> > > > own signature verification, and not require it to be signed via IMA. To
> > > > retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
> > > > unchanged, and thus enables appraisal for both kexec syscalls.
> > > 
> > > This seems like a roundabout way to disallow the kexec_load syscall.
> > > Wouldn't it make more sense to simply disallow kexec_load any time
> > > CONFIG_KEXEC_VERIFY_SIG is enabled, since it effectively renders that
> > > option impotent? Or has that idea already been rejected?
> > 
> > Agreed!  We can modify the "case LOADING_KEXEC_IMAGE" in
> > ima_load_data() to prevent the kexec_load based on
> > CONFIG_KEXEC_VERIFY_SIG.
> > 
> > The architecture specific policy would only include the IMA appraise
> > rule if CONFIG_KEXEC_VERIFY_SIG was not defined.
> 
> After looking at this some more I'm having second thoughts about my
> suggestion. As a distro we produce a kernel that needs to be flexible
> enough for a variety of scenarios, and if we completely close off the
> ability to load an unsigned kernel for kexec that's almost certainly
> going to end up breaking some use cases.
> 
> So I think it is necessary to make this a run-time decision rather than
> a compile-time decision. The patch as provided does this based on
> whether or not the kernel was booted under secure boot. That might be
> reasonable, though I still find this mechanism kind of awkward.

Right, the above change is almost right.  Instead of preventing the
kexec_load syscall based on CONFIG_KEXEC_VERIFY_SIG it should be based
on a runtime secure boot flag.  Only if there is an arch specific
secure boot function and the secure boot flag is enabled, would the
kexec_load be disabled.

Without an architecture specific secure boot function, the existing
IMA code would fail the kexec_load syscall.

>  It seems
> like ideally there would instead be some logic that would accept the
> image if the KEXEC_VERIFY_SIG verification had passed, and otherwise
> require IMA signature verification.

True, but for now to coordinate between the two signature verification
methods, only if CONFIG_KEXEC_VERIFY_SIG is not enabled would an IMA
architecture specific rule be defined.

Mimi
