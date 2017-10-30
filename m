Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:43162 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbdJ3LvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 07:51:02 -0400
Received: by mail-io0-f194.google.com with SMTP id 134so26463591ioo.0
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 04:51:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509363371.3583.39.camel@linux.vnet.ibm.com>
References: <20171026083144.16247-1-mjg59@google.com> <20171026120330.5360e427@totoro>
 <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
 <20171026124616.2f2ef1d2@totoro> <1509045773.5886.93.camel@linux.vnet.ibm.com>
 <CACdnJuv1n7LnWj4Oo=B+nOQQz--RFhEAvLTF1oMzcY_kqE-x6w@mail.gmail.com> <1509363371.3583.39.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 11:51:00 +0000
Message-ID: <CACdnJusZezTrdcaRG_CQEWZqk-bm+y=Qu6fD5cchYCZPdxWyXw@mail.gmail.com>
Subject: Re: [RFC] EVM: Add support for portable signature format
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 30, 2017 at 11:36 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-10-30 at 10:53 +0000, Matthew Garrett wrote:
>> 2) It should be possible to write a policy that allows these files to
>> be arbitrarily modified, including being deleted
>
> File deletion is not the problem, but if we allow the file metadata to
> change, then the file verification will fail.

That seems reasonable? The policy may not be appraising all files, in
which case having verification fail isn't a problem.

>> I'd been interpreting "immutable" in this case to mean "the kernel
>> will never replace the signature with an hmac" rather than "the file
>> and protected information cannot be modified". If you think the latter
>> is necessary then I think we need two separate signature types and to
>> handle the two separately.
>
> EVM, up to now, is reactive to file data and meta-data changes,
> replacing the file signature with an HMAC.  For the new file signature
> to be immutable it needs to prevent security.evm from changing, which
> this patch currently does not do.

It prevents the kernel from modifying security.evm, but doesn't
prevent userspace from doing so. But if userspace does so,
verification will fail.
