Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2933C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD91A2086A
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVPXG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:23:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33585 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPXG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 10:23:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so2912294qtz.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 07:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOHY8dYn9kTwJYCfiZpu4wTaeRPc0R5tD4IcVcFb15k=;
        b=QHpyk3rFs0LlucwQQLZgqhzxJzxsOBGJP7Ye6uNPo2kKH05fgsFr79udKcBsQMBmM0
         gc3REVSgWoax6AnMtVnQ29+lH0rSfFL/xC/D/1kNnzvytt4wpFLQSih5zKCHavFZX+MR
         IUzAFQFw99ZPazyJGVV+p9VYgQO6VSAhloDZhAngIBWFi2P0i/X/vHzcI9Y/5EOXcmIX
         BFIHsyp6Lyh8ywQrAZmYcrXePdRG+ez91HZVv+ZbJsItOoMkIUVAyBmhk9o62UGdrqKw
         CxoRsF6JRn3X/uDfpBr0zBhNCfEh2Nkj7QUdHQcRHhu7/phuZ8FsuEdHN3UX2WeSVDvV
         InWQ==
X-Gm-Message-State: AHQUAuZQ/+tW2ls9aMzEOvQWHTpRlGvRiqgPvC7xJdszbDot87JsZAkO
        T1DQ6St77uWhCP+G+DDhBQAv6A==
X-Google-Smtp-Source: AHgI3IYZf/O10hjD1XhS+qRwJv3jo1KaV7YZYqlkhP4CCRGZo964upbQkl/Mmlt/pvl9P4ib3U/JgQ==
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr3513141qts.266.1550848985646;
        Fri, 22 Feb 2019 07:23:05 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v22sm1164087qtb.72.2019.02.22.07.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:23:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:23:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222101728-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222102610.GB5613@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > kernel side of TPM over virtio.
> > 
> > Use case: TPM support is needed for performing trusted work from within
> > a virtual machine launched by Chrome OS.
> > 
> > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > implementation of the virtio TPM device can be found in these two source
> > files:
> > 
> > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> 
> These files/links do not make sense for kernel testing. Please remove
> them from the next version.

To clarify generally for a virtio device we want
- guest support
- device support
- spec

If the device is implemented in qemu and guest in linux kernel,
then there are lots of people familiar with these
programming environments, so sometimes we merge
guest and host code even if spec isn't written up at all.

If you don't want to do that there's a small number of people who can
properly review code, e.g. I don't think lots of people on this list are
familiar with crosvm.  One way to address this would be to build a QEMU
implementation. Another would be to write up a spec.  You can do both
too :)



> > and is currently backed by the libtpm2 TPM simulator:
> > 
> > - https://chromium.googlesource.com/chromiumos/third_party/tpm2/
> > 
> > Reviewed-on: https://chromium-review.googlesource.com/1387655
> 
> A non-standard flag. Should be removed. Also
> 
> > Reviewed-by: Andrey Pronin <apronin@chromium.org>
> > Tested-by: David Tolnay <dtolnay@gmail.com>
> > Signed-off-by: David Tolnay <dtolnay@gmail.com>
> 
> Your SOB should first and you cannot peer test your own patches. Please
> remove tested-by.
> 
> The whole thing looks like an early draft. Why the patch does not have
> an RFC tag? You should use it for early drafts. Now it is like saying
> "please merge this".
> 
> I don't have much knowledge of virtio. The commit message should at
> least give rough overview what is meant by "kernel side" in this
> context.
> 
> Since one cannot use standard Linux environment to test this I'm not too
> optimistic about this getting merged any time soon. And since even the
> commit message is broken I don't think it makes sense to review the code
> in detail at this point.
> 
> /Jarkko
