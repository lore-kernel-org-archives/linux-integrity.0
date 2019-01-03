Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80720C43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F882070D
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nRGZSlim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfACPYA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:24:00 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53104 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbfACPYA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 10:24:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 384C38EE268;
        Thu,  3 Jan 2019 07:24:00 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aaUzFgb53Y9n; Thu,  3 Jan 2019 07:24:00 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B31278EE0A4;
        Thu,  3 Jan 2019 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1546529039;
        bh=z4MmgaS6a6IiFfs5BXth4/Q45jA9kTUL5VvdxyP6w0s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nRGZSlimTiYbJlVdtjujGt1fjUSCO3Hl/8lGUAh7BJCJP4siXK8LrSw8TEB83pFmB
         imGrVnS4jgNspZotGbFDeqkbo7ItyZON94JEgM7EIX6XJLv5NAIMuq1g2/ZDp+Io7i
         DtQsOXQpv6O1Sz3WM7zL8bABUKgM/aFlEurL7jtI=
Message-ID: <1546529038.2824.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 03 Jan 2019 07:23:58 -0800
In-Reply-To: <20190103125904.GA10491@linux.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
         <20190103125904.GA10491@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-01-03 at 14:59 +0200, Jarkko Sakkinen wrote:
> On Mon, Dec 31, 2018 at 10:27:31AM -0800, James Bottomley wrote:
> > Ever since 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > runtime_pm" we have been returning success from tpm_try_transmit()
> > even if an error occurred.  The reason is that the introduction of
> > rc
> > = tpm_go_idle() at the end of processing overwrites the value of rc
> > if
> > it contains an error code (mostly with success).  Fix this by
> > writing
> > the return to a new variable rc1 instead.
> > 
> > Fixes: 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > runtime_pm"
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > 
> > ---
> > 
> > Note: the goto out looks fishy as well.  The only go_idle
> > implementor
> > is tpm_crb and that can return a timeout as -ETIME, so it looks
> > like it
> > would then loop forever
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 129f640424b7..ac7ebab6140c 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -432,7 +432,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > *chip,
> >  				unsigned int flags)
> >  {
> >  	struct tpm_output_header *header = (void *)buf;
> > -	int rc;
> > +	int rc, rc1;
> >  	ssize_t len = 0;
> >  	u32 count, ordinal;
> >  	unsigned long stop;
> > @@ -547,8 +547,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > *chip,
> >  		dev_err(&chip->dev, "tpm2_commit_space: error
> > %d\n", rc);
> >  
> >  out:
> > -	rc = tpm_go_idle(chip, flags);
> > -	if (rc)
> > +	rc1 = tpm_go_idle(chip, flags);
> > +	if (rc1)
> >  		goto out;
> >  
> >  	if (need_locality)
> 
> Thanks James and sorry for latency (holiday season). Just a small
> suggestion. I would just:
> 
> if (tpm_go_idle(chip, flags))
> 	goto out;
> 
> What do you think?

That it doesn't solve the loop forever with no warning problem.  If
anything, I think the correct thing is probably

	rc1 = tpm_go_idle(chip, flags);
	if (rc1)
  		dev_err(&chip->dev, "go idle failed with %d\n", rc1);

so we log the problem and move on.  If it is a timeout, it will likely
show up on the next TPM operation.  Since this is the only caller of
tpm_go_idle(), I think all looping should be done inside that function,
but we should probably wait for Tomas to comment since he wrote it.

James

