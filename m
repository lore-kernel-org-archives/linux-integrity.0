Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:42333 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDJRGs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 13:06:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Tue, 10 Apr 2018 18:06:46 +0100
Message-ID: <CABatt_yUbBdNbi_i3SQD5wnc99D8O1RQ_4Ysa+6n5X1vw4Lqnw@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Fabio,

On Tue, Apr 10, 2018 at 5:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Martin,
>
> On Mon, Apr 9, 2018 at 5:41 AM, Martin Townsend <mtownsend1973@gmail.com> wrote:
>> Hi,
>>
>> I'm trying to get to the bottom of an issue I'm seeing when enabling
>> the CAAM in the kernel with IMA/EVM enabled.  I'm using the official
>> NXP (imx_4.9.11_1.0.0_ga) vendor Kernel.
>
> Does it work better if you try mainline kernel instead?

I had a few issues getting mainline working, the board kept resetting,
when I checked there are lots of patches in the NXP kernel not in
mainline.   This CAAM problem does occur really early in the boot so
just for an experiment its worth a try.
