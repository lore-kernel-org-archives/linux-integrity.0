Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdLDROh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 12:14:37 -0500
Date: Mon, 4 Dec 2017 15:14:35 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Subject: Re: IMA-EVM-Utils OpenSSL1.1 interface update
Message-ID: <20171204171435.GA6190@glitch>
References: <20171201181522.GB3056@glitch>
 <1512392157.3977.36.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1512392157.3977.36.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 04-12, Mimi Zohar wrote:
> On Fri, 2017-12-01 at 16:15 -0200, Bruno E. O. Meneguele wrote:
> > Hi folks,
> > 
> > I don't really know what are your best interest in update ima-evm-utils
> > 1.0 package to support OpenSSL 1.1 new interface considering lots of
> > distros are chaging to it as the default one. Some are maintaining
> > compatibility packages to OpenSSL 1.0, but usually it remains available
> > in the official repos for something like 1 or 2 releases and then
> > removed completely.
> > 
> > Actually I have a simple/small port of it to OpenSSL 1.1 that I plan to
> > maintain for Fedora's Rawhide (next release, f28) package. Do you guys
> > have interest on it? I could post it as a patch.
> > 
> > Thanks!
> 
> Yes, I'd really appreciate it.  We need to release the new EVM
> portable signature support as well.
> 

Perfect! should I post with some different subject prefix or something
like that to let things clear that is a patch for the userspace app?

> thanks,
> 
> Mimi
> 


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
