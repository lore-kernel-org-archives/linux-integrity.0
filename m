Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56162 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387415AbeGKRKF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 13:10:05 -0400
Message-ID: <1531328689.3260.8.camel@HansenPartnership.com>
Subject: Regression in tpm_tis driver: the TPM now fatally offlines itself
 after a few hours of use
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 11 Jul 2018 10:04:49 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

First a caveat: all my laptop security goes through the TPM, so I'm a
much more industrial consumer of the technology than most users, who
don't use a TPM at all.

However, since 4.18-rc1 I've been seeing these errors with the TPM:

jejb@jarvis:~> dmesg|grep tpm
[    3.282605] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[14566.626614] tpm tpm0: Operation Timed out
[14566.626621] tpm tpm0: tpm2_load_context: failed with a system error -62
[14568.626607] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14570.626605] tpm tpm0: tpm2_load_context: failed with a system error -62
[14572.626526] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14577.710441] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14579.710418] tpm tpm0: tpm_try_transmit: tpm_send: error -62
[14581.710404] tpm tpm0: tpm_try_transmit: tpm_send: error -62
...

What happens is that I get one command that errors out with ETIME and
from that point on every TPM operation always returns -ETIME and it's
impossible to recover the TPM by any means except a reboot.

There are only three patches to tpm_tis in the merge window and it
looks like reverting this one fixes the problem:

commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
Author: Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Wed May 16 01:51:25 2018 -0400

    tpm: reduce polling time to usecs for even finer granularity

As far as I can tell, all that patch does is cause the TPM to be poked
far more often to see if it's finished, but something about this rate
of poking is causing it to drop off its bus.  Based on this theory,
I've got a proposed fix which increases the timing parameters so we can
maintain the performance benefits of the above patch while remedying
the regression (I'll send it as a reply to this report).

Regards,

James
