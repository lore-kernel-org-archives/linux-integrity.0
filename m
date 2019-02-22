Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D483C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BDB206BB
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBVUzj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:55:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33469 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVUzi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 15:55:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so2002828qkf.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 12:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJQu3ceEoc1WtTZ2Lx89W5Iq824xEHhgS/Qxo4A7GNE=;
        b=MLoPldBreGCi0nSTsdDalTIqkOY9C693KcXs7laFxXgAn7xl3UpGyxd6eofkE8HDlg
         0deZFKZYLbF24OwPuVI9h6Pt2T6T8YOJr3mmmPs6PYBKicUDK3qCEPBVVHeXgfGNYJaO
         ut/pM3zMLCI8gF/2psGquQe+3rARDLoGvBYmTxcnuEhpLgSvqjiKZERHO0O3MfzQyVrZ
         wVMt4Tomujl4C39mGo4feLZldtpYwitGx9/BtzAcnK9tQCzs8LdsImlJr7euwwGbxEBS
         +eWNSRj/h19EtfL4CN3bnXn7t5X1X0vl6QEAqEcaQkoGRTXqWvmY8kvAwler2zOMKzKL
         DrJQ==
X-Gm-Message-State: AHQUAuYwPfKRTK/3wy7i6XbH/p7lBqPrOiLagK+T/3XsV4jcqdrYVatT
        4gGInhTKWJEGgLgM0ETvYc10jQ==
X-Google-Smtp-Source: AHgI3IZb+0lptYoBTZoKLHcFIWRyTx6UdjHT0rPfnsmHpIzfSpvf5S8YX+ZN98WmL/IKd27/UAMXIA==
X-Received: by 2002:a37:c38b:: with SMTP id r11mr4524203qkl.159.1550868937358;
        Fri, 22 Feb 2019 12:55:37 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id z9sm1487981qkj.33.2019.02.22.12.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:55:36 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:55:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222154838-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222193156.GA6475@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 09:31:56PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 10:23:02AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> > > On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > > > kernel side of TPM over virtio.
> > > > 
> > > > Use case: TPM support is needed for performing trusted work from within
> > > > a virtual machine launched by Chrome OS.
> > > > 
> > > > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > > > implementation of the virtio TPM device can be found in these two source
> > > > files:
> > > > 
> > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> > > 
> > > These files/links do not make sense for kernel testing. Please remove
> > > them from the next version.
> > 
> > To clarify generally for a virtio device we want
> > - guest support
> > - device support
> > - spec
> > 
> > If the device is implemented in qemu and guest in linux kernel,
> > then there are lots of people familiar with these
> > programming environments, so sometimes we merge
> > guest and host code even if spec isn't written up at all.
> > 
> > If you don't want to do that there's a small number of people who can
> > properly review code, e.g. I don't think lots of people on this list are
> > familiar with crosvm.  One way to address this would be to build a QEMU
> > implementation. Another would be to write up a spec.  You can do both
> > too :)
> 
> I don't really understand your arguments.
> 
> /Jarkko

Jarkko, I am not making any argument at all.

I am trying to suggest ways for this driver to get upstream.

And I am saying that while I agree availability of an implementation in
crosvm isn't sufficient, availability of a software device
implementation in QEMU is not an absolute prerequisite for including a
virtio driver in Linux.  If there's a virtio spec explaining how to
write one, that can be enough.

-- 
MST
