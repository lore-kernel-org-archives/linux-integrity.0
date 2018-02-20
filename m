Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60300 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753129AbeBTR1q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 12:27:46 -0500
Message-ID: <1519147664.4446.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Date: Tue, 20 Feb 2018 12:27:44 -0500
In-Reply-To: <1519147339.6941.3.camel@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1519133428.4113.7.camel@linux.intel.com>
         <1519135044.9433.5.camel@HansenPartnership.com>
         <1519147339.6941.3.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-02-20 at 19:22 +0200, Jarkko Sakkinen wrote:
> EOn Tue, 2018-02-20 at 08:57 -0500, James Bottomley wrote:
> > 
> > On Tue, 2018-02-20 at 15:30 +0200, Jarkko Sakkinen wrote:
> > > 
> > > The calls for tpm2_get_pcr_allocation() and
> > > tpm2_get_cc_attrs_tbl()
> > > could be also moved before the self test.
> > 
> > That's not a good idea for a couple of reasons
> > 
> >    1. You really should do as little as possible with the TPM
> > before the
> >       self test
> 
> As Alexander correctly pointed out earlier, the section 12.3
> Self-Test Modes of the architecture specification states that
> 
> "If a command requires use of an untested algorithm or functional
> module, the TPM performs the test and then completes the command
> actions."
> 
> It would mean only running the self test for GetCapability as the
> first test if I understand what I'm reading correctly.
> 
> > 
> >    2. The TPM might not be started before the self test, so it
> > would error
> >       all commands with TPM_RC_INITIALIZE anyway (this was the
> > problem
> >       with the initial version of the patch set).
> 
> Do not see an issue to run Startup beforehand.

I still don't think it serves any useful purpose and it gives us more
to unwind if the self test fails, so occams razor would say do it after
the selftest passes.

Jaems
