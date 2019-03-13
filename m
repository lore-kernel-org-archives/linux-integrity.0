Return-Path: <SRS0=IrrW=RQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE78EC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB12146E
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cou1gjfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCMUga (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:36:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38702 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfCMUg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Mar 2019 16:36:29 -0400
Received: by mail-it1-f193.google.com with SMTP id k193so1029072ita.3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4crKjUx+aOe4UXmPV/hXAKJK5Y4MN8zFFDx/ITKQ0PA=;
        b=Cou1gjfn3V3Vpz0OlQwBZsSNWrmnOyFXNzFZ8nzjyppn8EHnPbhzFvm93p3m2k3E9o
         OszbDVF/yihHTsS7CUwuiflqsQWu0qQqJvM+wGE1FtlV6PSROf+9akdNoxrVkYkbvTfk
         FpsEgLNA3bbnP8m+W4gUm+bTXdgc7u3/scHUcswdNSHlvlQ4Sw5+yyhfQTssjGN0fcUv
         VrOQWqddw1SpdhxdzzPnogJllwowarOdmqzuiBVWFBaT26603E1fmIfVBQejXFVL0EII
         8Qx9pjfpGrtY34i4F8vvIXNaSGDIXJCIyqtPIwqyO28R0Lm/TXR14C66WEJK+Rz+Iv9j
         uCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4crKjUx+aOe4UXmPV/hXAKJK5Y4MN8zFFDx/ITKQ0PA=;
        b=QKyaQmGpeZTUuaPR9iJNmJIz8q3R2MKzz4qe/Ot4tMHP0k1dNMCewNkWhhCNUPLb3Q
         HF+r6Z//uW3XtgtufqXtLvYi5aTCT0AENh47NLb1BMqCDwSTdVhiGvzPYbHPO7oPDv/L
         wMXfawRPW9yCJfWnrywdTcoRfweuFAD+YWb5gJkakPUimu7YFsF3VvD8lPAYwBXKUxyG
         KpgJ0LEFMOhsc7qTU5RqyuLQ2ysPthD8Moi7hmJddkuDD8ekQJpRwunV2QYhLGFIyOCj
         nOTjbgUiYy2i+leY0CBPRqIQHzrXRMqw/Xa8alSqCqwpAzrkohWMfcizBZjMucSk8EIB
         ChxQ==
X-Gm-Message-State: APjAAAUCwYuuprFUteQrCbKTiLIGz4bjdHTccDDWUIkIUbKS7MYB8e2M
        Funs0i5Iu9GLaOaNxX3bk3AAzfayIVgRnkNwo7lVcAjf
X-Google-Smtp-Source: APXvYqzYVTvcXAQHuPstm5Hq4A9C+tSOj5wkms4DppfbEr62QPYt0aw0NBdI06yDvcaFC4RXOPpEku7Bn9E9Kk7J8dU=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr31323iti.161.1552509387711;
 Wed, 13 Mar 2019 13:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190312195715.101995-1-matthewgarrett@google.com> <1552478316.24794.210.camel@linux.ibm.com>
In-Reply-To: <1552478316.24794.210.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 13 Mar 2019 13:36:16 -0700
Message-ID: <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
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

On Wed, Mar 13, 2019 at 4:58 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-12 at 12:57 -0700, Matthew Garrett wrote:
> > Systems in lockdown mode should block the kexec of untrusted kernels.
> > For x86 and ARM we can ensure that a kernel is trustworthy by validating
> > a PE signature, but this isn't possible on other architectures. On those
> > platforms we can use IMA instead, either with native IMA digital
> > signatures or EVM-protected IMA hashes. Add a function to determine
> > whether IMA will verify signatures on kexec files, and if so permit
> > kexec_file() even if the kernel is otherwise locked down. This is
> > restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set in
> > order to prevent an attacker from loading additional keys at runtime.
>
> Thank you for working on this!  With the changes suggested below, it
> might work.  :)

Ok, I'll incorporate them - just one question:

> > +bool evm_key_loaded(void)
> >  {
> >       return (bool)(evm_initialized & EVM_KEY_MASK);
> >  }
>
> This might be sufficient for your environment, but in general it
> isn't.

Oh hm. The only case I can see where this isn't sufficient is if the
filesystem returns EOPNOTSUPP for the EVM xattr, but in that case we
should already have failed to get the IMA xattr and will fail
appraisal as a result?

> > +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
>
> With these defines, the function isn't limited to just "lockdown".
>  Either fix the defines or the patch description.

The function will be called even when lockdown isn't enabled, but it
won't have any impact on the logic flow.
