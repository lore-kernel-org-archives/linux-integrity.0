Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45080 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDNBGk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Apr 2018 21:06:40 -0400
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB348540499F4BE0C139D9FF0C98B30@VI1PR0402MB3485.eurprd04.prod.outlook.com>
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
 <CAOMZO5CLYRidtr9z_dhFLrVNau-Sn-s__RBeLe0N_J3-D51yEg@mail.gmail.com> <VI1PR0402MB348540499F4BE0C139D9FF0C98B30@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 13 Apr 2018 22:06:39 -0300
Message-ID: <CAOMZO5DXMicAZijRR7W5KGrUMRzG3-y2gmRtMrHtEqg+t55m-Q@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Martin Townsend <mtownsend1973@gmail.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Horia,

On Fri, Apr 13, 2018 at 3:18 AM, Horia Geanta <horia.geanta@nxp.com> wrote:

> Stripping should happen before set_rsa_pub_pdb() is called since the Protocol
> Data Block contains the input length that is used by the accelerator:
>         pdb->f_len = req->src_len;
>
> It should probably be moved at the top of rsa_edesc_alloc().

That did the trick, thanks!

> Ideally stripping would avoid copying data (and memory allocation for temporary
> buffers).

I will try to optimize this aspect and will post a proper patch.

Martin,

Before I try to optimize it, I would like to share the patch
(generated against linux-next) so that you can try it in your IMA
usecase:
http://code.bulix.org/n77z3e-318473

Does it work for you?

Thanks
