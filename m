Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:3904
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750730AbeDLHMf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Apr 2018 03:12:35 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Martin Townsend <mtownsend1973@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size
 Error
Date: Thu, 12 Apr 2018 07:12:31 +0000
Message-ID: <VI1PR0402MB3485555C22D36209A5F65A4598BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com>
 <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5BmepNWhMzL6J2hbf=+0YzsBZuOVqo+8jA-bLsYuGm8dA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 4/11/2018 8:26 PM, Fabio Estevam wrote:
> Hi Horia,
> 
> On Wed, Apr 11, 2018 at 7:15 AM, Horia Geanta <horia.geanta@nxp.com> wrote:
> 
>> You'd want to make sure rsa is offloaded to caam in this case - check in
>> /proc/crypto.
>> IIRC there are some i.mx parts that don't have support for Public Key
>> acceleration (PKHA).
> 
> PKHA is present on mx6ul and not present on mx6q.
> 
> mx6uq uses the generic rsa driver and handles the certificate correctly.
> 
> mx6ul uses pkcs1pad(rsa-caam,sha256) and it fails to handle the certificate.
> 
> So that explains the different behavior of mx6q versus mx6ul.
> 
Thanks for confirming my guess.

> Any ideas as to how to fix rsa-caam?
> 
Yes, driver needs to strip off leading zeros from input data before feeding it
to the accelerator.
I am working at a fix.

Horia
