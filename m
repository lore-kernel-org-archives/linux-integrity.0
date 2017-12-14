Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:56611 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdLNQGs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 11:06:48 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 0/3] Export broken TPMs to user space
Date: Thu, 14 Dec 2017 17:06:11 +0100
Message-ID: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I had already published those patches a while ago on the old mailing list, and there were some discussions, but we never came to a definite conclusion. I'd still like to get those patches applied, so here they are again, together with a summary of the discussions. The original description of the series is at the very end.

Back then there were some comments to not change the location of the idr_replace calls (patch 1/3), because that might break something, but no specifics were mentioned. I still believe my current change to be correct (and/or not worse than before). If you disagree, please describe a concrete scenario where this change is detrimental, so that I get a better understanding of the code. If nobody understands the code well enough to point out any flaws, but you still think it is wrong to change it, then maybe we should throw it away and rewrite it from scratch to make it easier to understand ;-)

There were also some concerns that allowing user space to access misbehaving/broken devices (patch 3/3) could have ill effects on the stability or even security of the system. To this it was pointed out:
* User space already has ways to access the device even without the kernel driver (e.g. direct access via /dev/mem), but having the kernel driver as a clean interface is preferable.
* The kernel driver has to be prepared to handle misbehaving devices in any case, not only when the device indicates failed selftests during boot (what happens for example when the device breaks, after the driver has already been loaded?). In the end, the kernel just provides a transparent interface to the device (at least as long as /dev/tpm0 is concerned), that is only as good or as bad as the underlying device.
* It is not uncommon for the kernel to talk to broken devices. If there are SMART failures, there is no code that prevents you from getting access to your hard disk.
* As for security, it is precisely the TPM's job to protect itself (and your secrets). You get all your security guarantees from the TPM, not the driver code, so it does not matter what the driver does, even with a broken TPM.

---

TPMs may break sometimes, in which case the kernel currently refuses to talk to them at all. As far as the kernel is concerned, this is okay, since it cannot fix them anyway. But there might be user space applications that can be used for further diagnosis or even to fix the underlying problem. In order to allow this, a broken device should be exported to user space, as long as we can at least talk to it, that is, as long as it provides well-formed answers to commands, even though it might return error codes that we do not expect.

Alexander Steffen (3):
  tpm-chip: Move idr_replace calls to appropriate places
  tpm-chip: Return TPM error codes from auto_startup functions
  tpm-chip: Export TPM device to user space even when startup failed

 drivers/char/tpm/tpm-chip.c      | 29 +++++++++++++++++------------
 drivers/char/tpm/tpm-interface.c |  6 ++----
 drivers/char/tpm/tpm2-cmd.c      |  4 +---
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.7.4
