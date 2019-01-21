Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01684C31680
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5C21019
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 19:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfAUTQW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:16:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:34665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfAUTQW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 14:16:22 -0500
Received: from Peter-MotoG5.fritz.box ([93.235.184.3]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MPIvU-1gq2lV3F3o-004W1s; Mon, 21 Jan 2019 20:16:09 +0100
Date:   Mon, 21 Jan 2019 20:16:04 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190121165848.GC25163@ziepe.ca>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com> <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com> <20190121022640.GD18017@ziepe.ca> <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com> <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com> <20190121165848.GC25163@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx
To:     Jason Gunthorpe <jgg@ziepe.ca>, oshri.alkoby@nuvoton.com
CC:     Dan.Morav@nuvoton.com, nayna@linux.vnet.ibm.com,
        dana.cohen@nuvoton.com, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com
From:   Peter Huewe <peterhuewe@gmx.de>
Message-ID: <CFC10279-4983-4EF7-8323-CFF29674D80A@gmx.de>
X-Provags-ID: V03:K1:fT/Qc+0D9Ai27vpp0/u22zF23xu+v3WuUbcg1H5snVFg2icqGvk
 GSYahi2J9316/kxjaNTIvANTNX6CKgmfyz6zKMa37Ahpvwp1twYZ/To3jJVcPt0XaDZIkFG
 bwhAV4dNtJUcvx76E9z5/YGq7dtQjBoueLN/hblj3EX3nB9DhcFb0Dg8OdhKTe1IfA7gGlD
 VZfEqgTyJNNLlcgtPcYxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eA11SB3VLkw=:1ZiJzvoypTzUekVaauOrml
 7FSR9RyMnBR7qNGaKgz8UUQxX6sb+I1vYd+sOzd+9qMrwTU71ZPPQBSySxrI49JmkgdNmBI7p
 prNGlJNjfMTCguF1xUyc+9olDejHCsc8oZ86aJwKTb3EFKqrrWekEc45f8BqCbkahXKtvoLNy
 djgq9Ie7GwqPUrf2opgaNi4QFRVUXkPj/dm161e29fu+iSwX/c9f1rUxNNUTWSerVzrEtWgjH
 I54zfBKNIrcRxhg04+j1DPmvhgWSHwESOZqjfVD+1QXQ9jvfo9JYP3IHL0rLgR+0oKiKYBc5W
 xuQTSRt8PU3TZpG4anDpMmUAQ7L0UlpSMCs/8l0U4OzrfImzPy9gd6HWAFNQZK3bY/76C6yZU
 FmL52XnrfGE0TOpf84z9pq3wHUFbYPVFFptz1SpWDg9y/jnZfn0+iqJnmsh4nBuXArw1hX+5A
 adZHHgUX7AWZspD/POEpoL+DlAd83vevInPfSVrTX8dzzY7rLgldNxkJc5ESqIslQABg/ImMH
 bGmyeoD31HuwvqK9LIcVQdp0csQXk/mh79BGIjNnE+MnwWNzl4dQTuaxL5jP+dI3ztXleZ03q
 wK0MVZwcQ6KphEXhQesRm9wW2WkYmzc1QKPX9N495P0qqOrHJVrWgSfsAzi/aLr73OtGEuY2Y
 eW0ccZYGfdv4Lw8M18R5myEceCLF9T9OD0r9mEsOex3ZqaYKqo8Bwf96WW18uq/mLC3BSINLM
 34AkGE32Hi8twRv6KVhzC73nkoNakBmWgYVTOpMMPZCWXQxLk5+/pEPq4Zj/sbrP9rb2PAl3P
 4BbfwX1XBjGUlQ3rqzYgzzXjS5JbVhnDLhtNetZcCOEEW9tSpPnVMf3Njd2A5e/NGswgVTeBv
 JL8FPi/9kWEia0PxZNq8Ej7jQ5YHgX6/5ibR0FAl0SPcM2/2S5kMJkAHqwnZSvZa6I6h0AFdk
 adsH+j9SlkA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Am 21. Januar 2019 17:58:48 MEZ schrieb Jason Gunthorpe <jgg@ziepe.ca>:
>On Mon, Jan 21, 2019 at 04:55:23PM +0000, oshri.alkoby@nuvoton.com
>wrote:
>> Hi Jason,
>> 
>> Since the driver implements the I2C interface defined by the TCG
>> PTP, wouldn't it be better to set the string to be something like
>> 'tcg,tpm-i2c-ptp' (as 'tcg,tpm-tis-mmio' for tpm-tis)? 
I think this is a good idea.

>> Any TPM that
>> implements this protocol can use this driver.

If it implements the tcg i2c protocol without too many deviations I would propose renaming the driver im the same step.
>
>Yes, probably, we've done that for LPC ..
>
>But the device compatabile string should still be something like:
>
> 'nuvoton,npct751','tcg,tpm-i2c-ptp'
Since there are no quirks and no existing bindings, I would advise for tcg,tpm-i2c-ptp only.

Peter
-- 
Sent from my mobile
