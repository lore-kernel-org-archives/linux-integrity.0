Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:46188 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdJRSS4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:18:56 -0400
Received: by mail-it0-f67.google.com with SMTP id f187so7393410itb.1
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 11:18:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACE9dm_vpTi705PJxGZkeNWUyHALZzVc2x=RUw_p=DZCPZfoXw@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com> <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
 <1508349118.4510.14.camel@linux.vnet.ibm.com> <CACE9dm_vpTi705PJxGZkeNWUyHALZzVc2x=RUw_p=DZCPZfoXw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 11:18:55 -0700
Message-ID: <CACdnJuto5CS=k98Tr65jWHPRPnXbVgPb317WxE3_wYuEHV_qgQ@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 11:16 AM, Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
> Hi,
>
> I have not read thread in detail so sorry if I will repeat something.
>
> EVM support signatures.
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/tree/security/integrity/evm/evm_main.c?h=next#n166
>
> They can be mutable or immutable if I not is marked immutables
> Mutable signature will be replaced on the first verification.
>
> And ima-evm-utils has support to generate evm signatures
>
> https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/src/evmctl.c#l1549
>
> Also there is concept of EVM signatures not bound to inode unique data like
> ino and generation

That's fine - the problem is how to write these out. If EVM is enabled
there's no way to write security.evm on a new file unless the iint
entry has an IMA_NEW_FILE flag, and this will only be set if there's
an IMA policy that covers that file.
