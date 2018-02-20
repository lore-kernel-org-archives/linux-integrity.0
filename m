Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeBTOMd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:12:33 -0500
Message-ID: <1519135945.4113.9.camel@linux.intel.com>
Subject: Re: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2018 16:12:25 +0200
In-Reply-To: <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
         <20180214134319.4400-2-tomas.winkler@intel.com>
         <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-19 at 13:27 +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 14, 2018 at 03:43:18PM +0200, Tomas Winkler wrote:
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip-
> > >locality);
> > +		/* this coud be on error path, don't override
> > error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip,
> > chip->locality);
> 
> All local variable declarations must be in the beginning of the
> function.
> 
> > +
> > +		if (l_rc) {
> > +			dev_err(&chip->dev, "%s:
> > relinquish_locality: error %d\n",
> > +				__func__, l_rc);
> > +			rc = l_rc;
> > +		}
> 
> Your comment about not overriding error code is incorrect.
> 
> The value of 'rc' should be never overridden, which kind of supports
> to "just print" behavior that we had for a locality error.
> 
> Is your fix somehow dependent on changing relinquish_locality()
> behavior? If not, please remove this change. If you want to
> contribute
> such behavioral change, you should make a separate patch of it.
> 
> Now it's like a trojan horse bundled inside a bug fix.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

[And while doing this noticed a flaw in my test suite:
https://github.com/jsakkine-intel/tpm2-scripts/issues/3]

/Jarkko
