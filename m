Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798CDC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F320842
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ESFgQZXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfBYUUp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:20:45 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfBYUUp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 15:20:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C68298EE1A0;
        Mon, 25 Feb 2019 12:20:44 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1TARmK-ay5b0; Mon, 25 Feb 2019 12:20:44 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0C9208EE101;
        Mon, 25 Feb 2019 12:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551126044;
        bh=EKaNkS1QA1DBSNb0pls3mf5BO2f4cAwPmDQhJIQEtzw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ESFgQZXgIRdrEOSQq2x4YsCSzekZIdA/FW9wNqbpeFWVFFJq7L0HtqDMFrE4H7hr/
         bDn385rzQrv2OneLbkp3akys/8NneOdFf1fr7IiVEe7EXhxA1eypMSDpsNqkFxfraM
         wN8m4IpCAgMjBZwpDORRkpKwjISsdMFHJ94Zujq0=
Message-ID: <1551126043.3226.45.camel@HansenPartnership.com>
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
Date:   Mon, 25 Feb 2019 12:20:43 -0800
In-Reply-To: <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-25 at 11:17 -0800, Matthew Garrett wrote:
> On Mon, Feb 25, 2019 at 7:36 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > > The virtio driver performs discovery via virtio, which crosvm
> > > implements already for all of its supported devices. This
> > > substantially reduces the amount of TPM-specific code compared to
> > > your suggestions, and lowers the barrier to entry for
> > > implementing TPM support in other hypervisors which I hope we
> > > agree is beneficial.
> > 
> > Well, that's somewhat misleading:  The reason we already have two
> > hypervisor specific drivers already is because every hypervisor has
> > a different  virtual discovery mechanism. You didn't find the other
> > two hypervisor drivers remotely useful, so why would another
> > hypervisor find yours useful?
>  
> The existing hypervisor drivers expose hypervisor-specific details.
> This proposed driver provides an abstract interface that is usable by
> other hypervisors. It allows building a VM that exposes TPM
> functionality without requiring additional hardware emulation,
> reducing the hypervisor attack surface.

Well, that depends whether you think a virtio bus is an abstract
concept or a hypervisor specific detail.  There are currently four
major hypervisors: xen, kvm, hyper-v and ESX.  Of those, only one
implements virtio: kvm.  I agree virtio is a standard and certainly a
slew of minor hypervisors implement it because they need paravirt
support on Linux so they piggyback off kvm, but I don't see any of the
other major hypervisors jumping on the bandwagon.

I certainly agree our lives would be easier if all the major hypervisor
vendors would just agree a single paravirt driver standard.

> > >  For me as a hypervisor implementer, what advantages do you see
> > > that would make me decide to implement TPM-specific virtual
> > > hardware emulation in the form of TIS rather than simply
> > > leveraging a virtio driver like for other virtual devices?
> > 
> > So your argument is that for every device we have in the Linux
> > kernel, we should have the N hypervisor paravirt variants for the
> > same thing? I assure you that's not going to fly because paravirt
> > drivers would then outnumber real drivers by an order of magnitude.
> 
> Well, no - in general there's no need to have more than one virtio
> driver for any /class/ of hardware. For various unfortunate accidents
> of history we've ended up with multiple cases where we have
> hypervisor-specific drivers.

Fully agree, that's why I'm doing so now.

>  Using the more generic virtio
> infrastructure reduces the need for that, since any hypervisor should
> be able to implement the backend (eg, in this case it'd be very easy
> to add support for this driver to qemu,

I certainly agree there ... is there a plan for this?

>  which would allow the use of TPMs without needing to enable a whole
> bunch of additional qemu features). This isn't a discussion we'd be
> having if we'd pushed back more strongly against hypervisor-specific
> solutions in the past.

I'm still looking for the pragmatic use case.  I think yours is attack
surface reduction, because the virtio discovery and operation is less
code and therefore more secure than physical hardware discovery and
operation?  I'm not entirely sure I buy that because the TPM
communication interface is pretty simple and it's fairly deep down in
the kernel internal stack making it difficult to exploit.

James

