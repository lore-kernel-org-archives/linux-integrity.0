Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1EDC43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22600208E3
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RCIg9iu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfACQRV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:17:21 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53724 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730643AbfACQRV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 11:17:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 138DA8EE268;
        Thu,  3 Jan 2019 08:17:21 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iYvlTxsbk2th; Thu,  3 Jan 2019 08:17:20 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7AE238EE0A4;
        Thu,  3 Jan 2019 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1546532240;
        bh=897aZsgJll5ctTJJkYsaUs+3eRNGp/K+D7SFGBgyy2g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RCIg9iu6JRanQQin3rwa1f98XVdsNQuS86/n66wP0DCeUDqQsNkoIjr6+85Nlu2Lf
         8q/fQLQE/JWYI3GC17Yod1xaCST21e/kMLwLrBr6G2gxqfm+/GEUlk8Qzt0XHwe1K5
         wg6xZdoRuPAbcwGzP6dfVkUGirikMjI/1U+TQWTk=
Message-ID: <1546532238.2824.10.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Thu, 03 Jan 2019 08:17:18 -0800
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
         <20190103125904.GA10491@linux.intel.com>
         <1546529038.2824.6.camel@HansenPartnership.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-01-03 at 15:34 +0000, Winkler, Tomas wrote:
> > -----Original Message-----
> > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com
> > ]
> > Sent: Thursday, January 03, 2019 17:24
> > To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Winkler, Tomas <tomas.winkler@intel.com>; linux-
> > integrity@vger.kernel.org
> > Subject: Re: [PATCH] tpm: fix incorrect success returns from
> > tpm_try_transmit()
> > 
> > On Thu, 2019-01-03 at 14:59 +0200, Jarkko Sakkinen wrote:
> > > On Mon, Dec 31, 2018 at 10:27:31AM -0800, James Bottomley wrote:
> > > > Ever since 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > > > runtime_pm" we have been returning success from
> > > > tpm_try_transmit() even if an error occurred.  The reason is
> > > > that the introduction of rc = tpm_go_idle() at the end of
> > > > processing overwrites the value of rc if it contains an error
> > > > code (mostly with success).  Fix this by writing the return to
> > > > a new variable rc1 instead.
> > > > 
> > > > Fixes: 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > > > runtime_pm"
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnersh
> > > > ip.c
> > > > om>
> > > > 
> > > > ---
> > > > 
> > > > Note: the goto out looks fishy as well.  The only go_idle
> > > > implementor is tpm_crb and that can return a timeout as -ETIME,
> > > > so it looks like it would then loop forever
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm-interface.c
> > > > b/drivers/char/tpm/tpm-interface.c
> > > > index 129f640424b7..ac7ebab6140c 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -432,7 +432,7 @@ static ssize_t tpm_try_transmit(struct
> > > > tpm_chip
> > > > *chip,
> > > >  				unsigned int flags)
> > > >  {
> > > >  	struct tpm_output_header *header = (void *)buf;
> > > > -	int rc;
> > > > +	int rc, rc1;
> > > >  	ssize_t len = 0;
> > > >  	u32 count, ordinal;
> > > >  	unsigned long stop;
> > > > @@ -547,8 +547,8 @@ static ssize_t tpm_try_transmit(struct
> > > > tpm_chip
> > > > *chip,
> > > >  		dev_err(&chip->dev, "tpm2_commit_space: error
> > > > %d\n", rc);
> > > > 
> > > >  out:
> > > > -	rc = tpm_go_idle(chip, flags);
> > > > -	if (rc)
> > > > +	rc1 = tpm_go_idle(chip, flags);
> > > > +	if (rc1)
> > > >  		goto out;
> > > > 
> > > >  	if (need_locality)
> > > 
> > > Thanks James and sorry for latency (holiday season). Just a small
> > > suggestion. I would just:
> > > 
> > > if (tpm_go_idle(chip, flags))
> > > 	goto out;
> > > 
> > > What do you think?
> > 
> > That it doesn't solve the loop forever with no warning problem.  If
> > anything, I think the correct thing is probably
> > 
> > 	rc1 = tpm_go_idle(chip, flags);
> > 	if (rc1)
> >   		dev_err(&chip->dev, "go idle failed with %d\n",
> > rc1);
> > 
> > so we log the problem and move on.  If it is a timeout, it will
> > likely show up on the next TPM operation.  Since this is the only
> > caller of tpm_go_idle(), I think all looping should be done inside
> > that function, but we should probably wait for Tomas to comment
> > since he wrote it.
> > 
> 
> We've already fixed it, I forgot myself , we were drinking too much
> :)
> https://patchwork.kernel.org/patch/10643565/
> Not sure why it was dropped.

Taking the trouble to gather error returns and then ignoring them is
not a good practice (it's actually been the bane of filesystems for a
while).  If you want to do it this way, tpm_go_idle() needs to be a
void function that emits an error message for every problem condition.

James

