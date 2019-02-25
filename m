Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314FC4360F
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0490217F9
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLvYe+uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfBYWY4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:24:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40421 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYWY4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 17:24:56 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so990849ite.5
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLskXa7LM+VPvVMl0WdLXteMeZno4K0gpEj+n0QMlAw=;
        b=oLvYe+uHNKANGAZu7ld9+G7n7Lq2l1nZkizKqOomLWjW5LToLj8ViGwE2ewpP3vxjP
         lZUinc13X2FNCx8hGA12GIWz32WHjcHVXHlj0k9Hn/WDWVgGZUCCP4YxwTqlwdkKC/5C
         GHWEK98jB/BWbj0ISL+W5PxvELZZgh/tGVYWP7AFno34kX8qzSEUbk0KGt/GS5vbpK5g
         kIeoyQpIvr0h/czX2xLDQV5ljPavKxXg6TUcQAPgIKPLUrDI7etMsa90LHZD+dTugYR/
         QbCis4rprVOHeCWgvDwrt7vz39Cg2RTfEZkjWmF1NGr8cGlpOMZXMUiKmH2k56/gJY+m
         3fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLskXa7LM+VPvVMl0WdLXteMeZno4K0gpEj+n0QMlAw=;
        b=UNUJe3N3zsvvOAybmivL5Yrfo0Qv98gooZW5XGM4dDNpPcpRCTXlhbny9Ocy/WPFRC
         5zJFFWzX369OmVWdgtOdQl4mpZAw6QCLERBHPyvYxE1MjoIFZ3NmKj1ZseZy6cwM9+wd
         LNl82863jdTpOpLfbOSSmMMFcPL8+BKLG3cQ5G+XLD50UwVzcqL50IOGnPF9Jo1mXDdX
         dwguEEI6gt1YX7zMZsdZKACFAF0yjNMI3X7hkXAFITaRnA2cVkewuVACk+A80cHr1dVL
         G394EeDWZu5Ndkie3P3RbMJ4Yab2ti2JABwDKbBgFqKIN0Jfmk/vlv/GRyu8m1bIdSLr
         /JGg==
X-Gm-Message-State: AHQUAua7Bb17PuQUaSLk4vJBhZtEHIlRkyaf5YX1SOQSA9xDv6xclfHj
        nPja/JzinTXmgWtdVO3d8ESy+5yFbezZaMaViTS8SQ==
X-Google-Smtp-Source: AHgI3Ia7pNpPpyZZMO35iDfnuxZsUevl35bOZQzOUppOXtOaod7Z66lF9I1Oqw2SJega3V5zfhms/BmD+LkQP13ueAU=
X-Received: by 2002:a24:43d1:: with SMTP id s200mr708734itb.118.1551133495213;
 Mon, 25 Feb 2019 14:24:55 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com> <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com> <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
 <1551132882.3226.67.camel@HansenPartnership.com>
In-Reply-To: <1551132882.3226.67.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 14:24:44 -0800
Message-ID: <CACdnJuus3yOcNy-uKWh_Mt-eDfP8xePize572jg92a5zkuECrA@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 2:14 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> > Being able to get away without any LPC support code at all seems like
> > a win, as does not having any ACPI or DeviceTree parsing code.
> > Injecting the hardware information via the kernel command line isn't
> > impossible, but it's not an attractive solution.
>
> Heh, but isn't that exactly what crosvm did for usb:
>
> https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/add5a4c3751778e5380f00b2ee6cebcb6bda48fc

My understanding is that the crosvm USB code is intended to allow
arbitrary USB hardware to be passed through to the guest - doing this
via virtio sounds complicated (you'd need a virtio driver that covered
every USB class, and how would you manage that for devices that are
handled in userland at the moment), whereas the virtio TPM support is
intended to pass through a software TPM rather than grant access to
the host TPM.

> Effectively it bypasses the hypervisor altogether and simply makes a
> direct connection to the host devices.  The TPM could actually work in
> exactly the same way, except you'd have to use the socsim IP connection
> (which all TSSs support) rather than a file descriptor.

I don't really follow - how would in-kernel TPM features work then?
