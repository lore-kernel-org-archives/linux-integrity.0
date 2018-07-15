Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36802 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbeGOCtl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:49:41 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so676682ywg.3
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:28:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:28:28 -0700
Message-ID: <CAGXu5jL8_nbUKKNO-PCyGwOdQ+vjPZ7_17FKNH1fssgtfjk=Rw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] ima: add build time policy
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

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> IMA by default does not measure, appraise or audit files, but can be
> enabled at runtime by specifying a builtin policy on the boot command line
> or by loading a custom policy.
>
> This patch defines a build time policy, which verifies kernel modules,
> firmware, kexec image, and/or the IMA policy signatures.  This build time
> policy is automatically enabled at runtime and persists after loading a
> custom policy.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
