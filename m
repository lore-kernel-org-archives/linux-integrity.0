Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:42691 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeDJWBl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 18:01:41 -0400
MIME-Version: 1.0
In-Reply-To: <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
 <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
 <CAOMZO5DdS-n2taSMsXHAFotCHZdg3Z1in5fy10_5F4Ttwj4vLw@mail.gmail.com> <CABatt_y94bWRJct_T94kcUt1F-BLgsNf4Q0Ay=_ozV93E7pUSA@mail.gmail.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Tue, 10 Apr 2018 23:01:38 +0100
Message-ID: <CABatt_yokAz4bozv5mGu44rh_sZaok-fGj36p2Z3EpcXYiphVA@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: Fabio Estevam <festevam@gmail.com>
Cc: Horia Geanta Neag <horia.geanta@nxp.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Breno Matheus Lima <brenomatheus@gmail.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Apr 10, 2018 at 7:43 PM, Martin Townsend
<mtownsend1973@gmail.com> wrote:
> Hi Fabio,
>
> On Tue, Apr 10, 2018 at 7:22 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Martin,
>>
>> On Tue, Apr 10, 2018 at 2:06 PM, Martin Townsend
>> <mtownsend1973@gmail.com> wrote:
>>> Hi Fabio,
>>>
>>> On Tue, Apr 10, 2018 at 5:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>>> Hi Martin,
>>>>
>>>> On Mon, Apr 9, 2018 at 5:41 AM, Martin Townsend <mtownsend1973@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I'm trying to get to the bottom of an issue I'm seeing when enabling
>>>>> the CAAM in the kernel with IMA/EVM enabled.  I'm using the official
>>>>> NXP (imx_4.9.11_1.0.0_ga) vendor Kernel.
>>>>
>>>> Does it work better if you try mainline kernel instead?
>>>
>>> I had a few issues getting mainline working, the board kept resetting,
>>
>> Let's try to fix this reset problem then :-)
>
> My preference would be mainline, no offence to the NXP kernel but it
> would be good to use the LTSI kernel so we get security updates etc :)
>  The reset was something to do with USB but that was as far as I got.
>
>>
>>> when I checked there are lots of patches in the NXP kernel not in
>>> mainline.   This CAAM problem does occur really early in the boot so
>>> just for an experiment its worth a try.
>>
>> Ok, I just applied this patch that adds CAAM for mx6ull against linux-next:
>>
>> http://code.bulix.org/rjkzt5-317022
>>
>> and I see the following issue with cfg80211 certificate, but I do not
>> get a reset as you reported:
>
> The reset (which is not the reset described above) occurs because I
> have IMA enabled and because it can't load the x509 certificate it
> can't verify init on the filesystem and hence it panics and resets.
>
> The message you are seeing below is the same as I'm seeing.  I'm not
> sure if you've seen my later posts but I put some debug statements and
> could see that in my case the signature is 257 bytes and key 270 bytes
> which is at odds with the error message.  Reading a post some
> signatures can contain extra information beside the signature so I'm
> wondering if the 257 bytes is a 256 byte signature plus a byte which
> indicates the encryption used to create the signature or something
> like that.
>

A hexdump of the signature reveals a 0x00 at the start

int public_key_verify_signature(const struct public_key *pkey,
const struct public_key_signature *sig)
{
...
    print_hex_dump(KERN_ERR, "signature", DUMP_PREFIX_OFFSET, 16, 1,
           sig->s, sig->s_size, true);
...
=>

signature00000000: 00 68 82 cc 5d f9 ee fb 1a 77 72 a6 a9 c6 4c cc
.h..]....wr...L.
signature00000010: d7 f6 2a 17 a5 db bf 5a 2b 8d 39 60 dc a0 93 39
..*....Z+.9`...9
signature00000020: 45 0f bc a7 e8 7f 6c 06 84 2d f3 c1 94 0a 60 56
E.....l..-....`V.
...


