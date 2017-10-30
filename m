Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:52169 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdJ3NVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 09:21:31 -0400
Received: by mail-io0-f180.google.com with SMTP id b186so27068782iof.8
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 06:21:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509366611.3583.65.camel@linux.vnet.ibm.com>
References: <20171026083144.16247-1-mjg59@google.com> <C2D7A727C393B644B70DF4B4DCFB60B921C4718F@FRAEML521-MBX.china.huawei.com>
 <1509366611.3583.65.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 13:21:30 +0000
Message-ID: <CACdnJuvz3RHG-asaN8NiJ=3uz-EH9CRAoc+kwG0gL+ChjJ64FQ@mail.gmail.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 30, 2017 at 12:30 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-10-27 at 10:27 +0000, Dmitry Kasatkin wrote:
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
>> >     return evm_protect_xattr(dentry, xattr_name, xattr_value, @@ -
>> > 432,6 +438,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr
>> > *attr)
>> >             return 0;
>> >     evm_status = evm_verify_current_integrity(dentry);
>> >     if ((evm_status == INTEGRITY_PASS) ||
>> > +       (evm_status == INTEGRITY_PASS_IMMUTABLE) ||
>> >         (evm_status == INTEGRITY_NOXATTRS))
>> >             return 0;
>>
>> Something is wrong here?
>> When integrity verification pass, this code WILL ALLOW to change attribute.
>> But it is not possible... next time integrity verification will fail?
>> Or I miss something?
>
> Right, it will allow the file metadata change.  The bigger problem is
> that evm_inode_post_setattr() will replace the signature with an HMAC.

It will allow the metadata update as long as it's not security.evm or
one of the evm protected xattrs, which means that
evm_inode_post_setxattr() will return rather than calling
evm_update_evmxattr().
