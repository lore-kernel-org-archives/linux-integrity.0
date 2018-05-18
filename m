Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lan.nucleusys.com ([92.247.61.126]:57094 "EHLO
        zztop.nucleusys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751980AbeERQeX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 12:34:23 -0400
Date: Fri, 18 May 2018 18:58:03 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Mark D. Baushke" <mdb@juniper.net>,
        Petko Manolov <petkan@mip-labs.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Cleaning up IMA
Message-ID: <20180518155803.GB4816@carbon>
References: <1526580423.3632.17.camel@linux.vnet.ibm.com>
 <92E32D97-B60A-4D75-AC9F-594F95E432B1@juniper.net>
 <1526651759.3632.172.camel@linux.vnet.ibm.com>
 <9298.1526652376@eng-mail01.juniper.net>
 <1526657654.3404.17.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526657654.3404.17.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 18-05-18 11:34:14, Mimi Zohar wrote:
> On Fri, 2018-05-18 at 07:06 -0700, Mark D. Baushke wrote:
> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > 
> > > On Fri, 2018-05-18 at 13:44 +0000, Mark Baushke wrote:
> > > > Hi Mimi,
> > > > 
> > > > I see that Petko has already provide the answer and an updated patch.
> > > > 
> > > > I was off-line most of yesterday, and am only now catching up on email.
> > > > 
> > > > To confirm, yes, we are still using the ima_update_policy() code.
> 
> Updating the policy wasn't the question. It was about using the IMA blacklist, 
> as opposed to the system blacklist.

The system-wide blacklist is populated at build time only.  This means that you 
need kernel change if you want to revoke a certificate, which is sub-optimal.  
To be useful for us it should be able to accept imports at run-time.

Until the system-wide blacklist keyring doesn't have this functionality i 
suggest that we keep .ima_blacklist around.


		Petko
