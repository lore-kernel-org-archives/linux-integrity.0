Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20033 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967360AbeBNLoN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Feb 2018 06:44:13 -0500
Date: Wed, 14 Feb 2018 13:44:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
Message-ID: <20180214114353.tw72tztmth2agpqu@linux.intel.com>
References: <20171111154516.GI17451@ziepe.ca>
 <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca>
 <20171111203132.hkejjs6cdrrzq3y3@cantor>
 <20171114145953.m3a343qvgln2z4er@linux.intel.com>
 <1510672631.4078.7.camel@HansenPartnership.com>
 <20171117131620.het4yxavz6lco6ow@linux.intel.com>
 <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
 <20180103003355.oaie7tych5lmtxiq@cantor>
 <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 09, 2018 at 11:53:55AM +0100, Laurent Bigonville wrote:
> I don't remember if I replied to this, re-posting to be sure:
>
> Le 03/01/18 a 01:33, Jerry Snitselaar a ecrit :
> > Hi Laurent,
> >
> > Can you try the following debug patch (earlier idea of adding a sleep to
> > allow
> > tpm to complete state transition):
> >
> > --8<--
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index fdde971bc810..6a9325b02059 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -80,6 +80,7 @@ static void release_locality(struct tpm_chip *chip,
> > int l)
> >     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >
> >     tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> > +    tpm_msleep(200);
> > }
> >
> > static int request_locality(struct tpm_chip *chip, int l)
>
> I tried the patch and this is working.
>
> Would that be a viable solution?
>
> Kind regards,
>
> Laurent Bigonville

According to the PC client specification in the section 5.5.2.3:

"For commands indicated as short or medium duration (i.e., those that do
not cause key  generation), the TPM SHALL respond to an abort within
TIMEOUT_A. For commands indicated as lon g duration or those that cause
key generation, the TPM SHALL respond to a request to abort the command
within TIMEOUT B"

The section 5.5.2.4 describing the access register does not give much
more light to this i.e. what the expected duration maximum is when there
is no command executing.

/Jarkko
