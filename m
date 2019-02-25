Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F00C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27869217F5
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 22:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERNbzDEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfBYWoF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:44:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38065 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfBYWoF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 17:44:05 -0500
Received: by mail-io1-f67.google.com with SMTP id p18so8929153ioh.5
        for <linux-integrity@vger.kernel.org>; Mon, 25 Feb 2019 14:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGBAeLcjhtfZdtptkxfrrAxX4GLODLgIkdmQR8dnq4k=;
        b=ERNbzDEPCQ46zQ2V8JTnQ94f4E+29Uz6iD0U2pJe0JxX2I7mgbJ2f/WxE+dYulb3tR
         1uceV+AAL47Be5wOPnKlVmGymaulY3QIwDJhEOVqZvM96/DjZ0pIYaWGjCRSc6U9WbfX
         3Rvj27JCrYf7z/bcgKTPdDBdV1XQ3i3knephgFmCDwZwqYaIxZV4VEAnZJhEpNGloOm1
         nMq1J5qdQuu3wuF0Cm+lPHiqAkXGDPgsXw/SL86m+ghs5io5lLzCa77lAZm90euJ2CYj
         Sbc+cltiACQyhbzUhaRNHJirCm3/IItvZbdZ/fzJOFVYNB4+G1aNx/Spnv/KS6fCwssV
         /mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGBAeLcjhtfZdtptkxfrrAxX4GLODLgIkdmQR8dnq4k=;
        b=mqU+bWHsPBsTOOuO/fDgP70GaRrTRA/ItQTYNMFweeaiDaBwVXyu7LnXF/tNnOz9ll
         LvoFY89XA1Za2Bfc05FIcSqmmtMzD6gz7Kmm1zyglssLoBslwA1mphayHN8H2pQH61JG
         UIf5Ex7DPOBX397nK2yit/OCBomZ3vJQfXfhfZHKp7h8hkY9Ay3Rz/vPLZJWXlhgQLEX
         61enpnlbsB2XO/vS3A0LzkD33XbSceXO+KsylazN+E/htv1coUXkBxBkN1BrNhLzuuD1
         xS366xAZzF3GQZGeqjLSWQP/XTKkJFGyv76CCn1fce+/FC3EjJ6FufRRm6UBFRkrPc4/
         SAGw==
X-Gm-Message-State: AHQUAua0+ND2WKiguODaoymvQdXabMCn271WASNJYkOdMsHKjpaIhBJW
        41t/xE9x5qKVJkHQZgLBuZ1xCQ/OyvGXDOzFcUZQFQ==
X-Google-Smtp-Source: AHgI3IaIkUMPCx//CxiSrJJleLgfJp+SEy7OLUu1KJtGFA108ALgORl7qu9u53rBJmsRIi9J+hS42FwTqAHnDiKm9Uo=
X-Received: by 2002:a5e:dc4c:: with SMTP id s12mr2158403iop.304.1551134643959;
 Mon, 25 Feb 2019 14:44:03 -0800 (PST)
MIME-Version: 1.0
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com> <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com> <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com> <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com> <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com> <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com> <CACdnJuvObeL75p1Wb2qnTdt1gS28zCMvasogA9=2ksMv=fE82Q@mail.gmail.com>
 <1551132882.3226.67.camel@HansenPartnership.com> <CACdnJuus3yOcNy-uKWh_Mt-eDfP8xePize572jg92a5zkuECrA@mail.gmail.com>
 <1551133927.3226.81.camel@HansenPartnership.com>
In-Reply-To: <1551133927.3226.81.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Feb 2019 14:43:52 -0800
Message-ID: <CACdnJuvhqHCuA7x2oyAaHB1zWnQ5T_4vTSc=FT3h85+sMSmwfg@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 2:32 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2019-02-25 at 14:24 -0800, Matthew Garrett wrote:
> > My understanding is that the crosvm USB code is intended to allow
> > arbitrary USB hardware to be passed through to the guest - doing this
> > via virtio sounds complicated (you'd need a virtio driver that
> > covered every USB class, and how would you manage that for devices
> > that are handled in userland at the moment),
>
> I think you'd need a virtio equivalent of the host driver, say
> xhci_virtio ... you could still use the in-kernel USB class drivers

Mm. I honestly don't know enough about the desired use case for USB to
be able to provide meaningful input here.

> > > Effectively it bypasses the hypervisor altogether and simply makes
> > > a direct connection to the host devices.  The TPM could actually
> > > work in exactly the same way, except you'd have to use the socsim
> > > IP connection (which all TSSs support) rather than a file
> > > descriptor.
> >
> > I don't really follow - how would in-kernel TPM features work then?
>
> If you do it at the TSS layer, then, of course, the kernel wouldn't
> participate.  If you used the proposed in-kernel socsim driver, I
> suppose it could ... not that I'm advocating this, I'm saying if you
> want to minimise hypervisor code for attack surface reduction, this
> would be the way to do it because this solution requires no in-
> hypervisor code at all.

You still need a transport mechanism through the hypervisor to
communicate with the host - what would you be using in that case
instead of virtio?
