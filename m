Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45835 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbdLORib (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 12:38:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so18891606wme.4
        for <linux-integrity@vger.kernel.org>; Fri, 15 Dec 2017 09:38:30 -0800 (PST)
Date: Fri, 15 Dec 2017 10:38:26 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171215173826.GD12434@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 15, 2017 at 04:56:30PM +0200, Jarkko Sakkinen wrote:
> On Thu, Dec 14, 2017 at 12:10:52PM -0700, Jason Gunthorpe wrote:
> > On Thu, Dec 14, 2017 at 08:08:58PM +0100, Javier Martinez Canillas wrote:
> > 
> > > Although probably reverting the offending commits is the right thing to do
> > > until a proper solution is proposed.
> > 
> > Yes, if a fix is not forthcoming soon Jarkko should revert.
> > 
> 
> I think I should drop the current patch going to 4.16 and revert the old
> patch. Do we agree on this?

I think the entire is_bsw thing needs to go, clearly manipulating
CLKRUN directly was not fully thought out?

Hopefully Intel will come up with a fix patch to preserve PS/2
functionality and it won't come to a revert..

Jason
