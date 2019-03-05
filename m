Return-Path: <SRS0=PR+Z=RI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEEC00319
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80B220842
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 20:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8cEvvJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCEU1y (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:27:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38265 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEU1x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Mar 2019 15:27:53 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so6587190itg.3
        for <linux-integrity@vger.kernel.org>; Tue, 05 Mar 2019 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drtt/almuFEK3nbHXAGU2RGVXx1Kj8zsT++EapVE3dg=;
        b=k8cEvvJtatlK5AUMz8lI79FjBbXtQ9NYP8TKoxWIaxRv8hl+rl11M5QOAtP9LOu5aq
         e11vOJLACqGl+myDvMck1+LIpcMMWRRkYRsyl6nvGeCDpRYAqSTLBtt706myHRigUIBa
         PO5PuT5ffjK/zEtz24uBVp39704L71zT1gkrbo2Aj/UnjfBXGjfcrJ/BNrxT8UKKtKVX
         Nx/9PxcD6pYzOZZQHN8NNlBXPJA93dzqBC6ZhlK95KBrxZsbSe8Arb8nzRtzcWAOVtNE
         5jVKYmG0gtQK1qqsvTdgA8rtotSJQXKYog0uWfQAgBaRdKeW1AM6AiFRmmAdLKyFz3QZ
         xVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drtt/almuFEK3nbHXAGU2RGVXx1Kj8zsT++EapVE3dg=;
        b=DoRznbi3KRcR2MM4/Xpa5u0NL2QMDc64merh1xL+pbTHWDfjQ6uUW4N0xxHOwDRius
         wiIbaMRsd7sJWF6qOCtRWqWd6q2suZDhCMgkC90FxK5Qs8PsN3ccqJ1NLy+i6AI9u300
         RI6hKeE5JWciLRk/jLlvqD2oV1zrcy2Vuv/pR1Jc0U1qecEINQxLKu6BqDNkRe7TEjIn
         UQgP0b8GAgVeE/5Nxoa/0oN7SPmjNr7Yioif97vA5lesKD4ayjLl06IS/2cjM//RHPV0
         6xqUVgFtaKIidbhwHujkSuElfnm7Bqr300U5y0RgnmxCd7YWD3TuHkU+LaMCzzoCPZa7
         IcAQ==
X-Gm-Message-State: APjAAAXfvVLKu9KG9e30zq0o5DnWrnigLWZ+2+VHS2JNHPa9Iqh4kpbd
        H4NlDRt9qtbLi4hr+2i0ZkMkg0A3FqPqhq6ujTI70w==
X-Google-Smtp-Source: APXvYqzCnZ0bGtMcZEua66izMDuAM7lSYBjvat/WFeU9JTcgHtAtdugZxIhig+Jg5LoYgH/BVgbpQEgjXjXVJToJCFE=
X-Received: by 2002:a24:7908:: with SMTP id z8mr135640itc.16.1551817672137;
 Tue, 05 Mar 2019 12:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com>
In-Reply-To: <1551815469.31706.132.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 5 Mar 2019 12:27:41 -0800
Message-ID: <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 5, 2019 at 11:51 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Tue, 2019-03-05 at 10:39 -0800, Matthew Garrett wrote:
> > We can trust in-kernel filesystems to return reliable information.
> > Network filesystems have the same issue as FUSE - we're trusting that
> > the remote endpoint won't give us different information on successive
> > reads. What's the threat that's blocked by requiring signed policy
> > here?
>
> Today, IMA calculates the file hash by reading the file.  If
> "get_hash" is a generic filesystem ops, then any filesystem could
> implement it, properly or not.  sysadmins shouldn't have to review
> kernel code to understand the source of the file hash, but should be
> able to assume that unless they explicitly authorize "get_hash" usage,
> IMA reads the file and calculates the file hash.

But what's the threat? If an attacker is in a position to inject
additional IMA policy then in general they're already in a position to
violate other security assumptions. Admins who have a threat model
that includes an attacker being able to do this are already requiring
signed policy. What's the threat that requiring signed policy for this
specific option mitigates?
