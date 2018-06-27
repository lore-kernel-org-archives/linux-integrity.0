Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38613 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeF0GLr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jun 2018 02:11:47 -0400
Received: by mail-ot0-f193.google.com with SMTP id w22-v6so959175otk.5
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 23:11:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621162101.GB11859@linux.intel.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca> <20180621162101.GB11859@linux.intel.com>
From: Louis Collard <louiscollard@chromium.org>
Date: Wed, 27 Jun 2018 14:11:45 +0800
Message-ID: <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Thanks for all the replies, let me add some background around the
motivation for this change.

On some systems we have seen large delays in boot time, due to
blocking on a call to getrandom() before the entropy pool has been
initialized. On these systems the usual sources of entropy are not
sufficient to initialize the pool in any kind of reasonable time -
delays of minutes have been observed; the most common workaround is to
mash the keyboard for a bit ;)

Setting a non-zero quality score causes the hwrng to be used as a
source of entropy for the pool, the pool is therefore initialized
early during boot, and no delay is observed.

I don't believe that the quality score is used anywhere else, so I
don't think setting it should impact anything other than how the
entropy pool is populated.

It's my understanding that to be useful in the above situation, the
parameter needs to be set on the kernel command line, so I'm not sure
if a sysfs file would work.

On Fri, Jun 22, 2018 at 12:21 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Mon, Jun 18, 2018 at 01:33:06PM -0600, Jason Gunthorpe wrote:
>> > > +module_param(override_rng_quality, short, 0644);
>> >
>> > Should this be 600 i.e. not to leak this information?
>>
>> There is a real push these days against adding module parameters, and
>> apparently, IMA can't function with TPM as a module.
>>
>> Are you sure this shouldn't be done in some other way?
>
> Maybe a sysfs file would be a better choice for this?
>
> /Jarkko
