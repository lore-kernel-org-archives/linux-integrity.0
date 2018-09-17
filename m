Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:37683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeIRCsW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Sep 2018 22:48:22 -0400
Date: Tue, 18 Sep 2018 00:19:00 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180917211900.GD6716@linux.intel.com>
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
 <20180916192510.GF7473@linux.intel.com>
 <b82c4603-1a60-16ec-14b6-81251e114b75@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b82c4603-1a60-16ec-14b6-81251e114b75@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 17, 2018 at 09:54:37AM -0400, Boris Ostrovsky wrote:
> On 9/16/18 3:25 PM, Jarkko Sakkinen wrote:
> > On Thu, Sep 13, 2018 at 05:25:51PM -0400, Boris Ostrovsky wrote:
> >> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
> >>
> >> Functionality of the xen-tpmfront driver was lost secondary to
> >> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
> >> ("xenbus_client: Extend interface to support multi-page ring").
> >>
> >> In this commit a pointer to the shared page address was being
> >> passed to the xenbus_grant_ring() function rather then the
> >> address of the shared page itself.  This resulted in a situation
> > I'm sorry but I'm far from being expert with Xen and this sentence
> > confuses me so maybe could open it up a bit.
> >
> > For me "shared page address" and "address of the shared page" are
> > the same thing. What am I missing? I mean just different forms in
> > english to describe the exact same thing...
> 
> xenbus_grant_ring() takes as an argument address of the ring shared
> between two guests. What Greg was trying to describe was the fact that
> existing code instead passes address of location where this address is
> stored (i.e. somewhat similar to difference between pointer and pointer
> to a pointer).

Just to understand this bug better why did not the wrong version
cause any undefined behavior? Sounds like a fatal bug. Does this
cause crashes?

> Would this be better:
> 
> "In this commit pointer to location of the where the shared page address
> is stored was being passed to the xenbus_grant_ring() function rather
> then the
> address of the shared page itself."

Yes, definitely!

> Or please suggest a better alternative, I'll be happy to amend the
> commit message.

Thank you.

> Thanks.
> -boris

/Jarkko
