Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:56461 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdKNUYF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Nov 2017 15:24:05 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3FvHSVZhraEVUBkgz8FJCWn6+zwPD__G5tQ8naPrc6wQ@mail.gmail.com>
References: <1510680986-29391-1-git-send-email-geert@linux-m68k.org> <CAK8P3a3FvHSVZhraEVUBkgz8FJCWn6+zwPD__G5tQ8naPrc6wQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Nov 2017 21:24:03 +0100
Message-ID: <CAMuHMdV-S-tULe7JqUMKy-FJCTwyS5JPMetHLN01B68kE8=Tqg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] time: Make sure jiffies_to_msecs() preserves
 non-zero time periods
To: Arnd Bergmann <arnd@arndb.de>
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

Hi Arnd,

On Tue, Nov 14, 2017 at 9:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Nov 14, 2017 at 6:36 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
>> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
>> time period.
>>
>> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 2001),
>> jiffies_to_msecs() may return zero for small non-zero time periods.
>> This may break code that relies on receiving back a non-zero value, e.g.
>> drivers/char/tpm/tpm2-cmd.c:tpm2_do_selftest().
>
> For reference, there are exactly three platforms that allow HZ to be larger
> than 1000, and they specifically use HZ=1024: alpha, itanium and
> mips/decstation.

jiffies_to_msecs(1) = zero if HZ=1024.

>> With the fix above, this becomes a false positive.
>> Nevertheless, it may be a good idea to preinitialize rc anyway, but I
>> have no idea what's the correct value (else I would have sent a patch
>> to do so ;-).
>
> I think changing the while() loop into do{}while() would be appropriate here.

Sounds reasonable.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
