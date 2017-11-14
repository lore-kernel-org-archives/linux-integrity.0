Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:55130 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbdKNUSe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 15:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <1510680986-29391-1-git-send-email-geert@linux-m68k.org>
References: <1510680986-29391-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Nov 2017 21:18:33 +0100
Message-ID: <CAK8P3a3FvHSVZhraEVUBkgz8FJCWn6+zwPD__G5tQ8naPrc6wQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] time: Make sure jiffies_to_msecs() preserves
 non-zero time periods
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 14, 2017 at 6:36 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> time period.
>
> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 2001),
> jiffies_to_msecs() may return zero for small non-zero time periods.
> This may break code that relies on receiving back a non-zero value, e.g.
> drivers/char/tpm/tpm2-cmd.c:tpm2_do_selftest().

For reference, there are exactly three platforms that allow HZ to be larger
than 1000, and they specifically use HZ=1024: alpha, itanium and
mips/decstation.

> With the fix above, this becomes a false positive.
> Nevertheless, it may be a good idea to preinitialize rc anyway, but I
> have no idea what's the correct value (else I would have sent a patch
> to do so ;-).

I think changing the while() loop into do{}while() would be appropriate here.

      Arnd
