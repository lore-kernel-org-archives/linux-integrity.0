Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E79EC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D936A2075A
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 15:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aMgWdKvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVPaU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:30:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47100 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfBVPaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 10:30:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DA5978EE26A;
        Fri, 22 Feb 2019 07:30:19 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bv32THPaXEth; Fri, 22 Feb 2019 07:30:19 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 502228EE105;
        Fri, 22 Feb 2019 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550849417;
        bh=gQY26nrSIVM4g78pmd0BvxRZmKnSuJldBKoBBExjkts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aMgWdKvvGajUbYugjz7cx8x8+TwtBVoxU4XHxv9O3ziTueK1Ysfbugi90WVnoVQ9D
         Enq/lIhBSOVXkLRSuYfSmwtxZeWXnhPvVROTxNxgl7PRi1TwDWF4Uy4RqY3ovGDlTe
         +KkclTBZ8bZkDROHmmJVXg7z4F2hAp75wVA5iPm8=
Message-ID: <1550849416.2787.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Date:   Fri, 22 Feb 2019 07:30:16 -0800
In-Reply-To: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> guest kernel side of TPM over virtio.

What's the use case for using this over the current non-virtio vTPM?. 
I always thought virtio was about guest to host transport efficiency,
but the phsical TPM, being connected over a very slow bus, is about as
inefficient as you can get in that regard, so why do we need to use
virtio to drive the virtual one?

> Use case: TPM support is needed for performing trusted work from
> within a virtual machine launched by Chrome OS.

The current vTPM does this, what's the use case for your special one?

> Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> implementation of the virtio TPM device can be found in these two
> source
> files:
> 
> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce
> 5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce
> 5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> 
> and is currently backed by the libtpm2 TPM simulator:

So is the reason simply that crosvm did vTPM emulation differently from
qemu and thus needs a different driver?

James

