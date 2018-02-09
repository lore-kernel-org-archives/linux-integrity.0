Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from anor.bigon.be ([91.121.173.99]:38528 "EHLO anor.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeBILDq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:46 -0500
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
References: <9245ef7d-dd34-fa5f-6fd9-bfb9582f910e@debian.org>
 <20171110205300.eyfkoyabobv7llgb@localhost.localdomain>
 <20171111154516.GI17451@ziepe.ca> <20171111191257.owuqtgzie3ostsab@cantor>
 <20171111194647.GA6918@ziepe.ca> <20171111203132.hkejjs6cdrrzq3y3@cantor>
 <20171114145953.m3a343qvgln2z4er@linux.intel.com>
 <1510672631.4078.7.camel@HansenPartnership.com>
 <20171117131620.het4yxavz6lco6ow@linux.intel.com>
 <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
 <20180103003355.oaie7tych5lmtxiq@cantor>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
Date: Fri, 9 Feb 2018 11:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180103003355.oaie7tych5lmtxiq@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I don't remember if I replied to this, re-posting to be sure:

Le 03/01/18 a 01:33, Jerry Snitselaar a ecrit :
> Hi Laurent,
>
> Can you try the following debug patch (earlier idea of adding a sleep 
> to allow
> tpm to complete state transition):
>
> --8<--
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c 
> b/drivers/char/tpm/tpm_tis_core.c
> index fdde971bc810..6a9325b02059 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,6 +80,7 @@ static void release_locality(struct tpm_chip *chip, 
> int l)
>     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>
>     tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +    tpm_msleep(200);
> }
>
> static int request_locality(struct tpm_chip *chip, int l)

I tried the patch and this is working.

Would that be a viable solution?

Kind regards,

Laurent Bigonville
