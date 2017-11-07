Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:46328 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754440AbdKGSGu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 13:06:50 -0500
Received: by mail-it0-f41.google.com with SMTP id f187so3545916itb.1
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2017 10:06:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com> <899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 7 Nov 2017 13:06:48 -0500
Message-ID: <CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 7, 2017 at 12:53 PM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/7/2017 3:49 PM, Matthew Garrett wrote:
>> RPM's hardly universal, and distributions are in the process of moving
>> away from using it for distributing non-core applications (Flatpak and
>> Snap are becoming increasingly popular here). I think this needs to be
>> a generic solution rather than having the kernel tied to a specific
>> package format.
>
>
> Support for new digest list formats can be easily added. Digest list
> metadata includes the digest list type, so that the appropriate parser
> is selected.

But we're still left in a state where the kernel has to end up
supporting a number of very niche formats, and userland agility is
tied to the kernel. I think it makes significantly more sense to push
the problem out to userland.

> Digest lists should be parsed directly by the kernel, because processing
> the lists in userspace would increase the chances that a compromised
> tool does not upload to the kernel the expected digests. Also, digest
> lists must be processed before init, otherwise appraisal will deny the
> execution. Lastly, the mechanism of parsing files from the kernel is
> already used to parse the IMA policy.

Isn't failing to upload the expected digest list just a DoS? We
already expect to load keys from initramfs, so it seems fine to parse
stuff there - what's the problem with extracting information from
RPMs, translating them to the generic format and pushing that into the
kernel?
