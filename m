Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5EC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB720675
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="C4fPKtjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBVWS0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:18:26 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51430 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfBVWS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 17:18:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C2FDE8EE26A;
        Fri, 22 Feb 2019 14:18:24 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COzRZwdAXxpH; Fri, 22 Feb 2019 14:18:24 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7FA618EE105;
        Fri, 22 Feb 2019 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550873903;
        bh=vu2XHq2Z4DYFLUvIIUiEdBOwaFslrcwPqmCLawavzMc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C4fPKtjHIW1nQA4LlEOqgfU6kkdc9qGLHB5nyAopFdDYn1C2juC18gk5CibMc2CQX
         djepl8qsfB1rCr7JkmBXR5ayMKg87jhGd3Bze7fY1Ye9BDuhY90guXkLNXfUdUvuuE
         byHDXNmXwpfUPdGdHZ4odjqaKFXtz+RpOlQECNoM=
Message-ID: <1550873900.2787.25.camel@HansenPartnership.com>
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
Date:   Fri, 22 Feb 2019 14:18:20 -0800
In-Reply-To: <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
         <1550849416.2787.5.camel@HansenPartnership.com>
         <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-02-22 at 14:00 -0800, David Tolnay wrote:
> On 2/22/19 7:30 AM, James Bottomley wrote:
> > On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > > guest kernel side of TPM over virtio.
> > 
> > What's the use case for using this over the current non-virtio
> > vTPM?. I always thought virtio was about guest to host transport
> > efficiency, but the phsical TPM, being connected over a very slow
> > bus, is about as inefficient as you can get in that regard, so why
> > do we need to use virtio to drive the virtual one?
> > 
> > > Use case: TPM support is needed for performing trusted work from
> > > within a virtual machine launched by Chrome OS.
> > 
> > The current vTPM does this, what's the use case for your special
> > one?
> 
> Thanks James, these are important questions and the intention
> certainly isn't to have another driver that does the same thing with
> differences for no reason.
> 
> I see three existing vTPM drivers already in drivers/char/tpm.
> 
> - tpm_ibmvtpm, which is specific to PowerPC and implemented in terms
> of PowerPC hcalls.
> 
> - xen-tpmfront, which is specific to Xen.
> 
> - tpm_vtpm_proxy, which as I understand it is intended to enable
> userspace TPM.
>   That is, if we are using this driver in a guest kernel, the TPM
> implementation
>   also needs to reside in the guest kernel rather than in the
> hypervisor.
> 
> For our use case which is not PowerPC and is running in our own
> hypervisor with the TPM needing to be provided by the hypervisor,
> none of the existing vTPM drivers seemed to fit the bill.
> 
> Please let me know if I arrived at the wrong conclusion on this!

Actually, yes, your third statement is not wholly correct:  The in-
kernel vTPM proxy can certainly be used to emulate a TPM within a guest
for that guest to use without any support from the hypervisor. 
However, when you have the correct qemu (requires a recent one), the
vTPM emulator can run in the host (or hypervisor) and be passed through
to the guest.  The best description of how to do that seems to be this
blog entry:

https://s3hh.wordpress.com/2018/06/03/tpm-2-0-in-qemu/

So won't this mode of operation exactly work for you (obviously with
necessary modifications to the crosvm hypervisor)?

James

