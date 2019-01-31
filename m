Return-Path: <SRS0=eEpa=QH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7DC169C4
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 18:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6008218AF
	for <linux-integrity@archiver.kernel.org>; Thu, 31 Jan 2019 18:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cxIgLqno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfAaSvZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:51:25 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:45193 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAaSvY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Jan 2019 13:51:24 -0500
Received: by mail-lf1-f51.google.com with SMTP id b20so3108585lfa.12
        for <linux-integrity@vger.kernel.org>; Thu, 31 Jan 2019 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8TmXOKugmPf5PKjfFSY0+MtEECnoWuXrcfZ9WYj7sQ=;
        b=cxIgLqnoURQzhPPQoVzTc3kGLEAW/JP1u2P5ucV1ZsVNhsd3LvJloBpP/vyQF0CN2i
         cEyNMJhJx+4Bj+X64xrwKUVfdSW8NoNLeyWe/CvYWmSzGchNlYE6pA1qZdrp0ZetciRM
         2Wox7w7BfbHIL5MET5xcChhZL9rFMbfTEYOJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8TmXOKugmPf5PKjfFSY0+MtEECnoWuXrcfZ9WYj7sQ=;
        b=tvv0bsXH2YjTloo6+1jcUKrIv+eC2wsRv0D59hYESZNDHQWrcVDfaCq8rGiNq/EgTJ
         mzDlgr87fvqKFFtosHfEFx7uRw+HrpYIk/XHC560XvoqhMwNHDe0HY5LUBrkx8ax4Zy2
         jio0jZ78qC/p91GaTT7ve8qE2q+LfiS74R8LEBbJ/wxNWIK6ROLtQ9gyXp6CjfaoGqjf
         /oWG3xwtNopLhf0hqHWgTNVok7sDT0hZP06XlH0w7h1wuuquzMmuBDfdEXa/ETg1H5gL
         qRazHmUXSKD2eDKBxrh/ZaJaqwEZnT+vsHNnfwYDhmOW+um0baBJfAEboL3Aeg4pC7M2
         sHZA==
X-Gm-Message-State: AJcUukcemgDHEesfTjiyvcjWEwygN9DWZC4B5xwBSP0R8VhMWt3QUY9A
        BlKQmYSxrZHSchyN9mjh9j6xtl+R6Dg=
X-Google-Smtp-Source: ALg8bN7Ytx4Lw+j1onVFVR7/uNNVmYhJ8RgUuuvLB7DOaOxoFCr2h61itIHHf3v59ZxOsWd/UO/VsA==
X-Received: by 2002:ac2:5599:: with SMTP id v25mr13714737lfg.169.1548960681856;
        Thu, 31 Jan 2019 10:51:21 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g70-v6sm914906ljg.92.2019.01.31.10.51.20
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:51:20 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z13so3118059lfe.11
        for <linux-integrity@vger.kernel.org>; Thu, 31 Jan 2019 10:51:20 -0800 (PST)
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr28892472lfk.78.1548960680075;
 Thu, 31 Jan 2019 10:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20190122010218.GA26713@linux.intel.com> <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
In-Reply-To: <20190131183530.GA27112@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 10:51:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
Message-ID: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 31, 2019 at 10:35 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> OK, so the length of the response is not trashed, but only the error
> code. The attached patch fully fixes the issue.
>
> Here's the header again:
>
> struct tpm_output_header {
>         __be16  tag;
>         __be32  length;
>         __be32  return_code;
> } __packed;
>
> The first to fields *are* read correctly and the last field get 1's
> (thus TPM error -1).

Ok, so this makes sense, even though that patch is (I think) completely wrong.

What happens is that the 32-bit fields are mis-aligned: the "tag" is
obviously properly 16-bit aligned, but then both "length" and
"return_code" are 32-bit fields that are only aligned on a 16-bit
alignment.

What happens is that first you copy the two first fields:

        memcpy_fromio(buf, priv->rsp, 6);

which copies "tag" and "length", but it copies them by reading then as
a 4-byte and then 2-byte value (in that order). So it actually reads
'tag' and 'first two bytes of 'length', and then the second access
reads the last two bytes of 'length'

And it all works, because the accesses are aligned by address of
access, even though they are *not* aligned in the 'struct
tpm_output_header' fields.

But then later on, when you read 'return_code', and do

        memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);

you now do a 4-byte memcpy at offset 6. So it does a 4-byte access,
bit it's not 4-byte aligned.

Honestly, memcpy() itself shouldn't have worked *either*, but you
lucked out. Gcc doesn't know that it's a 4-byte access, so it actually
calls out to the memcpy() routine. And that one happened to be "rep
movsb" on your machine. And that happened to work.

But it's really not supposed to work, and it really *wouldn't* have
worked if somebody disabled the rep-string functions.

In fact, we have another patch (that isn't applied) that makes even
the memcpy_erms() just call the sw version of memcpy() for short
copies (because "rep movsb" is slow for those cases). That would also
have broken your driver.

               Linus
