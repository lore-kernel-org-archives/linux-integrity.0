Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39546 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbeGOCsy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:48:54 -0400
Received: by mail-yb0-f196.google.com with SMTP id k127-v6so14224407ybk.6
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:27:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:27:42 -0700
Message-ID: <CAGXu5jKWGONcAfxrU_vk4g=La24NDSzS=scZWxp27xJdO_R0zA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
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
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
