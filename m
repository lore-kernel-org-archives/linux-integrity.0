Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbdLOO4g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 09:56:36 -0500
Date: Fri, 15 Dec 2017 16:56:30 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214191052.GA20833@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 12:10:52PM -0700, Jason Gunthorpe wrote:
> On Thu, Dec 14, 2017 at 08:08:58PM +0100, Javier Martinez Canillas wrote:
> 
> > Although probably reverting the offending commits is the right thing to do
> > until a proper solution is proposed.
> 
> Yes, if a fix is not forthcoming soon Jarkko should revert.
> 
> Jason

I think I should drop the current patch going to 4.16 and revert the old
patch. Do we agree on this?

/Jarkko
