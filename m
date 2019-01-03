Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A5C43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B0E217D9
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 13:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfACNrg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:47:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:49402 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfACNrg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 08:47:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 05:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="105224248"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2019 05:37:33 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 3 Jan 2019 05:37:32 -0800
Received: from HASMSX109.ger.corp.intel.com (10.184.198.21) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 3 Jan 2019 05:37:32 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.79]) by
 hasmsx109.ger.corp.intel.com ([169.254.3.179]) with mapi id 14.03.0415.000;
 Thu, 3 Jan 2019 15:37:10 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Thread-Topic: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Thread-Index: AQHUoTaDP3+Er/wooEum4hDGaSfDgKWdZEEAgAAnKGA=
Date:   Thu, 3 Jan 2019 13:37:09 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA62640@hasmsx108.ger.corp.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
 <20190103125904.GA10491@linux.intel.com>
In-Reply-To: <20190103125904.GA10491@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTgzOTc2MDUtMzVlMi00NDMzLTk5ZTUtNGMwMGUwYTY5ZGM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia1FrbVRpaWtvOUt1RnFBTWdYTUo1M1UzQVRMTG5OSGljaGYyK1JFXC9HY1wvaVJXSTY2Z2R0NzNYUGhYTEFyZlpjIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.254.144.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> 
> On Mon, Dec 31, 2018 at 10:27:31AM -0800, James Bottomley wrote:
> > Ever since 627448e85c766 "tpm: separate cmd_ready/go_idle from
> > runtime_pm" we have been returning success from tpm_try_transmit()
> > even if an error occurred.  The reason is that the introduction of rc
> > = tpm_go_idle() at the end of processing overwrites the value of rc if
> > it contains an error code (mostly with success).  Fix this by writing
> > the return to a new variable rc1 instead.
> >
> > Fixes: 627448e85c766 "tpm: separate cmd_ready/go_idle from runtime_pm"
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >
> > ---
> >
> > Note: the goto out looks fishy as well.  The only go_idle implementor
> > is tpm_crb and that can return a timeout as -ETIME, so it looks like
> > it would then loop forever
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 129f640424b7..ac7ebab6140c 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -432,7 +432,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
> >  				unsigned int flags)
> >  {
> >  	struct tpm_output_header *header = (void *)buf;
> > -	int rc;
> > +	int rc, rc1;
> >  	ssize_t len = 0;
> >  	u32 count, ordinal;
> >  	unsigned long stop;
> > @@ -547,8 +547,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
> >  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
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
> Thanks James and sorry for latency (holiday season). Just a small suggestion. I
> would just:
> 
> if (tpm_go_idle(chip, flags))
> 	goto out;
> 
> What do you think?


This is wrong as well because of the jump to 'out'.
I've introduced this bug in version 4 of the patch, when the wrappers were added, before the jump to 'out' was correct.
If it's okay with you I will post my version of the fix.
Thanks
Tomas

