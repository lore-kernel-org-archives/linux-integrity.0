Return-Path: <SRS0=Znl9=PS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB7FC43387
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262DD20874
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfAJRRD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:17:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:55858 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbfAJRRD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jan 2019 12:17:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="115793286"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2019 09:16:59 -0800
Date:   Thu, 10 Jan 2019 19:16:58 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Message-ID: <20190110171658.GB6589@linux.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
 <20190103125904.GA10491@linux.intel.com>
 <1546529038.2824.6.camel@HansenPartnership.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
 <1546532238.2824.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546532238.2824.10.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 03, 2019 at 08:17:18AM -0800, James Bottomley wrote:
> On Thu, 2019-01-03 at 15:34 +0000, Winkler, Tomas wrote:
> > > -----Original Message-----
> > > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com
> > > ]
> > > Sent: Thursday, January 03, 2019 17:24
> > > To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Winkler, Tomas <tomas.winkler@intel.com>; linux-
> > > integrity@vger.kernel.org
> > > Subject: Re: [PATCH] tpm: fix incorrect success returns from
> > > tpm_try_transmit()
> > > 
> > > On Thu, 2019-01-03 at 14:59 +0200, Jarkko Sakkinen wrote:
> > > > On Mon, Dec 31, 2018 at 10:27:31AM -0800, James Bottomley wrote:
> > > > > Ever since 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > > > > runtime_pm" we have been returning success from
> > > > > tpm_try_transmit() even if an error occurred.  The reason is
> > > > > that the introduction of rc = tpm_go_idle() at the end of
> > > > > processing overwrites the value of rc if it contains an error
> > > > > code (mostly with success).  Fix this by writing the return to
> > > > > a new variable rc1 instead.
> > > > > 
> > > > > Fixes: 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > > > > runtime_pm"
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnersh
> > > > > ip.c
> > > > > om>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Note: the goto out looks fishy as well.  The only go_idle
> > > > > implementor is tpm_crb and that can return a timeout as -ETIME,
> > > > > so it looks like it would then loop forever
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm-interface.c
> > > > > b/drivers/char/tpm/tpm-interface.c
> > > > > index 129f640424b7..ac7ebab6140c 100644
> > > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > > @@ -432,7 +432,7 @@ static ssize_t tpm_try_transmit(struct
> > > > > tpm_chip
> > > > > *chip,
> > > > >  				unsigned int flags)
> > > > >  {
> > > > >  	struct tpm_output_header *header = (void *)buf;
> > > > > -	int rc;
> > > > > +	int rc, rc1;
> > > > >  	ssize_t len = 0;
> > > > >  	u32 count, ordinal;
> > > > >  	unsigned long stop;
> > > > > @@ -547,8 +547,8 @@ static ssize_t tpm_try_transmit(struct
> > > > > tpm_chip
> > > > > *chip,
> > > > >  		dev_err(&chip->dev, "tpm2_commit_space: error
> > > > > %d\n", rc);
> > > > > 
> > > > >  out:
> > > > > -	rc = tpm_go_idle(chip, flags);
> > > > > -	if (rc)
> > > > > +	rc1 = tpm_go_idle(chip, flags);
> > > > > +	if (rc1)
> > > > >  		goto out;
> > > > > 
> > > > >  	if (need_locality)
> > > > 
> > > > Thanks James and sorry for latency (holiday season). Just a small
> > > > suggestion. I would just:
> > > > 
> > > > if (tpm_go_idle(chip, flags))
> > > > 	goto out;
> > > > 
> > > > What do you think?
> > > 
> > > That it doesn't solve the loop forever with no warning problem.  If
> > > anything, I think the correct thing is probably
> > > 
> > > 	rc1 = tpm_go_idle(chip, flags);
> > > 	if (rc1)
> > >   		dev_err(&chip->dev, "go idle failed with %d\n",
> > > rc1);
> > > 
> > > so we log the problem and move on.  If it is a timeout, it will
> > > likely show up on the next TPM operation.  Since this is the only
> > > caller of tpm_go_idle(), I think all looping should be done inside
> > > that function, but we should probably wait for Tomas to comment
> > > since he wrote it.
> > > 
> > 
> > We've already fixed it, I forgot myself , we were drinking too much
> > :)
> > https://patchwork.kernel.org/patch/10643565/
> > Not sure why it was dropped.
> 
> Taking the trouble to gather error returns and then ignoring them is
> not a good practice (it's actually been the bane of filesystems for a
> while).  If you want to do it this way, tpm_go_idle() needs to be a
> void function that emits an error message for every problem condition.

I'm happy to take a patch that adds logging in.

/Jarkko
