Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FFC10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30320883
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/1ayKWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDILqb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:46:31 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39327 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDILqb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 07:46:31 -0400
Received: by mail-lj1-f170.google.com with SMTP id l7so14148351ljg.6
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2019 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJ4TXa1cV8OrBvodnDAYkukkID9jJTt6WWQlUvTlIqU=;
        b=a/1ayKWGvZFkWCnjcseKy9PNIPq3d9RZVV7/FiIKiUmfpPrt7mTX4OaMNSgv7nwrEB
         KguG6WcjBLOXTnE6tWAlZJ3qzNeKkqXOX3pgJr2HRFPftGYy4Brj1G0YqQN1O+7BYzhn
         XU3JcJHcg8+6XfQB9bWXpq5XQ6ZEyPZMBwyqAXFOCcKe4E2yeOkui+tSYaLGy5c3S/4U
         AoWT6d07pTA8/x14aEGBPVKT8WsUzdmvK2uZSj1gE+NIvmG3Z30J/pa48jHyE4m2uhHe
         MfB8vb2gLbHds7LpKkZxXopUb2latnFd84joQwGnc18kDpIrpGR7ZR/kc2jEeVpDRZH8
         hHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJ4TXa1cV8OrBvodnDAYkukkID9jJTt6WWQlUvTlIqU=;
        b=qfU0sybT3AKxcYIWOzZHDLhJkICc8H9VpEQAcngb2deqijIHporic8BK+sLYTNnr+u
         XG5608uFzC6ug+O65mG6ps4oMUWLsIXGNma8BcYHqZQ5pxhj6usbRoHdne6etjRsiA4l
         jNgCtuqAw3v94BQmZRmBpsVUXwKRVBr6abG1uC/xYmeATRd9bXHZpyCDvfLd1D18LIu+
         hjg41TpKcEFNUSMuAkpwXh2LpsURCEMKMxr15R0yfCbI5tREMwyL0wFjFezpG5VX6hso
         KGD1ofaia/8NIeG8ejd+TloWaaYNVG1NNCSJBV0hdUqAP7I8x0wTV/qLD1NDvtgIimo6
         yq9g==
X-Gm-Message-State: APjAAAWSQjlSZ3ABl5YiC1x4fibAeUmKHhZgImPBrJGZcOCNe/V0ECdU
        5bwmmGEr28qaFkkoBC3B2ru9HlvNz8aYZ2UhqwY=
X-Google-Smtp-Source: APXvYqx5cdh3Vqy/JYOfYdVwzwIembPxMILdwYBjRzjsV4mVXvZhg2x06G6mAB1+Tj9kfxMwxpSPSUmtWqdwbVDPV0U=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr19016230lja.49.1554810389697;
 Tue, 09 Apr 2019 04:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
 <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
 <1554729047.17244.95.camel@linux.ibm.com> <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
In-Reply-To: <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 9 Apr 2019 14:46:18 +0300
Message-ID: <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 9, 2019 at 10:58 AM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> > The question of how much/how little to measure/appraise/audit is based
> > on policy and affects the integrity of the system and its performance.
> >  Detecting and updating the file hash each time the file changes would
> > have major performance repercussions.  Even that wouldn't solve the
> > problem, as the file change is in cache.  Writing the file hash as an
> > xattr and making the file change persistent needs to be coordinated,
> > probably at the filesystem level.
>
> As an experiment, I will add 'ima_file_update' function and call it
> from few strategic spots (such as vfs write) and see how far that can
> go removing the crash-recovery band-aid.

Adding ima_file_update in there seems to work fine and things stay
nicely up to date. It is certainly heavy, but maybe this is only
needed when sync() is intentionally being called for the fd?

void ima_file_update(struct file *file)
{
        struct inode *inode = file_inode(file);
        struct integrity_iint_cache *iint;

        if (!ima_policy_flag || !S_ISREG(inode->i_mode))
                return;

        iint = integrity_iint_find(inode);
        if (!iint)
                return;

        iint->flags &= ~IMA_COLLECTED;
        ima_update_xattr(iint, file);
}

It would take an additional integrity hook, of course.


--
Janne
