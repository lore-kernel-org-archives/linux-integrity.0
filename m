Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:52946 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754732AbdKNRgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 12:36:36 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] [RFC] time: Make sure jiffies_to_msecs() preserves non-zero time periods
Date: Tue, 14 Nov 2017 18:36:26 +0100
Message-Id: <1510680986-29391-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
time period.

However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 2001),
jiffies_to_msecs() may return zero for small non-zero time periods.
This may break code that relies on receiving back a non-zero value, e.g.
drivers/char/tpm/tpm2-cmd.c:tpm2_do_selftest().

jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
not support values of HZ larger than 12287, thus rejecting any
problematic huge values of HZ.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
I noticed this issue due to the following compiler warning with
gcc-4.1.2:

    drivers/char/tpm/tpm2-cmd.c: In function 'tpm2_do_selftest':
    drivers/char/tpm/tpm2-cmd.c:851: warning: 'rc' may be used uninitialized in this function

With the fix above, this becomes a false positive.
Nevertheless, it may be a good idea to preinitialize rc anyway, but I
have no idea what's the correct value (else I would have sent a patch
to do so ;-).

Fixes: 87434f58be31a96d ("tpm: Use dynamic delay to wait for TPM 2.0 self test result")
---
 kernel/time/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7dd6899d83..69b901a8739aad5e 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -314,9 +314,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
+	       HZ_TO_MSEC_SHR32;
 # else
-	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
+	return (j * HZ_TO_MSEC_NUM + HZ_TO_MSEC_DEN - 1) / HZ_TO_MSEC_DEN;
 # endif
 #endif
 }
-- 
2.7.4
