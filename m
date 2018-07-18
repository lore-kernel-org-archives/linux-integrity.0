Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32970 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbeGRDSs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Jul 2018 23:18:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so3052781wrp.0
        for <linux-integrity@vger.kernel.org>; Tue, 17 Jul 2018 19:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
 <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com> <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Tue, 17 Jul 2018 22:43:12 -0400
Message-ID: <CAAi9uDt063WYqNSX9dSCtRybd2a2Ad-0q2s8xvOst6qq3O4wPg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 4, 2018 at 2:54 AM, Louis Collard <louiscollard@chromium.org> wrote:
> On Fri, Jun 29, 2018 at 9:03 PM, David R. Bild <david.bild@xaptum.com> wrote:
>> As a point of clarification (and correct me if I'm wrong), the TPM is
>> always ready used to seed the rng. It just doesn't update the entropy
>> pool estimate.
>
> Good point.
>
>>
>> So, perhaps the default value for the TPM hwrng quality should be
>> non-zero (in addition to the module param that lets users override
>> it)?
>
> That makes sense to me, however I can imagine that some users would
> prefer to not have the TPM enabled as an ongoing source of entropy by
> default.

Fair enough.

> Following on from your previous point - perhaps we can just make a
> small change to how the initial seeding is done: maybe we can replace
> the call to crng_slow_load (via add_early_randomness and
> add_device_randomness) with a call (indirectly) to crng_fast_load. (We
> might also need to increase the amount of data read at this point.)
>
> This would update crng_init_cnt and crng_init, and calls to getrandom
> [without GRND_RANDOM] would not block.

Interesting.

add_hwgenereator_randomness() will call crng_fast_load(), regardless
of entropy estimate/quality, if crng_init is 0.  So initializing
crng_init from the hwrng, regardless of quality, is already the
intent.

But hw_random only calls add_hwgenerator_randomness() if
current_quality > 0, via the hwrng_fillfn() kthread.

All that to say, I agree.  add_early_randomness() should (indirectly)
call crng_fast_load(), like add_hwgenerator_randomness() does.

> This obviously doesn't solve the issue if there are blocking calls on
> boot that are querying random rather than urandom; I don't believe
> that would be a problem for our use case though.
>

It wouldn't be a problem for our use case either.

Best,
David
