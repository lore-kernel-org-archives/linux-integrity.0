Return-Path: <SRS0=MdHQ=RR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA0C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454DF21873
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 22:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRpgTJ9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCNWyg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:54:36 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:39478 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfCNWyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Mar 2019 18:54:36 -0400
Received: by mail-io1-f49.google.com with SMTP id x3so6640183ior.6
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d3h8wtCLOAk/Ubm+A8J6qJfMiMVZW9lcuTKBnxwlpw=;
        b=eRpgTJ9y2bE1jRBV7yIaEbBtJ3cIzZ9fu8MivOW5iWHHqXuxbckGf/900MQlzcxYnk
         37wlOfPoYbh057UDMWs8RFBn/WT0HEoZwT4VtiMy5XkvaS9ZFt/5xk4Lj4vrVQUieQH0
         gnRp2jlNkNSSZCE9orsm4CfG+aeXkjITsANX2rBaj8+Q969SSEJZB5ETqcuJ6WiU2uKl
         8hDp6sgj0gVN9zQtJ9EpZKPVJXWTS4M/vnZdxE5X+WFEm7l9vLqtWY4cG3GTR4DUgws6
         rdKa+0mHth606DIwBeuxpNniGM8lNRl4KIYAXJ4pERhm7CdX4DO3sBHvnttQwe9DKTJX
         sAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d3h8wtCLOAk/Ubm+A8J6qJfMiMVZW9lcuTKBnxwlpw=;
        b=lK4Wrg10sS9zDkeKKmcHu5RfwYk/AklWY64cekP51lK7/0kCbeLJobP+NM1fJcIrxa
         6G5Xk7dvVGEz0th97teWIu8KOy2QMBMqiDwk/AuCCJXNAJ3QnYbuqFBMqwJ6ZVW4/pol
         ghU/nZL0GT/mRvIi/xSf+8L60hMo1X2mAR0O4zJJlV2NyqFeA7Fh3oqoNFjGYgXzFKMr
         JafNY9rwka5nwHJZ1Lsa8f86+kYxDb1tY7aiPL1E9w0n+8BY1iLL4ViDOfJUxw5h3M6P
         I+voaNmc7upwb2OqQYbiqTvmtMaiuagugroM0SDLvy0QfXj4+Zkkg8/ZKC6BcxT6ZeQi
         lgHA==
X-Gm-Message-State: APjAAAVt1u1JQG0+fZheD9+AkpUA6fO8t9OWx3z4hksZyLYH/fSfqVTQ
        p/v6KTvypZsldmRZgY1pXO4IGvmW9dMCnZe087UCng==
X-Google-Smtp-Source: APXvYqzsOhyvnyni7vNy54CjQDAXKIM/8ZnadfeSmfDN/NV4fND/hldC0xGj9omzMyBqrJi60tgLELEzwXbU1R7kmIY=
X-Received: by 2002:a6b:e509:: with SMTP id y9mr307997ioc.169.1552604074701;
 Thu, 14 Mar 2019 15:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190312195715.101995-1-matthewgarrett@google.com>
 <1552478316.24794.210.camel@linux.ibm.com> <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
 <1552512556.24794.229.camel@linux.ibm.com> <CACdnJutmJDLhrdsU9UZtzE+S=Tw39RYqZ3q+TP35PbFbfsL76w@mail.gmail.com>
 <1552525698.24794.237.camel@linux.ibm.com> <CACdnJuv=-Gr9Psd1ABZ=fW43-2FHcgEkG_iu0bY20Jx4Vro=mA@mail.gmail.com>
 <1552602691.8658.49.camel@linux.ibm.com>
In-Reply-To: <1552602691.8658.49.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 14 Mar 2019 15:54:23 -0700
Message-ID: <CACdnJuuySXLON5=m9VCqAsv+-wQnZQKRi0=SRpbTiRbhuCOq4g@mail.gmail.com>
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy when
 locked down
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 14, 2019 at 3:31 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-03-14 at 14:08 -0700, Matthew Garrett wrote:
> > On Wed, Mar 13, 2019 at 6:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > The IMA hash and EVM hmac combination is fine for offline protection.
> > > It's used for mutable files.  For immutable files, there must be
> > > either an IMA or EVM signature.
> >
> > Ok. Is the correct way to handle this to check that the file has a
> > signature, or to extend IMA policy to allow it to provide a
> > requirement that EVM verify a signature rather than an HMAC and have
> > the arch policy set that?
>
> I'm not sure what you mean by "check that the file has a signature".

Call getxattr(XATTR_SECURITY_EVM) and parse the type to determine
whether it's an hmac or a signature.

> EVM and IMA are separate subsystems with a defined interface for
> interaction between them. evm_verifyxattr() isn't, but could be called
> by LSMs.  So evm_verifyxattr() would need to be extended to return the
> EVM xattr type.  The IMA policy could then require a specific evmxattr
> type.  Possible.

I'd been thinking of doing it the other way (ie, pass the set of
permitted EVM xattr types to evm_verifyxattr()), but yes.

> Perhaps for now require IMA signatures and defer supporting EVM
> signatures?

If that's sufficient for you, happy to do that.
