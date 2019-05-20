Return-Path: <SRS0=g5fc=TU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0BBC04AAC
	for <linux-integrity@archiver.kernel.org>; Mon, 20 May 2019 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345A82171F
	for <linux-integrity@archiver.kernel.org>; Mon, 20 May 2019 20:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URsGLiTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfETU7l (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 May 2019 16:59:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39881 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETU7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 16:59:41 -0400
Received: by mail-it1-f193.google.com with SMTP id 9so1274343itf.4
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDbtrkAn+1X/+6QAPGA7azScNJ8+AfBKHdkpeyBfaAs=;
        b=URsGLiTS87uMxjVortgbvlWNpWU1BKAlnTtN6iqJokKOYobND8XdHNJd37JypSqXx8
         6kVbW6mvNu63+SGe4gcIMu0d85gebGUfzQNr8T0Ttry1EbjqpIFlCumGBD5BP0vxUFCY
         5AS5yL477wJgd0A2pVp6NZI3xtkwmD4ETIj2baBBiN+qUbj+RUuPSgWFdWgkClsfTe6N
         zDGLP46vd+hZrcO/y+C1M+sUsLvM11nRg3ZRQaYN3umZjt+qoPXElhSITYSMjL6UcQUm
         fzh+aZ07YmHQQ+n4VDoMAWyc5OK+sUxYy5tXWLRsR9ABYEKI51/HWcsN+xi6tZNFKMbo
         0tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDbtrkAn+1X/+6QAPGA7azScNJ8+AfBKHdkpeyBfaAs=;
        b=gT/8SqAtWfKXzM/mGg8bk1cTHOrTuY0qqCIhZ1hDjzOkNykCLfVj1KbkVYVFYmBh3P
         f3YudWNbyN+7z5N6uzFejPWEO88ziPji7KljzgaCBpITrqkRMvIucbyyGvpvhdVN2wq+
         a0crfG3TXN2gYCWudRWDohXcfzbkpSplGoSjDGkBZbGCm192/yvfiOZoxvyghnsjkrLD
         TcFNo614Lg9/CkoetF8ourNVPVueEQcN4V8NuHWhJNID2EqwP//VUhBxB8Tz28w7+MBU
         llBA0wrisjX58l4gj9rLImdrPn1IVsVwUd4jbKxBd/NSWxtTeB4RaHS7yA2CaOks28Fs
         3wJw==
X-Gm-Message-State: APjAAAXzzKyfl3KPb5+uTYCTrdjcffDZgTSNwVXK4jcheckyuZeUfZ7h
        L5JRSkPj8bookYg9Cp0+EgIKEb3b0l9RAK7wX3b1Rg==
X-Google-Smtp-Source: APXvYqxkjSIeuumxaK1MzS8+Ijo/uhqZYvCMemsPoCqGyeDTpvZS5/GJDjvBPamdgpAcQa8DeEz68v5Zhqb8LElLYr4=
X-Received: by 2002:a24:a943:: with SMTP id x3mr953454iti.64.1558385980416;
 Mon, 20 May 2019 13:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
 <20190517212448.14256-7-matthewgarrett@google.com> <1558136840.4507.91.camel@linux.ibm.com>
In-Reply-To: <1558136840.4507.91.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 20 May 2019 13:59:28 -0700
Message-ID: <CACdnJutPywtoyjykDnfX_gazfo_iQ9TCFPYgK60PcOFFFy39YQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 17, 2019 at 4:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Matthew, I'm going to ask you to separate out this patch from this
> patch set.  Roberto, Thiago, Prakhar, I'm going to ask you to review
> Matthew's patch.  I'm expecting all of the patchsets will be re-posted
> based on it.

Would you like something along these lines merged before reviewing the
rest of them, or is adding the ima-vfs-ng template and allowing admins
to configure it as default sufficient?
