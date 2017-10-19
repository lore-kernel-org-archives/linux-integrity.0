Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:43957 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbdJSSQB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 14:16:01 -0400
Received: by mail-it0-f67.google.com with SMTP id k70so11132805itk.0
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:16:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACE9dm-mWTthaZT3jzc+2UCyNBfhUJyah4uAXkA7AvXTT8UryA@mail.gmail.com>
References: <20171018180111.13021-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
 <1508414402.4510.117.camel@linux.vnet.ibm.com> <C2D7A727C393B644B70DF4B4DCFB60B921C44F66@FRAEML521-MBX.china.huawei.com>
 <CACdnJuseJzWgG-3KiTbOGzghJWmMYxffrXcg6MtT3vyj1En4EQ@mail.gmail.com> <CACE9dm-mWTthaZT3jzc+2UCyNBfhUJyah4uAXkA7AvXTT8UryA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 19 Oct 2017 11:15:59 -0700
Message-ID: <CACdnJuv-WHWoiH49WxqMVLi6-OnZB4tkNybCkcXU_yCLyWY=Cw@mail.gmail.com>
Subject: Re: [PATCH] EVM: Add support for portable signature format
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 11:02 AM, Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
> On Thu, Oct 19, 2017 at 8:11 PM, Matthew Garrett <mjg59@google.com> wrote:
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

Broadly, but for our case we can't permit the local system to possess
a key that can create valid signatures, which means enhancing support
for portable asymmetric signatures.
