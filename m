Return-Path: <SRS0=M3wd=Q6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3585C43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 01:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3124206B7
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Feb 2019 01:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="irOxLvaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBWBeJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:34:09 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52848 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfBWBeI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 20:34:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 654388EE26A;
        Fri, 22 Feb 2019 17:34:08 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5HUj6Je_qlPb; Fri, 22 Feb 2019 17:34:08 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AED118EE105;
        Fri, 22 Feb 2019 17:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550885648;
        bh=qUSrlhTsid8/jnlJt5kyy3Ag4Z8EXM6AAE80rK5N7aM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=irOxLvaauChPH7x1cFPxAyl4+IJGNBNSNazrBWSG+w/Fe6CPwpcbYl3ejMBQ+ox1W
         b6Tu17ev7fEHcAMSRA1T4omOwE3/Y+Czl8mygJPa2ycBhGe+nJodfyqEl+dkTWaVyt
         LIZrjy9gNmTguIu31JS3LDiR28+d4Geea3m+7w/U=
Message-ID: <1550885645.3577.31.camel@HansenPartnership.com>
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
Date:   Fri, 22 Feb 2019 17:34:05 -0800
In-Reply-To: <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
         <1550849416.2787.5.camel@HansenPartnership.com>
         <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
         <1550873900.2787.25.camel@HansenPartnership.com>
         <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-02-22 at 16:45 -0800, David Tolnay wrote:
[...]
> I appreciate the explanation and link, James!
> 
> I had briefly investigated the existing support in QEMU before
> pursuing a virtio based driver. At the time, I determined that QEMU
> implements a register level emulation of a TPM rather than what our
> team would consider a minimum viable vTPM.

Actually, no, it doesn't at all.  QEMU implements nothing about a TPM. 
You have to set up a software TPM outside of qemu which talks over a
socket and then use the vTPM socket to pass that TPM through to qemu. 
Effectively QEMU is TPM implementation blind (which is why it can do
both 1.2 and 2.0) all it provides is discovery of the virtual hardware.

>  It implements the TPM-specific TIS interface (QEMU's tpm_tis.c) as
> well as CRB interface (QEMU's tpm_crb.c) which require Linux's TIS
> driver (Linux's tpm_tis.c) and CRB driver (Linux's tpm_crb.c)
> respectively. Both of those are based on ACPI.

That's right, QEMU implements the device interface emulation, but it
passes the actual TPM communication packets to the vTPM outside QEMU.

> As far as I can tell, QEMU does not provide a mode in which the
> tpm_vtpm_proxy driver would be involved *in the guest*.

It doesn't need to.  the vTPM proxy can itself do all of that using the
guest Linux kernel.  There's no hypervisor or host involvement.  This
is analagous to the vTPM for container use case, except that to get
both running in a guest you'd use no containment, so the vtpm client
and server run in the guest together:

https://www.kernel.org/doc/html/v4.16/security/tpm/tpm_vtpm_proxy.html

>  Certainly you could use a vtpm proxy driver *on the host* but would
> still need some other TPM driver running in the guest for
> communication with the host, possibly virtio. If this second approach
> is what you have in mind, let me know but I don't think it is
> applicable to the Chrome OS use case.

Actually, the vTPM on-host use case doesn't use the in kernel vtpm
proxy driver, it uses a plain unix socket.  That's what the original
website tried to explain: you set up swtpm in socket mode, you point
the qemu tpm emulation at the socket and you boot up your guest.

> Clearly it's possible for us to go the QEMU route and implement ACPI
> (which crosvm does not otherwise need) plus one or both of TIS and
> CRB in crosvm, but since all we need is for TPM command buffers to
> leave the VM and TPM response buffers to enter the VM, all of that
> seems unnecessarily complicated. A virtio driver substantially
> lowers the barrier to implementing a hypervisor vTPM.

I don't believe it requires ACPI, that's just one common way of
enumerating TPMs and it's how the guest finds it.  If you implemented
the QEMU passthrough in crosvm, you could use whatever mechanism that's
convenient to you and would cause a TPM driver to bind.  It's the QEMU
layer that provides the virtual hardware emulation for the device and
the external vTPM that provides the TPM implementation.  The two are
completely decoupled.

Are you saying crosvm has no ability at all to emulate the discovery
that we use in the kernel to find TPMs?  Is it some type of firecracker
like think that only supports fully emulated devices?

> Separately, I'd be curious whether you share Jason Gunthorpe's
> opinion stated elsewhere in the thread, or whether you would
> encourage the virtio TPM driver to be kept private if feasible
> alternative drivers already exist. Jason's comment:
> 
> > We already have a xen 'virtioish' TPM driver, so I don't think
> > there is a good reason to block a virtio driver if someone cares
> > about it. There are enough good reasons to prefer virtio to other
> > options, IMHO.

I've no real opinion on that one until I understand why you went down
this path instead of using existing implementations.  Right at the
moment I do get the impression its because you didn't know how the
existing implementations worked.

James

