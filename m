Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35439 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933911AbeF2NDP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 09:03:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id c13-v6so8779313wrq.2
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 06:03:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Fri, 29 Jun 2018 08:03:13 -0500
Message-ID: <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To: Louis Collard <louiscollard@chromium.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 27, 2018 at 1:11 AM, Louis Collard
<louiscollard@chromium.org> wrote:
>
> On some systems we have seen large delays in boot time, due to
> blocking on a call to getrandom() before the entropy pool has been
> initialized. On these systems the usual sources of entropy are not
> sufficient to initialize the pool in any kind of reasonable time -
> delays of minutes have been observed; the most common workaround is to
> mash the keyboard for a bit ;)
>
> Setting a non-zero quality score causes the hwrng to be used as a
> source of entropy for the pool, the pool is therefore initialized
> early during boot, and no delay is observed.
>

We have the same issue on our embedded devices and thus carry patches
in our tree that set the quality.  This would be a welcome change.

As a point of clarification (and correct me if I'm wrong), the TPM is
always ready used to seed the rng. It just doesn't update the entropy
pool estimate.

So, perhaps the default value for the TPM hwrng quality should be
non-zero (in addition to the module param that lets users override
it)?

As it stands, it encourages programmers to not use methods like
getrandom() or not check the entropy pool estimate before reading from
dev/urandom.  They know the rng was supposedly seeded by the TPM ---
the entropy estimate just wasn't updated --- so the easiest "fix" is
to just not check the entropy pool estimate.

I think the default config on a machine with a TPM should be that the
rng is seeded by the TPM and that the entropy pool estimate is updated
to reflect that.  Then programs that are written properly (i.e., use
getrandom()) will work correctly with no further effort from the user.

Best,
David
