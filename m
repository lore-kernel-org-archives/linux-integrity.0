Return-Path: <SRS0=2aJh=RY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B15C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 18:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4275A21874
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Mar 2019 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9I/GbPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCUSOB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:14:01 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:51641 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUSOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Mar 2019 14:14:01 -0400
Received: by mail-it1-f177.google.com with SMTP id e24so5783922itl.1
        for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2019 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9oAyuk9pzfL6IKhaXO6IzP0K61fyPJKoTlpyPAN2WI=;
        b=Q9I/GbPQ5+9cfKgPFe1a3TUx3P2O+f/MttL0hj8cMeQvV4FWj7WVN8KjFOWPi0P+z0
         Opaiipk+5cWuKQGY+Zym2q8rUSGzlyNd7F2GCXT4QoRZ7R2fDzLFrDtZH2hL84DzLyP1
         uCcK6P9cGTgScFV88B/76v6qdOAQaMFrueVbQdbflht9gGHl7gBy3yxhWg2g+LrN8jE5
         dfuKe2k7K8HvBUMP2/mM4qBKEElFYdJRAt1xI6fC8vC4PFHG92DGrt0gUfrpib7AQFG6
         X5BvW8Y86sepD5VTo+JSNpka2cNLRIq5P3YQ3HtmgfxXXTVTd4y2QsAl6G2VWCnlEHvG
         Tf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9oAyuk9pzfL6IKhaXO6IzP0K61fyPJKoTlpyPAN2WI=;
        b=glM/93BZ6mSxJTEq46WPsK+0ls3yOz5vnDMHlCt4mia9uQM99GM2oKEKgL71y+3KaT
         ry2peFN27qe1wewqzVQhVmfQy7iiz2MoUREk99JmYxqYslT5K4z74J4LwwDAfmY17+at
         6MIMWHZ+kz2KU2GyAi5kLy/GpZYzg1k7wXz/42TTrdGb/sdUACJUS0QkDzlRRWnqyyV9
         HV+xpqoMfQygXn3pINMVZuuAcM/n9evouxpqW3SccuT+LfLEpPV6yCoU0V+nvmegglV7
         N6esPMqwnZOa6XCxFmSlygsmdnW2ZA+tbfc0S0H1QVP523cbIAhiLyibOu8ImKJJqwbu
         9IpQ==
X-Gm-Message-State: APjAAAUfYTui7V9NYBazhULFMB0di0BqwIzdF090W2TDatHaXLbSsMBZ
        0jVs9nRzcx2UC1DqCSjvtjGxSV1v4RJnPlZ0QnyKoQ==
X-Google-Smtp-Source: APXvYqxLwXEiSDM7P2AObzE/1pEs+K8Nxm6ciD8SAKSDqEiZDTMDRulw12Hpbz73N1Sz6ibL8ug4ntOo1UyGFsXo2AE=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr58374iti.161.1553192040130;
 Thu, 21 Mar 2019 11:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com> <1553167318.4899.382.camel@linux.ibm.com>
In-Reply-To: <1553167318.4899.382.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 21 Mar 2019 11:13:49 -0700
Message-ID: <CACdnJuthM1zLKFSxps2oPd6Y10kzoLdcW2F=FmwFPp8a-UXKGA@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 21, 2019 at 4:22 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [Cc'ing Jann Horn, who brought this topic up last year.]
>
> On Wed, 2019-03-20 at 10:23 -0700, Matthew Garrett wrote:
> >
> > Like you said, they can implement this by copying the code from
> > read-only pages to separate executable pages. It does make it harder,
> > but not to a huge degree - anything that's mprotect()ing file-backed
> > pages to PROT_EXEC later is presumably doing so to avoid IMA, and
> > making this change will just encourage them to add further
> > workarounds. Since this is a fight we literally can't win, what's the
> > benefit?
>
> Really, Matthew?  Such gloomy thoughts coming from someone advocating
> the "lockdown" patch set and extending IMA/EVM.  Part of our job
> description as Linux kernel security/integrity developers is exactly
> that - to make it more difficult for attackers, by hardening the
> system and closing one measurement/appraisal gap at a time.

The question is whether it really makes it more difficult for
attackers :) If we block one avenue but leave another open, we haven't
won that much - we've added complexity to the kernel, but the
attackers are still able to inject code. Fundamentally, I can't see
any way we can prevent all avenues of code injection - instead I've
interpreted IMA appraisal as a statement that we believe the signed
binary won't deliberately attempt to circumvent our security model,
and then the problem goes away.
