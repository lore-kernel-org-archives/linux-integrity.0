Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:23864 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752904AbdLSNEi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:04:38 -0500
Date: Tue, 19 Dec 2017 15:04:32 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219130432.tlf6tiv62nf4rreh@linux.intel.com>
References: <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
 <20171218201902.GF19056@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218201902.GF19056@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 18, 2017 at 01:19:02PM -0700, Jason Gunthorpe wrote:
> On Mon, Dec 18, 2017 at 07:34:29PM +0000, Shaikh, Azhar wrote:
> 
> > >IIUC, if CLKRUN_EN is enabled, then all the devices attached to the
> > >LPC bus have to support the CLKRUN protocol. My guess is that on
> > >some Braswell systems LPC power management is enabled but the TPM
> > >device doesn't have CLKRUN support.
> > 
> > I think this is what might be happening here.
> 
> That makes it a BIOS bug, not a chipset bug, and we shouldn't be
> trying to fix it like this in Linux.
> 
> Based on the original discussion I always thought this was an Intel
> chipset bug and applies to all cases.
> 
> Jason

It would not be first time when some BIOS issues are circumvented in the
kernel.

/Jarkko
