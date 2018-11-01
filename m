Return-Path: <SRS0=DPN/=NM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB5C0044C
	for <linux-integrity@archiver.kernel.org>; Thu,  1 Nov 2018 03:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF7220821
	for <linux-integrity@archiver.kernel.org>; Thu,  1 Nov 2018 03:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnTIdqoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF7220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKAMhU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:37:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34560 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKAMhU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Nov 2018 08:37:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id v199-v6so7394181ywg.1
        for <linux-integrity@vger.kernel.org>; Wed, 31 Oct 2018 20:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zamWPB7Zrsbk1HU+g6DyYhjI1LOLXffcsrjOS1cfmoc=;
        b=cnTIdqoVbcehNhb9FKMitRDNdejZO0Uh4fHM64GEX5NlGgV/K5FQMWArwEJN8bWFnU
         yjVdKN2oGs+Fl4ZFjEZR0f48ZsnrB0TnFnAapbuRW3YuhENboxof8QwfUdgneZQ6xT0n
         mPwb4THqjBtZ6Wm7eNfxvBNDmeQla1kSlCmV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zamWPB7Zrsbk1HU+g6DyYhjI1LOLXffcsrjOS1cfmoc=;
        b=KNKE2kR0xVpVhF2l0YhYMtvGi5pUXZrwTXz3BTdWXRVXlw0lJB37qA3VWT9f6CgL24
         3Le4it4ZaXupQcYSUjXl5GsRywu9GPXhe/WRzaI3wqjZhiLNqjqfe7QeeIBtjNrvfUKC
         vpTfPDIJU/pvL7l7m3IH8ZLYVNWMXs9rm2iAhS+Jsa0LNguZXkRCfbJ9F41HRaFuZyxR
         QOtZDVsSrpHGAkwkFchP1OqyHUz3Vnicn2hoJMTB4vYOhrDEaErksTCQIZXjZ6NzskrW
         Ba6AEZvjnkTJRc3StWjIh9ptCk669T6hzC4MBPaDUoLsYTlXPi1YmbvCz++YCgz2iGmN
         aS8Q==
X-Gm-Message-State: AGRZ1gKLRk9jaPugqMPtV9QlnMbvGUzOgWDDDKx/vny4eKEHeSr9Q7GU
        pTeRUpvs2Jx231VPTaKCqSJ9kZYBgnw=
X-Google-Smtp-Source: AJdET5dIL5yLukELbh+iNWxDYxR/vPE17v6Y4H9Jkc8dLNjwQPsHmhG1qSyNMq87Wtu7tFgk+7a3zw==
X-Received: by 2002:a81:6c12:: with SMTP id h18-v6mr5836829ywc.116.1541043372282;
        Wed, 31 Oct 2018 20:36:12 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i189-v6sm5594645ywb.23.2018.10.31.20.36.11
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 20:36:12 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id k132-v6so7584461ybc.2
        for <linux-integrity@vger.kernel.org>; Wed, 31 Oct 2018 20:36:11 -0700 (PDT)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr5969887ybc.403.1541042915047;
 Wed, 31 Oct 2018 20:28:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 20:28:33
 -0700 (PDT)
In-Reply-To: <20181031091048.GH744@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com> <20181025001312.GA3159@worktop.c.hoisthospitality.com>
 <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com> <20181030155841.GF8177@hirez.programming.kicks-ass.net>
 <20181030162815.GB20827@arm.com> <20181031091048.GH744@hirez.programming.kicks-ass.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 31 Oct 2018 20:28:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKmhoSsOTqDJmr3ijwDAh57Bfq3KVE+AjrBdLXjPz83+g@mail.gmail.com>
Message-ID: <CAGXu5jKmhoSsOTqDJmr3ijwDAh57Bfq3KVE+AjrBdLXjPz83+g@mail.gmail.com>
Subject: Re: [PATCH 16/17] prmem: pratomic-long
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 31, 2018 at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 30, 2018 at 04:28:16PM +0000, Will Deacon wrote:
>> On Tue, Oct 30, 2018 at 04:58:41PM +0100, Peter Zijlstra wrote:
>> > Like mentioned elsewhere; if you do write_enable() + write_disable()
>> > thingies, it all becomes:
>> >
>> >     write_enable();
>> >     atomic_foo(&bar);
>> >     write_disable();
>> >
>> > No magic gunk infested duplication at all. Of course, ideally you'd then
>> > teach objtool about this (or a GCC plugin I suppose) to ensure any
>> > enable reached a disable.
>>
>> Isn't the issue here that we don't want to change the page tables for the
>> mapping of &bar, but instead want to create a temporary writable alias
>> at a random virtual address?
>>
>> So you'd want:
>>
>>       wbar = write_enable(&bar);
>>       atomic_foo(wbar);
>>       write_disable(wbar);
>>
>> which is probably better expressed as a map/unmap API. I suspect this
>> would also be the only way to do things for cmpxchg() loops, where you
>> want to create the mapping outside of the loop to minimise your time in
>> the critical section.
>
> Ah, so I was thikning that the altnerative mm would have stuff in the
> same location, just RW instead of RO.

I was hoping for the same location too. That allows use to use a gcc
plugin to mark, say, function pointer tables, as read-only, and
annotate their rare updates with write_rare() without any
recalculation.

-Kees

-- 
Kees Cook
