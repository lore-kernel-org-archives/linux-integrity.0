Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467DC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837B4206B6
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfBVVQF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:16:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33093 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVVQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:16:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so4211441qtz.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 13:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+cOjNwbVoWtYykF2haruDcaiY9aEtOCw5d8PuCWX9U=;
        b=j3AuFo8TSR1NqKqeha5z6zJFJ+GwxC34zCVwKKCUhMwfIirnoLBorMGfvKzJsExwzI
         mV40WbpFyFQJrLwg/9aIvt13pkfH4iyzpNZ75DKCiuRW3BI0DJVc8TMEjcrSofBcwvr6
         b9GR8XZw599B7ZP67lIbkbC6wzR4rbKeWgXUUymWWEeFrqEmSa91qAoaryo8srGuUhsT
         jWJ9ccJKHXAtnH1vvIxoZHOrz43lTOPWDy62aJ6+UIlX39pil0au0qAe2nIiYFvUAfQt
         euYUsBqGqglt/5VcrFrLYqMT+S8EEtTPMhgSTOtG0gdVoaOE2m1eOvVgNUhpW3b94W0s
         gwHQ==
X-Gm-Message-State: AHQUAuZDcFGeQsg0kgtku1TXXtpi9LKFBW/NEubZ/3P2fQO10Vn9Cb3s
        mHg6bkGHwi2ctuZ06IculT4wV1MDP0T/nw==
X-Google-Smtp-Source: AHgI3IbLCiJ/BfvwpP6f6/EotKmwl2wg7r6Us9gepUQ5JhkxanXwnITtkwL7YtM3UMsdqT/GDMvWng==
X-Received: by 2002:ac8:3281:: with SMTP id z1mr4800688qta.232.1550870164894;
        Fri, 22 Feb 2019 13:16:04 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id o2sm1961954qtf.46.2019.02.22.13.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:16:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 16:16:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222160220-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550849416.2787.5.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > guest kernel side of TPM over virtio.
> 
> What's the use case for using this over the current non-virtio vTPM?. 
> I always thought virtio was about guest to host transport efficiency,
> but the phsical TPM, being connected over a very slow bus, is about as
> inefficient as you can get in that regard, so why do we need to use
> virtio to drive the virtual one?

I can't say for sure about TPM.

But generally there are many reasons to do virtio rather than emulating
a hardware device.

Ease of extending the device could be one. E.g. what if you want to make
an extension that hardware does not support?  You are at cross-purposes
with a hardware vendor who can happen to be the driver maintainer as
well.

A decent specification and readiness to fix bugs in the right place
(e.g.  driver violates spec? we'll fix driver not as you to work around
it in the device) is another.

You can also download the spec without clicking I agree once - and it
follows the Non-Assertion IPR Mode to help people not get sued.

Stuff like that is conductive to getting things done.

-- 
MST
