Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52280 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751303AbeBPTpj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 14:45:39 -0500
Message-ID: <1518810337.4475.16.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Fri, 16 Feb 2018 11:45:37 -0800
In-Reply-To: <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1518807576.4475.3.camel@HansenPartnership.com>
         <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 20:26 +0100, Alexander Steffen wrote:
> On 16.02.2018 19:59, James Bottomley wrote:
> > 
> > On Fri, 2018-02-16 at 10:17 -0800, James Bottomley wrote:
> > > 
> > > On Fri, 2018-02-16 at 10:34 +0200, Jarkko Sakkinen wrote:
> > > > 
> > > > 
> > > > Hi
> > > > 
> > > > See the comments below and please include this as a prequel
> > > > patch for the next version:
> > > > 
> > > > https://patchwork.kernel.org/patch/10208965/
> > > 
> > > Actually, I've got another curious bit of behaviour from my
> > > Nuvoton:   After an experiment with primary EK generation that
> > > sent it into failure mode (connected with something else, nothing
> > > to do with this), it's taken to returning 232
> > > (TPM_RC_COMMAND_CODE) to a partial self test periodically on
> > > boot.  According to the manual this is impossible, so I think
> > > it's something to do with tpm_validate_command.  I think,
> > > perhaps, we shouldn't call the getcaps for the command codes
> > > until the self test is over, but I need to do more debugging to
> > > track down what's going on.
> > > 
> > > I've also got other reports of TPM_RC_COMMAND_CODE failures
> > > during self test, so this isn't just my screwed up chip.
> > 
> > This isn't anything to do with us synthesizing TPM_RC_COMMAND_CODE,
> > the status is definitely coming from the chip.  If I run a full
> > self test immediately after this, everything works as normal.
> 
> Interesting. What you call full and partial self test, those are the 
> same command (TPM2_SelfTest), just with fullTest=YES and fullTest=NO,
> right? Then it seems even stranger that whether you get
> RC_COMMAND_CODE does not depend on the command but on the parameter.

Yes, I did a lot of debugging because this is unexpected, but
nevertheless that's what I see.

> > Can anyone from the manufacturers shed any light on the
> > TPM_RC_COMMAND_CODE return from a partial self test?
> 
> It's the first time I see this usage of that return code. The 
> specification says that this code means "command code not supported",
> which to me sounds rather like "command not implemented", not
> "command temporarily not available". Maybe this is just a bug in this
> TPM implementation?

That was my first theory.  However, even if it's only Nuvoton specific
they're pretty widely deployed (all the Dell laptops), so we have to
cope with it in the kernel.  But I've also got reports of the same
problem affecting a ST Micro TPM, so it looks like an implementation
that's spreading.

For those who can play along at home, the way I induce the TPM failure
is to execute

tsscreateek -cp -alg ec -noflush

What seems to be happening is that most TPM implementations have a hard
coded short cut for primary endorsement key generation, but mine seems
to be missing the EC certificate, so asking it to generate an EC
primary for the endorsement seed hits a BUG_ON() in its internal
implementation code which causes the TPM to go into failure mode.

James
