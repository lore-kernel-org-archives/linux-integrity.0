Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36255 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdKTSv1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 13:51:27 -0500
Date: Mon, 20 Nov 2017 20:51:21 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] [RFC] time: Make sure jiffies_to_msecs() preserves
 non-zero time periods
Message-ID: <20171120185121.fik5lz62lzjcyceq@linux.intel.com>
References: <1510680986-29391-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1510680986-29391-1-git-send-email-geert@linux-m68k.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 14, 2017 at 06:36:26PM +0100, Geert Uytterhoeven wrote:
> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> time period.
> 
> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 2001),
> jiffies_to_msecs() may return zero for small non-zero time periods.
> This may break code that relies on receiving back a non-zero value, e.g.
> drivers/char/tpm/tpm2-cmd.c:tpm2_do_selftest().
> 
> jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> not support values of HZ larger than 12287, thus rejecting any
> problematic huge values of HZ.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I noticed this issue due to the following compiler warning with
> gcc-4.1.2:
> 
>     drivers/char/tpm/tpm2-cmd.c: In function 'tpm2_do_selftest':
>     drivers/char/tpm/tpm2-cmd.c:851: warning: 'rc' may be used uninitialized in this function
> 
> With the fix above, this becomes a false positive.
> Nevertheless, it may be a good idea to preinitialize rc anyway, but I
> have no idea what's the correct value (else I would have sent a patch
> to do so ;-).
> 
> Fixes: 87434f58be31a96d ("tpm: Use dynamic delay to wait for TPM 2.0 self test result")

I would consider the above fix just to masks the regression in the TPM
driver. The code in the TPM subsystem is incorrect by making such an
assumption and should be fixed there.

Arnd's suggestion is what I would do. Are you willing to contribute the
fix? If the answer is yes, please add suggested-by tag for Arnd. Thank
you for spotting this.

/Jarkko
