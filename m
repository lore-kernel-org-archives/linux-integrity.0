Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:20007 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754650AbdLGP4K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 10:56:10 -0500
From: <Alexander.Steffen@infineon.com>
To: <pmenzel@molgen.mpg.de>, <linux-integrity@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Date: Thu, 7 Dec 2017 15:56:07 +0000
Message-ID: <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
In-Reply-To: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Dear Linux folks,
> 
> 
> With Linux 4.15-rc2 built by the Ubuntu Kernel Team, the error messages
> below are shown by the Linux kernel. These are new.
> 
> ```
> Dez 06 13:22:24 Ixpees kernel: microcode: microcode updated early to
> revision 0x62, date = 2017-04-27
> Dez 06 13:22:24 Ixpees kernel: Linux version 4.15.0-041500rc2-generic
> (kernel@gloin) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #201712031230
> SMP Sun Dec 3 17:32:03 UTC 2017
> Dez 06 13:22:24 Ixpees kernel: Command line:
> BOOT_IMAGE=/vmlinuz-4.15.0-041500rc2-generic
> root=/dev/mapper/ubuntu--vg-root ro quiet splash vt.handoff=7
> Dez 06 13:22:24 Ixpees kernel: KERNEL supported cpus:
> Dez 06 13:22:24 Ixpees kernel:   Intel GenuineIntel
> Dez 06 13:22:24 Ixpees kernel:   AMD AuthenticAMD
> Dez 06 13:22:24 Ixpees kernel:   Centaur CentaurHauls
> Dez 06 13:22:24 Ixpees kernel: x86/fpu: Supporting XSAVE feature 0x001:
> 'x87 floating point registers'
> Dez 06 13:22:24 Ixpees kernel: x86/fpu: Supporting XSAVE feature 0x002:
> 'SSE registers'
> [...]
> Dez 06 13:22:24 Ixpees kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id
> 0xFE, rev-id 4)
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: TPM self test failed
> ```
> 
> Any idea what to do about those?

The list of "A TPM error (2314) occurred continue selftest" is caused by my commit 125a2210541079e8e7c69e629ad06cabed788f8c ("tpm: React correctly to RC_TESTING from TPM 2.0 self tests"). 2314 is TPM_RC_TESTING, so the TPM tells us that self-tests are still running in the background. This problem was not visible in previous versions, since it (incorrectly) ignored TPM_RC_TESTING.

The final error "TPM self test failed" is then the driver giving up after too many TPM_RC_TESTING responses have been received.

What confuses me a bit is that according to your log all of that happens within the same second. The driver uses tpm2_calc_ordinal_duration for TPM2_CC_SELF_TEST which maps to TPM_LONG and finally to TPM2_DURATION_LONG = 2000ms = 2s. So you should see those retries for at least two seconds. But since it does not give the TPM enough time to execute the tests, you see it failing in the end.

Could you try to find out how much time exactly (in milliseconds) it takes from the first "A TPM error" to the final "TPM self test failed" message? Is it possible that tpm_msleep delays for significantly less time in this case?

Also, while looking at the code I've noticed that the retry loop is not written in the best possible way and should actually try one more time. Could you make the following change to tpm2_do_selftest in drivers/char/tpm/tpm2-cmd.c and see whether that helps? 

---
        duration = jiffies_to_msecs(
                tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
 
-       while (duration > 0) {
+       while (1) {
                cmd.header.in = tpm2_selftest_header;
                cmd.params.selftest_in.full_test = 0;
 
                rc = tpm_transmit_cmd(chip, NULL, &cmd,
TPM2_SELF_TEST_IN_SIZE,
                                      0, 0, "continue selftest");
 
-               if (rc != TPM2_RC_TESTING)
+               if (rc != TPM2_RC_TESTING || duration <= 0)
                        break;
 
                tpm_msleep(delay_msec);
---

> If these are intentional, it'd be great
> to give some hint to the user, what effect this has.

I agree that those error messages in their current form are not that helpful for the users. But they are part of the general driver architecture, and are also caused by other parts of the code (e.g. when using a TPM 1.2 that is deactivated or when the platform did not send a startup command). We should find a way to hide (or at least mark) those kind of expected errors.

Alexander
