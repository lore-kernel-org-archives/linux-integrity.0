Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D0C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF24F20675
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBVV71 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:59:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:33850 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfBVV71 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:59:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 13:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,401,1544515200"; 
   d="scan'208";a="145787279"
Received: from delmer-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.153])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2019 13:59:22 -0800
Date:   Fri, 22 Feb 2019 23:59:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222215923.GB21427@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <20190222160220-mutt-send-email-mst@kernel.org>
 <20190222213137.GZ17500@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222213137.GZ17500@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 22, 2019 at 02:31:37PM -0700, Jason Gunthorpe wrote:
> On Fri, Feb 22, 2019 at 04:16:01PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> > > On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > > > guest kernel side of TPM over virtio.
> > > 
> > > What's the use case for using this over the current non-virtio vTPM?. 
> > > I always thought virtio was about guest to host transport efficiency,
> > > but the phsical TPM, being connected over a very slow bus, is about as
> > > inefficient as you can get in that regard, so why do we need to use
> > > virtio to drive the virtual one?
> > 
> > I can't say for sure about TPM.
> > 
> > But generally there are many reasons to do virtio rather than emulating
> > a hardware device.
> 
> We already have a xen 'virtioish' TPM driver, so I don't think there
> is a good reason to block a virtio driver if someone cares about
> it. There are enough good reasons to prefer virtio to other options,
> IMHO.
> 
> Provided it meets the general requirements for new virtio stuff you
> outlined.

Yeah, absolutely we can consider this.

For me it boils down to testing and documentation part.

No plans to merge code that I'm unable to run...

/Jarkko
