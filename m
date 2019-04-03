Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080DFC10F0B
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84E1214AF
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 19:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNR0y0rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDCT0L (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:26:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54489 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDCT0L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 15:26:11 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so11530079ite.4
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBGvNSBA2r4Qab5orgcoZDjbchj36csjHok/2EjqUMo=;
        b=NNR0y0rQpl5Kqqzwg/YZQOkwZ04CSnq8TMrzZwLfXN3EZ5LaSdLCmCiPGBzPGjfjDf
         EIGeD+ZuLYEJCmRLtSikpk/QvOlVgSvWG8qQqxTAYLM6NUIA3fmjqiEnY1DaxfAJLTj1
         ApLYG4TpTgpMiqUxsSSl54gK/3jfym37+vtr7n15PPvjvBMdbYSJ7n+QnHkXBoD3EbzY
         U7RYvGWqfMR5YdunMo7vxrGA5dzLaO4UQW/HxDxR2RywTEkKlFT3HjwS0ql01Zt27ZG6
         zs9v5dvcTbKGRP/HTUpibIsE5QC8RszxsVUxUd1fzkEMXk7iHuLxc+SHzyA4xQt7oU6c
         XGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBGvNSBA2r4Qab5orgcoZDjbchj36csjHok/2EjqUMo=;
        b=qvmVZAHO2Wpod9NXBWu6hJP5p65kzY4aDHDVvXuJYK+kJ9qEsDDutzX/MfH6gQin8U
         TScsd5gCxO2c4w/hdMl8RXZ5BTkPwH4vomkt1trqNA3IyaToW6pnlQwhos04g9D0OEaF
         Nv/w5WzLpeAzLQ37zgWUuofhmB6qmj2hlBzgt1WhudydBpkh8vlsUINChC6kBrK+u/NI
         uRyKTA9c8glDW38vpzBAU7e/eAxht+HQa+0ZQWk4/rVumGMQ5l/eBeWlK+f0V7ywWUVJ
         1IyEirdzQ1wEdCgGGGxgthnF4+l3sc9T3FRX474grEEOa6uFut3DM5C6ZWYZuvcSxxVn
         5+rQ==
X-Gm-Message-State: APjAAAWRUgMxZix7mieW7/jdLxj+VcYitBSGLnuWIcHwVp4fxqMe7m1R
        TQ+5sHgl1YKZUcTvWozTFeoDiZk4lYFFB3/DTMmbPQ==
X-Google-Smtp-Source: APXvYqyfgzFwjS7F1f6Qb2i7d8JjSXXlLZiZ+9oG/NGkt07HYWsOAjB9Os78xkovFJyJdlwDX+glRSuCgbaWJanQNGM=
X-Received: by 2002:a24:cf41:: with SMTP id y62mr1630633itf.106.1554319570213;
 Wed, 03 Apr 2019 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com> <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru> <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru> <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov> <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
 <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru> <CACdnJusgwpcSxzwNEieqsa54_3cTYMEfuXpAeP0cW81TQ29E+w@mail.gmail.com>
 <bca4eb5b-2d76-5df8-6e63-573b3a057985@omprussia.ru> <CACdnJutv4O9bPwvddrasz2up06P6OtBbHjsr6JGSOwAtryMTpg@mail.gmail.com>
 <3ebff410-f1bd-654e-7cd0-486ea4768ebe@omprussia.ru>
In-Reply-To: <3ebff410-f1bd-654e-7cd0-486ea4768ebe@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 3 Apr 2019 12:25:58 -0700
Message-ID: <CACdnJutN3415jtt+kaz-zxyAw0V9-0x0_YGWpxBXWYseD5Z7uA@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 3, 2019 at 11:47 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> On 03.04.2019 21:19, Matthew Garrett wrote:
> > There's two possible cases here:
> >
> > 1) The application is legitimate but can be convinced to open and
> > execute malicious code. There should be no such applications that
> > download code from the internet and execute it directly, so this can
> > be prevented by requiring that files be signed (which has to be done
> > to protect against attackers just using an interpreted language
> > instead)
> > 2) The application is actively malicious. In this case this approach
> > is insufficient - an actively malicious application can interpret code
> > rather than executing it directly. This can only be prevented by not
> > signing malicious applications.
> >
> > When you talk about "staying below the radar" it implies that you're
> > talking about case 2, but the proposed solution is only a speed bump
> > rather than a blocker.
>
> But what about buffer/stack overflow? The application doesn't need to be
> malicious. It could be just a web-browser or e-mail client processing
> some evil file.

Executable pages shouldn't be writable?
