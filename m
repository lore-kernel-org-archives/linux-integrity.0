Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E53C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF1C20651
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfAOQz5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37197 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfAOQzk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 11:55:40 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so5317353iti.2
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jan 2019 08:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8rfWcdvr079HZHBIQ3i3xZOXJNScrqx/omQCyL2Acc=;
        b=Xf/xQDGniNbYIWwNp+tEscv0y5lPqvFDrnpjSYXYFO/1XTkRDTX6TNLBXfCPJo7GqV
         9xWecMG0lU5mJiYRdBGhDc0SKtmPuIK3Bo1KAEj0E14lU+leUvvMMOUVZSqL+9nWjxgA
         318XM6HY6DaTXKTl0SThGKgOhEaIMuKBWDp+nI0bMc/TyVoBe9j0IZfwiF5USdU3nnJ3
         h4CfaDU6NCbmhRwmrlnRYHNn1DobkLJ+ml78idyEbSUcjOZYwKUkIYkmM66jeo8UZb6l
         w5KaFrR7G80xPYPbz0FawHdyW9v45kcA5MLZIfKBd7rrgoFMFTXIXTtvGORRe0ISBUot
         pH+Q==
X-Gm-Message-State: AJcUukdCVFKwaDdB0XCuXvymAfnhjdrJpL986SSuAf8X91WDzbZlFzLC
        YYJFO0JJ45gJ4ug/klPuJHT7Mv0+UJas5uujeTgJWA==
X-Google-Smtp-Source: ALg8bN5qXIN7zbqeAWIkmzWLAFna6Fa06f9G+P7gkKxPUD2FbNNvIhzv6Vhsex9kgyQn4li5nRv6VDCgkGZGyURRVCc=
X-Received: by 2002:a02:95e4:: with SMTP id b91mr2458946jai.15.1547570937144;
 Tue, 15 Jan 2019 08:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20190115094542.17129-1-kasong@redhat.com> <20190115094542.17129-3-kasong@redhat.com>
 <1547567218.4156.289.camel@linux.ibm.com>
In-Reply-To: <1547567218.4156.289.camel@linux.ibm.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 16 Jan 2019 00:48:46 +0800
Message-ID: <CACPcB9e+TWK7s5ud_yNd4EiuFyM5hctAMqBSnOZzL3g03ryr_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 15, 2019 at 11:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
>
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 7d97e432cbbc..a06b04065bb1 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
> >  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> >  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> >  {
> > -     return verify_pefile_signature(kernel, kernel_len,
> > -                                    VERIFY_USE_SECONDARY_KEYRING,
> > -                                    VERIFYING_KEXEC_PE_SIGNATURE);
> > +     int ret;
> > +     ret = verify_pefile_signature(kernel, kernel_len,
> > +                     VERIFY_USE_SECONDARY_KEYRING,
> > +                     VERIFYING_KEXEC_PE_SIGNATURE);
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>
> Consider using IS_ENABLED() or IS_BUILTIN().
>
> Mimi

Thanks for the suggestion, will update the patch later if there are no
other comments.

>
> > +     if (ret == -ENOKEY) {
> > +             ret = verify_pefile_signature(kernel, kernel_len,
> > +                             VERIFY_USE_PLATFORM_KEYRING,
> > +                             VERIFYING_KEXEC_PE_SIGNATURE);
> > +     }
> > +#endif
> > +     return ret;
> >  }
> >  #endif
>



--
Best Regards,
Kairui Song
