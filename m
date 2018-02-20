Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752917AbeBTRWY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 12:22:24 -0500
Message-ID: <1519147339.6941.3.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Date: Tue, 20 Feb 2018 19:22:19 +0200
In-Reply-To: <1519135044.9433.5.camel@HansenPartnership.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1519133428.4113.7.camel@linux.intel.com>
         <1519135044.9433.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

EOn Tue, 2018-02-20 at 08:57 -0500, James Bottomley wrote:
> On Tue, 2018-02-20 at 15:30 +0200, Jarkko Sakkinen wrote:
> > The calls for tpm2_get_pcr_allocation() and tpm2_get_cc_attrs_tbl()
> > could be also moved before the self test.
>
> That's not a good idea for a couple of reasons
>
>    1. You really should do as little as possible with the TPM before the
>       self test

As Alexander correctly pointed out earlier, the section 12.3
Self-Test Modes of the architecture specification states that

"If a command requires use of an untested algorithm or functional
module, the TPM performs the test and then completes the command
actions."

It would mean only running the self test for GetCapability as the
first test if I understand what I'm reading correctly.

>    2. The TPM might not be started before the self test, so it would error
>       all commands with TPM_RC_INITIALIZE anyway (this was the problem
>       with the initial version of the patch set).

Do not see an issue to run Startup beforehand.

> So self test should be the first command we send to the TPM.  The only
> reason I was suspicious of tpm_validate_command() is because it can
> manufacture a TPM_RC_COMMAND_CODE return.  However, that turned out not
> to be the case (and tpm_validate_command() has a bypass for sending
> everything to the TPM before the attribute table is initialized, so
> it's all working correctly).
>
> James

/Jarkko
