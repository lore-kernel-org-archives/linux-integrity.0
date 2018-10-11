Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJKXas (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 19:30:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
References: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Oct 2018 18:02:56 +0200
Message-ID: <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
Subject: Re: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 10/10/18, Nick Desaulniers <ndesaulniers@google.com> wrote:
> Hello,
> I noticed that compiling with
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> and Clang produced the warning:
>
>   CC      security/keys/trusted.o
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>         va_start(argp, h3);
>                        ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                                ^
>
> Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> standards explicitly call this out as undefined behavior:
>
> The parameter parmN is the identifier of the rightmost parameter in
> the variable parameter list in the function definition (the one just
> before the ...). If the parameter parmN is declared with ... or with a
> type that is not compatible with the type that results after
> application of the default argument promotions, the behavior is
> undefined.
>
> So if I understand my C promotion/conversion rules correctly, unsigned
> char would be promoted to int?
>
> We had a few ideas for possible fixes in:
> https://github.com/ClangBuiltLinux/linux/issues/41

I arrived at a similar patch as the one cited there, but it broke again
after an 'extern' declaration was added in include/keys/trusted.h,
so that has to be patched as well now.

       Arnd
