Return-Path: <SRS0=3Dhz=SE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE253C10F0B
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 21:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8246120857
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgxH1p9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfDBVv0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:51:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34264 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBVv0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Apr 2019 17:51:26 -0400
Received: by mail-it1-f195.google.com with SMTP id z17so3820492itc.1
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2019 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xywp59diGGhpDkbiKwDy1z/p41TsJGCT04l9clYa/bw=;
        b=cgxH1p9hR+Q06JJs5kFBfM9Kyh5DPamsWYdVF0dOKK8prPxsq3lgTyOaY7YDCicOWA
         T488n5X1XcxSkrl0ukEtFGi+xPCJQJyQHBue/DNa1uXTEPoo05oAgpFuei/QDfJRCyyq
         t9FsqC7+HgEDi1sT636+7YZnoy1JpZ8TDmu9iXyxMUkDuvo0s1RZ5ru4csy0g0f4k5iM
         1AiLgmJZKN3SfNQfXEKMjmbVvFqsV7CZbF3SmMx+eU2XvavP0JM/EG2NUI4gg/T7HG8G
         2gQW9vzgCcSihzMmWJL2dvHpG7HP2BzimvQN5myrNc1Xjq2n2r95Ar8Uhu0gPOdX+nfZ
         ewhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xywp59diGGhpDkbiKwDy1z/p41TsJGCT04l9clYa/bw=;
        b=cu0LmSJwmkhTr382P9jmQfugFB+FPU9DB7YJ9SR5Bcu7ppfy+DgI8uZsPs1oB8fDD2
         hsnoMR9QysQB23I0FOkuU+wpGbXTm5hRUKAS76+S5ayuwpcJ0wvsKQ0fXoP8lyiGY0Gs
         8RJrmxhNgSGldfUXrqeV4naIxHsJluhGO/s8SzK2cLafjp1D3gs9z7TTA6nr7LYhckmA
         whWPpqyqZi02WoLXRcLALokXNWlALrdy4sbz2LDWb8IiyEFyxQsQbEPnlSAcQWF7BqG8
         CSFIV4P3n031KQ4CzuL+jBuNZL86Tu10Id1sY+a+BodADuOQA4dUr/y2pqZZv1HJFswz
         IEXg==
X-Gm-Message-State: APjAAAV31RMzZ/K3y3yMXkGE8hTYAY0v4Gl1JI8ZiQ5QbrLHncdILt2X
        88cnhHIb0KsrUVUb4hB4YP/67Y+Bxc/rDfi/vpfD7A==
X-Google-Smtp-Source: APXvYqwVbk00Uxfr2Ccq7oUAtn2vcYmrClo21irGD94orTqlL5kNd4RQPDNFpoHH/oLVy0nmdWbZDpwKN1y9YP7iqxk=
X-Received: by 2002:a24:7294:: with SMTP id x142mr6230609itc.7.1554241885398;
 Tue, 02 Apr 2019 14:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com> <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
In-Reply-To: <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 2 Apr 2019 14:51:14 -0700
Message-ID: <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To:     Claudio Carvalho <cclaudio@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 2, 2019 at 2:11 PM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
> We want to use the efivarfs for compatibility with existing userspace
> tools. We will track and match any EFI changes that affect us.

So you implement the full PK/KEK/db/dbx/dbt infrastructure, and
updates are signed in the same way?

> Our use case is restricted to secure boot - this is not going to be a
> general purpose EFI variable implementation.

In that case we might be better off with a generic interface for this
purpose that we can expose on all platforms that implement a secure
boot key hierarchy. Having an efivarfs that doesn't allow the creation
of arbitrary attributes may break other existing userland
expectations.
