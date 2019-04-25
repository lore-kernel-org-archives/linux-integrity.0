Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B8C10F03
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A46206BA
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHmMOcsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfDYKFj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:05:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46007 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfDYKFi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 06:05:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so19679292ljd.12
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJOu3YbpjKJbdtZClnsgLn+dLUezvRJuNidI4kKmyaQ=;
        b=JHmMOcsObaZp8RQ8YpbTOxOxGYBiJ3K1G5gVA1RBR5vGcQ836QXhrhRXUEQ8oeOdJg
         o3d4XJXaAnF/84OcORS6IZ02WlKdcAR/2ljmablCyvfxJZev5sJ2F4Ng2Tbr6zUbimiL
         xLGbGGzwi81+HKTjcQwO+BOb3eeU0DVqiXEEhl0l/oKrn7jS7GZq5vFYoQ6zuHcdmPJE
         /dSb+4FEOF7brNBl+INxxUEf8hg6DkXWJb/YuwbSixDZx27QbSwtM2qyN2yzIU0ndVB4
         kEPEHseMqw0mx/dG06Xe8LPLje51RDcCV2xPUXjPJsgFmUbnhpMLI06/bXnAJ0TBnWkt
         I5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJOu3YbpjKJbdtZClnsgLn+dLUezvRJuNidI4kKmyaQ=;
        b=UlYHpyZRb+vlOsUIhUmZhc69fMwGz9lQTExuQhbqTsB1mF/ERLH8qXSUljY8Dwhst+
         npoznWbquIp6MB6O1cISoLbRhGJG29Lo/hz2bKHwnM+/4ufhV70cPkZ6aSwmaXLJZAkX
         F0ve98T0fetivBVhbn1qIeBlsoSR/8M8aNtLy8VKki/tRhPRkih+0zrwEpwCVVW9+FtT
         ovDH529Va7sahdPMA6UME75Egc0sZBz1g6cqm07YnODmtk93xoDV+X07W4I87qZSmANX
         JBvWG4W3uQ0xyROMU88M/iOllefT/wq2Vyl74P2xi7P4g9eJtKesaIjaR6mzunapnUSE
         4ZgA==
X-Gm-Message-State: APjAAAVg9n6wRxMG+QGleB7Tq/fLkg9iAfl5sof5+UQyIe+gvk5UUy8q
        7CxL2PJ5eKMYqoMwz5oMM/MGo8+8Go3dUz76aCTQ8A==
X-Google-Smtp-Source: APXvYqygeHF9YcRfbMREkAwC61hKe6zviDAUtjYxO8re/YrC1NJd0P6J9ELRmOBjpGBnWnWg8l4ChqbhGe5kpAoNwGw=
X-Received: by 2002:a2e:810f:: with SMTP id d15mr2765881ljg.38.1556186736117;
 Thu, 25 Apr 2019 03:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
 <1554987784.7843.40.camel@linux.ibm.com> <CAE=NcrYDK1de25XeJcYOpW41O3_RbqYJamkz=SE745Krfa=t8Q@mail.gmail.com>
In-Reply-To: <CAE=NcrYDK1de25XeJcYOpW41O3_RbqYJamkz=SE745Krfa=t8Q@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 25 Apr 2019 13:05:24 +0300
Message-ID: <CAE=NcraD_VD=ZmNTiCb4AWzwiaOYp5S0cE4uC64b0kHLQ=7PEA@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Finally. Now I think I'm almost happy with the overall construction
and my gut feeling is telling me I can make the hashes reflect the
filesystem state pretty well, maybe even over 99.9% of the time given
the workload stock android is generating.

The pieces that we did:
- initialize hashes correctly on open()
- hook 'sync'
- hook 'msync'
- hook 'truncate'
- introduce a per-cpu workqueue that gets work items from write and
dirty page flush. Long-running write is allowed to go as is (no
performance penalty from re-measurements), but once the the write goes
silent workqueue item is flushed and the file is hashed.

Before I uplift this construction against the mainline, any thoughts
about this? All I can say so far is that it runs and it seems to keep
the system relatively crash tolerant. 'Don't let the perfect be the
enemy of the better' I guess...


--
Janne

On Fri, Apr 12, 2019 at 3:40 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi Mimi,
>
> I will take a couple of days to test and think this through a bit
> better, there are extra cases like file creation without ever writing
> to it (also ending up in appraisal failure for no reason) and msync()
> that would also be beneficial to tackle on the same go.
>
>
> --
> Janne
>
>
> On Thu, Apr 11, 2019 at 4:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > Hi Janne,
> >
> > I need to finish up a couple of other things before vacation.  Below
> > are just a few comments/questions for you to think about.
> >
> > On Wed, 2019-04-10 at 17:56 +0300, Janne Karhunen wrote:
> >
> > > +/**
> > > + * ima_file_update - called from sync to update xattrs
> > > + * @file: pointer to file structure being updated
> > > + */
> > > +void ima_file_update(struct file *file)
> > > +{
> > > +     struct inode *inode = file_inode(file);
> > > +     struct integrity_iint_cache *iint;
> > > +
> > > +     if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > > +             return;
> > > +
> > > +     iint = integrity_iint_find(inode);
> > > +     if (!iint)
> > > +             return;
> > > +
> > > +     mutex_lock(&iint->mutex);
> > > +     if (atomic_read(&inode->i_writecount) == 1) {
> >
> > This test limits the number of opened writers.  Only if there is a
> > single writer opened, will the xattr be updated.  Is this what you
> > intended?
> >
> > Your testing should open the same file for write multiple times.
> >
> > > +             clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> > > +             if (!IS_I_VERSION(inode) ||
> > > +                 !inode_eq_iversion(inode, iint->version)) {
> > > +                     iint->flags &= ~IMA_COLLECTED;
> > > +                     ima_update_xattr(iint, file);
> >
> > Relatively recently there were some changes to iversion so that it
> > isn't being updated as frequently.  Can we use i_version here?
> >
> > > +             }
> > > +     }
> > > +     mutex_unlock(&iint->mutex);
> > > +}
> > > +EXPORT_SYMBOL_GPL(ima_file_update);
> > > +
> > >  /**
> > >   * ima_path_check - based on policy, collect/store measurement.
> > >   * @file: pointer to the file to be measured
> > > diff --git a/security/security.c b/security/security.c
> > > index 23cbb1a295a3..6a0980a1df22 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1451,6 +1451,11 @@ int security_file_open(struct file *file)
> > >       return fsnotify_perm(file, MAY_OPEN);
> > >  }
> > >
> > > +void security_file_sync(struct file *file)
> > > +{
> > > +     ima_file_update(file);
> > > +}
> > > +
> >
> > Either this is an LSM hook or it isn't.  If it's an LSM hook it needs
> > to be similar to the existing hooks.  If it's an IMA hook, like
> > ima_file_check() or ima_file_free(), then call it directly.
> >
> > Normally the function name is related to the LSM hook name.  For
> > example, I would name it ima_file_sync.
> >
> > Mimi
> >
> > >  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
> > >  {
> > >       int rc = lsm_task_alloc(task);
> >
