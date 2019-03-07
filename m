Return-Path: <SRS0=us8B=RK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D8C43381
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F42120851
	for <linux-integrity@archiver.kernel.org>; Thu,  7 Mar 2019 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6g+7oF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGWmM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:42:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50863 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCGWmM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Mar 2019 17:42:12 -0500
Received: by mail-it1-f194.google.com with SMTP id m137so18041061ita.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2019 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXHVjZQE+m+ENaxUDZY7qPxwWuv3aq1Isd0Vif+B5/0=;
        b=R6g+7oF2xACQfAZzKOp4jJjjg/n+Bzdekvmv7IAhbi/kpqRNw2Oc6KeLjOiSxE29w+
         CT39jlHXt+/DNgPvf5SvodJw14ZPuf25b9Je3xHHCRP5LbSYJB/udc3tt3gR2VZjajR+
         omBkP/OVKBS5QSFyu7EbHyOth2HBhhn5qYjEL3y7etNC5U0goNGzqX6nqlGCIb9MzxRu
         Y28RtauffgiGTI1c2s40QzSdNl33sZ5Hzx1kmFf3oG2t3NspI3hAPsOBVdX4Pem2iKqH
         VHQyejV73W1dllsObK72J8oRloe0LaVGanLgfGkRZLqDEJSu5UMRmXoKAbxeS8ySoTsh
         b63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXHVjZQE+m+ENaxUDZY7qPxwWuv3aq1Isd0Vif+B5/0=;
        b=m1imi8CWDpK6Y6tipIFo3470pQx4dSzWVdiFA7l//gcSV/j1EblKsrtN+EvZOIa93F
         BHo+SYqwOUG3Wp77kWs/kryqbyZeY7wN/VQGUvAk90ABEqlvPYJCeHnTawY2t9rHHRZv
         SyXbIPadqEKCJJ700Z69J4xjx4w7nY47gOvPV3BOnIKhSvcJH+mHi5MdHLcIYV4WncPQ
         KwhQyjw3GLk2543AUNQQEqWPZ3n9KKZWJQRszHN0OiYHfPeBJrDsv1XOVeXjIw5GAqFS
         y1alpPKy1yzifPhVe4f8v0beX+61iTxbrylt4JcHw3cnlpE+lp8/6r6pN/NUCI3UYOyX
         iq7w==
X-Gm-Message-State: APjAAAW7sXSUuuKMGXV0LX8nG+22xEPqrnXocQ/J0TdEFfhcPcinN+Gp
        PG5HH+QB2sBNhadxQwtDWI9VzXdqxdpVDqW9Lnv07CxX2CA=
X-Google-Smtp-Source: APXvYqxFU/5iFCyyjYgRuUhHxRUOg3X/hLqkoCa7/9AGP3keyoebFKIJ8Knkc5jVHqCvH993yC1NN0iNGHcbGQFbUjA=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr8722873jab.102.1551998531027;
 Thu, 07 Mar 2019 14:42:11 -0800 (PST)
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
 <1551991690.31706.416.camel@linux.ibm.com>
In-Reply-To: <1551991690.31706.416.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:41:59 -0800
Message-ID: <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
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

On Thu, Mar 7, 2019 at 12:48 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-03-06 at 20:19 -0800, Matthew Garrett wrote:
> > I'm not sure I understand the additional risk, though. Either a
> > filesystem is already being measured using a full read, in which case
> > adding an additional rule won't change behaviour, or it's not being
> > measured at all, in which case there's no incentive for an attacker to
> > add a new rule.
>
> In an environment where the initramfs contains everything, including
> the IMA policy, and is verified, then what you're saying is true - the
> IMA policy doesn't need to be signed.  However, the existing dracut
> and systemd IMA modules read the IMA policy not from the initramfs,
> but from real root.  In this environment where the IMA policy is on
> real root, an attacker could modify the IMA policy.  I realize this is
> an existing problem, not particular to "get_hash'.  Unlike other
> policy changes, the attestation server would have no way of detecting
> this particular change.

Ah, got you. Would measuring the policy be sufficient here?

> > In both cases we're placing trust in the filesystem's correctness.
> > It's certainly possible for the get_hash call to be broken, but that's
> > something we can put additional testing into.
>
> The call itself wouldn't be broken, but determining if the filesystem
> is actually calculating/re-calculating the file hash properly or
> simply returning a stored/cached value.  I do see the benefit of the
> filesystems being responsible for the file hash.  Perhaps I'm just
> being overly cautious.  I'd like to hear other people's opinions.

Yup, happy to get further feedback on this.
