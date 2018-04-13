Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:41173 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDMAME (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Apr 2018 20:12:04 -0400
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3485555C22D36209A5F65A4598BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com>
 <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
 <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
 <CAOMZO5Dfyp8iFd7i+6a-4XefFd0iHF6rUY6N12b_W_MeHQ4QpA@mail.gmail.com>
 <VI1PR0402MB3485F2A0D0A92BD055F4973098BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5BmepNWhMzL6J2hbf=+0YzsBZuOVqo+8jA-bLsYuGm8dA@mail.gmail.com> <VI1PR0402MB3485555C22D36209A5F65A4598BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Apr 2018 21:12:02 -0300
Message-ID: <CAOMZO5CLYRidtr9z_dhFLrVNau-Sn-s__RBeLe0N_J3-D51yEg@mail.gmail.com>
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

On Thu, Apr 12, 2018 at 4:12 AM, Horia Geanta <horia.geanta@nxp.com> wrote:

> Yes, driver needs to strip off leading zeros from input data before feeding it
> to the accelerator.
> I am working at a fix.

I was able to to strip off the leading zeros from input data as you suggested.

My changes are like this at the moment:

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 7a897209..ef9b9c2 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -500,6 +500,14 @@ static int set_rsa_priv_f3_pdb(struct
akcipher_request *req,
        return -ENOMEM;
 }

+static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
+{
+       while (!**ptr && *nbytes) {
+               (*ptr)++;
+               (*nbytes)--;
+       }
+}
+
 static int caam_rsa_enc(struct akcipher_request *req)
 {
        struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
@@ -507,7 +515,10 @@ static int caam_rsa_enc(struct akcipher_request *req)
        struct caam_rsa_key *key = &ctx->key;
        struct device *jrdev = ctx->dev;
        struct rsa_edesc *edesc;
+       void *buffer;
+       const u8 *temp;
        int ret;
+       size_t len;

        if (unlikely(!key->n || !key->e))
                return -EINVAL;
@@ -531,6 +542,46 @@ static int caam_rsa_enc(struct akcipher_request *req)
        /* Initialize Job Descriptor */
        init_rsa_pub_desc(edesc->hw_desc, &edesc->pdb.pub);

+       buffer = kmalloc(req->src_len, GFP_ATOMIC);
+       if (!buffer)
+               return -ENOMEM;
+
+       temp = kmalloc(req->src_len, GFP_ATOMIC);
+       if (!temp)
+               return -ENOMEM;
+
+       sg_copy_to_buffer(req->src, sg_nents(req->src),
+                         buffer, req->src_len);
+
+       temp = (u8 *)buffer;
+       len = req->src_len;
+       if (temp[0] != 0)
+               goto jr_enqueue;
+       else
+               pr_err("******* Leading zero found\n");
+
+       pr_err("******* Original buffer \n");
+       pr_err("***** temp[0] = 0x%x\n", temp[0]);
+       pr_err("***** temp[1] = 0x%x\n", temp[1]);
+       pr_err("***** temp[2] = 0x%x\n", temp[2]);
+       pr_err("***** temp[3] = 0x%x\n", temp[3]);
+       pr_err("***** Original size: %d\n", req->src_len);
+
+       caam_rsa_drop_leading_zeros(&temp, &len);
+       if (!temp)
+               return -ENOMEM;
+
+       pr_err("******* Buffer after dropping lead zero \n");
+       pr_err("***** temp[0] = 0x%x\n", temp[0]);
+       pr_err("***** temp[1] = 0x%x\n", temp[1]);
+       pr_err("***** temp[2] = 0x%x\n", temp[2]);
+       pr_err("***** temp[3] = 0x%x\n", temp[3]);
+
+       req->src_len = req->src_len - 1;
+       pr_err("***** Final size: %d\n", req->src_len);
+       sg_copy_from_buffer(req->src, sg_nents(req->src),
+                                 (void *)temp, req->src_len);
+jr_enqueue:
        ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_pub_done, req);
        if (!ret)
                return -EINPROGRESS;
@@ -683,14 +734,6 @@ static void caam_rsa_free_key(struct caam_rsa_key *key)
        memset(key, 0, sizeof(*key));
 }

