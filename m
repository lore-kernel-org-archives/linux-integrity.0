Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CFC4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033B92133D
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0mwpByz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDCSUL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:20:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42561 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSUL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 14:20:11 -0400
Received: by mail-io1-f65.google.com with SMTP id c4so14887201ioh.9
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgqB5232HS8m7JBIbN2VeBPlH21PZrvaZyno8HtVXiU=;
        b=i0mwpByzGbOw/Wlb1mhDAMesFsYx/QaJiCK3/o9MiE1Uz/oM4K3Wm1ojRGMHbd5bnM
         iiaPXr1+fx3y/XsIFaD84rOeB+aWaQHu+M42VP8sRwWsCl/bKkXs5WR1WgMA+EENdSeK
         S+KRUBEyAeMgAAaQFuHDATqTodcDmTqkCgwZ1KtLruBjtHhYzxatwhExmAVCsxwuBo7Q
         9YwJb7ny5CunzsbDNN+aeAhwMaOYxh2yApJQFIpOzmkkqjt5R/i/17Gmr4/U2itu8iz5
         L+DqhdPimKn/HP1Wm1y4YbUUiXSBoY76GdLZS2xSVHnxm3ANQiv0h8BJNtYPcSL1taTq
         f+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgqB5232HS8m7JBIbN2VeBPlH21PZrvaZyno8HtVXiU=;
        b=Jj6TvCzC7qhAgJSYLUZdiSj90H7Q18z0bzEY8orQSCnvbzpVPb4oOChzabJwRn1gop
         +2wEBLzxgTPYqTg7MWBeRydG4pgH3NjRTZ6l5Y9gWxOfaZoVOyuVKLkB/HKlw9cWKO+B
         7yyCG/k4wZc2EDwy0cr6KI5VO7g62j4XHLroDvBE6Hq+XUnb5Izp2wTU3EOOpeusjGB+
         LhEtnUNXTG1nBbNJ6OWOfK2IK3R1+Dv2RPH1O6pTJAk0Q7uK6tTq9+660bhJSsi57Z0z
         bo4J9GcBNbDQ6PAvr90UizOoDQ9ceXDYlbSGAmLWq5sfYsUHA9PJPyCDjOpAh1wfgm7H
         8UsQ==
X-Gm-Message-State: APjAAAV0yfM/rzo5AsIBrnGlIM2vwVBigTlQvcUW1M5z8hfZPxaz9VqI
        zn9m1md80Ogy/SVWldCOue0T5mbaO5yQdPrnIeHtmQ==
X-Google-Smtp-Source: APXvYqyrEAJlvR5yymGAwb2eZAts/TH8EAeo6DosT+JwgTPrsTuZkBmgmhDXjyR6RHmRzdJAwlLSKeBbBqcXtZCyVNI=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr1171230ioa.147.1554315610013;
 Wed, 03 Apr 2019 11:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com> <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru> <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru> <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov> <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
 <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru> <CACdnJusgwpcSxzwNEieqsa54_3cTYMEfuXpAeP0cW81TQ29E+w@mail.gmail.com>
 <bca4eb5b-2d76-5df8-6e63-573b3a057985@omprussia.ru>
In-Reply-To: <bca4eb5b-2d76-5df8-6e63-573b3a057985@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 3 Apr 2019 11:19:58 -0700
Message-ID: <CACdnJutv4O9bPwvddrasz2up06P6OtBbHjsr6JGSOwAtryMTpg@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 10:31 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> I'm trying to reduce attacker's possibilities to inject any new unauthorized
> code. Currently it could be:

(snip)

> 4) Anonymous executable pages (either new or existing changing to writable).
>     ^ This is what I'm talking about. Because it's relatively easy to create
>     anonymous executable page to stay below the radar. Because even if you
>     enable signature checking for all opened files it would be possible to
>     simply download the code and execute it directly from the anonymous pages.

There's two possible cases here:

1) The application is legitimate but can be convinced to open and
execute malicious code. There should be no such applications that
download code from the internet and execute it directly, so this can
be prevented by requiring that files be signed (which has to be done
to protect against attackers just using an interpreted language
instead)
2) The application is actively malicious. In this case this approach
is insufficient - an actively malicious application can interpret code
rather than executing it directly. This can only be prevented by not
signing malicious applications.

When you talk about "staying below the radar" it implies that you're
talking about case 2, but the proposed solution is only a speed bump
rather than a blocker.
