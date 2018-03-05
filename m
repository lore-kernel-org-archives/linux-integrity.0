Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:28145 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeCENJN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 08:09:13 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Date: Mon, 5 Mar 2018 13:09:09 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180305125642.GA3425@linux.intel.com>
In-Reply-To: <20180305125642.GA3425@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Monday, March 05, 2018 14:57
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; linux-integrity@vger.kernel.org; linux-
> security-module@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
> commands.
> 
> On Sun, Mar 04, 2018 at 02:12:03PM +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Where is the cover letter? Please send separate patches if they are unrelated
> *or* add a cover letter that describes what they do as a whole.
>
Why you need cover letter?  What are u missing in the patch description
 
> I will not review the next version if it does not have cover letter describing
> the high level change and containing the change log.

Don't follow.

> 
> > ---
> >  drivers/char/tpm/tpm-interface.c |  4 ++++
> >  drivers/char/tpm/tpm.h           | 27 ++++++++++++++++-----------
> >  drivers/char/tpm/tpm2-cmd.c      |  8 +++++---
> >  3 files changed, 25 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 85bdfa8c3348..c0aa9d11ec7a 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -699,6 +699,10 @@ int tpm_get_timeouts(struct tpm_chip *chip)
> >  		    msecs_to_jiffies(TPM2_DURATION_MEDIUM);
> >  		chip->duration[TPM_LONG] =
> >  		    msecs_to_jiffies(TPM2_DURATION_LONG);
> > +		chip->duration[TPM_LONG_LONG] =
> > +		    msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
> > +		chip->duration[TPM_UNDEFINED] =
> > +		    msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> >
> >  		chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
> >  		return 0;
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index
> > f895fba4e20d..192ba68b39c2 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -67,7 +67,9 @@ enum tpm_duration {
> >  	TPM_SHORT = 0,
> >  	TPM_MEDIUM = 1,
> >  	TPM_LONG = 2,
> > -	TPM_UNDEFINED,
> > +	TPM_LONG_LONG = 3,
> > +	TPM_UNDEFINED = 4,
> > +	TPM_DURATION_MAX,
> 
> This is starting to rotten to become unmaintainable.

> Here is what I suggest to move forward:

I fixed that in next patch, but this also moves the code to new spec,  so I didn't want to make too much noise in this one. 
 
> * Have essentially two duration types:
>   1. Default
>   2. Long
>   'default' is the old long duration i.e. two seconds. 'long' is a

> 
> We should probably have two durations:
> 
> enum tpm_duration {
> 	TPM_DURATION_DEFAULT = 2000,
> 	TPM_DURATION_LONG = 300000,
> };
> 
How is this aligned with the spec PTP spec?

> These would be both for TPM 1.2 and TPM 2.0. Instead of having table for
> every ordinal there should be a small tables describing commands that
> require long timeout.

Yeah I didn't cover the 1.2. 
> 
> > -		duration = 2 * 60 * HZ;
> > +		duration = msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> 
> NAK for this change.


You should explain your NAKs, .... in general, doesn't look good.


Thanks
Tomas