Using openssl to get the signature in my x509 cert

   Signature Algorithm: sha256WithRSAEncryption
         68:82:cc:5d:f9:ee:fb:1a:77:72:a6:a9:c6:4c:cc:d7:f6:2a:
         17:a5:db:bf:5a:2b:8d:39:60:dc:a0:93:39:45:0f:bc:a7:e8:
         7f:6c:06:84:2d:f3:c1:94:0a:60:56:1c:50:78:dc:34:d1:87:

So there's an extra 0x00 and the signature is 257 bytes so I guess
this is upsetting CAAM, just need to work out where it's coming from,
or whether it's valid and CAAM should be handling it.  I notice that
in my stack trace I have pkcs1pad_verify which suggests some sort of
padding?

>>
>> [    2.999416] caam_jr 2142000.jr1: 40000789: DECO: desc idx 7:
>> Protocol Size Error - A protocol has seen an error in size. When
>> running RSA, pdb size N < (size of F) when no formatting is used; or
>> pdb si
>> ze N < (F + 11) when formatting is used.
>> [    3.022168] ------------[ cut here ]------------
>> [    3.027247] WARNING: CPU: 0 PID: 1 at
>> crypto/asymmetric_keys/public_key.c:148
>> public_key_verify_signature+0x27c/0x2b0
>> [    3.038075] Modules linked in:
>> [    3.041226] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 4.16.0-next-20180410-00002-gf0ccf31-dirty #223
>> [    3.050413] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>> [    3.056643] Backtrace:
>> [    3.059173] [<c010d118>] (dump_backtrace) from [<c010d3d8>]
>> (show_stack+0x18/0x1c)
>> [    3.066802]  r7:00000000 r6:60000153 r5:00000000 r4:c107ae78
>> [    3.072523] [<c010d3c0>] (show_stack) from [<c0a50d24>]
>> (dump_stack+0xb4/0xe8)
>> [    3.079810] [<c0a50c70>] (dump_stack) from [<c012618c>] (__warn+0x104/0x130)
>> [    3.086922]  r9:d604dc94 r8:00000094 r7:00000009 r6:c0d3aea8
>> r5:00000000 r4:00000000
>> [    3.094728] [<c0126088>] (__warn) from [<c01262d0>]
>> (warn_slowpath_null+0x44/0x50)
>> [    3.102356]  r8:c1008908 r7:d67846c0 r6:c040bbc4 r5:00000094 r4:c0d3aea8
>> [    3.109120] [<c012628c>] (warn_slowpath_null) from [<c040bbc4>]
>> (public_key_verify_signature+0x27c/0x2b0)
>> [    3.118745]  r6:40000789 r5:d6782f00 r4:d6787f40
>> [    3.123428] [<c040b948>] (public_key_verify_signature) from
>> [<c040cbd4>] (x509_check_for_self_signed+0xc8/0x104)
>> [    3.133664]  r10:d602f000 r9:c0bcb1d0 r8:000002a8 r7:d6787f00
>> r6:d6787f40 r5:00000000
>> [    3.141543]  r4:d6782d80
>> [    3.144140] [<c040cb0c>] (x509_check_for_self_signed) from
>> [<c040bdd0>] (x509_cert_parse+0x11c/0x190)
>> [    3.153415]  r7:c0bcb1d0 r6:d6787f80 r5:d6782d80 r4:d6787f00
>> [    3.159138] [<c040bcb4>] (x509_cert_parse) from [<c040c860>]
>> (x509_key_preparse+0x1c/0x194)
>> [    3.167550]  r9:c0bcb1d0 r8:c10235dc r7:d604de30 r6:c1026a84
>> r5:d604de30 r4:c1026af0
>> [    3.175357] [<c040c844>] (x509_key_preparse) from [<c040adbc>]
>> (asymmetric_key_preparse+0x50/0x80)
>> [    3.184376]  r9:c0bcb1d0 r8:c10235dc r7:d604de30 r6:c1026a84
>> r5:c1008908 r4:c1026af0
>> [    3.192187] [<c040ad6c>] (asymmetric_key_preparse) from
>> [<c03e40b4>] (key_create_or_update+0x138/0x404)
>> [    3.201638]  r7:d6495601 r6:d6495600 r5:c1008908 r4:c1026a8c
>> [    3.207366] [<c03e3f7c>] (key_create_or_update) from [<c0f5a9c4>]
>> (regulatory_init_db+0xf4/0x1e8)
>> [    3.216303]  r10:0000000e r9:1f030000 r8:c0d1d144 r7:c17f1e7c
>> r6:c0bcb478 r5:000002a8
>> [    3.224180]  r4:c0bcb1d0
>> [    3.226780] [<c0f5a8d0>] (regulatory_init_db) from [<c0102764>]
>> (do_one_initcall+0x50/0x1a4)
>> [    3.235278]  r10:c0f00630 r9:c0f64858 r8:c107cb00 r7:00000000
>> r6:c0f5a8d0 r5:c1008908
>> [    3.243155]  r4:ffffe000
>> [    3.245753] [<c0102714>] (do_one_initcall) from [<c0f00f04>]
>> (kernel_init_freeable+0x118/0x1d8)
>> [    3.254512]  r9:c0f64858 r8:000000f4 r7:c0e1ec98 r6:c0f64854
>> r5:c107cb00 r4:c0f78f70
>> [    3.262324] [<c0f00dec>] (kernel_init_freeable) from [<c0a665b8>]
>> (kernel_init+0x10/0x118)
>> [    3.270650]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
>> r6:00000000 r5:c0a665a8
>> [    3.278527]  r4:00000000
>> [    3.281127] [<c0a665a8>] (kernel_init) from [<c01010b4>]
>> (ret_from_fork+0x14/0x20)
>> [    3.288749] Exception stack(0xd604dfb0 to 0xd604dff8)
>> [    3.293859] dfa0:                                     00000000
>> 00000000 00000000 00000000
>> [    3.302098] dfc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [    3.310329] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    3.316993]  r5:c0a665a8 r4:00000000
>> [    3.320825] irq event stamp: 186525
>> [    3.324504] hardirqs last  enabled at (186543): [<c01803b8>]
>> console_unlock+0x4d4/0x5c8
>> [    3.332584] hardirqs last disabled at (186550): [<c017ffac>]
>> console_unlock+0xc8/0x5c8
>> [    3.340664] softirqs last  enabled at (186566): [<c01023a0>]
>> __do_softirq+0x1f8/0x2a0
>> [    3.348665] softirqs last disabled at (186577): [<c012bffc>]
>> irq_exit+0x14c/0x1a8
>> [    3.356307] ---[ end trace abf8fdf803902ee1 ]---
>> [    3.361030] cfg80211: Problem loading in-kernel X.509 certificate (-22)
>> [    3.370633] platform regulatory.0: Direct firmware load for
>> regulatory.db failed with error -2
>> [    3.379780] cfg80211: failed to load regulatory.db
>> [    3.385260] VSD_3V3: disabling
>> [    3.388632] ALSA device list:
>> [    3.391662]   #0: mx6ul-wm8960
>> [    3.536866] EXT4-fs (mmcblk1p2): recovery complete
>> [    3.545725] EXT4-fs (mmcblk1p2): mounted filesystem with ordered
>> data mode. Opts: (null)
>> [    3.554300] VFS: Mounted root (ext4 filesystem) on device 179:2.
>> [    3.587857] devtmpfs: mounted
>> [    3.600044] Freeing unused kernel memory: 1024K
>> [    3.775667] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
>> Starting logging: OK
>> Initializing random number generator... done.
>> Starting network: OK
>>
>> Welcome to Buildroot
>>
>> It would be nice to fix this cfg80211 certificate issue though. My
>> colleague Breno has observed this same issue on a imx7.
>>
>> Thanks