-static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
-{
-       while (!**ptr && *nbytes) {
-               (*ptr)++;
-               (*nbytes)--;
-       }
-}
-
 /**
  * caam_read_rsa_crt - Used for reading dP, dQ, qInv CRT members.
  * dP, dQ and qInv could decode to less than corresponding p, q length, as the

but still get the original error as shown below.

Any ideas?

Thanks

[    2.985258] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    2.998105] ******* Leading zero found
[    3.002100] ******* Original buffer
[    3.005734] ***** temp[0] = 0x0
[    3.009147] ***** temp[1] = 0x87
[    3.012440] ***** temp[2] = 0x3
[    3.015634] ***** temp[3] = 0xda
[    3.019036] ***** Original size: 257
[    3.022675] ******* Buffer after dropping lead zero
[    3.027805] ***** temp[0] = 0x87
[    3.031092] ***** temp[1] = 0x3
[    3.034286] ***** temp[2] = 0xda
[    3.037673] ***** temp[3] = 0xf2
[    3.040960] ***** Final size: 256
[    3.044501] caam_jr 2142000.jr1: 40000789: DECO: desc idx 7:
Protocol Size Error - A protocol has seen an error in size. When
running RSA, pdb size N < (size of F) when no formatting is used; or
pdb si
ze N < (F + 11) when formatting is used.
[    3.067864] ------------[ cut here ]------------
[    3.072600] WARNING: CPU: 0 PID: 1 at
crypto/asymmetric_keys/public_key.c:148
public_key_verify_signature+0x27c/0x2b0
[    3.083390] Modules linked in:
[    3.086542] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.16.0-next-20180410-00005-g5e59986-dirty #323
[    3.095726] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    3.101954] Backtrace:
[    3.104482] [<c010d118>] (dump_backtrace) from [<c010d3d8>]
(show_stack+0x18/0x1c)
[    3.112113]  r7:00000000 r6:60000153 r5:00000000 r4:c107ae78
[    3.117840] [<c010d3c0>] (show_stack) from [<c0a50f24>]
(dump_stack+0xb4/0xe8)
[    3.125126] [<c0a50e70>] (dump_stack) from [<c012618c>] (__warn+0x104/0x130)
[    3.132236]  r9:d804dc94 r8:00000094 r7:00000009 r6:c0d3aed8
r5:00000000 r4:00000000
[    3.140036] [<c0126088>] (__warn) from [<c01262d0>]
(warn_slowpath_null+0x44/0x50)
[    3.147665]  r8:c1008908 r7:d87846c0 r6:c040bbc4 r5:00000094 r4:c0d3aed8
[    3.154428] [<c012628c>] (warn_slowpath_null) from [<c040bbc4>]
(public_key_verify_signature+0x27c/0x2b0)
[    3.164049]  r6:40000789 r5:d8782e00 r4:d8787ec0
[    3.168731] [<c040b948>] (public_key_verify_signature) from
[<c040cbd4>] (x509_check_for_self_signed+0xc8/0x104)
[    3.178963]  r10:d802f000 r9:c0bcb210 r8:000002a8 r7:d8787e80
r6:d8787ec0 r5:00000000
[    3.186839]  r4:d8782c80
[    3.189434] [<c040cb0c>] (x509_check_for_self_signed) from
[<c040bdd0>] (x509_cert_parse+0x11c/0x190)
[    3.198710]  r7:c0bcb210 r6:d8787f00 r5:d8782c80 r4:d8787e80
[    3.204433] [<c040bcb4>] (x509_cert_parse) from [<c040c860>]
(x509_key_preparse+0x1c/0x194)
[    3.212842]  r9:c0bcb210 r8:c10235dc r7:d804de30 r6:c1026a84
r5:d804de30 r4:c1026af0
[    3.220648] [<c040c844>] (x509_key_preparse) from [<c040adbc>]
(asymmetric_key_preparse+0x50/0x80)
[    3.229665]  r9:c0bcb210 r8:c10235dc r7:d804de30 r6:c1026a84
r5:c1008908 r4:c1026af0
[    3.237473] [<c040ad6c>] (asymmetric_key_preparse) from
[<c03e40b4>] (key_create_or_update+0x138/0x404)
[    3.246920]  r7:d8495601 r6:d8495600 r5:c1008908 r4:c1026a8c
[    3.252650] [<c03e3f7c>] (key_create_or_update) from [<c0f5a9c4>]
(regulatory_init_db+0xf4/0x1e8)
[    3.261586]  r10:0000000e r9:1f030000 r8:c0d1d174 r7:c17f1e7c
r6:c0bcb4b8 r5:000002a8
[    3.269465]  r4:c0bcb210
[    3.272067] [<c0f5a8d0>] (regulatory_init_db) from [<c0102764>]
(do_one_initcall+0x50/0x1a4)
[    3.280572]  r10:c0f00630 r9:c0f64858 r8:c107cb00 r7:00000000
r6:c0f5a8d0 r5:c1008908
[    3.288448]  r4:ffffe000
[    3.291047] [<c0102714>] (do_one_initcall) from [<c0f00f04>]
(kernel_init_freeable+0x118/0x1d8)
[    3.299810]  r9:c0f64858 r8:000000f4 r7:c0e1ec80 r6:c0f64854
r5:c107cb00 r4:c0f78f70
[    3.307620] [<c0f00dec>] (kernel_init_freeable) from [<c0a667b8>]
(kernel_init+0x10/0x118)
[    3.315947]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c0a667a8
[    3.323826]  r4:00000000
[    3.326423] [<c0a667a8>] (kernel_init) from [<c01010b4>]
(ret_from_fork+0x14/0x20)
[    3.334042] Exception stack(0xd804dfb0 to 0xd804dff8)
[    3.339150] dfa0:                                     00000000
00000000 00000000 00000000
[    3.347389] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    3.355620] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    3.362283]  r5:c0a667a8 r4:00000000
[    3.366061] irq event stamp: 186637
[    3.369710] hardirqs last  enabled at (186647): [<c01803b8>]
console_unlock+0x4d4/0x5c8
[    3.377877] hardirqs last disabled at (186656): [<c017ffac>]
console_unlock+0xc8/0x5c8
[    3.385867] softirqs last  enabled at (186588): [<c01023a0>]
__do_softirq+0x1f8/0x2a0
[    3.393847] softirqs last disabled at (186525): [<c012bffc>]
irq_exit+0x14c/0x1a8
[    3.401470] ---[ end trace 6e7c53a2c467c87b ]---
[    3.406196] cfg80211: Problem loading in-kernel X.509 certificate (-22)
[    3.416311] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    3.425458] cfg80211: failed to load regulatory.db
