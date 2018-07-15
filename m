Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34666 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbeGOCet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:34:49 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so13106059ywg.1
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:13:39 -0700
Message-ID: <CAGXu5jKU-cdYCQePZAr_eEUEsaK92kABFF=UowhaO6yuWVXEVA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] security: define new LSM hook named security_kernel_load_data
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Differentiate between the kernel reading a file specified by userspace
> from the kernel loading a buffer containing data provided by userspace.
> This patch defines a new LSM hook named security_kernel_load_data().
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
