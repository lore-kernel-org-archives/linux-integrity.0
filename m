Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6BAC10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 06:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71702133D
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 06:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9FYjCh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKGkN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:40:13 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38379 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKGkN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 02:40:13 -0400
Received: by mail-lj1-f181.google.com with SMTP id p14so4381606ljg.5
        for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2019 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNnpvqq+ZxguybwxZnttXr0ZJDhJhiD/TMggqyrOOcc=;
        b=r9FYjCh94Efh4Ip/or3OBx/KELvahzCbSCUN55Ek+2tesjTrWc6aNOo6FBh9dCdzS9
         eA/jrCWuN/NT+PPfaXQWWNDb5hiISnAVjD6RqF6xNJWFKnxSiI7eM5FQFE5DjhcJ4bW3
         2zeUyFWogu+vTOPahHnSKOduslTeW892QcjB8oYiNZGq320rHs9QeoBrEjFfT8zmjElp
         +YYPbb+vL5JqyL9ri4AbAmSA3aQwPoyg/icNm49N7ftVGCZHauyztoPUl7Y3QtJ16bMQ
         Vy6UdtehRCZaJHoOjcxndCbicJhVKgS1Z8axk0gdAG6hd07fc+766w4A0PhL3Ck8KAJs
         DoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNnpvqq+ZxguybwxZnttXr0ZJDhJhiD/TMggqyrOOcc=;
        b=VW95W/zRSJ3VtH3hPfR4jz0SdP0Lx1DCV90hD9MHWgp/iZWY5/tzImKV7RxNHNpezP
         6/KeleNs4KAZ3jk+k1LmKHTfjNRLpYq3f5UdTIaZ/1IkZvFxaIMsnC5DG9SWr4608IB4
         G4c0RVKBbeyZUZ80kG4WCPbuNaNvWuLwB1x3yP+i/1QCmSDRgzPw7owb4mk9BjluLQMj
         DEAFeb1xCaegtS5R1bkGrkIDdcURTiGoS0zcWnFItUHv41c/scy77l1HgkLMT+VLv+k/
         goNAxE+x/tN4RZnP5PoHx3HCfipGV8wurQo7jJhVuQ1Bxdj8d3rC3AjQKvBzykKJY8RE
         y5lg==
X-Gm-Message-State: APjAAAWIQ4vwLHuXk7NYsCKw5Ao3iH6+ZIdf6lZHLdgZH0E6J8VTVvPn
        /66TEFS716EQAS/sKpb+rbVixz1p9EA6FfqVi2U=
X-Google-Smtp-Source: APXvYqzvfmEZ4jIbvgnZ76SscLIPCXlugHLmLQiO6tmZWTUqu2qrh37pBlCBiWCSK7HX7X5VQDM3Uv9pXUzx9qeXJ6c=
X-Received: by 2002:a2e:9213:: with SMTP id k19mr10905493ljg.118.1554964810761;
 Wed, 10 Apr 2019 23:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
 <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
 <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
 <1554729047.17244.95.camel@linux.ibm.com> <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
 <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com>
 <1554811489.4192.15.camel@linux.ibm.com> <CAE=NcrbSpC3htW5BhZth8OuSGM-DVtH67i=uWg9tosJKv3Sg9g@mail.gmail.com>
 <1554813123.4192.33.camel@linux.ibm.com>
In-Reply-To: <1554813123.4192.33.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 11 Apr 2019 09:39:59 +0300
Message-ID: <CAE=NcrYH4q-3axdNkjqOTEO0oG9=8qhDMN+KZm5zhvCbQXppmA@mail.gmail.com>
Subject: Re: appraisal reset safety
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 9, 2019 at 3:33 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-04-09 at 15:25 +0300, Janne Karhunen wrote:
> > On Tue, Apr 9, 2019 at 3:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > > > It would take an additional integrity hook, of course.
> > >
> > > That's fine.
> >
> > Great, I will work up a proper patch and check the locking.
>
> Thanks!

Sent for review. I have tested it with arm8l and x86_64 qemu/kvm setup
with both appraisal & fix modes. Hashes seem to update correctly as
the syncs are done and I can't see any obvious smoke coming out from
anywhere..

As for crash testing, I will try to make many runs today. Based on my
understanding it should be pretty good, certainly battery outage or
just plain crash should have quite low probability to manage to tear a
single inode update halfway through. Besides, if that happens the fact
that IMA detects a file corruption is only a good thing. Broken files
are not allowed to be read, intact files are fine..


--
Janne
