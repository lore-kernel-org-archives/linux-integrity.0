Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:52339 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdJ3NRf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 09:17:35 -0400
Received: by mail-io0-f196.google.com with SMTP id f20so27012840ioj.9
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 06:17:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509367096.3583.70.camel@linux.vnet.ibm.com>
References: <20171026083144.16247-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C471AC@FRAEML521-MBX.china.huawei.com>
 <1509367096.3583.70.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 13:17:33 +0000
Message-ID: <CACdnJuvTEAs8tg2LoktmMRUzAMrfY5qTOeawTWCkvqit4A4huw@mail.gmail.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 30, 2017 at 12:38 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-10-27 at 10:41 +0000, Dmitry Kasatkin wrote:
>
>> > @@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *dentry, const
>> > char *xattr_name,
>> >     if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
>> >             if (!xattr_value_len)
>> >                     return -EINVAL;
>> > -           if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
>> > +           if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
>> > +               xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
>> >                     return -EPERM;
>> >     }
>>
>> Also I have an impression that evm_protect_xattr will allow to set
>> security.ima for example,
>> And it will cause to try to re-calculate hmac over immutable
>> signature...
>
> Right, it will allow evm_inode_post_setxattr() to replace the new file
> signature with an HMAC.

evm_inode_setxattr() will call evm_protect_xattr(), which will call
evm_verify_xattr(). This will return INTEGRITY_PASS_IMMUTABLE, which
will result in evm_protect_xattr() returning -EPERM, so we never get
to inode_post_setxattr().
