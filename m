Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFFC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A8A21841
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cws0wPrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfBYWvt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:51:49 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57526 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728708AbfBYWvt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 17:51:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0F4978EE1A0;
        Mon, 25 Feb 2019 14:51:49 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ghq_VUdu-Qch; Mon, 25 Feb 2019 14:51:48 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1112E8EE101;
        Mon, 25 Feb 2019 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551135108;
        bh=WSdvB4lMWzZfO50Ccyn/jvKRnIPp8dWVS6rbA+pYxVQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cws0wPrF10v/F+cfJ+J3zM5cofwSiCUw5sxtacm6TCj+0QynpkCuOwN9IPk3A7Zgh
         r2ANkM9t5wFQ85lZAipJZbgCI7P3IZ4phEIXbf0gaQ6EaYEwfwsP3HMSq+jWwGKxpz
         yaxLtLxWF50JCPbAboobNa1W491j0VyCNyrAyr78=
Message-ID: <1551135106.3226.91.camel@HansenPartnership.com>
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
Date:   Mon, 25 Feb 2019 14:51:46 -0800
In-Reply-To: <CACdnJuvhqHCuA7x2oyAaHB1zWnQ5T_4vTSc=FT3h85+sMSmwfg@mail.gmail.com>
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
         <1551132882.3226.67.camel@HansenPartnership.com>
         <CACdnJuus3yOcNy-uKWh_Mt-eDfP8xePize572jg92a5zkuECrA@mail.gmail.com>
         <1551133927.3226.81.camel@HansenPartnership.com>
         <CACdnJuvhqHCuA7x2oyAaHB1zWnQ5T_4vTSc=FT3h85+sMSmwfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-25 at 14:43 -0800, Matthew Garrett wrote:
> On Mon, Feb 25, 2019 at 2:32 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Mon, 2019-02-25 at 14:24 -0800, Matthew Garrett wrote:
> > > My understanding is that the crosvm USB code is intended to allow
> > > arbitrary USB hardware to be passed through to the guest - doing
> > > this
> > > via virtio sounds complicated (you'd need a virtio driver that
> > > covered every USB class, and how would you manage that for
> > > devices
> > > that are handled in userland at the moment),
> > 
> > I think you'd need a virtio equivalent of the host driver, say
> > xhci_virtio ... you could still use the in-kernel USB class drivers
> 
> Mm. I honestly don't know enough about the desired use case for USB
> to be able to provide meaningful input here.
> 
> > > > Effectively it bypasses the hypervisor altogether and simply
> > > > makes a direct connection to the host devices.  The TPM could
> > > > actually work in exactly the same way, except you'd have to use
> > > > the socsim IP connection (which all TSSs support) rather than a
> > > > file descriptor.
> > > 
> > > I don't really follow - how would in-kernel TPM features work
> > > then?
> > 
> > If you do it at the TSS layer, then, of course, the kernel wouldn't
> > participate.  If you used the proposed in-kernel socsim driver, I
> > suppose it could ... not that I'm advocating this, I'm saying if
> > you want to minimise hypervisor code for attack surface reduction,
> > this would be the way to do it because this solution requires no
> > in-hypervisor code at all.
> 
> You still need a transport mechanism through the hypervisor to
> communicate with the host - what would you be using in that case
> instead of virtio?

Socsim is net transported; it's sort of the TPM equivalent of NFS or
iSCSI storage for guests.

James

