Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdJTTgu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 15:36:50 -0400
Date: Fri, 20 Oct 2017 17:36:48 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, lwang@redhat.com
Subject: Re: IMA appraisal against xz-compressed modules
Message-ID: <20171020193648.GA10759@glitch.routerbox>
References: <20171012145520.GC2495@glitch>
 <1508037063.3426.79.camel@linux.vnet.ibm.com>
 <20171018194936.GA10984@glitch>
 <1508422840.3268.7.camel@linux.vnet.ibm.com>
 <20171019193101.GA2583@glitch>
 <1508444027.3268.53.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
In-Reply-To: <1508444027.3268.53.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 19-10, Mimi Zohar wrote:
> On Thu, 2017-10-19 at 17:31 -0200, Bruno E. O. Meneguele wrote:
> > On 19-10, Mimi Zohar wrote:
>  
> > > > Right, but it's also possible to note that CONFIG_MODULE_SIG_FORCE is
> > > > handled on kernel/module.c and has a kernel cmdline param,
> > > > module.sig_enforce, that is read in case CONFIG_MODULE_SIG_FORCE is not
> > > > set. Wouldn't be better ima_read_file depend on this cmdline param
> > > > instead directly on the CONFIG? That way kernels compiled without
> > > > CONFIG_MODULE_SIG_FORCE set as default would have the option to enable
> > > > the kernel param and use their normal policy (MODULE_CHECK).
> > > > 
> > > > What do you think?
> > > 
> > > I wasn't aware of the module_param.  Thank you for pointing it out.
> > >  "sig_enforce" is currently defined as static.  Should it be defined
> > > as __initdata?
> > > 
> > 
> > Well, at first I thought it could stay as it is and just create a
> > "getter" function, like "is_module_sig_enforced()", and use it on
> > ima_main.c through module.h, since this code would be called to every
> > module loaded in runtime.
> > 
> > If it's ok to you I can try to write a patch against integrity-next and
> > see how it behaves.
> 
> Thanks!
> 

Patchset posted: http://www.spinics.net/lists/linux-integrity/msg00398.html
Any feedback is welcome :).

Thanks Mimi.

-- 
bmeneg 
PGP Key: http://bmeneg.com/pubkey.txt


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
