Return-Path: <SRS0=VAB3=RA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E17C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173F20C01
	for <linux-integrity@archiver.kernel.org>; Mon, 25 Feb 2019 19:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBYTyU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:54:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:38938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfBYTyT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Feb 2019 14:54:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 11:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="323289826"
Received: from hansenmi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.190])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2019 11:54:13 -0800
Date:   Mon, 25 Feb 2019 21:54:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Tolnay <dtolnay@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190225195411.GB6019@linux.intel.com>
References: <1550849416.2787.5.camel@HansenPartnership.com>
 <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com>
 <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com>
 <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com>
 <be2c8327-49d0-a1e4-cc22-38342ce06ed3@gmail.com>
 <1551108969.3226.26.camel@HansenPartnership.com>
 <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuuMdYS5L4uCKDHr5e-+N3g2qbuZY4KpKdAPbGS9QFYs9g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 25, 2019 at 11:17:20AM -0800, Matthew Garrett wrote:
> On Mon, Feb 25, 2019 at 7:36 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > > The virtio driver performs discovery via virtio, which crosvm
> > > implements already for all of its supported devices. This
> > > substantially reduces the amount of TPM-specific code compared to
> > > your suggestions, and lowers the barrier to entry for implementing
> > > TPM support in other hypervisors which I hope we agree is beneficial.
> >
> > Well, that's somewhat misleading:  The reason we already have two
> > hypervisor specific drivers already is because every hypervisor has a
> > different  virtual discovery mechanism. You didn't find the other two
> > hypervisor drivers remotely useful, so why would another hypervisor
> > find yours useful?
> 
> The existing hypervisor drivers expose hypervisor-specific details.
> This proposed driver provides an abstract interface that is usable by
> other hypervisors. It allows building a VM that exposes TPM
> functionality without requiring additional hardware emulation,
> reducing the hypervisor attack surface.
> 
> > >  For me as a hypervisor implementer, what advantages do you see that
> > > would make me decide to implement TPM-specific virtual hardware
> > > emulation in the form of TIS rather than simply leveraging a virtio
> > > driver like for other virtual devices?
> >
> > So your argument is that for every device we have in the Linux kernel,
> > we should have the N hypervisor paravirt variants for the same thing?
> > I assure you that's not going to fly because paravirt drivers would
> > then outnumber real drivers by an order of magnitude.
> 
> Well, no - in general there's no need to have more than one virtio
> driver for any /class/ of hardware. For various unfortunate accidents
> of history we've ended up with multiple cases where we have
> hypervisor-specific drivers. Using the more generic virtio
> infrastructure reduces the need for that, since any hypervisor should
> be able to implement the backend (eg, in this case it'd be very easy
> to add support for this driver to qemu, which would allow the use of
> TPMs without needing to enable a whole bunch of additional qemu
> features). This isn't a discussion we'd be having if we'd pushed back
> more strongly against hypervisor-specific solutions in the past.
> 
> (While I work for Google, I'm not involved in crosvm development and
> this shouldn't be interpreted as the position of anyone on that team)

OK, this clears a lot of misconceptions thank you. The commit message
itself fails to explain almost all of these details that you just wrote.

The commit is also pretty badly formed so I grew a lot of initial
mistrust, which I think is perfectly understandable.  Putting links to
random source files to a commit message is a sign of unwanted rush (i.e.
time has not been taken to write down in plain English what has been
done).

Once the commit is in a better condition and some documentation how
the stack is implemented from end to end we can better evaluate this.

Some instructions how to compile and run crosvm would be also nice.

/Jarkko
