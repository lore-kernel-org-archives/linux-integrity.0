Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14664 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbeAHKtq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jan 2018 05:49:46 -0500
Date: Mon, 8 Jan 2018 12:49:34 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander.Steffen@infineon.com
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] tpm: fix driver so that burstcount can be
 safely ignored
Message-ID: <20180108104934.lqam7yumw3lggnd5@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171215120439.v7fvyy2cuauhnl2h@linux.intel.com>
 <20171224204109.fobx53ffmog2a5nk@linux.intel.com>
 <97fc00fd033f46038d08b71e7f1d076c@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97fc00fd033f46038d08b71e7f1d076c@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jan 04, 2018 at 01:11:34PM +0000, Alexander.Steffen@infineon.com wrote:
> > On Fri, Dec 15, 2017 at 02:04:39PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Dec 08, 2017 at 07:46:49PM +0100, Alexander Steffen wrote:
> > > > Disclaimer: This is RFC because unfortunately I do not have the time to
> > bring it up to the usual standards. But from lying around on my hard disk it
> > definitely won't improve, so I've decided to publish it now, to get at least
> > some feedback or maybe for somebody else to pick it up. Since the work
> > began some time ago, it is probably not rebased against the current state
> > (but hopefully still applies).
> > > >
> > > > This is a collection of all the fixes I made during the investigation of the
> > problems with the "ignore burstcount" change. These are mainly fixes for the
> > wait state handling in tpm_tis_spi, that probably was not really tested so far,
> > since the previous implementation avoided wait states as far as possible. It
> > also includes changes to tpm_tis_core, so that it follows the specification
> > more closely. Finally, I've included a rebased version of the original "ignore
> > burstcount" patch. Together, those patches pass all my tests and also each
> > intermediate step is fine (so that bisecting still works).
> > > >
> > > > Alexander Steffen (8):
> > > >   tpm_tis_core: clean up whitespace
> > > >   tpm_tis_core: access single TIS registers before doing complex
> > > >     transfers
> > > >   tpm_tis_core: correctly wait for flags to become zero
> > > >   tpm_tis_core: send all data in single operation
> > > >   tpm_tis_core: use XDATA_FIFO for transfers if available
> > > >   tpm_tis_spi: fix sending wrong data during wait state handling
> > > >   tpm_tis_spi: release CS line when wait state handling fails
> > > >   tpm_tis_spi: add delay between wait state retries
> > > >
> > > > Nayna Jain (1):
> > > >   tpm: ignore burstcount to improve tpm_tis send() performance
> > > >
> > > >  drivers/char/tpm/tpm_tis_core.c | 131 ++++++++++++++++++++---------
> > -----------
> > > >  drivers/char/tpm/tpm_tis_core.h |  26 ++++----
> > > >  drivers/char/tpm/tpm_tis_spi.c  |  21 +++++--
> > > >  3 files changed, 95 insertions(+), 83 deletions(-)
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > Might not have time to review this before holidays but will do if
> > > I can.
> > 
> > Unfortunately this and your patches for broken TPMs came so late that
> > they have no chance to make into 4.16. Thus, I will postpone their
> > review after the pull request and take care of the high priority stuff
> > for that release.
> 
> As long the "ignore burstcount" patch does not make it into 4.16 either, that's fine. Then nothing new gets broken, it just does not get any faster.

OK, I guess it has to be dropped from 4.16 and postponed to 4.17.

Thanks for pointing that out.

/Jarkko
