Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeGKU6J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 16:58:09 -0400
Date: Wed, 11 Jul 2018 22:51:40 +0200
In-Reply-To: <1531341545.3260.24.camel@HansenPartnership.com>
References: <1531328689.3260.8.camel@HansenPartnership.com> <1531329074.3260.9.camel@HansenPartnership.com> <20180711182120.GF23935@ziepe.ca> <1531336133.3260.16.camel@HansenPartnership.com> <20180711200101.GH23935@ziepe.ca> <1531341545.3260.24.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
From: Peter Huewe <peterhuewe@gmx.de>
Message-ID: <EA1F52B6-C56D-4910-A88A-9C0FC0F6E1FE@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



Am 11. Juli 2018 22:39:05 MESZ schrieb James Bottomley <James.Bottomley@HansenPartnership.com>:
>On Wed, 2018-07-11 at 14:01 -0600, Jason Gunthorpe wrote:
>> On Wed, Jul 11, 2018 at 12:08:53PM -0700, James Bottomley wrote:
>> > On Wed, 2018-07-11 at 12:21 -0600, Jason Gunthorpe wrote:
>> > > On Wed, Jul 11, 2018 at 10:11:14AM -0700, James Bottomley wrote:
>> > > > tpm_tis regressed recently to the point where the TPM being
>> > > > driven
>> > > > by
>> > > > it falls off the bus and cannot be contacted after some hours
>> > > > of
>> > > > use.
>> > > > This is the failure trace:
>> > > > 
>> > > > jejb@jarvis:~> dmesg|grep tpm
>> > > > [    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE,
>> > > > rev-id 
>> > > > 2)
>> > > > [14566.626614] tpm tpm0: Operation Timed out
>> > > > [14566.626621] tpm tpm0: tpm2_load_context: failed with a
>> > > > system
>> > > > error -62
>> > > > [14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
>> > > > [14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
>> > > > [14570.626605] tpm tpm0: tpm2_load_context: failed with a
>> > > > system
>> > > > error -62
>> > > > [14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
>> > > > [14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
>> > > > ...
>> > > > 
>> > > > The problem is caused by a change that caused us to poke the
>> > > > TPM
>> > > > far
>> > > > more often to see if it's ready.  Apparently something about
>> > > > the
>> > > > bus
>> > > > its on and the TPM means that it crashes or falls off the bus
>> > > > if
>> > > > you
>> > > > poke it too often and once this happens, only a reboot will
>> > > > recover
>> > > > it.
>> > > 
>> > > I wonder if something about triggering ETIME even once breaks the
>> > > driver so it can't talk to the chip at all thereafter..
>> > > 
>> > > Ie it doesn't abort the command properly and becomes desynced
>> > > with the TIS execution protocol.
>> > 
>> > Yes, I wondered about this, but I don't understand the bus protocol
>> > well enough.  The tpm-interface:tpm_try_transmit() which throws the
>> > first ETIME says after we get that we send chip->ops->cancel()
>> > which tpm_tis simply translates to tpm_tis_ready() which also times
>> > out.  Is there a bigger hammer I can hit it with?
>> 
>> I don't remember off hand.. But this is, IMHO, a better guess than
>> the firmware crashes from reading the status register..
>
>Oh, actually, I think the bus crashes or wedges, not the TPM.  I just
>don't have any tools to probe the LPC.
>

I doubt that your fTPM is actually attached to LPC.
And usually if lpc  wedges it takes down your pc with it (from my experience)

I wonder what the contents of the acc and sts registers actually are.


If you want i can send you a small tis 'debug' tool tomorrow.

>James
>
>
>> Perhaps reducing the timeout to force a ETIME would prove the theory?

-- 
Sent from my mobile
