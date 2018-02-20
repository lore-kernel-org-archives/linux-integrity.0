Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58530 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750733AbeBTN51 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 08:57:27 -0500
Message-ID: <1519135044.9433.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 08:57:24 -0500
In-Reply-To: <1519133428.4113.7.camel@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1519133428.4113.7.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-02-20 at 15:30 +0200, Jarkko Sakkinen wrote:
> On Fri, 2018-02-16 at 10:17 -0800, James Bottomley wrote:
> > 
> > so I think it's something to do with tpm_validate_command.  I
> > think, perhaps, we shouldn't call the getcaps for the command codes
> > until the self test is over, but I need to do more debugging to
> > track down what's going on.
> 
> The calls for tpm2_get_pcr_allocation() and tpm2_get_cc_attrs_tbl()
> could be also moved before the self test.

That's not a good idea for a couple of reasons

   1. You really should do as little as possible with the TPM before the
      self test
   2. The TPM might not be started before the self test, so it would error
      all commands with TPM_RC_INITIALIZE anyway (this was the problem
      with the initial version of the patch set).

So self test should be the first command we send to the TPM.  The only
reason I was suspicious of tpm_validate_command() is because it can
manufacture a TPM_RC_COMMAND_CODE return.  However, that turned out not
to be the case (and tpm_validate_command() has a bypass for sending
everything to the TPM before the attribute table is initialized, so
it's all working correctly).

James
