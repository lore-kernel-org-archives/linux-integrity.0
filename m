Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26020 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdKNOzT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 09:55:19 -0500
Date: Tue, 14 Nov 2017 16:55:14 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
        Laurent Bigonville <bigon@debian.org>,
        Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20171114145242.2rzmdwb4nik4vq3o@linux.intel.com>
References: <20171024160725.r6kj452jdzpkbb6o@linux.intel.com>
 <8f4df9a9-c8cd-832f-4c3f-5305fabab7a8@debian.org>
 <0a6e4771-f871-b3ca-b5b0-26dbd9efa8b1@debian.org>
 <20171110002820.wtfvb3tv5fcjqecu@localhost.localdomain>
 <20171110070738.ki5xie4z7yql77fk@localhost.localdomain>
 <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca>
 <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171111194647.GA6918@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Nov 11, 2017 at 12:46:47PM -0700, Jason Gunthorpe wrote:
> On Sat, Nov 11, 2017 at 12:12:57PM -0700, Jerry Snitselaar wrote:
> 
> > Before the release_locality code would only actually release the
> > locality if the request use bit was set. So after it grabbed the
> > locality during probe it probably never released it. The idea with the
> > new code was to release it when it was no longer needed so another
> > requester would be able to take the tpm without having to wait for it
> > to be released.
> 
> If I recall, this was so that system level things outside linux could
> access the TPM properly??
> 
> > With the old code I think it would have to wait either
> > until the next time release_locality was called, or attempt to seize
> > the tpm with the seize bit in the access register. I need to read
> > through the spec some more, but does the tpm ever force a change when
> > the request use bit is set, or does it leave it up to the software
> > to deal with it and only gets involved in the case where the seize
> > bit has been set?
> 
> Do we handle these cases? Maybe something like that has happened..
> 
> Jason

At least the driver works with TXT properly that uses locality 2.

The locality stuff for tpm_crb has bee made to work sanely with TXT.

/Jarkko
