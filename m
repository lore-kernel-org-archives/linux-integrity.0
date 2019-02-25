Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE195C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B1820663
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 15:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WPpBV/yS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBYPgO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:36:14 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53570 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbfBYPgN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 10:36:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D3EE88EE1A0;
        Mon, 25 Feb 2019 07:36:12 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L5-bo-phW8mM; Mon, 25 Feb 2019 07:36:12 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B959B8EE101;
        Mon, 25 Feb 2019 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551108972;
        bh=vkhsJlcIsXzV5jlDDfzQTsMGWiUtjZ+E8v6v4PtcsM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WPpBV/ySqD18FciNB+8klVnC5s8GhJfUbqZrapOJYILiSrpNIKQExNRXIC0Jm9O2D
         Ve7dgybIP8mtPX5+PHEp0GBO36lOH1hzeMRb8Legf2s7T1NK9FYosAeSak8QVZVmuM
         BDQObACvbNNq/K/twK87Iy73OeyzntEsbjwaXHyQ=
Message-ID: <1551108969.3226.26.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Tolnay <dtolnay@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Date:   Mon, 25 Feb 2019 07:36:09 -0800
In-Reply-To: <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
         <1550849416.2787.5.camel@HansenPartnership.com>
         <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
         <1550873900.2787.25.camel@HansenPartnership.com>
         <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
         <1550885645.3577.31.camel@HansenPartnership.com>
         <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
         <1551025819.3106.25.camel@HansenPartnership.com>
         <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-02-24 at 14:12 -0800, David Tolnay wrote:
> On 2/24/19 8:30 AM, James Bottomley wrote:
> > QEMU implements a virtual hardware emulation for discovery, but
> > once discovered all the packet communication is handed off to the
> > vTPM socket.
> > 
> > The virtual hardware emulation can be anything we have a driver
> > for. TIS is the simplest, which is why I think they used it.  TIS
> > is actually a simple interface specification, it supports discovery
> > over anything, but the discovery implemented in standard guest
> > drivers is over ACPI, OF and PNP.  If you want more esoteric
> > discovery methods, we also support i2c.  However, that latter is
> > really only for embedded.  I think QEMU chose TIS because it works
> > seamlessly on both Linux and Windows guests.
> > 
> > 
> > > All of this is what I would like to avoid by using a virtio
> > > driver.
> > 
> > How? Discovery is the part that you have to do, whether it's using
> > emulated physical mechanisms or virtual bus discovery.
> 
> What I mean is that we avoid the need for *TPM-specific virtual
> hardware emulation* for discovery by using a virtio driver.
> 
> We avoid implementing TIS or any other TPM-specific interface
> mechanism, and we avoid implementing ACPI or OF or PNP or I2C or any
> other additional bus necessitated by the existing set of Linux TPM
> drivers which we wouldn't otherwise need.
> 
> The virtio driver performs discovery via virtio, which crosvm
> implements already for all of its supported devices. This
> substantially reduces the amount of TPM-specific code compared to
> your suggestions, and lowers the barrier to entry for implementing
> TPM support in other hypervisors which I hope we agree is beneficial.

Well, that's somewhat misleading:  The reason we already have two
hypervisor specific drivers already is because every hypervisor has a
different  virtual discovery mechanism. You didn't find the other two
hypervisor drivers remotely useful, so why would another hypervisor
find yours useful?

> Turning this around a different way, suppose that there already was a
> virtio TPM driver in the kernel.

There already are two paravirt TPM drivers: xen-tpmfront and
tpm_ibmvtpm.

The reason we have so many is that every hypervisor implements a
different virtual bus mechanism.  So if we add this for you all we need
is an ESX driver to have the full complement; or at least for the four
main hypervisors, there are probably a huge number of minor ones, like
the parallels hypervisor, virtual box etc. ... by the time we're done
we'll have ten or so paravirt TPM drivers.

>  For me as a hypervisor implementer, what advantages do you see that
> would make me decide to implement TPM-specific virtual hardware
> emulation in the form of TIS rather than simply leveraging a virtio
> driver like for other virtual devices?

So your argument is that for every device we have in the Linux kernel,
we should have the N hypervisor paravirt variants for the same thing? 
I assure you that's not going to fly because paravirt drivers would
then outnumber real drivers by an order of magnitude.

> > If you want to make this more concrete: I once wrote a pure socsim
> > packet TPM driver:
> > 
> > https://patchwork.ozlabs.org/patch/712465/
> > 
> > Since you just point it at the network socket, it does no discovery
> > at all and works in any Linux environment that has net.  I actually
> > still use it because a socsim TPM is easier to debug from the
> > outside. However it was 230 lines.  Your device is 460 so that
> > means about half your driver is actually about discovery.
> 
> It looks like all the comments in the virtio driver account for the
> difference, not necessarily discovery.
> 
> But to put this in perspective, what we save is the 1000+ lines I see
> in QEMU dedicated to TIS. Without a virtio driver (or socsim, or
> something else that avoids TPM-specific hardware emulation for device
> discovery), QEMU and crosvm and other hypervisors need to reproduce a
> TIS implementation. Conceptually this is simple but it is still a
> quite substantial barrier compared to not needing any TPM-specific
> discovery.

Paravirt drivers are something we add when there's a pragmatic use
case.  Paravirt is not a panacea because it costs us in terms of
additional maintenance burden.  You also still need a receiver in the
hypervisor even for a paravirt driver.  We can argue about the amount
of code you need for the receiver, but without adding some code another
hypervisor can't make use of your paravirt driver.  And, of course, if
they use a different virtual bus implementation, as every hypervisor
seems to, it's quite an enormous amount of code to emulate your bus
implementation.

> > The only reasons I can see to use a virtual bus is either because
> > its way more efficient (the storage/network use case) or because
> > you've stripped down the hypervisor so far that it's incapable of
> > emulating any physical device (the firecracker use case).
> 
> Crosvm does fall under the Firecracker use case, I believe.

Well you just added USB emulation:

https://www.aboutchromebooks.com/news/project-crostini-usb-support-linux-chrome-os/

You didn't tell the kernel USB subsystem to add virtio USB drivers ...

What I've been fishing for for several emails is the pragmatic use case
... do you have one?

James

