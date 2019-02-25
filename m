Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11862C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D841820652
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ9fVKP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBYTRd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:17:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37039 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTRc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 14:17:32 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so137040itc.2
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxAJYrRkAhHScOzFtK9wXtlGx5UUi1BjO67mxeJvLIA=;
        b=uJ9fVKP1w+mTsD+gvyMxekyFTEZypLRwXuggIOOq5L+cnIK1Fx07251wv1cgN8Auv1
         6oC6+sOzEzFGGzRnKHmzeulGHdzHoIGCNG5f/SSCaSHcqArQKQXcX8w6ozc+a0dp8V9I
         hp1QHLifWfD/pRGwx7afBwK9E0hkbVDyifZ4ACc5kkXIdDRPFE2P7sC6SZJjbMZSNoe3
         x0q5Mz8xi4l03AOL/6GSBog+Cm0G94j3dAOAxZokWUmTIxPTqX61FqGRaqCSWq512rsV
         tH2k8TAL1L+g+wXPzSmJgefTWK2I9owvKnk1gqB1fp8/lLhdhwffpx+IgRMe8Vimb63c
         D+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxAJYrRkAhHScOzFtK9wXtlGx5UUi1BjO67mxeJvLIA=;
        b=aAyZ2sV08ddghWcaaSyO+7S/8TtE9/cH71YZMvjbzh6kNbM5P9XDMQyEmsHO7c1zBD
         aVb7j8hp8pSjI5s8IulgCgDgKiZ2u+uLHzWqN89rlQSkhhJdSsqv7oaPJu0KBTaUnizz
         S0ZfCAjCyMvnksljNZeW5p76hSw91Vwttd7yzNgl6nnGl3uRQIwvUqV/71uv+dsHeYmp
         2eIdZttngByt8X05nuoHK5MMwzUF8IfaUMZrLf0WVyvR4yWkssSUXlHfUBxdQSoCaQ4C
         AJjJdryH8Rw1uhlh3PsP9bmXLMP5bkrXhoF1VK1xQqONOnDwRREDJMqoOIzIPlzQiWE9
         lHKw==
X-Gm-Message-State: APjAAAWigUC2qEjI4nwDUdI10SeVWZcsq6zm9PDliND5jvzHa4Yjh2Bs
        cr06v7mHlgdpqxXowSUXubBJ4c2hD4GzetL9rjMKP/8deoE=
X-Google-Smtp-Source: AHgI3IbBKvMliHkzKNfBLmjNQxunQt7ke4tK/pyeGlE8ae1DAbw1EV6DJY029K5cfXpdwrir7PNtJJMeAn3Tdk0w6BA=
X-Received: by 2002:a24:7908:: with SMTP id z8mr285502itc.16.1551122251219;
 Mon, 25 Feb 2019 11:17:31 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com>
In-Reply-To: <1551108969.3226.26.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 11:17:20 -0800
Message-ID: <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 7:36 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> > The virtio driver performs discovery via virtio, which crosvm
> > implements already for all of its supported devices. This
> > substantially reduces the amount of TPM-specific code compared to
> > your suggestions, and lowers the barrier to entry for implementing
> > TPM support in other hypervisors which I hope we agree is beneficial.
>
> Well, that's somewhat misleading:  The reason we already have two
> hypervisor specific drivers already is because every hypervisor has a
> different  virtual discovery mechanism. You didn't find the other two
> hypervisor drivers remotely useful, so why would another hypervisor
> find yours useful?

The existing hypervisor drivers expose hypervisor-specific details.
This proposed driver provides an abstract interface that is usable by
other hypervisors. It allows building a VM that exposes TPM
functionality without requiring additional hardware emulation,
reducing the hypervisor attack surface.

> >  For me as a hypervisor implementer, what advantages do you see that
> > would make me decide to implement TPM-specific virtual hardware
> > emulation in the form of TIS rather than simply leveraging a virtio
> > driver like for other virtual devices?
>
> So your argument is that for every device we have in the Linux kernel,
> we should have the N hypervisor paravirt variants for the same thing?
> I assure you that's not going to fly because paravirt drivers would
> then outnumber real drivers by an order of magnitude.

Well, no - in general there's no need to have more than one virtio
driver for any /class/ of hardware. For various unfortunate accidents
of history we've ended up with multiple cases where we have
hypervisor-specific drivers. Using the more generic virtio
infrastructure reduces the need for that, since any hypervisor should
be able to implement the backend (eg, in this case it'd be very easy
to add support for this driver to qemu, which would allow the use of
TPMs without needing to enable a whole bunch of additional qemu
features). This isn't a discussion we'd be having if we'd pushed back
more strongly against hypervisor-specific solutions in the past.

(While I work for Google, I'm not involved in crosvm development and
this shouldn't be interpreted as the position of anyone on that team)
