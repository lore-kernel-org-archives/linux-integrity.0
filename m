Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:14619
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752929AbeDMGSK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Apr 2018 02:18:10 -0400
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
Date: Fri, 13 Apr 2018 06:18:06 +0000
Message-ID: <VI1PR0402MB348540499F4BE0C139D9FF0C98B30@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com>
 <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5BmepNWhMzL6J2hbf=+0YzsBZuOVqo+8jA-bLsYuGm8dA@mail.gmail.com>
 <VI1PR0402MB3485555C22D36209A5F65A4598BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5CLYRidtr9z_dhFLrVNau-Sn-s__RBeLe0N_J3-D51yEg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 4/13/2018 3:12 AM, Fabio Estevam wrote:
> Hi Horia,
> 
> On Thu, Apr 12, 2018 at 4:12 AM, Horia Geanta <horia.geanta@nxp.com> wrote:
> 
>> Yes, driver needs to strip off leading zeros from input data before feeding it
>> to the accelerator.
>> I am working at a fix.
> 
> I was able to to strip off the leading zeros from input data as you suggested.
> 
> My changes are like this at the moment:
> 
[snip]
> but still get the original error as shown below.
> 
> Any ideas?
> 
Stripping should happen before set_rsa_pub_pdb() is called since the Protocol
Data Block contains the input length that is used by the accelerator:
	pdb->f_len = req->src_len;

It should probably be moved at the top of rsa_edesc_alloc().

Ideally stripping would avoid copying data (and memory allocation for temporary
buffers).

Horia
