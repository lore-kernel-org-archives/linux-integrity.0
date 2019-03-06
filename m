Return-Path: <SRS0=JWD1=RJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B891C43381
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140BD20840
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZc/vTds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCFSbx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:31:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40173 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfCFSbx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Mar 2019 13:31:53 -0500
Received: by mail-it1-f193.google.com with SMTP id l139so11671491ita.5
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2019 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNYoeEZvh+USGJDNLNdXv2J2pyRg3DyhgA6ntqaBZ8E=;
        b=OZc/vTdsk458uJkSl3c09XbZOOGJHSW/pPW9Ifg5ikfEeL8e3oF8/6/kcqeNLUNmtu
         MpFSROVHjRCS4SgweREnhf7n9GmxXumPldtTuSOwTp/pYXkNZYqE2S7JYoekTkLlfRtx
         ooU4438aQn0mcn4BT7yYIvYnqTem5Y9o9yPXf9JHdVHNb1U5B3x6++iko7mxjisEbYfV
         WbsI7Sn6K6JxGzDsBEg70cBY9hfB5gYZaw1WSdYluLo5qul/TwnLlaW9qRAtPUqUFS9Y
         WlKRyQgF5c8avyAGY6HkuD7yKD8M/zf1N2gErZ5bBAWWznXN0bswZfXOxvTbwCvSjzYU
         Qkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNYoeEZvh+USGJDNLNdXv2J2pyRg3DyhgA6ntqaBZ8E=;
        b=f+gnTpZpytbHyMOYF/9ywDdfvRrzDDJaaWjDawMKklUbv3QOY7BsG36bD5r4VycOs8
         xb2GP/QgdRmcr+IGGgn0qRJwcQehO00/Js2MoL9srBqOGMBV1CcqhFt//ytQebwgCKK6
         ztvA2Up0O68xpH9XCZZ6fXUUKmTvnklkiRumju7t3ZmDbhHE8GOufYuVytzc3TMfXcCr
         29KjyNwH8mRxcStvTUirKAx9iWLMoUYgR9BXryf9RpmJQLZDxEhrEyPmb40dczFufC9P
         VtkNw17vHoTp2CiDTPvu+5tFF09eEmVZvoPKiTgteqEhnU51FP/uvHHx/oHbpFGUkndn
         ObgA==
X-Gm-Message-State: APjAAAVcS45iTln6bB8hOimHfxBMW/MSN0x6xGI71lp0pzu/2F+X66eq
        cT7kcqhNe1fl46NUEnkC/GzGzGPZece8V1tddkzG4w==
X-Google-Smtp-Source: APXvYqwzsQsVqD9+Osgci2L6M/Dua+VC6ihIhYaG7cu+T12V2iKBbRo6o7eom0Ky0nthFjl+VLqbQK8Tef0QmQAXO3c=
X-Received: by 2002:a02:23cd:: with SMTP id u196mr4752805jau.103.1551897112006;
 Wed, 06 Mar 2019 10:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com>
In-Reply-To: <1551875418.31706.158.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 Mar 2019 10:31:40 -0800
Message-ID: <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 4:30 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-03-05 at 12:27 -0800, Matthew Garrett wrote:
> > But what's the threat? If an attacker is in a position to inject
> > additional IMA policy then in general they're already in a position to
> > violate other security assumptions. Admins who have a threat model
> > that includes an attacker being able to do this are already requiring
> > signed policy. What's the threat that requiring signed policy for this
> > specific option mitigates?
>
> That might be true, but this "feature" isn't a minor change.  It
> totally changes the IMA measurement list meaning, without any
> indication of the change in meaning.

Ok. Would annotating the audit message to indicate that the hash was
provided directly by the filesystem be sufficient? I'm not clear on
why an admin would set this flag without having read the documentation
for it - like many security features, enabling an inappropriate
combination of them may result in bad things happening. I'm not keen
on tying it to signing because:

a) There are multiple configurations where requiring signed policy
doesn't give a security benefit - if the IMA policy is part of a
verified or measured initramfs, we already have integrity guarantees
and adding an additional layer of signing doesn't win us anything (eg,
in this configuration the IMA key may be loaded from the initramfs as
well, so an attacker able to modify policy could add an additional
signing key).
b) Users who are already using signed policy won't get the additional
hint that you think is necessary.

I'm happy to add this if there's a real threat model around it, but
requiring signing for something other than security reasons seems like
it's conflating unrelated issues.
