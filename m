Return-Path: <SRS0=mqgK=SH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6268C282CE
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E65921726
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTP4Iolf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDEUzf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:55:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45775 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDEUze (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Apr 2019 16:55:34 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so6129186iom.12
        for <linux-integrity@vger.kernel.org>; Fri, 05 Apr 2019 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JPgxrvEn3gXs3Y4gKvoo9glWEe9rgrCB9GXAW/hjxU=;
        b=TTP4IolfJYlz0Uv0EjJoJI424E1QJ66epYs5jXTO6fhV9WDZmtLjfhVXZcV11mVIJh
         Y3+um5bAp2FMkTs/8pPUTY0FgoRF16ifYo/62yOyMJ1hC0YdiwfcHmHhQFzC/NTmXN92
         ON1fz/Htvnb80Rw/PJwSu6E2+ERMwBkdi2TP/g1vGdHPXPFQwOzcQKiWwCFy/wMCqfcU
         Q8gUvzupXa2/eAJPCzJtGxxLZI+/cfVt95tpI/8OQevY1+RRoR0SsUKcAywxt8FS1EEk
         yuXP446yVNuOGOqLEfpBD+a6BKFROIgkayaVCHCOxAmPNyd1sUjvKmIDC+aM0owb/8jN
         ZYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JPgxrvEn3gXs3Y4gKvoo9glWEe9rgrCB9GXAW/hjxU=;
        b=I5clWNNxz8HCp/KtNSfDuFTWcrP3bs5XSybBPi7PZpIA9Tp6TLEsz8J98AmWoG4PjP
         fI1PXIErFBY1pmqA7eEoir9OD4rWtcC+wEzJpTlyX338KAFE44ZY1q2B057KyLWLscok
         f/LFMZQmIgOtxhyGRbNzyrpeVDR6H3VyDCt8AOSk3HA9FBq4ZdQuxVtONjZmq67XSelv
         J0rgzaynY1TwSmHRlKK8sXdvBN8eSUmWn9Yxy+uFbbfm3Ysz2KVF8EZotW5dCylRrN9g
         k+lOOIE6GVpbcEYmFgeyV07+uRXvykKwhgdUTh5O6PJOjJ3v/g/5Dy1fkU8RCI6NrM4W
         Do5w==
X-Gm-Message-State: APjAAAUX7QYcL8kfCYn3txFpjFPYA2zrU5nkJfeRDYZL/BisW3oDUmNy
        qQwYliWZxNh9pRHK2zPNkCCH4iRhnfVu+7qa/O20cw==
X-Google-Smtp-Source: APXvYqxTYRBwZRLJ0JUkKHNwwY42ugUD+oG/MDYyZrYiwNC88pI6sGufBu/BNoEZblMatj9Sa/l/PVs+eUa/Hxh71tk=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr10585112ioa.147.1554497733756;
 Fri, 05 Apr 2019 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
 <1554416328.24612.11.camel@HansenPartnership.com> <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
 <1554417315.24612.15.camel@HansenPartnership.com> <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
 <1554431217.24612.37.camel@HansenPartnership.com>
In-Reply-To: <1554431217.24612.37.camel@HansenPartnership.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 5 Apr 2019 13:55:22 -0700
Message-ID: <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 4, 2019 at 7:27 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2019-04-04 at 18:50 -0700, Matthew Garrett wrote:
> > On Thu, Apr 4, 2019 at 3:35 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > Redundant information is always possible, but it can become
> > > inconsistent and, because the hashes can't be derived from each
> > > other, it's hard to tell if it is inconsistent without redoing the
> > > whole hash with each method.
> >
> > Part of the problem here is that IMA is effectively used for two
> > related but different purposes - measurement and appraisal. You
> > generally want measurements to be comparable across filesystems,
> > whereas appraisal doesn't need to be.
>
> Sure, but I think the only requirement for measurement is knowing how
> to reproduce them.  As long as you know the algorithm the filesystem is
> using ... i.e. it's recorded in the IMA log, you should be able to
> verify them.

Mm. I think this is use-case dependent, but there are certainly use
cases where this would be sufficient. I think this would work on the
VFS side, but we'd need to extend IMA to allow you to write a policy
that specified the use of the fs-verity data on the appropriate
filesystems (right now IMA uses one hash type globally) - if anyone's
interested in deploying that, I'm happy to add support for it.
