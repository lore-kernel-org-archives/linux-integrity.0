Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753241AbdJSOUv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 10:20:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JEJfGO099942
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 10:20:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dpu42b5sq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 10:20:50 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 15:20:48 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JEKiuD21954694
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 14:20:45 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JEKbDA015163
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 01:20:37 +1100
Subject: Re: IMA appraisal against xz-compressed modules
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
Cc: linux-integrity@vger.kernel.org, lwang@redhat.com
Date: Thu, 19 Oct 2017 10:20:40 -0400
In-Reply-To: <20171018194936.GA10984@glitch>
References: <20171012145520.GC2495@glitch>
         <1508037063.3426.79.camel@linux.vnet.ibm.com>
         <20171018194936.GA10984@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508422840.3268.7.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 17:49 -0200, Bruno E. O. Meneguele wrote:
> On 14-10, Mimi Zohar wrote:
> > On Thu, 2017-10-12 at 10:55 -0400, Bruno E. O. Meneguele wrote:
> > > Hi, 
> > > 
> > > recently, while playing around with IMA modules check support, I notice
> > > that when the kernel was compiled/installed with XZ-compressed modules
> > > the IMA kernel infra returns -EACCESS on modules initialization. Let me
> > > detail a bit more:
> > > 
> > > I created the policy file (/etc/ima/ima-policy) with
> > > 
> > > measure func=MODULE_CHECK uid=0
> > > (... and more, policy file is attached)
> > > 
> > > then rebooted the kernel (that was built with XZ-compressed modules) and
> > > a bunch of modules didn't load, e.g.:
> > > 
> > > without ima-policy:
> > > # lsmod | wc -l
> > > 32
> > > 
> > > with it:
> > > # lsmod | wc -l
> > > 14
> > > 
> > > these 14 modules were all loaded during initram booting phase, but if I
> > > rmmod some of them and try to modprobe (strace output):
> > > 
> > > init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)
> > > 
> > > The point is that there is no violation, because the error occurs right
> > > after kmod calls init_module() and the call follows to ima_read_file()
> > > (kernel tree: security/integrity/ima/ima_main.c) which returns -EACCES,
> > > since there is no 'file' structure available (init_module uses memory
> > > region only and not file descriptor).
> > 
> > IMA hashes/signatures are stored as xattrs, which requires a file
> > descriptor.  IMA only supports the new kernel module syscall, which
> > provides the file descriptor.
> > 
> 
> Patches from Thiago Bauerman
> (http://www.spinics.net/lists/linux-integrity/msg00243.html) could help
> to solve this, don't they?

True.  Initially we're introducing appended signature support for
kernel images.  Afterwards, perhaps we'll be able to use it to close
other appraisal gaps (e.g bpf).

> > > I notice this behavior using Fedora 26 (using SELinux as sec framework)
> > > and up-to-date kernel, the question is: should IMA kernel mechanism
> > > support memory regions integrity measurements, maybe following the steps
> > > that MODULE_SIGNATURE takes (that check for module signature through its
> > > mmap region), allowing compressed modules to be loaded? Or kernels built
> > > with XZ/GZ-compressed modules was never meant to be supported? Is it a
> > > bug or a possible enhancement?
> > 
> > If the IMA policy requires kernel modules to be signed, an appended
> > signature is permitted as long as the kernel is configured with
> > CONFIG_MODULE_SIG_FORCE enabled.
> > 
> 
> Right, but it's also possible to note that CONFIG_MODULE_SIG_FORCE is
> handled on kernel/module.c and has a kernel cmdline param,
> module.sig_enforce, that is read in case CONFIG_MODULE_SIG_FORCE is not
> set. Wouldn't be better ima_read_file depend on this cmdline param
> instead directly on the CONFIG? That way kernels compiled without
> CONFIG_MODULE_SIG_FORCE set as default would have the option to enable
> the kernel param and use their normal policy (MODULE_CHECK).
> 
> What do you think?

I wasn't aware of the module_param.  Thank you for pointing it out.
 "sig_enforce" is currently defined as static.  Should it be defined
as __initdata?

Mimi
