Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:49450 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdJSLOH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 07:14:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id w197so13854668oif.6
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 04:14:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACdnJuto5CS=k98Tr65jWHPRPnXbVgPb317WxE3_wYuEHV_qgQ@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com> <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
 <1508349118.4510.14.camel@linux.vnet.ibm.com> <CACE9dm_vpTi705PJxGZkeNWUyHALZzVc2x=RUw_p=DZCPZfoXw@mail.gmail.com>
 <CACdnJuto5CS=k98Tr65jWHPRPnXbVgPb317WxE3_wYuEHV_qgQ@mail.gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 19 Oct 2017 14:14:06 +0300
Message-ID: <CACE9dm_-ff0E_c-G+bhkuYedYzEYaRTgYQEdm-YiHe7e16e1XQ@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 9:18 PM, Matthew Garrett <mjg59@google.com> wrote:
> On Wed, Oct 18, 2017 at 11:16 AM, Dmitry Kasatkin
> <dmitry.kasatkin@gmail.com> wrote:
>> Hi,
>>
>> I have not read thread in detail so sorry if I will repeat something.
>>
>> EVM support signatures.
>> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/tree/security/integrity/evm/evm_main.c?h=next#n166
>>
>> They can be mutable or immutable if I not is marked immutables
>> Mutable signature will be replaced on the first verification.
>>
>> And ima-evm-utils has support to generate evm signatures
>>
>> https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/src/evmctl.c#l1549
>>
>> Also there is concept of EVM signatures not bound to inode unique data like
>> ino and generation
>
> That's fine - the problem is how to write these out. If EVM is enabled
> there's no way to write security.evm on a new file unless the iint
> entry has an IMA_NEW_FILE flag, and this will only be set if there's
> an IMA policy that covers that file.

Why??

It is possible to set digital signature..

int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
       const void *xattr_value, size_t xattr_value_len)
{
         const struct evm_ima_xattr_data *xattr_data = xattr_value;

            if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
                  if (!xattr_value_len)
                          return -EINVAL;
                  if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
                        return -EPERM;
               }
            return evm_protect_xattr(dentry, xattr_name, xattr_value,
xattr_value_len);
}



-- 
Thanks,
Dmitry
