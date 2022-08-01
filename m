Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99060C19F29
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Aug 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiHAM45 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiHAM4n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Aug 2022 08:56:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF19FFD;
        Mon,  1 Aug 2022 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1659358547;
  x=1690894547;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=RYmAUi+YwukWu4Wx94/JkssMHy+CcsetmdFvVeFbL/4=;
  b=VNoP9t90DIKfuwEbUXl6UANmVmHCTexy67z+0hvm2pV/Q9crsj8hF2zL
   DdSdQ7ofiRvrgozU445t7adv1yauJYn5+Kt+NLTyqRYMpN/skGA+DjFok
   nxmcbIX7jHxfzPWL4hodgS7usARi2h9nPVUdTjYYGJ8uHIjBaiPvnIsOU
   YR0gEpy9lkgBPbiQOQeF9QkHgHJlPpd98PM+Vw/YbcIikDZSqOykUlZls
   jL+Kq07eWxGeYcDo9xv3RCf6v2BpirkvBePgP93QrvyEpG6FAe9NZ5G9W
   mImbTqWflZEX4X1kpj+kkv4hfqkhpokRMHmw5HlHUbOcHeXp9wZdYlzXm
   Q==;
Date:   Mon, 1 Aug 2022 14:55:35 +0200
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YufNR0WT5L+cb2+E@axis.com>
References: <20220705132423.232603-1-marten.lindahl@axis.com>
 <YsuQW/N/lMtFT1U6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsuQW/N/lMtFT1U6@kernel.org>
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 11, 2022 at 04:52:11AM +0200, Jarkko Sakkinen wrote:
> On Tue, Jul 05, 2022 at 03:24:23PM +0200, M??rten Lindahl wrote:
> > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > TPM2 modules") it was said that:
> > 
> > "If the TPM is in Failure mode, it will successfully respond to both
> > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > is in Failure mode."
> > 
> > But a check was never added in the commit when calling
> > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > This commit corrects this by adding a check.
> > 
> > Fixes: 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for TPM2 modules")
> > Cc: stable@vger.kernel.org # v5.17+
> > Signed-off-by: M??rten Lindahl <marten.lindahl@axis.com>
> 
> The characters here are messed up.

Hi!

Sorry, I don't know why it looks like that. The patch looks fine as far
as I can see. I will resend it again.

Kind regards
Mårten

> 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > 
> > v3:
> >  - Add Jarkkos Reviewed-by tag.
> >  - Add Fixes tag and Cc.
> > 
> > v2:
> >  - Add missed check for TPM error code.
> > 
> >  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index c1eb5d223839..65d03867e114 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -752,6 +752,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >  	}
> >  
> >  	rc = tpm2_get_cc_attrs_tbl(chip);
> > +	if (rc == TPM2_RC_FAILURE || (rc < 0 && rc != -ENOMEM)) {
> > +		dev_info(&chip->dev,
> > +			 "TPM in field failure mode, requires firmware upgrade\n");
> > +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> > +		rc = 0;
> > +	}
> >  
> >  out:
> >  	/*
> > -- 
> > 2.30.2
> > 
> 
> BR, Jarkko
