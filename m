Return-Path: <SRS0=pSLL=SO=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD7CC10F0E
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Apr 2019 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAB72082E
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Apr 2019 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiiXLZun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDLMkx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:40:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41121 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLMkx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Apr 2019 08:40:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id t30so7370322lfd.8
        for <linux-integrity@vger.kernel.org>; Fri, 12 Apr 2019 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rSB0yTORzRWljDD7DoGEVdxDihChsZmyZMtBkA7224=;
        b=LiiXLZunUVRIK/GkCL1P8u2EJow/bV3zJChEcmFoMzJv+FIvMyCICGzJK2PmeacoEn
         vzAQRiXHarop3QhE+UBFwkuIPh/G8MqZg2JjxRmpRhcxsvp01CgMCrWDaUxD5pxpgnzh
         rezQU5I7pOF619EUgkilj1bogUSvIQzvyNpDAt9w4lQI3JxU6h1qZfVYgJdvm8jAvIZi
         OA9xRWXmAkRB2JFrX0ucYHs8jDq2qP9sbE5c4sEbQ+W03kmEdEie0ujavBfkTPrEEfTg
         8Ti7QwaB6zycoFBa3T6Y/qoUS2MKNU0G2hVc/X3SD2maTUxVmdtGkFkUv1SI/ZwyAbaM
         LVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rSB0yTORzRWljDD7DoGEVdxDihChsZmyZMtBkA7224=;
        b=IIfDQUkrukZvv5rPbM26Umu6KVBT7Kv2s4NvlTZQo0g8yO7akA1cNzXcPlEmubu7KT
         Z+r54KB2fLNyRk1MuxfNkeYJ0RiEDjf7zwThoVVqupTS45kgt4NlBbFI7u+WWOLLGVRv
         /LsAh6L9lL8nLGgwIIgebuBK6u+2SkIf6ChG57CNSK+rP7XY+HWJjxBLKFYR02v51kGR
         ZaIt23wbvyTzMB6OjwglZKQ2WyNtD91dfM0NR87Do25x0UQ05/dHgOdxY8uelGnZNEPf
         /7KNIFHh+/PyWgljn2JFhZ5fkFkkPJCCgejuW9Smths5+oC5GXP5QwEi/1kr3p3OEhZZ
         v3ZQ==
X-Gm-Message-State: APjAAAWAbNSRj4yd4HnjlUE2C1vcel/H8cADkP+ZyrEE+6pLkQPSVAim
        ujqCM+s4UEGQNUyi7f4fYp3ZWteFTiXGnx5h7HIuLg==
X-Google-Smtp-Source: APXvYqwYGHlllvzbjQG6MGoCo9YwH6/pTf1/7DsbHktjKQDHuS9hyOwepWCw1BVgyesECh8AqKPxLlNAtppetqYTIXc=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr4482005lfy.128.1555072851195;
 Fri, 12 Apr 2019 05:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com> <1554987784.7843.40.camel@linux.ibm.com>
In-Reply-To: <1554987784.7843.40.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 12 Apr 2019 15:40:39 +0300
Message-ID: <CAE=NcrYDK1de25XeJcYOpW41O3_RbqYJamkz=SE745Krfa=t8Q@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

I will take a couple of days to test and think this through a bit
better, there are extra cases like file creation without ever writing
to it (also ending up in appraisal failure for no reason) and msync()
that would also be beneficial to tackle on the same go.


--
Janne


On Thu, Apr 11, 2019 at 4:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Janne,
>
> I need to finish up a couple of other things before vacation.  Below
> are just a few comments/questions for you to think about.
>
> On Wed, 2019-04-10 at 17:56 +0300, Janne Karhunen wrote:
>
> > +/**
> > + * ima_file_update - called from sync to update xattrs
> > + * @file: pointer to file structure being updated
> > + */
> > +void ima_file_update(struct file *file)
> > +{
> > +     struct inode *inode = file_inode(file);
> > +     struct integrity_iint_cache *iint;
> > +
> > +     if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > +             return;
> > +
> > +     iint = integrity_iint_find(inode);
> > +     if (!iint)
> > +             return;
> > +
> > +     mutex_lock(&iint->mutex);
> > +     if (atomic_read(&inode->i_writecount) == 1) {
>
> This test limits the number of opened writers.  Only if there is a
> single writer opened, will the xattr be updated.  Is this what you
> intended?
>
> Your testing should open the same file for write multiple times.
>
> > +             clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> > +             if (!IS_I_VERSION(inode) ||
> > +                 !inode_eq_iversion(inode, iint->version)) {
> > +                     iint->flags &= ~IMA_COLLECTED;
> > +                     ima_update_xattr(iint, file);
>
> Relatively recently there were some changes to iversion so that it
> isn't being updated as frequently.  Can we use i_version here?
>
> > +             }
> > +     }
> > +     mutex_unlock(&iint->mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(ima_file_update);
> > +
> >  /**
> >   * ima_path_check - based on policy, collect/store measurement.
> >   * @file: pointer to the file to be measured
> > diff --git a/security/security.c b/security/security.c
> > index 23cbb1a295a3..6a0980a1df22 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1451,6 +1451,11 @@ int security_file_open(struct file *file)
> >       return fsnotify_perm(file, MAY_OPEN);
> >  }
> >
> > +void security_file_sync(struct file *file)
> > +{
> > +     ima_file_update(file);
> > +}
> > +
>
> Either this is an LSM hook or it isn't.  If it's an LSM hook it needs
> to be similar to the existing hooks.  If it's an IMA hook, like
> ima_file_check() or ima_file_free(), then call it directly.
>
> Normally the function name is related to the LSM hook name.  For
> example, I would name it ima_file_sync.
>
> Mimi
>
> >  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
> >  {
> >       int rc = lsm_task_alloc(task);
>
