Return-Path: <SRS0=OrKi=PZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2606C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 20:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B2B20868
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547758074;
	bh=n8JMekFCbtwr62FzDCJJoj5l06UUzHpxnzcg5AUI7TM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZGEyFw92o2Tyv9niN1pDiRP951GMSimQSeYo+XPGu85GZQ96hW1migIcpIkeJT9/Y
	 66RongugxiBW/wLSuzfKe3jLI1A216ce6q6b3Kol3VvFkiZTtYoctCTM91L1vvuZXN
	 SNZ6RhdJ6TV51j4fDdPgfvXXryL6PeiRe18we3n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAQUrx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfAQUrw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jan 2019 15:47:52 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614722086D
        for <linux-integrity@vger.kernel.org>; Thu, 17 Jan 2019 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547758070;
        bh=n8JMekFCbtwr62FzDCJJoj5l06UUzHpxnzcg5AUI7TM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1v/yNJqBMgzweIaFgEWtP2lvGXeclrXJB1t0pXSbhZgFbyyQjphalnJPKjN1b7XGp
         8qNqL7JXfylXL1R7pc0XXdlb1KZGx/cZBFV5Up9Dgj4W8zDq2uH0g8kHugPIVJxxv3
         zqQmR8daNSixtMx2XuYELmKrlF860GrbRVCRB0Yo=
Received: by mail-wm1-f51.google.com with SMTP id y8so2480007wmi.4
        for <linux-integrity@vger.kernel.org>; Thu, 17 Jan 2019 12:47:50 -0800 (PST)
X-Gm-Message-State: AJcUukfhDsUFb7zc60AOCR7utMR2VPfSbO8OD8o8izQM4bGbftnPx9Hy
        m6MBPyAr1CNmz6PocFyqchKKods0Z6SUB96cO3RXeQ==
X-Google-Smtp-Source: ALg8bN4vqTfkkxsexP5RbKOvuJorBZi95A0P8/TrT41r99XTtUzScb+36zH48d5duGJlj85urGEm4ZA5aAqFumiCqsY=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr13844935wmf.32.1547758068833;
 Thu, 17 Jan 2019 12:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-7-rick.p.edgecombe@intel.com> <CALCETrUMAsXoZogEJg7ssv0CO56vzBV2C7VotmWcwNM7iH9Wqw@mail.gmail.com>
In-Reply-To: <CALCETrUMAsXoZogEJg7ssv0CO56vzBV2C7VotmWcwNM7iH9Wqw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 17 Jan 2019 12:47:37 -0800
X-Gmail-Original-Message-ID: <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com>
Message-ID: <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com>
Subject: Re: [PATCH 06/17] x86/alternative: use temporary mm for text poking
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 17, 2019 at 12:27 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jan 16, 2019 at 4:33 PM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> >
> > From: Nadav Amit <namit@vmware.com>
> >
> > text_poke() can potentially compromise the security as it sets temporary
> > PTEs in the fixmap. These PTEs might be used to rewrite the kernel code
> > from other cores accidentally or maliciously, if an attacker gains the
> > ability to write onto kernel memory.
>
> i think this may be sufficient, but barely.
>
> > +       pte_clear(poking_mm, poking_addr, ptep);
> > +
> > +       /*
> > +        * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> > +        * as it also flushes the corresponding "user" address spaces, which
> > +        * does not exist.
> > +        *
> > +        * Poking, however, is already very inefficient since it does not try to
> > +        * batch updates, so we ignore this problem for the time being.
> > +        *
> > +        * Since the PTEs do not exist in other kernel address-spaces, we do
> > +        * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> > +        * more unwarranted TLB flushes.
> > +        *
> > +        * There is a slight anomaly here: the PTE is a supervisor-only and
> > +        * (potentially) global and we use __flush_tlb_one_user() but this
> > +        * should be fine.
> > +        */
> > +       __flush_tlb_one_user(poking_addr);
> > +       if (cross_page_boundary) {
> > +               pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
> > +               __flush_tlb_one_user(poking_addr + PAGE_SIZE);
> > +       }
>
> In principle, another CPU could still have the old translation.  Your
> mutex probably makes this impossible, but it makes me nervous.
> Ideally you'd use flush_tlb_mm_range(), but I guess you can't do that
> with IRQs off.  Hmm.  I think you should add an inc_mm_tlb_gen() here.
> Arguably, if you did that, you could omit the flushes, but maybe
> that's silly.
>
> If we start getting new users of use_temporary_mm(), we should give
> some serious thought to the SMP semantics.
>
> Also, you're using PAGE_KERNEL.  Please tell me that the global bit
> isn't set in there.
>

Much better solution: do unuse_temporary_mm() and *then*
flush_tlb_mm_range().  This is entirely non-sketchy and should be just
about optimal, too.

--Andy
