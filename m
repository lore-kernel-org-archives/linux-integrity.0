Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42523 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbeGKS0y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 14:26:54 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so5318582plb.9
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jul 2018 11:21:22 -0700 (PDT)
Date: Wed, 11 Jul 2018 12:21:20 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
Message-ID: <20180711182120.GF23935@ziepe.ca>
References: <1531328689.3260.8.camel@HansenPartnership.com>
 <1531329074.3260.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531329074.3260.9.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 11, 2018 at 10:11:14AM -0700, James Bottomley wrote:
> tpm_tis regressed recently to the point where the TPM being driven by
> it falls off the bus and cannot be contacted after some hours of use.
> This is the failure trace:
> 
> jejb@jarvis:~> dmesg|grep tpm
> [    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [14566.626614] tpm tpm0: Operation Timed out
> [14566.626621] tpm tpm0: tpm2_load_context: failed with a system error -62
> [14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14570.626605] tpm tpm0: tpm2_load_context: failed with a system error -62
> [14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> [14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> ...
> 
> The problem is caused by a change that caused us to poke the TPM far
> more often to see if it's ready.  Apparently something about the bus
> its on and the TPM means that it crashes or falls off the bus if you
> poke it too often and once this happens, only a reboot will recover
> it.

I wonder if something about triggering ETIME even once breaks the
driver so it can't talk to the chip at all thereafter..

Ie it doesn't abort the command properly and becomes desynced with the
TIS execution protocol.

I would be very surprised if polling the TIS status register effects
the firmware running inside the chip..

BTW, no interrupt in your latop setup? I'm surprised by that..

Jason
