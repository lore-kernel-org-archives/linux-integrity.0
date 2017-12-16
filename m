Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64467 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757093AbdLPRBX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 Dec 2017 12:01:23 -0500
Message-ID: <1513443676.29063.0.camel@linux.intel.com>
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Date: Sat, 16 Dec 2017 19:01:16 +0200
In-Reply-To: <20171215173826.GD12434@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
         <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
         <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
         <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
         <20171214191052.GA20833@ziepe.ca>
         <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
         <20171215173826.GD12434@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-12-15 at 10:38 -0700, Jason Gunthorpe wrote:
> On Fri, Dec 15, 2017 at 04:56:30PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Dec 14, 2017 at 12:10:52PM -0700, Jason Gunthorpe wrote:
> > > On Thu, Dec 14, 2017 at 08:08:58PM +0100, Javier Martinez Canillas wrote:
> > > 
> > > > Although probably reverting the offending commits is the right thing to do
> > > > until a proper solution is proposed.
> > > 
> > > Yes, if a fix is not forthcoming soon Jarkko should revert.
> > > 
> > 
> > I think I should drop the current patch going to 4.16 and revert the old
> > patch. Do we agree on this?
> 
> I think the entire is_bsw thing needs to go, clearly manipulating
> CLKRUN directly was not fully thought out?
> 
> Hopefully Intel will come up with a fix patch to preserve PS/2
> functionality and it won't come to a revert..

Agreed.

/Jarkko
