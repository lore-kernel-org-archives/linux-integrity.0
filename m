Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40697 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbeGOCfe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:35:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id p129-v6so13093414ywg.7
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:14:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-3-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:14:24 -0700
Message-ID: <CAGXu5j+bRE7-Jq4Q+jcVOyZ3e1hy6kbpF5ctdmdQxuV+ri82hQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] kexec: add call to LSM hook in original kexec_load syscall
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> In order for LSMs and IMA-appraisal to differentiate between kexec_load
> and kexec_file_load syscalls, both the original and new syscalls must
> call an LSM hook.  This patch adds a call to security_kernel_load_data()
> in the original kexec_load syscall.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
