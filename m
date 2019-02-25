Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F90C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE01217F5
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XDC0lB4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfBYWY4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:24:56 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57252 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726919AbfBYWY4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 17:24:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8A9128EE1A0;
        Mon, 25 Feb 2019 14:24:55 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b1FCeoJGUl5q; Mon, 25 Feb 2019 14:24:55 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 209998EE101;
        Mon, 25 Feb 2019 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551133494;
        bh=gYPCkZ9FZitooDGmvyYgKnn+jkl/V8/CrR0hwnaMTFs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XDC0lB4oub4kFkJ/JtseRC3wcnQ8zzcltSVe+RbZEWDWMcVL7JZfxJQDO+C3ggoKL
         UTg0eiC4GaJ62sRybwd3mtiEAde/QqMZNFS+Cf5vzFwVZqTsi0jamkhA4E0fVcNGGd
         kcfgru8/6LyGD1JaFFiJWYDExlyhNBXHpqKHVW9Q=
Message-ID: <1551133491.3226.75.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Date:   Mon, 25 Feb 2019 14:24:51 -0800
In-Reply-To: <20190225210511.GA8727@linux.intel.com>
References: <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
         <1550873900.2787.25.camel@HansenPartnership.com>
         <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
         <1550885645.3577.31.camel@HansenPartnership.com>
         <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
         <1551025819.3106.25.camel@HansenPartnership.com>
         <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
         <1551108969.3226.26.camel@HansenPartnership.com>
         <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
         <1551126043.3226.45.camel@HansenPartnership.com>
         <20190225210511.GA8727@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-25 at 23:05 +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 25, 2019 at 12:20:43PM -0800, James Bottomley wrote:
> > On Mon, 2019-02-25 at 11:17 -0800, Matthew Garrett wrote:
> > > On Mon, Feb 25, 2019 at 7:36 AM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > The virtio driver performs discovery via virtio, which crosvm
> > > > > implements already for all of its supported devices. This
> > > > > substantially reduces the amount of TPM-specific code
> > > > > compared to your suggestions, and lowers the barrier to entry
> > > > > for implementing TPM support in other hypervisors which I
> > > > > hope we agree is beneficial.
> > > > 
> > > > Well, that's somewhat misleading:  The reason we already have
> > > > two hypervisor specific drivers already is because every
> > > > hypervisor has a different  virtual discovery mechanism. You
> > > > didn't find the other two hypervisor drivers remotely useful,
> > > > so why would another hypervisor find yours useful?
> > > 
> > >  
> > > The existing hypervisor drivers expose hypervisor-specific
> > > details. This proposed driver provides an abstract interface that
> > > is usable by other hypervisors. It allows building a VM that
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
> > 
> > I certainly agree our lives would be easier if all the major
> > hypervisor vendors would just agree a single paravirt driver
> > standard.
> 
> I think that a Windows hypervisor (Hyper-V) and a closed hypervisor
> (VMWare) are out of context for this discussion.

But why?  We already have both in various Linux subsystems; for
instance SCSI has storvsc (hyper-v paravirt storage driver) and
vmw_pvscsi (VMWare paravirt storage dirver).  The only real requirement
is a willingness to open source the driver and publish the
communication spec.  If another paravirt TPM driver is a good idea, why
wouldn't we allow these guys to play in our sandpit too (under the
right open source conditions, of course)?

James

