Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F6C10F00
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B172213A2
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aED8CmEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBYWOp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:14:45 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57182 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfBYWOp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 17:14:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9417D8EE1A0;
        Mon, 25 Feb 2019 14:14:44 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U9RRw-IUZ4T1; Mon, 25 Feb 2019 14:14:44 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 81FDC8EE101;
        Mon, 25 Feb 2019 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551132884;
        bh=V3e3EQV9+C8c/alX3nsgjQQMxUzi6L3tFYm+jshJCFU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aED8CmEq2iyI14GTN+XmhEbrh1tmBSg2zakA25//w10C9kwYVdRzKoq0Gf2PG0YFo
         ro0m6Q4llO5EBZUiwInv/f3+1MRw31NllLpa38sGm7ljX8fyWog08XrRRSwma/RnOb
         2x5ojXHyYI4Xg6OJK2Z3Mze4u/+Ac+4pKdf3nMFk=
Message-ID: <1551132882.3226.67.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Date:   Mon, 25 Feb 2019 14:14:42 -0800
In-Reply-To: <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
         <1550849416.2787.5.camel@HansenPartnership.com>
         <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
         <1550873900.2787.25.camel@HansenPartnership.com>
         <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
         <1550885645.3577.31.camel@HansenPartnership.com>
         <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
         <1551025819.3106.25.camel@HansenPartnership.com>
         <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
         <1551108969.3226.26.camel@HansenPartnership.com>
         <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
         <1551126043.3226.45.camel@HansenPartnership.com>
         <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-25 at 13:00 -0800, Matthew Garrett wrote:
> On Mon, Feb 25, 2019 at 12:20 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Mon, 2019-02-25 at 11:17 -0800, Matthew Garrett wrote:
> > > The existing hypervisor drivers expose hypervisor-specific
> > > details.  This proposed driver provides an abstract interface
> > > that is usable by other hypervisors. It allows building a VM that
> > > exposes TPM functionality without requiring additional hardware
> > > emulation, reducing the hypervisor attack surface.
> > 
> > Well, that depends whether you think a virtio bus is an abstract
> > concept or a hypervisor specific detail.  There are currently four
> > major hypervisors: xen, kvm, hyper-v and ESX.  Of those, only one
> > implements virtio: kvm.  I agree virtio is a standard and certainly
> > a slew of minor hypervisors implement it because they need paravirt
> > support on Linux so they piggyback off kvm, but I don't see any of
> > the other major hypervisors jumping on the bandwagon.
> 
> Is there any technical issue preventing virtio working with Xen?
> Running HVM guests under qemu ought to allow virtio to work.

Other than developer resistance because xenbus was "first" not really,
I think.  There was even a GSOC student who tried it:

https://wiki.xenproject.org/wiki/Virtio_On_Xen

> > > Well, no - in general there's no need to have more than one
> > > virtio driver for any /class/ of hardware. For various
> > > unfortunate accidents of history we've ended up with multiple
> > > cases where we have hypervisor-specific drivers.
> > 
> > Fully agree, that's why I'm doing so now.
> > 
> > >  Using the more generic virtio infrastructure reduces the need
> > > for that, since any hypervisor should be able to implement the
> > > backend (eg, in this case it'd be very easy to add support for
> > > this driver to qemu,
> > 
> > I certainly agree there ... is there a plan for this?
> 
> I don't know, but I can see the value in making testing easier.

Having at least a commitment to qemu support does make the case
stronger.

> > >  which would allow the use of TPMs without needing to enable a
> > > whole bunch of additional qemu features). This isn't a discussion
> > > we'd be having if we'd pushed back more strongly against
> > > hypervisor-specific solutions in the past.
> > 
> > I'm still looking for the pragmatic use case.  I think yours is
> > attack surface reduction, because the virtio discovery and
> > operation is less code and therefore more secure than physical
> > hardware discovery and operation?  I'm not entirely sure I buy that
> > because the TPM communication interface is pretty simple and it's
> > fairly deep down in the kernel internal stack making it difficult
> > to exploit.
> 
> Being able to get away without any LPC support code at all seems like
> a win, as does not having any ACPI or DeviceTree parsing code.
> Injecting the hardware information via the kernel command line isn't
> impossible, but it's not an attractive solution.

Heh, but isn't that exactly what crosvm did for usb:

https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/add5a4c3751778e5380f00b2ee6cebcb6bda48fc

Effectively it bypasses the hypervisor altogether and simply makes a
direct connection to the host devices.  The TPM could actually work in
exactly the same way, except you'd have to use the socsim IP connection
(which all TSSs support) rather than a file descriptor.

James

