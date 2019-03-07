Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D6AC43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ECE205C9
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551988953;
	bh=ByUaQCKcKzv0my0lmiYVV9zvCyXBm/O9YGbgtfnaDvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YK2mSBDOMyW3s5mpBfGcDJDyODYJSyXakkPcWdVkXW2DOYUrlw70hszhfdEbxMsyI
	 8oNPE3Vtz/SwcHrtTlLAH7Vdrdw1gzegjTLG9vy4pN8mYlfleHTAiT8GtPZTWAKq4W
	 C74+lDBuTcJ+7j+W5LhxVPGlurMRIqw8UTK+OmOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGUC2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfCGUC1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 15:02:27 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FA221734
        for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2019 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551988947;
        bh=ByUaQCKcKzv0my0lmiYVV9zvCyXBm/O9YGbgtfnaDvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tTFLaAHECFfxDolaR23hDB2kmjcvn/kwdGL6DWJvgrOCCnng15NrIa4ETVGGiDpTl
         92bC9dj1aPOcqBZSzqUnsoLwCLH9DXXvITw5oxI2jKQKokQ+ZkZX8Q0LUN9RTJwXyl
         jkiDCh5RtqqFWgob3IG2xUg2yo+UhXACDTUS41kY=
Received: by mail-wr1-f52.google.com with SMTP id w6so18911749wrs.4
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2019 12:02:26 -0800 (PST)
X-Gm-Message-State: APjAAAUJq4EagcM67qjmpQMbvGBfks5lcj45aMfP7X4KSvqSUukf8hIp
        QKwo4+1EMt0YxM0JLvgLeKhXRs24sfDjQsPqB5eJkg==
X-Google-Smtp-Source: APXvYqw3g/bjVvCO+9Bw1hS8eEdLNpbnvEVJFQDTTx8I2hr0gL3KUzv9tqSod6Zis4j0iPJYm08yWKgMMeSEtA7SRpA=
X-Received: by 2002:adf:e58f:: with SMTP id l15mr7917047wrm.309.1551988945061;
 Thu, 07 Mar 2019 12:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic> <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic> <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
 <20190211191059.GR19618@zn.tnic> <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com>
 <20190211194251.GS19618@zn.tnic> <20190307072947.GA26566@zn.tnic>
 <EF5F87D9-EA7B-4F92-81C4-329A89EEADFA@zytor.com> <20190307170629.GG26566@zn.tnic>
In-Reply-To: <20190307170629.GG26566@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Mar 2019 12:02:13 -0800
X-Gmail-Original-Message-ID: <CALCETrUY6L_Fwd9CZzo2eZL8HT2sBSHFiD-Bp-HCPPFBxkzcdA@mail.gmail.com>
Message-ID: <CALCETrUY6L_Fwd9CZzo2eZL8HT2sBSHFiD-Bp-HCPPFBxkzcdA@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules loading
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 7, 2019 at 9:06 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 07, 2019 at 08:53:34AM -0800, hpa@zytor.com wrote:
> > If we *do*, what is the issue here? Although boot_cpu_has() isn't
> > slow (it should in general be possible to reduce to one testb
> > instruction followed by a conditional jump) it seems that "avoiding an
> > alternatives slot" *should* be a *very* weak reason, and seems to me
> > to look like papering over some other problem.
>
> Forget the current thread: this is simply trying to document when to use
> static_cpu_has() and when to use boot_cpu_has(). I get asked about it at
> least once a month.
>
> And then it is replacing clear slow paths using static_cpu_has() with
> boot_cpu_has() because there's purely no need to patch there. And having
> a RIP-relative MOV and a JMP is good enough for slow paths.
>

Should we maybe rename these functions?  static_cpu_has() is at least
reasonably obvious.  But cpu_feature_enabled() is different for
reasons I've never understood, and boot_cpu_has() is IMO terribly
named.  It's not about the boot cpu -- it's about doing the same thing
but with less bloat and less performance.

(And can we maybe collapse cpu_feature_enabled() and static_cpu_has()
into the same function?)

--Andy
