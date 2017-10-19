Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:51880 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbdJSRL0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 13:11:26 -0400
Received: by mail-it0-f53.google.com with SMTP id o135so10567549itb.0
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 10:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B921C44F66@FRAEML521-MBX.china.huawei.com>
References: <20171018180111.13021-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
 <1508414402.4510.117.camel@linux.vnet.ibm.com> <C2D7A727C393B644B70DF4B4DCFB60B921C44F66@FRAEML521-MBX.china.huawei.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 19 Oct 2017 10:11:24 -0700
Message-ID: <CACdnJuseJzWgG-3KiTbOGzghJWmMYxffrXcg6MtT3vyj1En4EQ@mail.gmail.com>
Subject: Re: [PATCH] EVM: Add support for portable signature format
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 8:11 AM, Dmitry Kasatkin
<dmitry.kasatkin@huawei.com> wrote:
> Hi,
>
> 1. I do not get the idea...
>
>> ship EVM signatures in packages
>
> System up and running EVM without hmac?

Correct.

> How it creates new files without hmac?

New files won't have EVM signatures. Appraisal will only be performed
on executables that are running in a privileged security context.
