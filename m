Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF5C4360F
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38166218B0
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 21:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OF6uz+hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfB1Vlo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:41:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50347 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfB1Vlo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Feb 2019 16:41:44 -0500
Received: by mail-it1-f195.google.com with SMTP id m137so17097185ita.0
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7CwXuihhNGEOa1tO1Mc9ZpIBP8K+cAkyX7VXGAyPXc=;
        b=OF6uz+hT3eoRvtBRSLNMIUanAQ5np30A91vOW8nFVcdYCKVL6lBAndv46+snGhPGxD
         M4g/SAm6Gg2ZiyE/Qb6dF3YcrZxXPEw11Hp5na4dlc6azEIbmwIncSj+Jr0qtiGcJwMG
         qmnG0Ke5Yjgp9wq7HRIbgh9kric6ZOG/A44Ha3KYY++1/l3ep85bOCVqG4znLDw1/Zuz
         6o066svV4IfMLxdnBr7xNFoR1e8ciHhY7RLWqoSr/3bnOzyXnji3IZ4szopwRVcGauDi
         2OOwkodvTRxy6snFsYUgGmppaZpA68+5+V9OhQq7Uv6GbhI+dPEbUorlsh5u/5vksMFU
         kZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7CwXuihhNGEOa1tO1Mc9ZpIBP8K+cAkyX7VXGAyPXc=;
        b=Ru142YFCKFvtiNsI9sCU43zmG5f+6ikZMQfGRQo0a/111Gm8sEv71X3HQ2Z/i+j5Am
         CwESM111e8MjPb9I3e5Y4Y+gBUpMAR06tX+4R8EJEe19kmay03AIgMCW8kBUPRWVxd6r
         TDLINnuLk+iL0KxU5OQmOykl6jh1qtdmG6waQCljGM6mLOyuXha8t268nS1S4ugrPU1R
         MCke6f/xIGRNu9JT+xxYBTE8BtsgutH/xFAobkGaAPuQvoNTUia0mpcn58ls0nHEK347
         QSxF7nb8lQyWpfFypfPniR/xjkzUhB5SmaunfWXI6aKSd9QlmTcdOJ2xcykpg07KJou9
         8eAg==
X-Gm-Message-State: APjAAAWJ5rU3Gj0Dq0ViIVeBLWWrLFxBdXv23hn40RkcIb7c+4NxxjuC
        0FS2vtBiRG3A25JGM4ih693E1ieUWGXCYRV3tkx1Q/SPeFc=
X-Google-Smtp-Source: APXvYqwKBm9rijttpBcirKJVkODqfK1NCkBtPyGigWPE57SQfuwUQJwbI/sKP8h/a93BgXV5P4zrjFBN0b5zO4JLXl4=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr772019jab.102.1551390103018;
 Thu, 28 Feb 2019 13:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com>
In-Reply-To: <1551377110.10911.202.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 13:41:32 -0800
Message-ID: <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
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

On Thu, Feb 28, 2019 at 10:05 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
>
> > > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > > index 09a5def7e28a..6a517282068d 100644
> > > --- a/Documentation/ABI/testing/ima_policy
> > > +++ b/Documentation/ABI/testing/ima_policy
> > > @@ -24,7 +24,8 @@ Description:
> > >                             [euid=] [fowner=] [fsname=] [subtype=]]
> > >                     lsm:    [[subj_user=] [subj_role=] [subj_type=]
> > >                              [obj_user=] [obj_role=] [obj_type=]]
> > > -                   option: [[appraise_type=]] [permit_directio]
> > > +                   option: [[appraise_type=] [permit_directio]
> > > +                            [trust_vfs]]
> >
> > Let's generalize "trust_vfs" a bit.  How about introducing
> > "collect_type=", with the default being reading and calculating the
> > file hash?
>
> The naming might be based on the VFS name (e.g vfs_read, vfs_get_hash)
> or on the file_operations name (eg. read, get_hash).

If collect_type=get_hash and the filesystem doesn't support the
get_hash type, should the behaviour be to fall back to read?
