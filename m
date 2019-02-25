Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E4C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C3E20842
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 21:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBYVFU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:05:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:21641 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfBYVFT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 16:05:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 13:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="146459140"
Received: from hansenmi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.190])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2019 13:05:15 -0800
Date:   Mon, 25 Feb 2019 23:05:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190225210511.GA8727@linux.intel.com>
References: <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com>
 <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com>
 <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com>
 <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com>
 <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
 <1551126043.3226.45.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551126043.3226.45.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 25, 2019 at 12:20:43PM -0800, James Bottomley wrote:
> On Mon, 2019-02-25 at 11:17 -0800, Matthew Garrett wrote:
> > On Mon, Feb 25, 2019 at 7:36 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > > The virtio driver performs discovery via virtio, which crosvm
> > > > implements already for all of its supported devices. This
> > > > substantially reduces the amount of TPM-specific code compared to
> > > > your suggestions, and lowers the barrier to entry for
> > > > implementing TPM support in other hypervisors which I hope we
> > > > agree is beneficial.
> > > 
> > > Well, that's somewhat misleading:  The reason we already have two
> > > hypervisor specific drivers already is because every hypervisor has
> > > a different  virtual discovery mechanism. You didn't find the other
> > > two hypervisor drivers remotely useful, so why would another
> > > hypervisor find yours useful?
> >  
> > The existing hypervisor drivers expose hypervisor-specific details.
> > This proposed driver provides an abstract interface that is usable by
> > other hypervisors. It allows building a VM that exposes TPM
> > functionality without requiring additional hardware emulation,
> > reducing the hypervisor attack surface.
> 
> Well, that depends whether you think a virtio bus is an abstract
> concept or a hypervisor specific detail.  There are currently four
> major hypervisors: xen, kvm, hyper-v and ESX.  Of those, only one
> implements virtio: kvm.  I agree virtio is a standard and certainly a
> slew of minor hypervisors implement it because they need paravirt
> support on Linux so they piggyback off kvm, but I don't see any of the
> other major hypervisors jumping on the bandwagon.
> 
> I certainly agree our lives would be easier if all the major hypervisor
> vendors would just agree a single paravirt driver standard.

I think that a Windows hypervisor (Hyper-V) and a closed hypervisor
(VMWare) are out of context for this discussion. I think it is a good
thing that there exist a fully open alternative to closed solutions such
as VMBus. It is not only good for Linux but also for other open source
operating systems (*BSD, Fuchsia etc.). I won't disregard virtio-TPM
based on that.

The main interest lies in these:

- QEMU
- KVM
- Xen

> >  Using the more generic virtio
> > infrastructure reduces the need for that, since any hypervisor should
> > be able to implement the backend (eg, in this case it'd be very easy
> > to add support for this driver to qemu,
> 
> I certainly agree there ... is there a plan for this?

I don't *necessarily* require QEMU to support this in the implementation
level in order to accept the change. What I do require is a buy-in from
the QEMU and Xen community that this is the right path.

/Jarkko
