Return-Path: <SRS0=Ey5g=SK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03923C10F13
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C607F2147A
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Apr 2019 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsBpAinI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDHN5c (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:57:32 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39926 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHN5c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Apr 2019 09:57:32 -0400
Received: by mail-lf1-f48.google.com with SMTP id z9so1017276lfh.6
        for <linux-integrity@vger.kernel.org>; Mon, 08 Apr 2019 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZ9KCvLAaFAxaCsOxwqx3UTwCKiWnrwld40G05qB5iw=;
        b=tsBpAinIrxp8CODScxlKsbhIsftrxUgj+G6wa1zNvB2CGSRmmCKuLejDgGWtwKEUBK
         i2B5h8z2C++Z2voGCxdvpIAJw3FlGrktdivEp7QLZ9nhc9KbDPaJ2S7D1qgXiyto91Y2
         3ElpM6CNe5EbIa26Fc4XlSb8NEQ7l32W/N20H419fQjyUeXyXdxnNTzKwngDKF1HyDVM
         a3i4YKILc25Trp5noo3H+DPf/EzrPyEgwm8th3mexylp7IBvcHHFjfpT9fFvDUmNOeX8
         ncRCZvOUGuId/IkEX82pPd0zpx48QASDIz01IGISP7/SLga3KjeF0TnHAe8GMzPMIUd5
         k8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZ9KCvLAaFAxaCsOxwqx3UTwCKiWnrwld40G05qB5iw=;
        b=eqTnHsPhsdXQtS4LiecobXjhH16NVwx7xEdt5A5s2QQuWYuHtB/QHTQxt8QNlTQFoh
         MqGHY3yTbhI7eVLPS49EBlWDEVXoH5ovAgXY7HU5gJGu8bNkNgip6dslzlU5C7aJMzme
         rDIn5H9kCvre2id/XeWF62yxZ2ynrYxip54gS/NiODcfGbmj15gmbbaCbUk14KpmU0Kv
         qlXx/LMHG0L25/ZZqnJWwPTQWmo5OMzNCuZpTAmxMQ0qd/JwXQA5GOd7neXAeNha/Ik6
         PGAv++LE3cBMfis8adlUJXbUOE9WkmscUbBz8tFPtd/1i0vaE5vI0FG7h6aCCm75QFKA
         ++bQ==
X-Gm-Message-State: APjAAAWwaz0zCXeT1rEvZfJQ8L4otNv73NQGH7eNJWI3V8MuRHpT+rpS
        iMIhygOj+WaeKg/g/UpUdyqjWEzrE+8/BzjvWn8=
X-Google-Smtp-Source: APXvYqyZ9y2KXATfq9rFY///n4XZ9pt2FyrPRJICbRDciw7f5uoSQhCwqqrI0DOPLNfMsY1bUQ6B+hncLcDxK+YC9Jg=
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr11269113lfp.132.1554731849417;
 Mon, 08 Apr 2019 06:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
 <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com> <1554729047.17244.95.camel@linux.ibm.com>
In-Reply-To: <1554729047.17244.95.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 8 Apr 2019 16:57:18 +0300
Message-ID: <CAE=NcrbwfZsKst=p2VMPOe4akjBp8n=AuwHabuDd=1a7w0GVjQ@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 8, 2019 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Hmm, looks to me ima_update_xattr seems to be kicking in only from the
> > appraisal failure when in fix mode or via fput() delayed work item.
> > So, no sync() or anything like that will ever help and there is
> > nothing listening on the i_version updates. Moreover, there is no
> > integrity hook for write() or sync() to put such update in. Uh. I was
> > under impression it would somehow see the interim file updates, but I
> > guess no. Fundamental misunderstanding from my point of view how this
> > thing works, duh.
>
> The question of how much/how little to measure/appraise/audit is based
> on policy and affects the integrity of the system and its performance.
>  Detecting and updating the file hash each time the file changes would
> have major performance repercussions.  Even that wouldn't solve the
> problem, as the file change is in cache.  Writing the file hash as an
> xattr and making the file change persistent needs to be coordinated,
> probably at the filesystem level.

Thanks. I was somehow under the impression that i_version walks the
inode revisions as they occur on the filesystem and that ima is
somehow magically in sync with those revisions. I guess that was naive
thing to expect..

Since I can't leave the device in non-functioning state, I added
following logic to my stack:
- detect the crash,
- add 'appraise_type=fixcrash' to ima,
- load few extra policy rules when a crash is detected to allow subset
of the hashes to be fixed.

If this is of any interest for you, I can send the patch for review.
Most certainly this is not a perfectly secure thing to do, but it is
better than bricking the device just because the battery died or the
kernel crashed :-/

Thanks again,


--
Janne
