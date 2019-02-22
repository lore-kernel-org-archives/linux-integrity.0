Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1EBC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77929206BB
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HgM4ljSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfBVVbj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:31:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33607 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVVbj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:31:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so1698099pgl.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 13:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8s7v8UhT5lAPnLyhANMUZf2qagmMvfAchIhQaOxs1QA=;
        b=HgM4ljStC9Qm2x9WVQaSOIH7/PEAQr069QZirbndRcxSGJcLv+TcDCy5+lumJJGoOx
         tSL4zAUzhTHm3PuO1ax64pPeqpo7afaV3AS2AOmYK/LAloS+tgoBi9RnePrnhE7XZFp8
         A7HjzjBcIQqfFXcWhEi6eMtedekUkSeJCHg6lBvg4y/dBluRI45xGd7lK3LZIIYJH6r+
         ld7bmYOV9kHDAOizxy8CTg3ixQfJ04sBpuKIvE2GRHtoWh73aKAOc8RCTDG3QkVzFpKq
         G+1reov3YQ7BG+YKALAPP79LYzoe1+8bCrLzq8J4OOy4u8b9x9lQv3A1KjuQQdjlcD0E
         sOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8s7v8UhT5lAPnLyhANMUZf2qagmMvfAchIhQaOxs1QA=;
        b=c5KICF9dnB6tojpjfRiG61cZ7K2lWBcARRCB25p/qlKy/YfVpbm3MXhftoC1RHIjWM
         TmiYcIbX2MGOd16AhXZZkYcCZZRxAL+nlcxKAfEtAkCWjx8FJdy5xsjKo4MuSV/hPbhA
         1b0KJKW3rNvrRFxQTI2Y0f3Wx+4+hZuf6mjQC8uc+F0HNlhDqK8KzGYcjXVuj8+VbIkG
         eNWXbfnZfhY9o81eqd8fVyjK0W0gcXg9Byb/bT3QacDFreBU6y/kntSeZpFvoXYymK/S
         ylt6lkam7Bzt/evUiLEn4vG/J2vftn5pYnOlsRRY2bd25g4v7QFgCuYbw0JhXae+NxHg
         Hixg==
X-Gm-Message-State: AHQUAubhjHiifzoILPV3RxmabFDfcGvI1tcpfeCDy4Sav+V2WH4+wjyF
        Wh8CjM0rhBgtfaZsM3kU/G5pUA==
X-Google-Smtp-Source: AHgI3IZEbazbZp+ExGNf35piglrvNY+mgv8cBddPf2VbH+0rQ5pBhWwQ3rbCmAH1FrtXc53NKKKpsg==
X-Received: by 2002:a63:2c7:: with SMTP id 190mr5566001pgc.367.1550871098314;
        Fri, 22 Feb 2019 13:31:38 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a20sm6288450pfj.5.2019.02.22.13.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:31:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gxIPx-0003xy-6J; Fri, 22 Feb 2019 14:31:37 -0700
Date:   Fri, 22 Feb 2019 14:31:37 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222213137.GZ17500@ziepe.ca>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <20190222160220-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222160220-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 04:16:01PM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> > On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > > guest kernel side of TPM over virtio.
> > 
> > What's the use case for using this over the current non-virtio vTPM?. 
> > I always thought virtio was about guest to host transport efficiency,
> > but the phsical TPM, being connected over a very slow bus, is about as
> > inefficient as you can get in that regard, so why do we need to use
> > virtio to drive the virtual one?
> 
> I can't say for sure about TPM.
> 
> But generally there are many reasons to do virtio rather than emulating
> a hardware device.

We already have a xen 'virtioish' TPM driver, so I don't think there
is a good reason to block a virtio driver if someone cares about
it. There are enough good reasons to prefer virtio to other options,
IMHO.

Provided it meets the general requirements for new virtio stuff you
outlined.

Jason
