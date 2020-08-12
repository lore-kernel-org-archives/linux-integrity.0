Return-Path: <SRS0=RuTV=BW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23ACC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Aug 2020 00:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D54E20782
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Aug 2020 00:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PG9gY58C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHLAx1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgHLAx1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Aug 2020 20:53:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7235C06174A
        for <linux-integrity@vger.kernel.org>; Tue, 11 Aug 2020 17:53:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so394965eje.7
        for <linux-integrity@vger.kernel.org>; Tue, 11 Aug 2020 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYh/gNBc0o62B+oTjwV1g3IEJqvln2YW1WJDmtXO1HE=;
        b=PG9gY58CFea4VSMtltenSEP95M5MBKhRh2gFYLaOpm+MskB4pQWL0hNvRyZ2EMGkEd
         Vz0WjI2gCGXLg6yz1AUCMcjC1s88b+QC4GlyFKHjdcicv4gQ2mdy/q0KfmdeoWaKkFXu
         SvTMC8uuoZHWc9OjVzQzrfjrjdVQkctGapf/2fN7+BjOY6xQD2FYxot9bB7l3nMRbHGY
         U/etiTEakwpMIFGG+9/pz4s57C50R9IZEezJskYSXHBKEilv3DXs7ryl227tk0kvP+9K
         /h9hPBrHyVW36reL2uvEm0dAx4jPOGRBymdMpR0L2PUldHbOJtVIHLp8AQP2dAXfuRV3
         qALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYh/gNBc0o62B+oTjwV1g3IEJqvln2YW1WJDmtXO1HE=;
        b=J8XNtLzQ838QTYtRqbXEoLwo9akYQOUXnonad4u9AXoStjKONbyVAr7COkRyffrku9
         snZrAezdF5Iw1WYAsl4AWWQOhtqOQ1rCVeNtiWfTaFBQhNmTo/ALg8ARBZoNgJw8bsL4
         zd8s1tmtNnuty1vdbH1w0TlXVWEfrzvPV/nIksBKa8hGJ/cuaQ+4rr0KHduUgj9T6UaF
         qunBVFnEGqZLD9pJb0VJutERPY35V/+6beqUvzJ4rfZtqH4m7MRdzv25iH0q5ecdqk+O
         9eZ6I/gkkSV+WVrXQNAjk946bkh1RONvaaz35Aoa85Ga7vanItx2UOhf1YSeKOJrNTn2
         Hx8w==
X-Gm-Message-State: AOAM5326uCP4Zt5xfyy0isKU+y4qBWhjCtg9UrR7Nk/EOiRfZLq2o1Ft
        hxERRKD4xlfp9vyIbJlEh99HJ6w6m1Pdy3HClYaX
X-Google-Smtp-Source: ABdhPJxeMY1HlD6iT+SQUDbDeq84zSwUZBHhGdLVNnTttrJ7OyviDIdNfvSgQF8XcLz1IAoqzLv1PXtEwmms30oF5bc=
X-Received: by 2002:a17:907:20e1:: with SMTP id rh1mr10469427ejb.106.1597193605390;
 Tue, 11 Aug 2020 17:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200810010210.4037-1-nramas@linux.microsoft.com>
In-Reply-To: <20200810010210.4037-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Aug 2020 20:53:14 -0400
Message-ID: <CAHC9VhQFPF_+Eo7P7xbEQkvWG8afb1NT71hKBc2HUKs8jFhCkQ@mail.gmail.com>
Subject: Re: [PATCH] field-dictionary.csv: Add errno to audit message field dictionary
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Aug 9, 2020 at 9:02 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Error code was not included in the audit messages logged by
> the integrity subsystem in the Linux kernel.
>
> commit 2f845882ecd2 in https://github.com/torvalds/linux tree added
> "errno" field in the audit messages logged by the integrity subsystem.
> The "errno" field will be set to 0 when the operation was completed
> successfully, and on failure a non-zero error code is set in this field
> in the audit message.
>
> Add the documentation for the "errno" field in the audit message
> field dictionary.
>
> Sample audit message from the integrity subsystem with errno field:
>
>     [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_key cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0 errno=-12
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  specs/fields/field-dictionary.csv | 1 +
>  1 file changed, 1 insertion(+)

Merged.  Thanks for following up with this.

-- 
paul moore
www.paul-moore.com
