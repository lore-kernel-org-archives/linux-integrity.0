Return-Path: <SRS0=83sA=NK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A6EECDE44
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Oct 2018 19:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEF62081B
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Oct 2018 19:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="js+vjHyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEF62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeJaEJl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:09:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44044 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeJaEJk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Oct 2018 00:09:40 -0400
Received: by mail-yw1-f65.google.com with SMTP id k6-v6so1026596ywa.11
        for <linux-integrity@vger.kernel.org>; Tue, 30 Oct 2018 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=snsTm8fAPGUfSdsnB6UIfUoFWMS1wWtbb4pqgSay4sA=;
        b=js+vjHyiVy7gKOcR4aV8aB6qbFEHm1tQBHbY/tnoGr1sJ0IsCxOkyAi588iqVgxxTD
         TmOGu3y1E6hYb+duMhWiN6w6UUykrHTIDJoGIUwZJUO/JjkT8puHgjty3vDuJLXFlBqB
         K/j7WHf8RIxqYMxXPYrBZLJd7iQ6TARKKl9ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=snsTm8fAPGUfSdsnB6UIfUoFWMS1wWtbb4pqgSay4sA=;
        b=s3W4XH7giu8qZi6KKiIIjjjaRMagXgAZa7ZS4flg+/FXLvpiAC/MUqe/fmInEyit24
         SmTPDftiDHnEthCfLzC5Wytrirl6Cj+fHghBPQdwKB+zF3zK3ZwHL/P49SvynlJ5IB00
         3ASmRidJSW7kIcCiPpHpHggQPFLvV3H+fPjTxc+k1QpejA23ZfVp6xmQTlG61W0o8eS1
         94abcvuPeaTkB9NmOowjdbBWcIMhD5ZRuNohlYfo9GCrtdVA5h8Y/iKMLubjxR8R2PxD
         tqhG05ApuW5mBnilWwcitHqyYIIhSthvYd6rAegCeboL+LIUQous7hJ6IyFxUod9sCQL
         lV4w==
X-Gm-Message-State: AGRZ1gJN4U2vU3/g5Xf70RF/W4uI9DBb5aVvIJtV7JSYcSqHD+VzLNiB
        tbEaIQ6xN5gI77jTkhK2ryagE2mAaLc=
X-Google-Smtp-Source: AJdET5fhSe6rLKg0/Unlas0z0SzTH5f1ifppJ2LhINbEYI16TU4uLj1tWT07tL+VoLqf4JWczLh8PQ==
X-Received: by 2002:a0d:ce42:: with SMTP id q63-v6mr3946581ywd.369.1540926896315;
        Tue, 30 Oct 2018 12:14:56 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id f203-v6sm1362560ywa.45.2018.10.30.12.14.52
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 12:14:54 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id d126-v6so5402336ywa.5
        for <linux-integrity@vger.kernel.org>; Tue, 30 Oct 2018 12:14:52 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr3973873ywg.353.1540926891605;
 Tue, 30 Oct 2018 12:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 12:14:50
 -0700 (PDT)
In-Reply-To: <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 12:14:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK583zi9NPP2hwm51z6FbF2kkr5Em61eSp3EnwYFnKZEw@mail.gmail.com>
Message-ID: <CAGXu5jK583zi9NPP2hwm51z6FbF2kkr5Em61eSp3EnwYFnKZEw@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 30, 2018 at 11:51 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Oct 30, 2018, at 10:58 AM, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
>>>> On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
>>> I support the addition of a rare-write mechanism to the upstream kernel.
>>> And I think that there is only one sane way to implement it: using an
>>> mm_struct. That mm_struct, just like any sane mm_struct, should only
>>> differ from init_mm in that it has extra mappings in the *user* region.
>>
>> I'd like to understand this approach a little better.  In a syscall path,
>> we run with the user task's mm.  What you're proposing is that when we
>> want to modify rare data, we switch to rare_mm which contains a
>> writable mapping to all the kernel data which is rare-write.
>>
>> So the API might look something like this:
>>
>>    void *p = rare_alloc(...);    /* writable pointer */
>>    p->a = x;
>>    q = rare_protect(p);        /* read-only pointer */
>>
>> To subsequently modify q,
>>
>>    p = rare_modify(q);
>>    q->a = y;
>>    rare_protect(p);
>
> How about:
>
> rare_write(&q->a, y);
>
> Or, for big writes:
>
> rare_write_copy(&q, local_q);
>
> This avoids a whole ton of issues.  In practice, actually running with a special mm requires preemption disabled as well as some other stuff, which Nadav carefully dealt with.

This is what I had before, yes:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d

It just needs the switch_mm() backend.

-- 
Kees Cook
