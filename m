Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A52C10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BA220883
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwbEJ2II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDIM0B (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:26:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36378 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIM0B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 08:26:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so2867806lfi.3
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2019 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxwzLBcIjY07FW9F4wJztFfUvxzmDQs993HE9g3LodI=;
        b=cwbEJ2IISNewabuxaSZAFY12vc4rjqR+pgmHj4C4u5MVNyVdwWW06p9NuJXQ/bzGj5
         RwY523ysjM0JvNJv6jV7aXj3hZmXhzqA3JPG3jrLD7aVIIRa/mEdJVsq+1tOkfvh2FkX
         VsFa1aHdsiFhPZwO+dFH6g3Vhj8LaY34D0I7TFU7VZz0SJWViGud5SZuFLF4HdziVOBo
         6W53J2+ETePoOo35dhh2RKCf3sqT1GFl+xzfCREc6x40csSJeo5btOiA1x1a6+7IgNiv
         DNUR5qumo4aqQNy4+AT8C6KqJYKEC5SSiAZKZ2CSOKT/zO9klcfWnHweviyTH88GeESJ
         6EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxwzLBcIjY07FW9F4wJztFfUvxzmDQs993HE9g3LodI=;
        b=j5ncHJNehyFiYwNAO7sDR4s5ZPzdr4KxecDpmTNojX0pdVWeFhi/XRW5Sim/s+nErr
         bY/R9QNe5JA3FgGZHhFlA83XVk5/rN+VUtQwmbBKIgQV0mHu/Ts/0Ljnrab31JmM/Esj
         nALjVvC6D8QkGBone1UmHGdXlfQv7Mnih19D9+WAgzDZu6Iv7sjmetE3A/Pf8gVXa+pK
         t3yNZntpQYz/TXNUR7nUJ3419gS0MLNuTCNFq4OFNPCoMD0SwE6wLXO/F87N31BMFT9j
         GJ0HOTZUEa7oUZfGjEjg6z1lUHWsgJWtGlTTB+94hxDHnMj0XLxwBHwrn04OHoq5Cy6h
         GP3Q==
X-Gm-Message-State: APjAAAW2mdADqBhnsatFYoFx1zn5QZVuFUBgAliTm7gMoTjxtQyVPrEw
        Y75l0zXyEb3bA4fEXRsNWAneT3U+0TmC6bamXhM=
X-Google-Smtp-Source: APXvYqyl+plhiGnzDi0lHFEJYPy1dK15no0wHGQhPmlTMpxmA7884wrrkgXIdi2UOAsXR7JU/BfSpdZkhuzVebqR3a4=
X-Received: by 2002:a19:7114:: with SMTP id m20mr19636234lfc.63.1554812759286;
 Tue, 09 Apr 2019 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
 <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
 <1554729047.17244.95.camel@linux.ibm.com> <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
 <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com> <1554811489.4192.15.camel@linux.ibm.com>
In-Reply-To: <1554811489.4192.15.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 9 Apr 2019 15:25:47 +0300
Message-ID: <CAE=NcrbSpC3htW5BhZth8OuSGM-DVtH67i=uWg9tosJKv3Sg9g@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 9, 2019 at 3:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > As an experiment, I will add 'ima_file_update' function and call it
> > > from few strategic spots (such as vfs write) and see how far that can
> > > go removing the crash-recovery band-aid.
>
> Remember somehow EVM will need to be updated as well for it to work.

I will test some more, seemed to work fine under my quick trials.


> > Adding ima_file_update in there seems to work fine and things stay
> > nicely up to date. It is certainly heavy, but maybe this is only
> > needed when sync() is intentionally being called for the fd?
>
> I was thinking the same thing.

Right, so now if the application is designed correctly the guaranteed
appraisal failure caused by the kernel crash goes to 99.9% (or higher)
reliability. Big improvement, even if not perfect, IMHO..


> > void ima_file_update(struct file *file)
> > {
> >         struct inode *inode = file_inode(file);
> >         struct integrity_iint_cache *iint;
> >
> >         if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> >                 return;
> >
> >         iint = integrity_iint_find(inode);
> >         if (!iint)
> >                 return;
> >
> >         iint->flags &= ~IMA_COLLECTED;
> >         ima_update_xattr(iint, file);
> > }
> >
>
> I would think there needs to be some locking here.
>
> > It would take an additional integrity hook, of course.
>
> That's fine.

Great, I will work up a proper patch and check the locking.


--
Janne
