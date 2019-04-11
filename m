Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C80BC10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C0D2077C
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIGHBc0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKOKU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:10:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40355 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKOKU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 10:10:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so5666253ljq.7
        for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2019 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYkc8YQqPc00Rje+w2qEqohy/p17AYyQ6dmAxKzeyyI=;
        b=cIGHBc0Q+VhdGKCJHwOJeVJUawnhPY+NVsFs0FzxpW2D0qBRIu4xDYYJ8ETjsjNtSv
         hVDGrp51lxPAmHhbNMx0R4t7Zwwj+eLtf4872APUkxJFRJjzILgXYxbh94dBPAI92zpL
         Qf4qacfi8udQkaPVJWnmyXIqJvIhTMqc+PxWFaQY9qJAhqx5w53OSd/fhgKo+WOd0e9o
         I3fOeTSELbFDaZ+MCH2MGlOjIgCs89MNGCgMMwl82OO85Tpzrkry1iUIWOco+QES3sDb
         UnqQbi/+S+uWu9a8vHuhTV5BCn/ijzCJCwo7t5dVlTLMkgCdmojBFdfdWeQuEY13WXhF
         PjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYkc8YQqPc00Rje+w2qEqohy/p17AYyQ6dmAxKzeyyI=;
        b=Ft6NLayAaEmotPQ7sV2JwB/BF07Wz2GrVKaf5FgtZEOPPjnAD6Bo2pqjp9G/yUSAJ8
         BoZpCR/59HV01LmJgzdygXpbzhYTCzicwUoTr0zFeFBc13/UtF1kBiom2WENizTDyQMI
         fdaPckLX8AepuIbm1WiphoRz7W/rvc+PawjIaGDtzApsrsDMs42h54ascb+CInCGUPuM
         2NGiK7nEryiR2gx+rR/LXyPHPTkiIiy7A2docSI6XS8V9em88y70mxLZLr9RSN3OkNiz
         fUbR1ANdtmbBv678oyPYQ3TYk1LIDDe8tMgxTl19Za4f3sh7Jr4dEnOYCPVsxIQKftou
         Ba4Q==
X-Gm-Message-State: APjAAAUodfKfBO7MTvJyV03mXPz5wjN1kC41Tlvgnkz6aTcyRx7Da/y3
        JKORFD/iYSpSs2tUdK4tkVR4N/G/lHTsMRcGLxYbXg==
X-Google-Smtp-Source: APXvYqyvp99+qy4c7wvljAN7oJlkp8t3/TYpam3AEF4g8DSVPpGVc9cORmS5Ql57/CA3H7x9QCCGtkvkquspjGICWw8=
X-Received: by 2002:a2e:3506:: with SMTP id z6mr25961520ljz.72.1554991818593;
 Thu, 11 Apr 2019 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com> <1554987784.7843.40.camel@linux.ibm.com>
In-Reply-To: <1554987784.7843.40.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 11 Apr 2019 17:10:07 +0300
Message-ID: <CAE=NcrY_nwjdPoD+hk90CW93LTDattY_g-qQcqFQa=Xb7M+wPA@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 11, 2019 at 4:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > +     mutex_lock(&iint->mutex);
> > +     if (atomic_read(&inode->i_writecount) == 1) {
>
> This test limits the number of opened writers.  Only if there is a
> single writer opened, will the xattr be updated.  Is this what you
> intended?

Certainly no, I misunderstood that to be a flag. Will fix.


> Your testing should open the same file for write multiple times.

Indeed. I was just wondering what happened with 'locksettings.db' as
it failed to update. Duh..


> > +             clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> > +             if (!IS_I_VERSION(inode) ||
> > +                 !inode_eq_iversion(inode, iint->version)) {
> > +                     iint->flags &= ~IMA_COLLECTED;
> > +                     ima_update_xattr(iint, file);
>
> Relatively recently there were some changes to iversion so that it
> isn't being updated as frequently.  Can we use i_version here?

Thanks.


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

Ok. I guess ima hook it is then, doubt any lsm will ever need it?


--
Janne
