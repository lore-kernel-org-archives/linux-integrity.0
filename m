Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33232 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbeGOCmt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:42:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so14232434ybb.0
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:21:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:21:38 -0700
Message-ID: <CAGXu5jKDE0mPzi8RUhsViEwjhZX1=M-xU4DEa70tk3i2tN+rPA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] ima: based on policy require signed kexec kernel images
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
> The original kexec_load syscall can not verify file signatures, nor can
> the kexec image be measured.  Based on policy, deny the kexec_load
> syscall.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
