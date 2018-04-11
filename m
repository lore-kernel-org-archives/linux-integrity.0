Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40054 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeDKR0C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Apr 2018 13:26:02 -0400
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com> <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Apr 2018 14:26:01 -0300
Message-ID: <CAOMZO5BmepNWhMzL6J2hbf=+0YzsBZuOVqo+8jA-bLsYuGm8dA@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Horia,

On Wed, Apr 11, 2018 at 7:15 AM, Horia Geanta <horia.geanta@nxp.com> wrote:

> You'd want to make sure rsa is offloaded to caam in this case - check in
> /proc/crypto.
> IIRC there are some i.mx parts that don't have support for Public Key
> acceleration (PKHA).

PKHA is present on mx6ul and not present on mx6q.

mx6uq uses the generic rsa driver and handles the certificate correctly.

mx6ul uses pkcs1pad(rsa-caam,sha256) and it fails to handle the certificate.

So that explains the different behavior of mx6q versus mx6ul.

Any ideas as to how to fix rsa-caam?

Thanks
