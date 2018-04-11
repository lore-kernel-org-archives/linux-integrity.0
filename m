Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:36592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751409AbeDKKPu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Apr 2018 06:15:50 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Fabio Estevam <festevam@gmail.com>,
        Martin Townsend <mtownsend1973@gmail.com>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size
 Error
Date: Wed, 11 Apr 2018 10:15:47 +0000
Message-ID: <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 4/11/2018 5:21 AM, Fabio Estevam wrote:
> Hi Martin,
> 
> On Tue, Apr 10, 2018 at 7:01 PM, Martin Townsend
> <mtownsend1973@gmail.com> wrote:
> 
>> A hexdump of the signature reveals a 0x00 at the start
> 
> Yes, same is happening here on my mx6ul evk running linux-next:
> 
[snip]
> 
> However, the same kernel running on a mx6 board does not give the
> "Protocol Size Error":
> 
You'd want to make sure rsa is offloaded to caam in this case - check in
/proc/crypto.
IIRC there are some i.mx parts that don't have support for Public Key
acceleration (PKHA).

Horia
