Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:41428 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755541AbeEJBmR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 21:42:17 -0400
Date: Thu, 10 May 2018 04:42:10 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David R. Bild" <david.bild@xaptum.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180510014210.GK6190@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <CAAi9uDuMyUt1sROZ--_QHM5rUjTMo2F7PHyCoEtuD=y35ezgtA@mail.gmail.com>
 <20180506150229.jvbkvq7hlxbgmsgn@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180506150229.jvbkvq7hlxbgmsgn@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, May 06, 2018 at 09:02:29AM -0600, Jason Gunthorpe wrote:
> On Fri, May 04, 2018 at 03:19:21PM -0500, David R. Bild wrote:
> > Setting the platform hierarchy password to a random discarded value
> > (and the dictionary lockout reset) is really the only special work
> > done here. The other steps (startup, self test, etc.) are done by the
> > TPM subsystem if needed.
> > 
> > So easy option would be for the TPM subsystem to set the platform
> > hierarchy password to a random value during device registration, if
> > needed.  It could either
> 
> This would probably make more sense, I'm not opposed at least
> 
> > This wouldn't require a significant change to the TPM subsystem
> > internals and would let me drop nearly the entire second patch from
> > this series.  (I think the dictionary lockout reset can be done via
> > the already exported "tpm_send(...)" function.)
> 
> Sounds like a much better approach to me.
> 
> Jason

Yes this part but I have absolutely zero understanding about what was
explained before this part (the *longer* part in the email).

/Jarkko
