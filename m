Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36639 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJJFay (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 01:30:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so1497586pgv.3
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 15:11:51 -0700 (PDT)
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 9 Oct 2018 15:11:39 -0700
Message-ID: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
Subject: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,
I noticed that compiling with
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
and Clang produced the warning:

  CC      security/keys/trusted.o
security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^

Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

So if I understand my C promotion/conversion rules correctly, unsigned
char would be promoted to int?

We had a few ideas for possible fixes in:
https://github.com/ClangBuiltLinux/linux/issues/41

Do the maintainers have feedback on these suggestions or a more appropriate fix?

Note: https://www.gnu.org/software/libc/manual/html_node/Calling-Variadics.html
and `man 3 va_start` mention more about promotions, but just for
va_arg, not va_start. But the standard seems explicit about parmN
which is passed to va_start.

https://www.eskimo.com/~scs/cclass/int/sx11c.html is also an
interesting read on the subject, which states: `Finally, for vaguely
related reasons, the last fixed argument (the one whose name is passed
as the second argument to the va_start() macro) should not be of type
char, short int, or float, either.`
-- 
Thanks,
~Nick Desaulniers
