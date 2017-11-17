Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933291AbdKQNQ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 08:16:26 -0500
Date: Fri, 17 Nov 2017 15:16:20 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Laurent Bigonville <bigon@debian.org>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171117131620.het4yxavz6lco6ow@linux.intel.com>
References: <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca>
 <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca>
 <20171111203132.hkejjs6cdrrzq3y3@cantor>
 <20171114145953.m3a343qvgln2z4er@linux.intel.com>
 <1510672631.4078.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1510672631.4078.7.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 14, 2017 at 07:17:11AM -0800, James Bottomley wrote:
> On Tue, 2017-11-14 at 16:59 +0200, Jarkko Sakkinen wrote:
> > On Sat, Nov 11, 2017 at 01:31:32PM -0700, Jerry Snitselaar wrote:
> > > 
> > > On Sat Nov 11 17, Jason Gunthorpe wrote:
> > > > 
> > > > On Sat, Nov 11, 2017 at 12:12:57PM -0700, Jerry Snitselaar wrote:
> > > > 
> > > > > 
> > > > > Before the release_locality code would only actually release
> > > > > the locality if the request use bit was set. So after it
> > > > > grabbed the locality during probe it probably never released
> > > > > it. The idea with the new code was to release it when it was no
> > > > > longer needed so another requester would be able to take the
> > > > > tpm without having to wait for it to be released.
> > > > 
> > > > If I recall, this was so that system level things outside linux
> > > > could access the TPM properly??
> > > > 
> > > 
> > > Yes, that is what drove this initially. I believe Jarkko was also
> > > thinking of the possibility in the future where something like a vm
> > > could request a locality as well, but that is just a hazy
> > > recollection of emails from back then.
> > 
> > This was something I recall discussing in LPC 2016 in the hallway at
> > least :-) A tidbit but it could make sense to tie it to VMM, not VM.
> 
> I think we should be extremely wary of different localities before we
> have a cast iron definition of what they mean.  All the TPM PC spec
> says is that locality 4 is reserved for firmware (meaning the kernel
> should have no access) and it implies there's a privilege hierarchy,
> making 4 the most privileged and 0 the least but leaves all the
> definition to the OS.  Since we only have four other localities to play
> with, we need a global definition of what they mean in Linux (and who
> protects them) otherwise we'll get conflicting uses.  What does Windows
> use them for?
> 
> James

No idea. If I had to guess, they use only one locality for OS as this
what PTT/fTPM had when it didn't have localities. At least their
implementation works with only one locality.

/Jarkko
