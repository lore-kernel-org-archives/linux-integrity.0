Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0055C4360F
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8D220C01
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCewEvSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfBYVBH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:01:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40874 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfBYVBG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 16:01:06 -0500
Received: by mail-io1-f65.google.com with SMTP id p17so8684422iol.7
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HvZczZo53Nm1Eu+KBNODzP9s6jD8TK0VIzWVAKJabM=;
        b=QCewEvSV//Fcuan8zEM+JHTVYLnSXz28RY8A4ZbACRUSntv9TRdsu1XtteUJemc9Ml
         sJHnaj3/3e4+NnT9jjbifTGpMtagV/Ho6pqOpWK9WvLiPbdxbNzdHzeWAacncTUk5u0t
         +l1fWNrPyAELthBgN7Lg2hzDWTXM7kVDMnU7jw5VlV0VpR2Fr/Xa43hDYtNUNUW3MX6Q
         t+5o42I8ZASjJZVB0mZUwokj5BHN6HRVBmIsWsHShdUXuqXy+C2/qzNBH5r2KAkHa20V
         4qgyxvZf/W0Na3N05tV658f0+xXwwXx55LGvtc47rNS758g/pHQQKNBHtytRBBIl646T
         FZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HvZczZo53Nm1Eu+KBNODzP9s6jD8TK0VIzWVAKJabM=;
        b=fu3OAfyIqNymsrGMIIqN6JvEunE/fl2pJsxXVNOGov/sgpCCSBoQe0MMXK/jZdTvTH
         I0vJhmJHr0jkFU4+eFV8TdrdYi6VgFvL2lvFDkHhgB7Nl059tDnUPc5qev9nucbVDJrb
         BswkRvCA5iN/YBmIkOPl5hZH6mcmE8MIkG/v9FKqCL4zcCRpEPcOzPVmecaoep5cy8Vp
         9TKcMYdP/uVWK7FfobLbmA93i/v3LEROmuQbMO0cnsfCFFkn9P8Or7yImUDp/dxcvifU
         PBQ4BhEsOmNWLb7K2aG3rPlbnHBvuqcJ898dfM6lHne8ZtiV61N3ic7fTMfv4TaPJS3O
         zKtw==
X-Gm-Message-State: AHQUAuZMcU2/zP/C9NJlkqoWOSzezJIhKz9REr9JUC8u1hpcd6c23XnN
        b9CSJmFkNxijLE9mpNl9bGHu53CVo5Yc+knQS4P3uQ==
X-Google-Smtp-Source: AHgI3IZM35jzzuiRyRp5Z0veiesO9upCo4Fx2+vVfJ3+bpAYrA/jFy/AE+I35sZrWizxWdO0PLK3P7i7zZTmUSUEhlg=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr10724150iol.88.1551128465461;
 Mon, 25 Feb 2019 13:01:05 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com> <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com>
In-Reply-To: <1551126043.3226.45.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 13:00:54 -0800
Message-ID: <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 12:20 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2019-02-25 at 11:17 -0800, Matthew Garrett wrote:
> > The existing hypervisor drivers expose hypervisor-specific details.
> > This proposed driver provides an abstract interface that is usable by
> > other hypervisors. It allows building a VM that exposes TPM
> > functionality without requiring additional hardware emulation,
> > reducing the hypervisor attack surface.
>
> Well, that depends whether you think a virtio bus is an abstract
> concept or a hypervisor specific detail.  There are currently four
> major hypervisors: xen, kvm, hyper-v and ESX.  Of those, only one
> implements virtio: kvm.  I agree virtio is a standard and certainly a
> slew of minor hypervisors implement it because they need paravirt
> support on Linux so they piggyback off kvm, but I don't see any of the
> other major hypervisors jumping on the bandwagon.

Is there any technical issue preventing virtio working with Xen?
Running HVM guests under qemu ought to allow virtio to work.

> > Well, no - in general there's no need to have more than one virtio
> > driver for any /class/ of hardware. For various unfortunate accidents
> > of history we've ended up with multiple cases where we have
> > hypervisor-specific drivers.
>
> Fully agree, that's why I'm doing so now.
>
> >  Using the more generic virtio
> > infrastructure reduces the need for that, since any hypervisor should
> > be able to implement the backend (eg, in this case it'd be very easy
> > to add support for this driver to qemu,
>
> I certainly agree there ... is there a plan for this?

I don't know, but I can see the value in making testing easier.

> >  which would allow the use of TPMs without needing to enable a whole
> > bunch of additional qemu features). This isn't a discussion we'd be
> > having if we'd pushed back more strongly against hypervisor-specific
> > solutions in the past.
>
> I'm still looking for the pragmatic use case.  I think yours is attack
> surface reduction, because the virtio discovery and operation is less
> code and therefore more secure than physical hardware discovery and
> operation?  I'm not entirely sure I buy that because the TPM
> communication interface is pretty simple and it's fairly deep down in
> the kernel internal stack making it difficult to exploit.

Being able to get away without any LPC support code at all seems like
a win, as does not having any ACPI or DeviceTree parsing code.
Injecting the hardware information via the kernel command line isn't
impossible, but it's not an attractive solution.
