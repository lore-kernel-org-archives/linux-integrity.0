Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751762AbdJSTbD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 15:31:03 -0400
Date: Thu, 19 Oct 2017 17:31:01 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, lwang@redhat.com
Subject: Re: IMA appraisal against xz-compressed modules
Message-ID: <20171019193101.GA2583@glitch>
References: <20171012145520.GC2495@glitch>
 <1508037063.3426.79.camel@linux.vnet.ibm.com>
 <20171018194936.GA10984@glitch>
 <1508422840.3268.7.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1508422840.3268.7.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 19-10, Mimi Zohar wrote:
> On Wed, 2017-10-18 at 17:49 -0200, Bruno E. O. Meneguele wrote:
> > On 14-10, Mimi Zohar wrote:
> > > On Thu, 2017-10-12 at 10:55 -0400, Bruno E. O. Meneguele wrote:
> > > > Hi, 
> > > > 
> > > > recently, while playing around with IMA modules check support, I notice
> > > > that when the kernel was compiled/installed with XZ-compressed modules
> > > > the IMA kernel infra returns -EACCESS on modules initialization. Let me
> > > > detail a bit more:
> > > > 
> > > > I created the policy file (/etc/ima/ima-policy) with
> > > > 
> > > > measure func=MODULE_CHECK uid=0
> > > > (... and more, policy file is attached)
> > > > 
> > > > then rebooted the kernel (that was built with XZ-compressed modules) and
> > > > a bunch of modules didn't load, e.g.:
> > > > 
> > > > without ima-policy:
> > > > # lsmod | wc -l
> > > > 32
> > > > 
> > > > with it:
> > > > # lsmod | wc -l
> > > > 14
> > > > 
> > > > these 14 modules were all loaded during initram booting phase, but if I
> > > > rmmod some of them and try to modprobe (strace output):
> > > > 
> > > > init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)
> > > > 
> > > > The point is that there is no violation, because the error occurs right
> > > > after kmod calls init_module() and the call follows to ima_read_file()
> > > > (kernel tree: security/integrity/ima/ima_main.c) which returns -EACCES,
> > > > since there is no 'file' structure available (init_module uses memory
> > > > region only and not file descriptor).
> > > 
> > > IMA hashes/signatures are stored as xattrs, which requires a file
> > > descriptor.  IMA only supports the new kernel module syscall, which
> > > provides the file descriptor.
> > > 
> > 
> > Patches from Thiago Bauerman
> > (http://www.spinics.net/lists/linux-integrity/msg00243.html) could help
> > to solve this, don't they?
> 
> True.  Initially we're introducing appended signature support for
> kernel images.  Afterwards, perhaps we'll be able to use it to close
> other appraisal gaps (e.g bpf).
> 

Ah right, nice. I'll keep an eye on it.

> > > > I notice this behavior using Fedora 26 (using SELinux as sec framework)
> > > > and up-to-date kernel, the question is: should IMA kernel mechanism
> > > > support memory regions integrity measurements, maybe following the steps
> > > > that MODULE_SIGNATURE takes (that check for module signature through its
> > > > mmap region), allowing compressed modules to be loaded? Or kernels built
> > > > with XZ/GZ-compressed modules was never meant to be supported? Is it a
> > > > bug or a possible enhancement?
> > > 
> > > If the IMA policy requires kernel modules to be signed, an appended
> > > signature is permitted as long as the kernel is configured with
> > > CONFIG_MODULE_SIG_FORCE enabled.
> > > 
> > 
> > Right, but it's also possible to note that CONFIG_MODULE_SIG_FORCE is
> > handled on kernel/module.c and has a kernel cmdline param,
> > module.sig_enforce, that is read in case CONFIG_MODULE_SIG_FORCE is not
> > set. Wouldn't be better ima_read_file depend on this cmdline param
> > instead directly on the CONFIG? That way kernels compiled without
> > CONFIG_MODULE_SIG_FORCE set as default would have the option to enable
> > the kernel param and use their normal policy (MODULE_CHECK).
> > 
> > What do you think?
> 
> I wasn't aware of the module_param.  Thank you for pointing it out.
>  "sig_enforce" is currently defined as static.  Should it be defined
> as __initdata?
> 

Well, at first I thought it could stay as it is and just create a
"getter" function, like "is_module_sig_enforced()", and use it on
ima_main.c through module.h, since this code would be called to every
module loaded in runtime.

If it's ok to you I can try to write a patch against integrity-next and
see how it behaves.

-- 
bmeneg 
PGP Key: http://bmeneg.com/pubkey.txt


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
