Return-Path: <SRS0=2iBq=QI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B27C282D8
	for <linux-integrity@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A121872
	for <linux-integrity@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AHkQBSm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfBASE4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:04:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42980 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfBASE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Feb 2019 13:04:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so5701631lfh.9
        for <linux-integrity@vger.kernel.org>; Fri, 01 Feb 2019 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgeSA8RapEzaEBIQTqVc0HMpXA+lL4rs9Yi3JGdgs88=;
        b=AHkQBSm4TqXQTK1J3JDbTpXlehljteke8FWJqC3iyhu1++ihRp0bAKrqTGWaXmGBvU
         +lG1AJiS81P9ugUO1n7CxenFxnK+n0Y8fgPyge1eRM0UzyRjS/vyYUKdIsYulgFzN2gT
         R3y9HdJ23wKUNcNPaHKMU5lw00sSYOSIiRnwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgeSA8RapEzaEBIQTqVc0HMpXA+lL4rs9Yi3JGdgs88=;
        b=AmH8k5lpKCrFHga/mOtOAMHyOwWGEw0uyzAJ4oFWclUP7x8N0q/AJRhuh6b+O+r60W
         +wdaic60lsnN/Us3u8BQ9pF4/8GDDJQ1Iq41RFsDWViz7kI1ZkTq7Uj64kMwRP6LH8/c
         xYwU1aP4STK8G+rp0KamNR2vTQtCg6AEIcVy34ahs8LNwQ5GeiqasbyulIDbv8/S3UOH
         tHS5i/oKYmaEBaXX+HzOX62AMLtd9pQJ0A8Gcy61LWDoouBVZc73o0VoOGN+wOEi1Pqe
         bsH15ezY10IiMySsp2kHat8OhoVtitmmOL//DwGfRjdskdq472yOMaut3LWHd2lKiUKM
         0yzw==
X-Gm-Message-State: AHQUAuYgmgggr+XXfEZBn9HesSoBb13nVvYP8PL+en/ySmb6Rq0Xcq1n
        JPE+WX3XCvyaOqOXD9n9zcIJQ1pJGgA=
X-Google-Smtp-Source: AHgI3IY4MGinAcExcHUdDQeBbvQUAgGeJlyfhnW+hBTXtbIekV2ace/ydvAsOfyDfWgk5Mp/j2CrQg==
X-Received: by 2002:ac2:5087:: with SMTP id f7mr5169231lfm.100.1549044294024;
        Fri, 01 Feb 2019 10:04:54 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1371221ljv.1.2019.02.01.10.04.52
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 10:04:52 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id z13so5703465lfe.11
        for <linux-integrity@vger.kernel.org>; Fri, 01 Feb 2019 10:04:52 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr30859610lfa.1.1549044292236;
 Fri, 01 Feb 2019 10:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <20190131204510.GA354@linux.intel.com>
In-Reply-To: <20190131204510.GA354@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Feb 2019 10:04:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
Message-ID: <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 31, 2019 at 12:45 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> I understand what you mean. Just surprised that this hasn't failed
> before to anyone (the same driver has been even successfully used
> on ARM64 with TrustZone based fTPM implementation). It has been in
> for three years now.

Just to finish this thread off: it turns out that both ARM and ARM64
worked fine, because neither did a memcpy(), but had explicit IO copy
routines.

And in those explicit routines, 32-bit ARM did only byte accesses, and
64-bit ARM did 8-byte accesses for the bulk transfer part, but byte
accesses for the unaligned head and tail of the IO area.

So I think it's all good. x86 used to work by luck (either because all
machines that used that TPM chip always had ERMS, or because the
people who didn't have it never cared), and ARM just worked because it
would never do unaligned IO accesses anyway (well, I guess you can
force them with "readl()" on an unaligned address, but then you just
have yourself to blame).

           Linus
