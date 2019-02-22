Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD3C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2157B2070B
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfBVTcB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:32:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:28685 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfBVTcB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 14:32:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 11:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="117068691"
Received: from delmer-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2019 11:31:57 -0800
Date:   Fri, 22 Feb 2019 21:31:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222193156.GA6475@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222101728-mutt-send-email-mst@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 10:23:02AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > > kernel side of TPM over virtio.
> > > 
> > > Use case: TPM support is needed for performing trusted work from within
> > > a virtual machine launched by Chrome OS.
> > > 
> > > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > > implementation of the virtio TPM device can be found in these two source
> > > files:
> > > 
> > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> > 
> > These files/links do not make sense for kernel testing. Please remove
> > them from the next version.
> 
> To clarify generally for a virtio device we want
> - guest support
> - device support
> - spec
> 
> If the device is implemented in qemu and guest in linux kernel,
> then there are lots of people familiar with these
> programming environments, so sometimes we merge
> guest and host code even if spec isn't written up at all.
> 
> If you don't want to do that there's a small number of people who can
> properly review code, e.g. I don't think lots of people on this list are
> familiar with crosvm.  One way to address this would be to build a QEMU
> implementation. Another would be to write up a spec.  You can do both
> too :)

I don't really understand your arguments.

/Jarkko
