Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56035 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeABUyA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 15:54:00 -0500
Date: Tue, 2 Jan 2018 21:53:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20180102205356.GA24307@amd>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <34783fa1-4235-0057-1351-f7da9ee57024@redhat.com>
 <1d724655-b0cc-b1bd-c771-839a04a74000@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1d724655-b0cc-b1bd-c771-839a04a74000@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e7bd2e750f69..0858c08b3b89 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -688,7 +688,7 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>  	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
>  	u32 clkrun_val;
>  
> -	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
> +	if (!IS_ENABLED(TCG_TIS_ENABLE_CLKRUN_QUIRK) || !is_bsw())

Missing CONFIG_?
								pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


    [ Part 2, "Digital signature"  Application/PGP-SIGNATURE (Name: ]
    [ "signature.asc") 188 bytes. ]
    [ Unable to print this part. ]
