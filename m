Return-Path: <SRS0=Hy7N=O6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 21 Dec 2018 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE6218E0
	for <linux-integrity@archiver.kernel.org>; Fri, 21 Dec 2018 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545412998;
	bh=jKlCDnEG+8eNj0q1jYLDJIR9NUvNXj14/UuskFSxAH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v1bR3xGlVPafUyTIGCvTFt24Y+XT3QKyo6o/gn7Eznmum7JVk454sW0WAW+Ddy21R
	 CWNopBxd6fmeFPdyrR3GXXApi/GeHuzveX1eeIPoCu5PpfN44bQUs/kkigrT4CM58J
	 etdR+top7Kca/yZP+d6LXQ6CoJACAiuq9ZtSwTio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbeLURXR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeLURXR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Dec 2018 12:23:17 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F5B218E0
        for <linux-integrity@vger.kernel.org>; Fri, 21 Dec 2018 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545412996;
        bh=jKlCDnEG+8eNj0q1jYLDJIR9NUvNXj14/UuskFSxAH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qupI2FB2kuvsXIyc8X4o4XB7y15ipKkI5IEOVxtAj2G+936cBkM3nIgyyPB/lPBao
         uxvjk6ic87RhrixSSe4ViSpCG9JVY9EacyG80dfHX7ek70UMrFNJ/i6sY4Kb3EZ2ho
         TsFbfTZuE+5lZIuCU/usZXgLLwW+fA/mHZUb2VFk=
Received: by mail-wr1-f43.google.com with SMTP id j2so6068588wrw.1
        for <linux-integrity@vger.kernel.org>; Fri, 21 Dec 2018 09:23:16 -0800 (PST)
X-Gm-Message-State: AJcUukd2Sorj8+DmhTlw/EJFr38qGyDMqY+1GSwXcbv4JwgYgKyNx7D8
        sbPbVJ1QlOot0lymeI48zmZSocp6HiKJq08gxili0Q==
X-Google-Smtp-Source: ALg8bN4ZeYqGNHdVpM5COhY8QbAZi4KnB5P1xxPYCQosYXFPL+mGjLqrDWqtR1riWc3f9WTtxgN5Gnu43nCemvgjmu4=
X-Received: by 2002:adf:8323:: with SMTP id 32mr3357864wrd.176.1545412994785;
 Fri, 21 Dec 2018 09:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com> <20181220184917.GY10600@bombadil.infradead.org>
 <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
In-Reply-To: <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Dec 2018 09:23:03 -0800
X-Gmail-Original-Message-ID: <CALCETrU8GZbF2oWYeKUVKBURuh1zeMqcHM5RMTchiDsdrSSVPA@mail.gmail.com>
Message-ID: <CALCETrU8GZbF2oWYeKUVKBURuh1zeMqcHM5RMTchiDsdrSSVPA@mail.gmail.com>
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 20, 2018 at 11:19 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
>
>
> On 20/12/2018 20:49, Matthew Wilcox wrote:
>
> > I think you're causing yourself more headaches by implementing this "op"
> > function.
>
> I probably misinterpreted the initial criticism on my first patchset,
> about duplication. Somehow, I'm still thinking to the endgame of having
> higher-level functions, like list management.
>
> > Here's some generic code:
>
> thank you, I have one question, below
>
> > void *wr_memcpy(void *dst, void *src, unsigned int len)
> > {
> >       wr_state_t wr_state;
> >       void *wr_poking_addr = __wr_addr(dst);
> >
> >       local_irq_disable();
> >       wr_enable(&wr_state);
> >       __wr_memcpy(wr_poking_addr, src, len);
>
> Is __wraddr() invoked inside wm_memcpy() instead of being invoked
> privately within __wr_memcpy() because the code is generic, or is there
> some other reason?
>
> >       wr_disable(&wr_state);
> >       local_irq_enable();
> >
> >       return dst;
> > }
> >
> > Now, x86 can define appropriate macros and functions to use the temporary_mm
> > functionality, and other architectures can do what makes sense to them.
> >

I suspect that most architectures will want to do this exactly like
x86, though, but sure, it could be restructured like this.

On x86, I *think* that __wr_memcpy() will want to special-case len ==
1, 2, 4, and (on 64-bit) 8 byte writes to keep them atomic. i'm
guessing this is the same on most or all architectures.

>
> --
> igor
