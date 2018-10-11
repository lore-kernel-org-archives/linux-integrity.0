Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbeJKXiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 19:38:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BG9e8q144638
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 12:10:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n27k3ewxf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 12:10:14 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 10:10:12 -0600
Subject: Re: undefined behavior (-Wvarargs) in
 security/keys/trusted.c#TSS_authhmac()
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc: zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Date: Thu, 11 Oct 2018 09:10:03 -0700
In-Reply-To: <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
References: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
         <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539274203.2623.56.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-10-11 at 18:02 +0200, Arnd Bergmann wrote:
> On 10/10/18, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Hello,
> > I noticed that compiling with
> > CONFIG_TCG_TPM=y
> > CONFIG_HW_RANDOM_TPM=y
> > and Clang produced the warning:
> > 
> >   CC      security/keys/trusted.o
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-
> > Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> > 
> > Specifically, it seems that both the C90 (4.8.1.1) and C11
> > (7.16.1.4) standards explicitly call this out as undefined
> > behavior:
> > 
> > The parameter parmN is the identifier of the rightmost parameter in
> > the variable parameter list in the function definition (the one
> > just before the ...). If the parameter parmN is declared with ...
> > or with a type that is not compatible with the type that results
> > after application of the default argument promotions, the behavior
> > is undefined.
> > 
> > So if I understand my C promotion/conversion rules correctly,
> > unsigned char would be promoted to int?
> > 
> > We had a few ideas for possible fixes in:
> > https://github.com/ClangBuiltLinux/linux/issues/41
> 
> I arrived at a similar patch as the one cited there, but it broke
> again after an 'extern' declaration was added in
> include/keys/trusted.h, so that has to be patched as well now

They look either over complicated or potentially problematic.  since
this is an internal API and a char * is always legal, what's wrong with
simply swapping h2 and h3?

James
