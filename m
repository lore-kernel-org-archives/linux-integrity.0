Return-Path: <SRS0=DQCd=P2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E5C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAAE2087E
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfARMHm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:07:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40675 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfARMHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jan 2019 07:07:42 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so5449842ita.5
        for <linux-integrity@vger.kernel.org>; Fri, 18 Jan 2019 04:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efRhbMu40jc01doE6dk+XxasVG9OQ61RtTN2y4dxMGQ=;
        b=rnkEHKrB5d8knxEKyt9YTeh7parBIKVh0QRuB7UuvGojzaG1nczlHLalmKk6QwGIdr
         MFt9+jYLjC98fPVAnr2LvpEyd4bCFv/pNNcbQZC3SXN1P34tXIWbpeg1K8ZUx3sV/OQc
         2Jcj44Pv11HkTp5HYztCBqZePfApP5cqTpH/0i2fSD0OURRgW15mTLSdA2jj4BwKuMPm
         nWPIgo6HzJHjZ8AlzQTYXnrrZzrIlvULUzb1kAS0WhJSz9JAm04pw58JyPwBRyywrmcp
         RW4w/nvy00G8bEZpHAy9hxrkPE00jVE5LrcRmig+RJCmQstkyeN0+a4QO0nDa2W8TEAK
         /Msg==
X-Gm-Message-State: AJcUukdAa4vAQjnNXJ12B5HeAI5P0FIK4Dak4k6pIiO0lpN/xh/mTn/C
        O7EQF60dDqLGQSAGTwuXOfjwWu6sfDzHqWsmH44j2w==
X-Google-Smtp-Source: ALg8bN5J65+Ihu7aY1kAKgQaZTBLwQP8ulIODQPgSeQYaurblGVCeTIyGO6GDKFds4RlkK7pIFec9pyqEmYV94riBWc=
X-Received: by 2002:a24:4d05:: with SMTP id l5mr2029393itb.147.1547813261576;
 Fri, 18 Jan 2019 04:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20190118091733.29940-1-kasong@redhat.com> <1547812432.3982.55.camel@linux.ibm.com>
In-Reply-To: <1547812432.3982.55.camel@linux.ibm.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 20:07:30 +0800
Message-ID: <CACPcB9ffvpHbGdp5xz4R5cwXxERsVwzkQEKO9C50c+_hj+n_0g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 18, 2019, 19:54 Mimi Zohar <zohar@linux.ibm.com wrote:
>
> On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component could
> > use this keyring as well.
>
> Kairui, when people review patches, the comments could be specific,
> but are normally generic.  My review included a couple of generic
> suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> term "preboot" keys, and remove any references to "other components".
>
> After all the wording suggestions I've made, you are still saying, "So
> other components could use this keyring as well".  Really?!  How the
> platform keyring will be used in the future, is up to you and others
> to convince Linus.  At least for now, please limit its usage to
> verifying the PE signed kernel image.  If this patch set needs to be
> reposted, please remove all references to "other components".
>
> Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> Acked the original post.  Can I include it?  Can we get some
> additional Ack's on these patches?
>
> thanks!
>
> Mimi
>

Hi, Mimi, thanks for your feedback. My bad I reused the old cover
letter without checking it carefully, hopefully, the commit messages
should have a proper wording now. If the cover letter needs to be
updated I can resend the patch, let me just hold a while before update
again.
