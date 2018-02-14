Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:6985 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967739AbeBNNET (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Feb 2018 08:04:19 -0500
Date: Wed, 14 Feb 2018 15:04:04 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: jmorris@namei.org, linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Subject: Re: [PATCH v2 0/2] Fix kernel buffer overruns caused by bit flips
Message-ID: <20180214130404.tjxhptg75nxfdzwg@linux.intel.com>
References: <1518121576.21828.10.camel@HansenPartnership.com>
 <20180209171324.ciuw6jadxnoyxty7@linux.intel.com>
 <1518197611.3930.12.camel@HansenPartnership.com>
 <20180214114456.l5ddzcqro7li575p@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180214114456.l5ddzcqro7li575p@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:44:56PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 09, 2018 at 09:33:31AM -0800, James Bottomley wrote:
> > On Fri, 2018-02-09 at 19:13 +0200, Jarkko Sakkinen wrote:
> > > On Thu, Feb 08, 2018 at 12:26:16PM -0800, James Bottomley wrote:
> > > > 
> > > > If a TPM is attached to a system via a serial bus on a platform
> > > > that suffers bit flips, we can get back dangerously wrong
> > > > data.  This patch series aims never to do a direct copy into a
> > > > kernel buffer based on an unchecked size value returned from the
> > > > TPM.
> > > > 
> > > > Jeremy Boone (5):
> > > >   tpm: fix potential buffer overruns caused by bit glitches on the
> > > > bus
> > > >   tpm: st33zp24: fix potential buffer overruns caused by bit
> > > > glitches on
> > > >     the bus
> > > >   tpm_i2c_infineon: fix potential buffer overruns caused by bit
> > > > glitches
> > > >     on the bus
> > > >   tpm_i2c_nuvoton: fix potential buffer overruns caused by bit
> > > > glitches
> > > >     on the bus
> > > >   tpm_tis: fix potential buffer overruns caused by bit glitches on
> > > > the
> > > >     bus
> > > > 
> > > >  drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
> > > >  drivers/char/tpm/tpm-interface.c     | 4 ++++
> > > >  drivers/char/tpm/tpm2-cmd.c          | 4 ++++
> > > >  drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
> > > >  drivers/char/tpm/tpm_i2c_nuvoton.c   | 5 +++--
> > > >  drivers/char/tpm/tpm_tis_core.c      | 5 +++--
> > > >  6 files changed, 19 insertions(+), 8 deletions(-)
> > > > 
> > > > -- 
> > > > o 2.12.3
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkkinen@linux.intel.com>
> > > 
> > > I cannot test all of these but I'll put these to linux-next anyway.
> > > The changes are obvious and small scoped so if no one shouts they'll
> > > be part of the next PR.
> > > 
> > > I've tested the changes that affect tpm2-cmd.c, tpm-interface.c and
> > > tpm_tis_core.c. For HW specific changes tested-by's would be much
> > > appreciated but I don't think they will break anything.
> > > 
> > > Because these are quite critical fixes I wonder if I could do one
> > > more PR to 4.16?
> > 
> > They're all cc'd to stable, so they'd make the stable updates to 4.16
> > regardless of when they're pulled.  Since the merge window will close
> > on Sunday and you have to go via James' tree, I'd say it would cause a
> > lot of stress to try to make 4.16 but it's your call.
> > 
> > James
> 
> Agreed, thanks for input!
> 
> /Jarkko

They are now in master/next.

/Jarkko
