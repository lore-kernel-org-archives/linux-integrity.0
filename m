Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41776 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeDKCVR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 22:21:17 -0400
MIME-Version: 1.0
In-Reply-To: <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com> <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Apr 2018 23:21:15 -0300
Message-ID: <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: Horia Geanta Neag <horia.geanta@nxp.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Martin,

On Tue, Apr 10, 2018 at 7:01 PM, Martin Townsend
<mtownsend1973@gmail.com> wrote:

> A hexdump of the signature reveals a 0x00 at the start

Yes, same is happening here on my mx6ul evk running linux-next:

[    2.990651] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    2.999046] signature00000000: 00 87 03 da f2 82 c2 dd af 7c 44 2f
86 d3 5f 4c  .........|D/.._L
[    3.008213] signature00000010: 93 48 b9 fe 07 17 bb 21 f7 25 23 4e
aa 22 0c 16  .H.....!.%#N."..
[    3.017069] signature00000020: b9 73 ae 9d 46 7c 75 d9 c3 49 57 47
bf 33 b7 97  .s..F|u..IWG.3..
[    3.026064] signature00000030: ec f5 40 75 c0 46 22 f0 a0 5d 9c 79
13 a1 ff b8  ..@u.F"..].y....
[    3.035049] signature00000040: a3 2f 7b 8e 06 3f c8 b6 e4 6a 28 f2
34 5c 23 3f  ./{..?...j(.4\#?
[    3.043994] signature00000050: 32 c0 e6 ad 0f ac cf 55 74 47 73 d3
01 85 b7 0b  2......UtGs.....
[    3.052941] signature00000060: 22 56 24 7d 9f 09 a9 0e 86 9e 37 5b
9c 6d 02 d9  "V$}......7[.m..
[    3.061879] signature00000070: 8c c8 50 6a e2 59 f3 16 06 ea b2 42
b5 58 fe ba  ..Pj.Y.....B.X..
[    3.070813] signature00000080: d1 81 57 1a ef b2 38 88 58 f6 aa c4
2e 8b 5a 27  ..W...8.X.....Z'
[    3.079742] signature00000090: e4 a5 e8 a4 ca 67 5c ac 72 67 c3 6f
13 c3 2d 35  .....g\.rg.o..-5
[    3.088669] signature000000a0: 79 d7 8a e7 f5 d4 21 30 4a d5 f6 a3
d9 79 56 f2  y.....!0J....yV.
[    3.097512] signature000000b0: 0f 10 f7 7d d0 51 93 2f 47 f8 7d 4b
0a 84 55 12  ...}.Q./G.}K..U.
[    3.106437] signature000000c0: 0a 7d 4e 3b 1f 2b 2f fc 28 b3 69 34
e1 80 80 bb  .}N;.+/.(.i4....
[    3.115366] signature000000d0: e2 af b9 d6 30 f1 1d 54 87 23 99 9f
51 03 4c 45  ....0..T.#..Q.LE
[    3.124292] signature000000e0: 7d 02 65 73 ab fd cf 94 cc 0d 3a 60
fd 3c 14 2f  }.es......:`.<./
[    3.133238] signature000000f0: 16 33 a9 21 1f cb 50 b1 8f 03 ee a0
66 a9 16 79  .3.!..P.....f..y
[    3.142189] signature00000100: 14
            .
[    3.155013] caam_jr 2142000.jr1: 40000789: DECO: desc idx 7:
Protocol Size Error - A protocol has seen an error in size. When
running RSA, pdb size N < (size of F) when no formatting is used; or
pdb si
ze N < (F + 11) when formatting is used.

However, the same kernel running on a mx6 board does not give the
"Protocol Size Error":

[    2.654244] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    2.662221] signature00000000: 00 87 03 da f2 82 c2 dd af 7c 44 2f
86 d3 5f 4c  .........|D/.._L
[    2.671221] signature00000010: 93 48 b9 fe 07 17 bb 21 f7 25 23 4e
aa 22 0c 16  .H.....!.%#N."..
[    2.680082] signature00000020: b9 73 ae 9d 46 7c 75 d9 c3 49 57 47
bf 33 b7 97  .s..F|u..IWG.3..
[    2.688893] signature00000030: ec f5 40 75 c0 46 22 f0 a0 5d 9c 79
13 a1 ff b8  ..@u.F"..].y....
[    2.697750] signature00000040: a3 2f 7b 8e 06 3f c8 b6 e4 6a 28 f2
34 5c 23 3f  ./{..?...j(.4\#?
[    2.706604] signature00000050: 32 c0 e6 ad 0f ac cf 55 74 47 73 d3
01 85 b7 0b  2......UtGs.....
[    2.715460] signature00000060: 22 56 24 7d 9f 09 a9 0e 86 9e 37 5b
9c 6d 02 d9  "V$}......7[.m..
[    2.724323] signature00000070: 8c c8 50 6a e2 59 f3 16 06 ea b2 42
b5 58 fe ba  ..Pj.Y.....B.X..
[    2.733182] signature00000080: d1 81 57 1a ef b2 38 88 58 f6 aa c4
2e 8b 5a 27  ..W...8.X.....Z'
[    2.742032] signature00000090: e4 a5 e8 a4 ca 67 5c ac 72 67 c3 6f
13 c3 2d 35  .....g\.rg.o..-5
[    2.750883] signature000000a0: 79 d7 8a e7 f5 d4 21 30 4a d5 f6 a3
d9 79 56 f2  y.....!0J....yV.
[    2.759737] signature000000b0: 0f 10 f7 7d d0 51 93 2f 47 f8 7d 4b
0a 84 55 12  ...}.Q./G.}K..U.
[    2.768543] signature000000c0: 0a 7d 4e 3b 1f 2b 2f fc 28 b3 69 34
e1 80 80 bb  .}N;.+/.(.i4....
[    2.777403] signature000000d0: e2 af b9 d6 30 f1 1d 54 87 23 99 9f
51 03 4c 45  ....0..T.#..Q.LE
[    2.786259] signature000000e0: 7d 02 65 73 ab fd cf 94 cc 0d 3a 60
fd 3c 14 2f  }.es......:`.<./
[    2.795110] signature000000f0: 16 33 a9 21 1f cb 50 b1 8f 03 ee a0
66 a9 16 79  .3.!..P.....f..y
[    2.803957] signature00000100: 14
            .
[    2.816788] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.824922] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    2.829396] ALSA device list:
[    2.833904] cfg80211: failed to load regulatory.db
