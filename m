Return-Path: <SRS0=2pHC=Q7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E57C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F027720663
	for <linux-integrity@archiver.kernel.org>; Sun, 24 Feb 2019 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfBXRvM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 24 Feb 2019 12:51:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:35825 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfBXRvM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Feb 2019 12:51:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 09:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,408,1544515200"; 
   d="scan'208";a="322981045"
Received: from unknown (HELO localhost) ([10.249.254.142])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2019 09:51:06 -0800
Date:   Sun, 24 Feb 2019 19:51:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190224175104.GA9371@linux.intel.com>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <1550849416.2787.5.camel@HansenPartnership.com>
 <e0284af7-be61-6a0f-8df6-a0d646577258@gmail.com>
 <1550873900.2787.25.camel@HansenPartnership.com>
 <a36fb1a3-3a5b-d849-0dec-87f394e7a86a@gmail.com>
 <1550885645.3577.31.camel@HansenPartnership.com>
 <bc11d2e8-1b67-8210-6750-d24d36eb7d87@gmail.com>
 <1551025819.3106.25.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551025819.3106.25.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 24, 2019 at 08:30:19AM -0800, James Bottomley wrote:
> On Fri, 2019-02-22 at 18:41 -0800, David Tolnay wrote:
> > On 2/22/19 5:34 PM, James Bottomley wrote:
> > > On Fri, 2019-02-22 at 16:45 -0800, David Tolnay wrote:
> [...]
> > > >  It implements the TPM-specific TIS interface (QEMU's tpm_tis.c)
> > > > as well as CRB interface (QEMU's tpm_crb.c) which require Linux's
> > > > TIS driver (Linux's tpm_tis.c) and CRB driver (Linux's tpm_crb.c)
> > > > respectively. Both of those are based on ACPI.
> > > 
> > > That's right, QEMU implements the device interface emulation, but
> > > it passes the actual TPM communication packets to the vTPM outside
> > > QEMU.
> > 
> > Could you clarify what you mean by a TPM communication packet since I
> > am less familiar with TPM and QEMU?
> 
> Like most standards defined devices, TPMs have a defined protocol, in
> this case defined by the trusted computing group.  It's a
> request/response model.  The job of the kernel is to expose this
> request response packet interface.  The device manufacturers don't get
> any flexibility, so their devices have to implement it and the only
> freedom they get is how the device is attached to the hardware.
> 
> >  I don't see "packet" terminology being used in drivers/char/tpm. Is
> > a packet equivalent to a fully formed TPM command / response or is it
> > a lower level aspect of the device interface than that?
> 
> It's a request/response corresponding to a command and its completion
> or error.
> 
> > More concretely, would you say that a hypervisor necessarily needs to
> > implement TPM device interface emulation (TIS and/or CRB) in order to
> > expose a TPM running on the host to its guest OS? I can see QEMU has
> > those things.
> 
> A hypervisor is needed to implement discovery, and whether its
> discovery over a virtual or physical bus, that part is required.
> 
> > > > As far as I can tell, QEMU does not provide a mode in which the
> > > > tpm_vtpm_proxy driver would be involved *in the guest*.
> > > 
> > > It doesn't need to.  the vTPM proxy can itself do all of that using
> > > the guest Linux kernel.  There's no hypervisor or host
> > > involvement.  This is analagous to the vTPM for container use case,
> > > except that to get both running in a guest you'd use no
> > > containment, so the vtpm client and server run in the guest
> > > together:
> > > 
> > > https://www.kernel.org/doc/html/v4.16/security/tpm/tpm_vtpm_proxy.h
> > > tml
> > 
> > I apologize for still not grasping how this would apply. You bring up
> > a vtpm proxy that runs in the guest Linux kernel with no hypervisor
> > or host involvement, with the vtpm client and server running in the
> > guest together. But host involvement is specifically what we want
> > since only the host is trusted to run the software TPM implementation
> > or interact with a hardware TPM. I am missing a link in the chain:
> 
> Well, in your previous email you asked how you would run the emulator
> in the guest.  This is how.  If you're actually not interested in that
> use case we don't need to discuss it further.
> 
> > - guest userspace makes TPM call (through tpm2-tss or however else);
> > - guest kernel receives the call in tpm-dev-common / tpm-interface;
> > - tpm-interface delegates to a tpm-chip implementation (which one?
> >   vtpm_proxy_tpm_ops?);
> > - ???
> > - a host daemon triages and eventually performs the TPM operation.
> > 
> > 
> > > > Certainly you could use a vtpm proxy driver *on the host* but
> > > > would still need some other TPM driver running in the guest for
> > > > communication with the host, possibly virtio. If this second
> > > > approach is what you have in mind, let me know but I don't think
> > > > it is applicable to the Chrome OS use case.
> > > 
> > > Actually, the vTPM on-host use case doesn't use the in kernel vtpm
> > > proxy driver, it uses a plain unix socket.  That's what the
> > > original website tried to explain: you set up swtpm in socket mode,
> > > you point the qemu tpm emulation at the socket and you boot up your
> > > guest.
> > 
> > Okay. If I understand correctly, the vTPM on-host use case operates
> > through TIS and/or CRB implemented in QEMU and the tpm_tis / tpm_crb
> > driver in the guest. Do I have it right?
> 
> No, vTPM operates purely at the packet level over various interfaces. 
> Microsoft defines an actual network packet interface called socsim, but
> this can also run over unix sockets, which is what the current QEMU
> uses..
> 
> QEMU implements a virtual hardware emulation for discovery, but once
> discovered all the packet communication is handed off to the vTPM
> socket.
> 
> The virtual hardware emulation can be anything we have a driver for. 
> TIS is the simplest, which is why I think they used it.  TIS is
> actually a simple interface specification, it supports discovery over
> anything, but the discovery implemented in standard guest drivers is
> over ACPI, OF and PNP.  If you want more esoteric discovery methods, we
> also support i2c.  However, that latter is really only for embedded.  I
> think QEMU chose TIS because it works seamlessly on both Linux and
> Windows guests.
> 
> 
> > All of this is what I would like to avoid by using a virtio driver.
> 
> How? Discovery is the part that you have to do, whether it's using
> emulated physical mechanisms or virtual bus discovery.
> 
> If you want to make this more concrete: I once wrote a pure socsim
> packet TPM driver:
> 
> https://patchwork.ozlabs.org/patch/712465/
> 
> Since you just point it at the network socket, it does no discovery at
> all and works in any Linux environment that has net.  I actually still
> use it because a socsim TPM is easier to debug from the outside. 
> However it was 230 lines.  Your device is 460 so that means about half
> your driver is actually about discovery.
> 
> The only reasons I can see to use a virtual bus is either because its
> way more efficient (the storage/network use case) or because you've
> stripped down the hypervisor so far that it's incapable of emulating
> any physical device (the firecracker use case).

Thanks for the feedback James. It has been really useful and in-depth,

The yes/no condition boils down to what is or is there any hard reason
that the virtio driver is absolutely required rather than crosvm
implementing the same emulation model as QEMU does.

/Jarkko
