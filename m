Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35757 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbeGOCzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:55:33 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so14236135ybm.2
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:34:19 -0700
Message-ID: <CAGXu5jKGvQLKV_LmyYaOaF_G6CzF6kUp03cROz1+1PWHEMdrZg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Some systems are memory constrained but they need to load very large
> firmwares.  The firmware subsystem allows drivers to request this
> firmware be loaded from the filesystem, but this requires that the
> entire firmware be loaded into kernel memory first before it's provided
> to the driver.  This can lead to a situation where we map the firmware
> twice, once to load the firmware into kernel memory and once to copy the
> firmware into the final resting place.
>
> To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> into a pre-allocated buffer") introduced request_firmware_into_buf() API
> that allows drivers to request firmware be loaded directly into a
> pre-allocated buffer.
>
> Do devices using pre-allocated memory run the risk of the firmware being
> accessible to the device prior to the completion of IMA's signature
> verification any more than when using two buffers? (Refer to mailing list
> discussion[1]).
>
> Only on systems with an IOMMU can the access be prevented.  As long as
> the signature verification completes prior to the DMA map is performed,
> the device can not access the buffer.  This implies that the same buffer
> can not be re-used.  Can we ensure the buffer has not been DMA mapped
> before using the pre-allocated buffer?
>
> [1] https://lkml.org/lkml/2018/7/10/56
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I can't decide if it's worth adding the link (maybe using the
lkml.kernel.org url[1]) directly in the code or not.

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://lkml.kernel.org/r/CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com

-- 
Kees Cook
Pixel Security
