Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57168 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbeGKTOg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 15:14:36 -0400
Message-ID: <1531336133.3260.16.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 11 Jul 2018 12:08:53 -0700
In-Reply-To: <20180711182120.GF23935@ziepe.ca>
References: <1531328689.3260.8.camel@HansenPartnership.com>
         <1531329074.3260.9.camel@HansenPartnership.com>
         <20180711182120.GF23935@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-07-11 at 12:21 -0600, Jason Gunthorpe wrote:
> On Wed, Jul 11, 2018 at 10:11:14AM -0700, James Bottomley wrote:
> > tpm_tis regressed recently to the point where the TPM being driven
> > by
> > it falls off the bus and cannot be contacted after some hours of
> > use.
> > This is the failure trace:
> > 
> > jejb@jarvis:~> dmesg|grep tpm
> > [    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 
> > 2)
> > [14566.626614] tpm tpm0: Operation Timed out
> > [14566.626621] tpm tpm0: tpm2_load_context: failed with a system
> > error -62
> > [14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> > [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> > [14570.626605] tpm tpm0: tpm2_load_context: failed with a system
> > error -62
> > [14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> > [14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
> > ...
> > 
> > The problem is caused by a change that caused us to poke the TPM
> > far
> > more often to see if it's ready.  Apparently something about the
> > bus
> > its on and the TPM means that it crashes or falls off the bus if
> > you
> > poke it too often and once this happens, only a reboot will recover
> > it.
> 
> I wonder if something about triggering ETIME even once breaks the
> driver so it can't talk to the chip at all thereafter..
> 
> Ie it doesn't abort the command properly and becomes desynced with
> the TIS execution protocol.

Yes, I wondered about this, but I don't understand the bus protocol
well enough.  The tpm-interface:tpm_try_transmit() which throws the
first ETIME says after we get that we send chip->ops->cancel() which
tpm_tis simply translates to tpm_tis_ready() which also times out.  Is
there a bigger hammer I can hit it with?

> I would be very surprised if polling the TIS status register effects.

Well, I was surprised too, but given the patch that's causing the
problem, it was the only explanation I could come up with.

> the firmware running inside the chip..
> 
> 
> BTW, no interrupt in your latop setup? I'm surprised by that..

Heh, I hear rumours that most laptops are delivered like this and a
large software company might be annoyed enough about the problem to
mandate interrupts the next time it produces a hardware requirements
spec.

James
