Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D076FC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC0A2075C
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfBVWHY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:07:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40669 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWHY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 17:07:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so4302379qta.7
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 14:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVlgmnFkcj2PmgtNeWcNciyK5dvnSRfqqMGJ0Dku9LQ=;
        b=lW44EhE5OUsSYpSIin5Y+YeKEq4mWNeNk16/HPfZQLCBVsDiDdTcwh0NdMuhlwad+z
         mTGOs3/LWJI6jZEVQ3d4/pRYWgSWA3ghBkMZ6jwIuzwwMB2FQEKbikCtJFxr/I/STRHu
         rzXGBmBk1T4//CTrI4o0eVPw/sg/1F624IvGL8eZfx4x0uUMl5VdyiyR9ZNq3Oa1IMsw
         TM2DWMRxeNTEO9YxuhGS51PupdxIr/Gh7oRLdul1Gzy0/BmJE1NYVPSZmkSpgX/GBnxr
         RSStDbJ0giTDcwX7+JByDQda3466VOA+fFWHMBkQKIXHimylIqBrUS+nen1zuJElaxWA
         SP8g==
X-Gm-Message-State: AHQUAubqoUskgUXype1w8N99uBdBDste/aTIBHiWyQo5gUuPnto0oAHf
        U8z6sBDj9AkHYNb7Ia6H3h+XQa+H/l1HRQ==
X-Google-Smtp-Source: AHgI3IYvHiFjrOAzBgT1znlmxVrxI9W0OFavXYsgR9argZGwvDKiuaeZWSbeIcraDzjjIn6cgCSCmA==
X-Received: by 2002:ac8:346c:: with SMTP id v41mr4832346qtb.231.1550873242849;
        Fri, 22 Feb 2019 14:07:22 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id i33sm2105898qti.74.2019.02.22.14.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 14:07:21 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:07:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222170556-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <20190222160220-mutt-send-email-mst@kernel.org>
 <20190222213137.GZ17500@ziepe.ca>
 <20190222215923.GB21427@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222215923.GB21427@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 11:59:23PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 02:31:37PM -0700, Jason Gunthorpe wrote:
> > On Fri, Feb 22, 2019 at 04:16:01PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> > > > On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > > > > guest kernel side of TPM over virtio.
> > > > 
> > > > What's the use case for using this over the current non-virtio vTPM?. 
> > > > I always thought virtio was about guest to host transport efficiency,
> > > > but the phsical TPM, being connected over a very slow bus, is about as
> > > > inefficient as you can get in that regard, so why do we need to use
> > > > virtio to drive the virtual one?
> > > 
> > > I can't say for sure about TPM.
> > > 
> > > But generally there are many reasons to do virtio rather than emulating
> > > a hardware device.
> > 
> > We already have a xen 'virtioish' TPM driver, so I don't think there
> > is a good reason to block a virtio driver if someone cares about
> > it. There are enough good reasons to prefer virtio to other options,
> > IMHO.
> > 
> > Provided it meets the general requirements for new virtio stuff you
> > outlined.
> 
> Yeah, absolutely we can consider this.
> 
> For me it boils down to testing and documentation part.
> 
> No plans to merge code that I'm unable to run...
> 
> /Jarkko

I do this sometimes. One can't require samples for all supported
hardware. If I can check that code matches spec, I might settle for
that.

-- 
MST
