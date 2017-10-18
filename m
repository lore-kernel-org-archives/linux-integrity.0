Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:54809 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdJRSXJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:23:09 -0400
Received: by mail-it0-f53.google.com with SMTP id 72so7024225itk.3
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 11:23:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508350783.4510.22.camel@linux.vnet.ibm.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com> <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
 <1508349118.4510.14.camel@linux.vnet.ibm.com> <CACdnJutON0tX5NV_Di1PEOFHN5Hf-E-shQ=Fzv6CSYkkBk-i=Q@mail.gmail.com>
 <1508350783.4510.22.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 11:23:08 -0700
Message-ID: <CACdnJuu-F0Rft2TdyA+qa3PGT_jceiDVy_z_nA3QRvAdrGcsjw@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 11:19 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The IMA_NEW_FILE check is applicable only when there are no security
> xattrs (INTEGRITY_NOXATTRS), which would not be the case after writing
> the first security xattr.  The return result in that case is
> INTEGRITY_NOLABEL, meaning no security.evm.

Ah, of course. Ok, how about going with my proposal with an intention
to relax the restriction around it and HMAC support once we have a
mechanism for setting multiple xattrs at once?
