Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:50823 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753574AbdJSRJy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 13:09:54 -0400
Received: by mail-it0-f68.google.com with SMTP id 72so11019363itl.5
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 10:09:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508417552.4510.131.camel@linux.vnet.ibm.com>
References: <20171018180111.13021-1-mjg59@google.com> <1508417552.4510.131.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 19 Oct 2017 10:09:53 -0700
Message-ID: <CACdnJuuaLJ0g0-o567YsEU8pxs4c1xMZLU2viU6FFG6_t9uh3Q@mail.gmail.com>
Subject: Re: [PATCH] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 5:52 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Wed, 2017-10-18 at 11:01 -0700, Matthew Garrett wrote:
>> The EVM signature includes the inode number and (optionally) the
>> filesystem UUID, making it impractical to ship EVM signatures in
>> packages. This patch adds a new portable format intended to allow
>> distributions to include EVM signatures. It is identical to the existing
>> format but hardcodes the inode and generation numbers to 0 and does not
>> include the filesystem UUID even if the kernel is configured to do so.
>
> The existing IMA signature format is already portable and immutable.
>  The new portable and immutable signature type is only needed for EVM.
>  I don't see a need to refer to it as EVM_IMA_XATTR_PORTABLE_DIGSIG.

Ok, I can change the name.

>> Admins should note that creating portable signatures that do not include
>> the security.ima xattr would allow these signatures to be applied to any
>> file with the same owners and security labels, which would allow
>> subversion of EVM's security guarantees. The kernel does not attempt to
>> enforce this.
>
> As much as possible IMA and EVM should work independently of each
> other.  But in this case, I think we need to blur the lines a bit.
>
> Currently, before writing a new security.evm value, the existing
> security.evm value is verified.  To do this it has to read the
> security xattrs to calculate the hash/hmac.  How hard would it really
> be to verify that a security.ima xattr exists, before writing this new
> EVM signature?  How hard would it be to make sure that security.ima is
> included in the calculation on verification?

I don't think it would be especially hard to ensure that security.ima
is present if the portable digsig format is used, but as you say it
would blur the lines a little.
