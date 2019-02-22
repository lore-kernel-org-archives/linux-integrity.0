Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7DEC43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8360C206BA
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfBVVZM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:25:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42603 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVZM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:25:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so4169637qtr.9
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 13:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxsumS25lbgoA+g/WcdawldrA1AZ5CRB5WX3Nm4mYxk=;
        b=aSCtHNY9RSft/a4eu3Py4KvKGUWuPhoh6P8suC6hNK2OKFvtNq/olkVM6qguzu9arj
         9X46icYULhKDKr05dSIgqiPF7cKU2wQMgU/sTPXINH4jTwkQdIBxlupO3oJTe1ENQix+
         h/4j6qQjfjZdLWi9grd2If2PmePoZeIvk7+lyVrrpHakkMymNlVB01MDT7sdHoRYEMgO
         HFmVGZD8ysEPi/j9HpYxIdY1zCvokzKKp0ADnqxk8TevShGzE6YfF5AKe7AFaXqJhVmV
         juWcZoChndemBOhSpiChyGTXbBxRBMHK55T0bXwe7ag0XyBFJjW/TrvL5LeMTq9sDqPY
         /ifQ==
X-Gm-Message-State: AHQUAuaI86uF4YWsL/8DVMHBYtbkrphQxJDzQmV4ORFNe4SmsCTc6oUx
        Upxygb9IAkTPgpIzbYAYNxVFyA==
X-Google-Smtp-Source: AHgI3IZetKQ4EAAfF/RfxIA9tvW/Coba9tyI1ZGYOUDx+v74/0gs6l69lPSZmrM/G0t9o5V1EVYwJg==
X-Received: by 2002:ac8:2246:: with SMTP id p6mr4726017qtp.66.1550870711399;
        Fri, 22 Feb 2019 13:25:11 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id r22sm1789184qki.43.2019.02.22.13.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:25:10 -0800 (PST)
Date:   Fri, 22 Feb 2019 16:25:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222161636-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
 <20190222193305.GB6475@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222193305.GB6475@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 09:33:05PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 09:31:56PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 22, 2019 at 10:23:02AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> > > > On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > > > > kernel side of TPM over virtio.
> > > > > 
> > > > > Use case: TPM support is needed for performing trusted work from within
> > > > > a virtual machine launched by Chrome OS.
> > > > > 
> > > > > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > > > > implementation of the virtio TPM device can be found in these two source
> > > > > files:
> > > > > 
> > > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> > > > 
> > > > These files/links do not make sense for kernel testing. Please remove
> > > > them from the next version.
> > > 
> > > To clarify generally for a virtio device we want
> > > - guest support
> > > - device support
> > > - spec
> > > 
> > > If the device is implemented in qemu and guest in linux kernel,
> > > then there are lots of people familiar with these
> > > programming environments, so sometimes we merge
> > > guest and host code even if spec isn't written up at all.
> > > 
> > > If you don't want to do that there's a small number of people who can
> > > properly review code, e.g. I don't think lots of people on this list are
> > > familiar with crosvm.  One way to address this would be to build a QEMU
> > > implementation. Another would be to write up a spec.  You can do both
> > > too :)
> > 
> > I don't really understand your arguments.
> 
> ... and I did your response total three times and did not find any
> causality of any sort from anything.
> 
> /Jarkko

Thanks for spending the time reading my response.  What was included in
it was a general suggestion for a virtio based driver to be acceptable
in upstream Linux.

You pointed out that a pointer to a prototype implementation in Rust
isn't relevant. However, FYI just posting guest code and asking for it
to be merged alone won't work for a virtio driver either. I am merely
trying to speed things up instead of having the contributor repost with
a tweaked commit log just to immediately get another set of nacks.

-- 
MST
