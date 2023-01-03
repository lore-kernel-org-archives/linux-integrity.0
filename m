Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEFC3DA7D
	for <linux-integrity@archiver.kernel.org>; Tue,  3 Jan 2023 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjACVKm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjACVKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 16:10:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4087D83
        for <linux-integrity@vger.kernel.org>; Tue,  3 Jan 2023 13:10:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so77077925ejc.3
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jan 2023 13:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ2FmSNv2fjhmbZL2xtwyZRIFuE2CkO7NJQ4V0Oc4Lo=;
        b=KxvXpyJbx48R7zqxK+HjZsnzh/LA/YfC2EyctNqWwm1f0aIalJDCzJcIoWHlnOxC2x
         3MEaRg83mt5GlbcyNI/Rjr9dDLJ33/34wCEw4O5vOXP/tQF9qXHJDoY66t/ojuMf4TVB
         VxoDsxyX5MzJ9cswu4NxJ6hesJloCMsm6EnEG3QUQpbcOtPV3tC+B2cH7zt8ELsgjVGa
         M/t+9SEGAcniOsDcoV6tK2ZCHPnP0DSrOt8MPyO1I/gYjbZurDs5JKYEzt+7S8r+lwvP
         f6KmE+qCIB6gSa2SUrBigHIQR3n4lLurRb5GCJKYfOQF+vIq49I0bXNqGBWNHv7Z+msd
         U3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ2FmSNv2fjhmbZL2xtwyZRIFuE2CkO7NJQ4V0Oc4Lo=;
        b=akLwOdJ0eeYoBKV1AfD4sr4UgxLyLAgJsstwxk8VxrNI9g62Fa99obS0fY1TKYLNQf
         l71JGnANQTEGeDLWJfoMjGTKJJeFh5XizpjkI4zEuqluZuTKjitwoJTub4Kqjgx0pVvV
         j2KcSKpcckpgFKQozc4MXeXdHXwIqYZdaE7j3mE0vRvRiCvXazL9PQ75hOfk7/jNksi4
         BvQnLnrgOMdgjbjhN+utsWC3/jyOdEPUT8BDVLnm9vlLJGEf/qAzvfOH8AwEIGVDCdw5
         mjrnwcyMR/qelhLmsaH6m/4iFEPVjlzkqJlxiw8HtvpcDLhp7xEGqaiFz/FlLJ0kFut7
         LbeA==
X-Gm-Message-State: AFqh2kqAkcnRZCIFd7YNTSOzCSB7VxCvsS6uarQfk85hhNBcKRyLwxhd
        R9G9DMsEnSbU38P4FXhOd/0xpTkG+mguNhiJHe0VKw==
X-Google-Smtp-Source: AMrXdXvf/3WBemrGFk0maUt724TGaq9i0EGs6E+5zxJRGtltiDXr4elLp+LeL/qQqZnGr2pW54U4MVPjM6vT2/vg4BY=
X-Received: by 2002:a17:906:500f:b0:7c0:d125:1fe6 with SMTP id
 s15-20020a170906500f00b007c0d1251fe6mr4023752ejj.514.1672780238196; Tue, 03
 Jan 2023 13:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com> <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
In-Reply-To: <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
From:   Matthew Garrett <mgarrett@aurora.tech>
Date:   Tue, 3 Jan 2023 13:10:27 -0800
Message-ID: <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     jejb@linux.ibm.com, Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 3, 2023 at 1:05 PM William Roberts <bill.c.roberts@gmail.com> wrote:

> What's the use case of using the creation data and ticket in this
> context? Who gets the
> creationData and the ticket?
> Could a user supplied outsideInfo work? IIRC I saw some patches flying around
> where the sessions will get encrypted and presumably correctly as well. This
> would allow the transfer of that outsideInfo, like the NV Index PCR value to
> be included and integrity protected by the session HMAC.

The goal is to ensure that the key was generated by the kernel. In the
absence of the creation data, an attacker could generate a hibernation
image using their own key and trick the kernel into resuming arbitrary
code. We don't have any way to pass secret data from the hibernate
kernel to the resume kernel, so I don't think there's any easy way to
do it with outsideinfo.
