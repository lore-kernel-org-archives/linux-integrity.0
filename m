Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36782 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbeBIRdd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 12:33:33 -0500
Message-ID: <1518197611.3930.12.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/2] Fix kernel buffer overruns caused by bit flips
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jmorris@namei.org
Cc: linux-integrity@vger.kernel.org,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>
Date: Fri, 09 Feb 2018 09:33:31 -0800
In-Reply-To: <20180209171324.ciuw6jadxnoyxty7@linux.intel.com>
References: <1518121576.21828.10.camel@HansenPartnership.com>
         <20180209171324.ciuw6jadxnoyxty7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-09 at 19:13 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 08, 2018 at 12:26:16PM -0800, James Bottomley wrote:
> > 
> > If a TPM is attached to a system via a serial bus on a platform
> > that suffers bit flips, we can get back dangerously wrong
> > data.  This patch series aims never to do a direct copy into a
> > kernel buffer based on an unchecked size value returned from the
> > TPM.
> > 
> > Jeremy Boone (5):
> >   tpm: fix potential buffer overruns caused by bit glitches on the
> > bus
> >   tpm: st33zp24: fix potential buffer overruns caused by bit
> > glitches on
> >     the bus
> >   tpm_i2c_infineon: fix potential buffer overruns caused by bit
> > glitches
> >     on the bus
> >   tpm_i2c_nuvoton: fix potential buffer overruns caused by bit
> > glitches
> >     on the bus
> >   tpm_tis: fix potential buffer overruns caused by bit glitches on
> > the
> >     bus
> > 
> >  drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
> >  drivers/char/tpm/tpm-interface.c     | 4 ++++
> >  drivers/char/tpm/tpm2-cmd.c          | 4 ++++
> >  drivers/char/tpm/tpm_i2c_infineon.c  | 5 +++--
> >  drivers/char/tpm/tpm_i2c_nuvoton.c   | 5 +++--
> >  drivers/char/tpm/tpm_tis_core.c      | 5 +++--
> >  6 files changed, 19 insertions(+), 8 deletions(-)
> > 
> > -- 
> > o 2.12.3
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkkinen@linux.intel.com>
> 
> I cannot test all of these but I'll put these to linux-next anyway.
> The changes are obvious and small scoped so if no one shouts they'll
> be part of the next PR.
> 
> I've tested the changes that affect tpm2-cmd.c, tpm-interface.c and
> tpm_tis_core.c. For HW specific changes tested-by's would be much
> appreciated but I don't think they will break anything.
> 
> Because these are quite critical fixes I wonder if I could do one
> more PR to 4.16?

They're all cc'd to stable, so they'd make the stable updates to 4.16
regardless of when they're pulled.  Since the merge window will close
on Sunday and you have to go via James' tree, I'd say it would cause a
lot of stress to try to make 4.16 but it's your call.

James
