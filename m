Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA2C282CA
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BD1222B2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIcKCeXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBMOW4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:22:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37448 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbfBMOWx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 09:22:53 -0500
Received: by mail-it1-f194.google.com with SMTP id l131so6101074ita.2
        for <linux-integrity@vger.kernel.org>; Wed, 13 Feb 2019 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt7EwH0wU09rDKGwwGbMfe6lUinGuQ6f5KcIUgyhw2I=;
        b=UIcKCeXofzBdpiYSM9ja7ySRDYK8fSkp1w+zKIzJZLIQ+6olx1c6Fu/zN3abTTgYVL
         CaYyBJQQjQWI0r65B4siobcgvxpmzcbbK3jYxnvQ3LtW+15pNQJMzAH2AqTCVfB0GQbu
         5mfDAP0SA2EnuBfLkzVTFlRoILy7dITaSFKdYk5xTdCrir0CAOfvARRmynI04IMz497O
         xrKGcusnwDEKXas0NPYY0fXRMmJqTqHzlGLWuFYYou9+mGA+sEADpoC2vbXgR6I9RBNU
         4bH/FnKD6FsUNSODArdHKQmYx3KKy0EdRLpOy7Mo1Qi6EoqhMBHNAm03gt6kymP1lMXW
         1vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt7EwH0wU09rDKGwwGbMfe6lUinGuQ6f5KcIUgyhw2I=;
        b=FGdOYjsgt5otRfUgHMpzCmX8nAYst7iMAfGbGoPq/rJrfajecetX63keAaNtZCjSDM
         F46Me9UW65Hxfn7pu9F8h6kpDwMxbecRsxenZ9pM+yWgX0ep2mAh+hnuzBSt5qxW8L9r
         98FA4pv/uwTE771WbiKvOsC+xB19X4+Phq5t+ebmGjU/TCd4EfeCLBtCquPsINBaov2V
         qJwa5nccXzTlIyeHZ9muqNERX4Yj+AmYlLyzYbucvRRXQdF7rTQyAYmYBMzzwz464kdM
         6wskfXGZ15lpNBlBJBZ5poYb2dIWepGEURksSEl0dXClm65+zSry/osyyvJjIQo1i6WP
         ELzw==
X-Gm-Message-State: AHQUAuZ4ZwjBv8JhHUwKqRf8yLBaSkU2eeeM0x8UoFeoDmz190ef/+tc
        CF+/Um7CJBlnBD8HqVdmFk28v95K/Z6VblWAHRt5BJGp
X-Google-Smtp-Source: AHgI3IYUXUKGYLV9RnyjFdJCe+Vo7bGCAVXGmU3HPf1eDouLaYHxhTgqb+JCrlQfMuNb8gtZ1dgrplshSv+EUSqU3EA=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr430409iom.170.1550067771719;
 Wed, 13 Feb 2019 06:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20190211143052.3128-1-bsz@semihalf.com> <20190211143052.3128-5-bsz@semihalf.com>
 <20190213112640.GI7087@linux.intel.com> <CABLO=+ne=dfrMiqmmxV_xOPt7QKiwSgnmokgod6ZMn4PZeahvg@mail.gmail.com>
In-Reply-To: <CABLO=+ne=dfrMiqmmxV_xOPt7QKiwSgnmokgod6ZMn4PZeahvg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Feb 2019 15:22:39 +0100
Message-ID: <CAKv+Gu9_AgkDO5+Us0=WyqKKiV3m-Ajdqx3-NyqqN+kazuPXxw@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi/libstub/tpm: Retrieve TPM event log in 2.0 format
To:     Bartosz Szczepanek <bsz@semihalf.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peterhuewe@gmx.de,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 13 Feb 2019 at 15:21, Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> On Wed, Feb 13, 2019 at 12:26 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Collides with Matthew's changes. I want to land those change first
> > because they are almost production ready.
> >
> > Maybe you should consider reviewing those changes to make sure that
> > they make sense to you so that you can build these on top of after
> > these have landed.
>
> Yeah, I think so. Actually, I wasn't aware of Matthew's efforts, as it
> didn't appear on linux-efi mailing list. (On bad, I haven't checked
> linux-integrity.)
>
> At this point, I think it makes more sense to limit this patchset to
> 5/5 patch, which makes TPM event log initialized on ARM platforms.
> Patches 1-4 introduce nothing more than Matthew already did, maybe
> except putting calc_tpm2_event_size to a library instead of making it
> inline. This function has already grown a bit so it may be a better
> approach, but that's nothing to affect functionality.
>
> I'll pull Matthew changes to my tree to confirm operation on ARM
> platforms, if that works fine the only thing to merge would be 5/5 +
> optionally the library change, if we reach agreement on that.
>

Sounds good, and yes, it would be good to cc patches that affect the
EFI subsystem to linux-efi as well.
