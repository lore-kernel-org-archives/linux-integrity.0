Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbeAJQSk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jan 2018 11:18:40 -0500
Date: Wed, 10 Jan 2018 18:18:30 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Morris <james.l.morris@oracle.com>
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v4.16
Message-ID: <20180110161830.kh5zlatbtiebzkbh@linux.intel.com>
References: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
 <alpine.LFD.2.20.1801091141410.17337@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.20.1801091141410.17337@localhost>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 09, 2018 at 11:42:16AM +1100, James Morris wrote:
> On Mon, 8 Jan 2018, Jarkko Sakkinen wrote:
> 
> > Hi James,
> > 
> > Sorry for a late PR.
> > 
> > Summary of the content:
> > 
> > * Reduced polling delays in tpm_tis.
> > * Support for retrieving TPM 2.0 Event Log through EFI before
> >   ExitBootServices.
> > * Replaced tpm-rng.c with a hwrng device managed by the driver for each
> >   TPM device.
> > * TPM resource manager synthesizes TPM_RC_COMMAND_CODE response instead
> >   of returning -EINVAL for unknown TPM commands. This makes user space
> >   more sound.
> > * CLKRUN fixes:
> >   * Keep #CLKRUN disable through the entier TPM command/response flow.
> >   * Check whether #CLKRUN is enabled before disabling and enabling it
> >     again because enabling it breaks PS/2 devices on a system where it
> >     is disabled.
> > 
> 
> Thanks, merged to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> 	next-tpm
> 	next-testing

Thank you. We'll follow the issues that Alexander described.

/Jarkko
