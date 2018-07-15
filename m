Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40890 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeGOCpT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jul 2018 22:45:19 -0400
Received: by mail-yw0-f193.google.com with SMTP id p129-v6so13096555ywg.7
        for <linux-integrity@vger.kernel.org>; Sat, 14 Jul 2018 19:24:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:24:07 -0700
Message-ID: <CAGXu5j+GTMeX=TNO3mEYivBd1_9MGQBfOivnMYg5+63HboyXMA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] firmware: add call to LSM hook before firmware
 sysfs fallback
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
> Add an LSM hook prior to allowing firmware sysfs fallback loading.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
