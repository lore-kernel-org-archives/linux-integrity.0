Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42617 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeGBPaK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 11:30:10 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so15070638ioh.9
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 08:30:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com> <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 2 Jul 2018 17:30:09 +0200
Message-ID: <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
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
> pre-allocated buffer. (Based on the mailing list discussions, calling
> dma_alloc_coherent() is unnecessary and confusing.)
>
> (Very broken/buggy) devices using pre-allocated memory run the risk of
> the firmware being accessible to the device prior to the completion of
> IMA's signature verification.  For the time being, this patch emits a
> warning, but does not prevent the loading of the firmware.
>

As I attempted to explain in the exchange with Luis, this has nothing
to do with broken or buggy devices, but is simply the reality we have
to deal with on platforms that lack IOMMUs.

Even if you load into one buffer, carry out the signature verification
and *only then* copy it to another buffer, a bus master could
potentially read it from the first buffer as well. Mapping for DMA
does *not* mean 'making the memory readable by the device' unless
IOMMUs are being used. Otherwise, a bus master can read it from the
first buffer, or even patch the code that performs the security check
in the first place. For such platforms, copying the data around to
prevent the device from reading it is simply pointless, as well as any
other mitigation in software to protect yourself from misbehaving bus
masters.

So issuing a warning in this particular case is rather arbitrary. On
these platforms, all bus masters can read (and modify) all of your
memory all of the time, and as long as the firmware loader code takes
care not to provide the DMA address to the device until after the
verification is complete, it really has done all it reasonably can in
the environment that it is expected to operate in.

(The use of dma_alloc_coherent() is a bit of a red herring here, as it
incorporates the DMA map operation. However, DMA map is a no-op on
systems with cache coherent 1:1 DMA [iow, all PCs and most arm64
platforms unless they have IOMMUs], and so there is not much
difference between memory allocated with kmalloc() or with
dma_alloc_coherent() in terms of whether the device can access it
freely)






> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> ---
> Changelog v5:
> - Instead of preventing loading firmware from a pre-allocate buffer,
> emit a warning.
>
>  security/integrity/ima/ima_main.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e467664965e7..7da123d980ea 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -416,6 +416,15 @@ void ima_post_path_mknod(struct dentry *dentry)
>                 iint->flags |= IMA_NEW_FILE;
>  }
>
> +static int read_idmap[READING_MAX_ID] = {
> +       [READING_FIRMWARE] = FIRMWARE_CHECK,
> +       [READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> +       [READING_MODULE] = MODULE_CHECK,
> +       [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> +       [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> +       [READING_POLICY] = POLICY_CHECK
> +};
> +
>  /**
>   * ima_read_file - pre-measure/appraise hook decision based on policy
>   * @file: pointer to the file to be measured/appraised/audit
> @@ -439,18 +448,16 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>                 }
>                 return 0;       /* We rely on module signature checking */
>         }
> +
> +       if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
> +               if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +                       pr_warn("device might be able to access firmware prior to signature verification completion.\n");
> +               }
> +       }
>         return 0;
>  }
>
> -static int read_idmap[READING_MAX_ID] = {
> -       [READING_FIRMWARE] = FIRMWARE_CHECK,
> -       [READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> -       [READING_MODULE] = MODULE_CHECK,
> -       [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> -       [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> -       [READING_POLICY] = POLICY_CHECK
> -};
> -
>  /**
>   * ima_post_read_file - in memory collect/appraise/audit measurement
>   * @file: pointer to the file to be measured/appraised/audit
> --
> 2.7.5
>
