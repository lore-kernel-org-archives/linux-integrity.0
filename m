Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFCC10F03
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDE3205F4
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 12:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuypOg2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDYMqQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:46:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34705 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYMqP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 08:46:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id h5so17403159lfm.1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne7Cr7cRJB4/Fee5VYepxByB1IKJKt4iilCFoonP81k=;
        b=MuypOg2dCHK6s3H1PJQ8+jxK8cPChL/0/NEk81n7kjMApCf1Zn87COdnySoQp2wcUR
         78l/foo7RN+BdGPsrVB86tINAK2fXh/B+NGRIUhnsj6/HKn+SzInBHlcrfv9pa90vnlI
         NdzxTB2tjodMKuCqPjUCY6NFGQTrgS2yxQynY1+XbtFtxwXgu98GbK8UX1/VTws2WEn9
         xfrYmUuXiMWlmqqWHfVO2DDPNqZrbmvkrYKOp+m5WbCSViCjEgywg+gFbSwnAejuPB77
         3UM9ZcFxrOuFe63ZcqkVC/UT+EkU0IaQlIvg3zTFM5dJH81FEYw2r8FGPU4cIo9COpY0
         8Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne7Cr7cRJB4/Fee5VYepxByB1IKJKt4iilCFoonP81k=;
        b=jhp7fwbACGHDxImIozxvTjOD9vKjz+FnfExuulg+jpVPQreH0ptc0m1yKONph4qLmI
         GKRo0dHgaCbXLyEPTflFVeCv7K1LQVI2KOUg1b/EzU8Y9rj1B+cQOOD7f3ZGxYrcRTSZ
         6et8l1PAiH5cajbxtFD5pboIP3zEUEhA6ILptRpJ8ROZez6S9LfVfprSrGKrUcx+2igb
         CvI28MNs9XeTZMMz6JNyq34oB6s9LDzzaIU5i2aYfr0lfbPeJ3wbLG4sddSMPv0IbLGS
         UwvXfijxOF5BpIdWuEubfiWJWy85PRZLu0BG6OE46mcLvwzUWRN0kUhsFrToPQoZOCP0
         mzyQ==
X-Gm-Message-State: APjAAAXkNmxlauCU56bLwjfNTwZVVI2QFhqECimTYdwJUOVUg1NVVy9K
        lU9hfilVPHuAZMcla2DMcHe85zrQncQr4lLwoclVpflF
X-Google-Smtp-Source: APXvYqw96OegnZ6pR1LuqHWEWtcZ5IJ5DHsPhaEr7IJdNlbgk3wCbhjM0CuvEIypFtwh8krMgUdjiEOx1Gxvu/q/4DI=
X-Received: by 2002:ac2:5107:: with SMTP id q7mr20657238lfb.162.1556196373798;
 Thu, 25 Apr 2019 05:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
 <1554987784.7843.40.camel@linux.ibm.com> <CAE=NcrYDK1de25XeJcYOpW41O3_RbqYJamkz=SE745Krfa=t8Q@mail.gmail.com>
 <CAE=NcraD_VD=ZmNTiCb4AWzwiaOYp5S0cE4uC64b0kHLQ=7PEA@mail.gmail.com> <1556194447.3894.105.camel@linux.ibm.com>
In-Reply-To: <1556194447.3894.105.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 25 Apr 2019 15:46:02 +0300
Message-ID: <CAE=NcrZNo1r+kJi+F-uf=7=wr2DhDA2wPRzUWxXTJ9b1mgdt4w@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 25, 2019 at 3:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > The pieces that we did:
> > - initialize hashes correctly on open()
> > - hook 'sync'
> > - hook 'msync'
> > - hook 'truncate'
> > - introduce a per-cpu workqueue that gets work items from write and
> > dirty page flush. Long-running write is allowed to go as is (no
> > performance penalty from re-measurements), but once the the write goes
> > silent workqueue item is flushed and the file is hashed.
>
> What type of workqueue (eg. fifo)?  Are all of the writes needed, as
> they might be re-written later.

We can talk about this, but what I have now is

static struct workqueue_struct *ima_update_wq;
ima_update_wq = create_workqueue("ima-update-wq");

..

queue_work(ima_update_wq, &iint->ima_update_data.work);

All writes are not hashed at all, it tries to insert an element into
the workqueue on every write, but if there is already one it is happy.
Alternative is that we add delayed work that is constantly kicked
forward, so rehash will fire for example 'dirty_expire_centisecs'
after the last write on the inode. Unfortunately I need really high
crash tolerance in my use case (lovely vendor kernel), so I don't
delay it much in our case.

Android is pretty rough test, btw. It keeps 800+ files open for
writing on /data alone. This survives that kind of thing crashing in a
loop.


> > Before I uplift this construction against the mainline, any thoughts
> > about this? All I can say so far is that it runs and it seems to keep
> > the system relatively crash tolerant. 'Don't let the perfect be the
> > enemy of the better' I guess...
>
> As long as the iint cache info isn't affected by these changes, the
> change is limited to writing out the xattr more frequently.  If the
> iint cache info is affected, then you need to be careful that multiple
> readers/writers continue to work.

Sadly, it is affected. That is where I hide the 'work_struct' and the
'file' pointer :-/


--
Janne
