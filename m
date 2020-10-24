Return-Path: <SRS0=Mr59=D7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE25C4363A
	for <linux-integrity@archiver.kernel.org>; Sat, 24 Oct 2020 12:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47E720725
	for <linux-integrity@archiver.kernel.org>; Sat, 24 Oct 2020 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603541841;
	bh=GC6vaE3SexjFzImO0cOeWETygvoJQkubjbau5l5NV6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WSe7fsjVVDtRFwS0GecOOfaO2+XFiQ17jyHXoD8XOQsXdWethxjElIa6q5K428wmb
	 8qR2uin22guv2yROoLXInzKE1fcq5qhSFeX5fm7XjKJuGwPw7TwpP+s6hPM+HaSy8z
	 uKqS/hqTAAibmY45OOjrxb9L2bT2++ZiVvyv3JZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758623AbgJXMRV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 24 Oct 2020 08:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758529AbgJXMRV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Oct 2020 08:17:21 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352722226B;
        Sat, 24 Oct 2020 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603541840;
        bh=GC6vaE3SexjFzImO0cOeWETygvoJQkubjbau5l5NV6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xNGSOgkobCWbZ1kbhq4TE9a6nv7vocbbs+2wemTyckLfJ96QPZBeR9tiRsHSoU+hE
         o3vjVidSeOrUoK5njzLQKkVNEIQiO62onOTWURAxxHjpSt7dLV448zXzQI/kM6mTxE
         kblIhd89+SvWXFeOUWOWRbuvDwgZYF/qBa6YiMYI=
Date:   Sat, 24 Oct 2020 15:17:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201024121718.GC32960@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh4hg4wg.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 04:41:35PM -0700, Jerry Snitselaar wrote:
> 
> James Bottomley @ 2020-10-01 11:09 MST:
> 
> > There are two problems with our current interrupt probing: firstly the
> > TPM_CHIP_FLAG_IRQ never gets set initially, so a check for interrupts
> > is never done.  Fix this by setting the flag before we generate and
> > interrupt for probing.  Secondly our IRQ setup may be ineffective on a
> > TPM without legacy access cycles becuase according to the TPM
> > Interface Specification the interrupt registers are only writeable in
> > the current locality, so issue a request_locality before setting up
> > the interrupts.
> >
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >
> > ---
> >
> > v2: improved description
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 0c07da8cd680..12b657ed3a39 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -809,6 +809,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
> >  	}
> >  	priv->irq = irq;
> >  
> > +	/*
> > +	 * note writes to the interrupt registers are only effective
> > +	 * when the TPM is in the active locality, so we have to
> > +	 * request the locality here to get the interrupt set up.
> > +	 * This request has no corresponding release, because the
> > +	 * locality will be relinquished at the end of the tpm command
> > +	 * that probes the interrupts
> > +	 */
> > +	if (request_locality(chip, 0) != 0) {
> > +		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
> > +		return -EBUSY;
> > +	}

Appreciate the comment a lot, but s/note/Note/

/Jarkko
