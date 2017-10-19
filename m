Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54480 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbdJSSNg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 14:13:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id a132so16324535oih.11
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:13:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACE9dm-mWTthaZT3jzc+2UCyNBfhUJyah4uAXkA7AvXTT8UryA@mail.gmail.com>
References: <20171018180111.13021-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
 <1508414402.4510.117.camel@linux.vnet.ibm.com> <C2D7A727C393B644B70DF4B4DCFB60B921C44F66@FRAEML521-MBX.china.huawei.com>
 <CACdnJuseJzWgG-3KiTbOGzghJWmMYxffrXcg6MtT3vyj1En4EQ@mail.gmail.com> <CACE9dm-mWTthaZT3jzc+2UCyNBfhUJyah4uAXkA7AvXTT8UryA@mail.gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 19 Oct 2017 21:13:35 +0300
Message-ID: <CACE9dm8Jgmfo0J0xPUx_fcCMWLj=rDgiEnb1JOamhwhC6B=J_w@mail.gmail.com>
Subject: Re: [PATCH] EVM: Add support for portable signature format
To: Matthew Garrett <mjg59@google.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 9:02 PM, Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
> On Thu, Oct 19, 2017 at 8:11 PM, Matthew Garrett <mjg59@google.com> wrote:
>> On Thu, Oct 19, 2017 at 8:11 AM, Dmitry Kasatkin
>> <dmitry.kasatkin@huawei.com> wrote:
>>> Hi,
>>>
>>> 1. I do not get the idea...
>>>
>>>> ship EVM signatures in packages
>>>
>>> System up and running EVM without hmac?
>>
>> Correct.
>>
>>> How it creates new files without hmac?
>>
>> New files won't have EVM signatures. Appraisal will only be performed
>> on executables that are running in a privileged security context.
>
> This patch was there for 3 years to enable policy to require evm
> digital signatures.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kasatkin/linux-digsig.git/commit/?h=evm-next&id=580e1ad19dd9917ce8ca5edbdf823c30397ccd47
>
> I was running a system where certain (privileged) components were
> required to use evm signatures.
>
> Before initramfs supported xattrs, we were running from rootfs /init
> and some binaries with EVM signature required. HMAC key was unsealed
> and initalized during this process.
> Now it is also possible to use external initramfs with xattrs and
> require evm digsigs.
>
> you are basically doing the same.
>

Ok. i got the use case. No hmac at all.
Currently EVM is enabled if any of the key (symmetric or public) is loaded.

Currently with only public key, it works fine when rootfs is mounted
read-only, because no need to generate hmac.

But when fully running and remounted rw, then it would require HMAC.

So we need a way to have only evm signatures..

-- 
Thanks,
Dmitry
