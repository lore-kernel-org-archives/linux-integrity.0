Return-Path: <SRS0=kHfr=QU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E01C282C2
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B06222BE
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Feb 2019 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="muAiGkfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfBMOVN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:21:13 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46319 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730964AbfBMOVN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Feb 2019 09:21:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so1442073vso.13
        for <linux-integrity@vger.kernel.org>; Wed, 13 Feb 2019 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBgeo3jT47/cB1TRoOn0GG0vfX0G94Ze9DPtiEyWnno=;
        b=muAiGkfAgvj7ze14eyCq9V6CndfS5vRb8qAMvqly2a1RE0CXmaUL6uTUixOXE+G6cl
         pIlysvQzSHcbuSgyL8iHTrKxdLIxB9eirQr+AB/i2Gna6N6ao3VDphM8fSYvxWyoM1vN
         3MWeY4kIdH38Ffv4JbERXnYofuvdqcW3cmcZ93YCTOf+ld0w5KksBELg/tvoCX6wqAWH
         ZMHBagnt07FR5K1ZwkI22h4fPM30pHEKf0yNkfFvToOyk2uUZRjb4Nk/p+UTFCgbZPXw
         5Zb7nPgPCLgtYLgDCNGmYsINk9NhyAZa0b18EEH3nrA2WT6J/KnsCzJWdchyjxdyNe8Q
         rdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBgeo3jT47/cB1TRoOn0GG0vfX0G94Ze9DPtiEyWnno=;
        b=o/wTNRAhNIURd1hooHQoy5+vYDAsf4+U3Eb8qTZSrps6v1jaL6gNc9bp2TYhFMqgDp
         +3O4YwtNZ6PLWGDNu9K2gvUdkroL8fP7PnyYpOfGYuBE/SynDNgmlQ0EcBDxxgXMM2Hz
         2soW2mIgQoZV/cUlYr656jNdiw71xPm5YDG53trt5m1FKjRcZgGjQiMhMG/Z+/33deiy
         ZLjWyj8BChWYEv0cHvdkvthsoREtYQ1V6zEPUGCLZzH7dV6AtFWR0A8qj1iiFQ5hIf6F
         B0tC9NCdWOFUh2JZZT0AVJhL4/caYLxknakgcxwa0NCnTKOa8H5GItcxTb4nI8jBV1M7
         COLg==
X-Gm-Message-State: AHQUAuYex7dHkT48Vlmi4freZfT3nIrttX+Qf1x33e7LOD9osJVzO+lY
        JKoV6E2xl8vzbOnn1yeBNFzgO21niQcfWHTdhkzM0g==
X-Google-Smtp-Source: AHgI3IZGnFUv8HvcwcAzQwJdCtu68nji5drK6KddWOwiRyuTQ889STlbnh5dyrPCgDq8kRg5H5mx2E+6QsDrKfd8kqk=
X-Received: by 2002:a67:f557:: with SMTP id z23mr300434vsn.4.1550067672526;
 Wed, 13 Feb 2019 06:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20190211143052.3128-1-bsz@semihalf.com> <20190211143052.3128-5-bsz@semihalf.com>
 <20190213112640.GI7087@linux.intel.com>
In-Reply-To: <20190213112640.GI7087@linux.intel.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Wed, 13 Feb 2019 15:21:01 +0100
Message-ID: <CABLO=+ne=dfrMiqmmxV_xOPt7QKiwSgnmokgod6ZMn4PZeahvg@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi/libstub/tpm: Retrieve TPM event log in 2.0 format
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        mingo@kernel.org, hdegoede@redhat.com,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 13, 2019 at 12:26 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Collides with Matthew's changes. I want to land those change first
> because they are almost production ready.
>
> Maybe you should consider reviewing those changes to make sure that
> they make sense to you so that you can build these on top of after
> these have landed.

Yeah, I think so. Actually, I wasn't aware of Matthew's efforts, as it
didn't appear on linux-efi mailing list. (On bad, I haven't checked
linux-integrity.)

At this point, I think it makes more sense to limit this patchset to
5/5 patch, which makes TPM event log initialized on ARM platforms.
Patches 1-4 introduce nothing more than Matthew already did, maybe
except putting calc_tpm2_event_size to a library instead of making it
inline. This function has already grown a bit so it may be a better
approach, but that's nothing to affect functionality.

I'll pull Matthew changes to my tree to confirm operation on ARM
platforms, if that works fine the only thing to merge would be 5/5 +
optionally the library change, if we reach agreement on that.

Bartosz
