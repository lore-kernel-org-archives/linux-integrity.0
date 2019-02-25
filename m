Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A89C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 23:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857621841
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 23:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPlfvq6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfBYXCp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:02:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44421 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfBYXCp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 18:02:45 -0500
Received: by mail-io1-f67.google.com with SMTP id y13so8946526iop.11
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nUG2wXnAzl8G7jM2t3QLuAauYCxBD891VnVyjFATdM=;
        b=UPlfvq6JbX3667x4Xez0bGUDCeUwC0WdKkZW/kVWTjdOmxJOoPB7UF0GXzRv0giJ9l
         aPwlWyocin4kAiprHOfgFw70vzseSw23k/IS3K97Dqrjr2GZWzuJSIKRNY9cMlrGQdb/
         4RlaadA8GMHdiriTEc9+e6HzNvE/q1v64S6hPBiqL813ndK0snUimmBx1Xk/YbStMwlk
         sMrPOTAOFmyfpeUdpIwWuSriFFqkNYTyXpkxOlmK2fYPUol9KUUwQ4wsB5Yj9R9rjhyx
         /wf48arJF/UPN6C7Err3NucLjPSQgdTGH/3Y7lmtsd6I4wcZkhDDC+06vZz2US2tGHXK
         9U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nUG2wXnAzl8G7jM2t3QLuAauYCxBD891VnVyjFATdM=;
        b=ZETFAuwJwjVdXIhhBiAQbbQSFhS9Ys/hObDdF5pOcuzty4myPZnI97BMa8wRrxf8f5
         Vaq7j5tcr3NkeHS4wld7fLMS3pJFHTb0HnSXaIz4n6gdIikHd5DTnzVxHa67LB4JoED3
         5SAnTdi3yZFrUPyYlAd6V94ya/XJnZ4a/6n/8APHc4YwmpyOs1tGp3dkXc2s8R+GbE+M
         04UaY+emOT6euRyKbuEku/j1HWJovQbyBFGvT0xmh8nZwmmwoBPRlEdWFp0wijxBj6LZ
         zWBbgTfEV01Xyr/Um34wbJnX2qxOtW+tXyRZ/7+DTaDrVX0TFHJpjvUpEtzRosp9g4kP
         wDmQ==
X-Gm-Message-State: AHQUAuaE50MzX7ZNvHLhDbz0bdzmI2o4T4v0IxyMz3UGLGgpvQ++dStK
        RKM+F9x6MHYopJSvRdlRVGXAc4jkDwkwHzN626ggdg==
X-Google-Smtp-Source: AHgI3IZJTBBlsygaLf+9JQqDPQvGpYBTgmf9pbCwvyxndceY8fLjlWIUC/Fbk07RTcGIu9X7AndxAQrejNuQ3J4M+gA=
X-Received: by 2002:a5e:dc4c:: with SMTP id s12mr2194877iop.304.1551135764063;
 Mon, 25 Feb 2019 15:02:44 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com> <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com> <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
 <1551132882.3226.67.camel@HansenPartnership.com> <CACdnJuus3yOcNy-uKWh_Mt-eDfP8xePize572jg92a5zkuECrA@mail.gmail.com>
 <1551133927.3226.81.camel@HansenPartnership.com> <CACdnJuvhqHCuA7x2oyAaHB1zWnQ5T_4vTSc=FT3h85+sMSmwfg@mail.gmail.com>
 <1551135106.3226.91.camel@HansenPartnership.com>
In-Reply-To: <1551135106.3226.91.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 15:02:32 -0800
Message-ID: <CACdnJus1PHuV9ZM0mFOXQk_dbCiAZjdjgO69oHRTv=t7S3sdZg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 25, 2019 at 2:51 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2019-02-25 at 14:43 -0800, Matthew Garrett wrote:
> > You still need a transport mechanism through the hypervisor to
> > communicate with the host - what would you be using in that case
> > instead of virtio?
>
> Socsim is net transported; it's sort of the TPM equivalent of NFS or
> iSCSI storage for guests.

Oh, so it relies on the guest being able to reach the host via
network? Hmm. That's a different security tradeoff. It presumably also
prevents any in-kernel use before networking is up?
