Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJMAj0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 20:39:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id 80-v6so6114622pgh.10
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
In-Reply-To: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 12 Oct 2018 10:05:48 -0700
Message-ID: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To: denkenz@gmail.com
Cc: jejb@linux.ibm.com, dhowells@redhat.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Oct 12, 2018 at 8:14 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi James,
>
> >> So can't we simply use 'bool' or uint32 as the type for h3 instead
> >> of re-ordering everything
> >
> > The problem is the standard is ambiguious.  The only thing that's
> > guaranteed to work for all time is a char *.  If you want to keep the
> > order, what I'd suggest is inserting a dummy pointer argument which is
> > always expected to be NULL between the h3 and the varargs.
>
> So maybe I'm misunderstanding something, but the issue seems to be that
> unsigned char is promoted to 'unsigned char *' by Clang and probably
> unsigned int or int by gcc.

No. This is extremely well defined behavior in C.  In C, integral
types are NEVER promoted to pointer to integer types, only to larger
integral types through rules more complicated than the correct flags
to pass to `tar`.
https://xkcd.com/1168/

>
> So instead of having unsigned char h3, can't we simply have bool h3 or
> unsigned int h3?

int is the default argument promotion. Proposed:
https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339

>
> Regards,
> -Denis
>


-- 
Thanks,
~Nick Desaulniers
