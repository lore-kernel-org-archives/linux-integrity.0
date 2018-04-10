Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35100 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJQ7R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Apr 2018 12:59:17 -0400
MIME-Version: 1.0
In-Reply-To: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Apr 2018 13:59:16 -0300
Message-ID: <CAOMZO5Aycn37omkEuevpBrkMTYt0xSeDcX3y79asqUDHYTM-eA@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Martin,

On Mon, Apr 9, 2018 at 5:41 AM, Martin Townsend <mtownsend1973@gmail.com> wrote:
> Hi,
>
> I'm trying to get to the bottom of an issue I'm seeing when enabling
> the CAAM in the kernel with IMA/EVM enabled.  I'm using the official
> NXP (imx_4.9.11_1.0.0_ga) vendor Kernel.

Does it work better if you try mainline kernel instead?
