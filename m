Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40466 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeGDGyU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jul 2018 02:54:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so8742998oie.7
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 23:54:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
 <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
From: Louis Collard <louiscollard@chromium.org>
Date: Wed, 4 Jul 2018 14:54:18 +0800
Message-ID: <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To: "David R. Bild" <david.bild@xaptum.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 9:03 PM, David R. Bild <david.bild@xaptum.com> wrote:
> On Wed, Jun 27, 2018 at 1:11 AM, Louis Collard
> <louiscollard@chromium.org> wrote:
>>
>> On some systems we have seen large delays in boot time, due to
>> blocking on a call to getrandom() before the entropy pool has been
>> initialized. On these systems the usual sources of entropy are not
>> sufficient to initialize the pool in any kind of reasonable time -
>> delays of minutes have been observed; the most common workaround is to
>> mash the keyboard for a bit ;)
>>
>> Setting a non-zero quality score causes the hwrng to be used as a
>> source of entropy for the pool, the pool is therefore initialized
>> early during boot, and no delay is observed.
>>
>
> We have the same issue on our embedded devices and thus carry patches
> in our tree that set the quality.  This would be a welcome change.

Glad to hear this!

>
> As a point of clarification (and correct me if I'm wrong), the TPM is
> always ready used to seed the rng. It just doesn't update the entropy
> pool estimate.

Good point.

>
> So, perhaps the default value for the TPM hwrng quality should be
> non-zero (in addition to the module param that lets users override
> it)?

That makes sense to me, however I can imagine that some users would
prefer to not have the TPM enabled as an ongoing source of entropy by
default.

Following on from your previous point - perhaps we can just make a
small change to how the initial seeding is done: maybe we can replace
the call to crng_slow_load (via add_early_randomness and
add_device_randomness) with a call (indirectly) to crng_fast_load. (We
might also need to increase the amount of data read at this point.)

This would update crng_init_cnt and crng_init, and calls to getrandom
[without GRND_RANDOM] would not block.

This obviously doesn't solve the issue if there are blocking calls on
boot that are querying random rather than urandom; I don't believe
that would be a problem for our use case though.

Thoughts?

Thanks,
Louis
