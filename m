Return-Path: <SRS0=fuDz=QM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737FC282CB
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 05:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2520821
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Feb 2019 05:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN4I3JUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfBEF3B (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:29:01 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:39601 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfBEF3A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Feb 2019 00:29:00 -0500
Received: by mail-it1-f178.google.com with SMTP id a6so5428714itl.4
        for <linux-integrity@vger.kernel.org>; Mon, 04 Feb 2019 21:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAS9x9BoioMrZ+baqFLmG4RBEoOFpNqrtF9poRAxDv8=;
        b=tN4I3JUXKRdntUXEfWP8kC9wtgHKB05iUkUOCAAy2cCqmxIe0t62dGcABy06rB6SAM
         SBdVDphgjmCmxM4R+SXkUgYSf8sVFbA0V+p/nfePLmcg7jD/Bp4tLfHbKqzOGsBvierL
         gjvPWHwsPz/A6ggZyU1vvcR8au3pGP7UjzZ2Nr7dtsnObQMMCaNcUhjX028KbPIYS5Qr
         mhUQGHxM93Lu4AEtNvMDcuQY7GiR4GebOPjtW4ph4EoJcxD3VjKPRAHeAjQ9iCArKYFP
         fM7US0Qi7dkfqoCqqB/liQrorue99xxU35hjCXaSF5BOBjua7r+NhHtSYx5qmDrQG/jq
         1acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAS9x9BoioMrZ+baqFLmG4RBEoOFpNqrtF9poRAxDv8=;
        b=fogvQMhh352B9nPCzUiINgKsKlGroNq/Q/jDHdP5yBGKsVD3FM6j9yVPYElGxVFfnc
         PjL3wV1cLX3dyCjpvl/1KOpRd8kC3HlpAbff/Zeapx3TkP3dYHrTHhsEKZp24n7/5NzQ
         hTe6IkoD2wy0KQ/MMzm9LjCqO1nihYDUqvlmhnGVzSIC+oW3EkIDu98uQFXGViPExZcM
         eyXtYMjVhzGf/FyQa7fLYxvHDXpyDhlZFPGq+Uk41OE670mj/055zeuXRUdFXv1dEw8z
         VnL+C3nt9xYOxoYENkHuetnfza33ceq5LYoack7GeZ6eGalZTUfhSkrpg9oThiujH72Y
         zY0g==
X-Gm-Message-State: AHQUAubr9qGJ14+l+FMoe0pQ7iA0+RWvw8BaNIYWfTTnjNuHwemgbjJy
        GjnIP9wQWpj7CKVh0iSHRONE6xd15e1a6UGL41UCBw==
X-Google-Smtp-Source: AHgI3IbIrVIJJ8YRmXtOEgY05y8FTf5rahyXz1zBH3amS4NOohQID9Qcs1hT/NfZ62wCUXJGPRK8NpKR8yZSZRY1gfk=
X-Received: by 2002:a02:a906:: with SMTP id n6mr1655179jam.123.1549344539706;
 Mon, 04 Feb 2019 21:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gsgpbcXD8xpG-XTZ3QCs_1CoN_9w6sOUSPVYHJ7OrnwQA@mail.gmail.com>
 <1548787074.20210.27.camel@linux.ibm.com> <CALUj-gv6Wq_nnyA1m5es_jkkEvfQh_j2yQeDgzJTpNmBAC1Rug@mail.gmail.com>
 <1548856436.20210.107.camel@linux.ibm.com>
In-Reply-To: <1548856436.20210.107.camel@linux.ibm.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 5 Feb 2019 10:58:48 +0530
Message-ID: <CALUj-gtHdnjPVkwbhVzOU0sHkw4OiODrni9zySJaGACz=45Hjg@mail.gmail.com>
Subject: Re: Understanding fsuuid policy rule for appraisal and exclusion
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks I understood, only explicitly specified file using "appraise"
is actually verified.
One more thing, where can I find evmtest source code.

On Wed, Jan 30, 2019 at 7:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> (Bottom post please.)
>
> On Wed, 2019-01-30 at 19:08 +0530, rishi gupta wrote:
> > Yes, I am having problem as I am not able to validate IMA
> > implementation on my device.
> > Basically, uuid of partition B is not yyyy-yy-yy-yy and therefore I am
> > not able to conclude whether it will be appraised or not.
> >
> > If no rule is written for any partition is it appraised ?
>
> That's dependent on the rest of the policy rules.  Without an appraise
> rule, nothing is appraised.
>
> Mimi
>
