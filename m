Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B69C282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4C20989
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGQp+Vuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfA3Nih (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:38:37 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:53000 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Nih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 08:38:37 -0500
Received: by mail-it1-f181.google.com with SMTP id d11so10263081itf.2
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jan 2019 05:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeNH8ob0XdnnqWYnL2TdJ7AwkCn9+ounACD1Yc/WpHI=;
        b=MGQp+VucQLUeMX74V1eGvm8EKe5VRxAxDD9EvqbGvc0jTvfVEOWTD6zNiEnTZHfOuW
         sidmgw7S6Ee6QlLY5WtB+QgqoMGLqpNWcBB202gYgr5bRDp2pHxwvd/WXNCJzB0YZMZR
         V037kPMjKQ98Pu6cjp0EVOfldgyxFyUeAchoOmPdEb+wzvFIPaeS2S1puuwW9JQ/UveA
         ltprSJzqy188AAnrbmIXBjBnVwF7Ly5SIXR6q31Lv7kRT/tdDXDTjaBk7KXB0QIrxD18
         PDrqdbrIXSTfLy6Qho1p7n9lb8JN+dY4eeAFbaZUp7s4lNjRvgyQAGHUv3Qz3JsQmIYv
         CFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeNH8ob0XdnnqWYnL2TdJ7AwkCn9+ounACD1Yc/WpHI=;
        b=ln26bcWa88kPFkSxIuR3bspIKw26nt/Jl2xWVoSy3Jj30w6sjMnVCEnw+2bjNNM19g
         eUx3/29v1QHM7nDrrYhSQyeMjk7HmWg6A+d3ZQd0wRJG4mPt6hqgSHKtcsyH15dkbDS1
         WvZFUXYsryN0k5poNv8MKUbDBx47EmWfO2GqDdu037VsgnE3qoyisspNdMcXwdiskYV9
         R7e2E2ESSgcJM6n/nXy6tapmaI1SVpK8KmTyQia87F7ocbvjPXuyob4BqFMR29SG3CSx
         lBofyghhuDe4KOjD2CnIzDypR5e3kCF/5uo4CpywrwDQchJVaOB16RW1Cx0oughek5uK
         E5rQ==
X-Gm-Message-State: AJcUukfx87us0NUYRvpc3WMfsVURH/qGiW0quctwYWhuCAvyNkZwg97Z
        7VnrjIB/CAaDarpwYF85fZF+OMydO9a69UblNBNH8Q==
X-Google-Smtp-Source: AHgI3IZjKAnx8k7zNvOhHY4dBl3FsiuZluPNdio78p7PUpZzzccTnvgWJ1gsWphpF4WWvOXXEl8tctcma/yNrKjNtbk=
X-Received: by 2002:a24:648f:: with SMTP id t137mr14444178itc.176.1548855516660;
 Wed, 30 Jan 2019 05:38:36 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gsgpbcXD8xpG-XTZ3QCs_1CoN_9w6sOUSPVYHJ7OrnwQA@mail.gmail.com>
 <1548787074.20210.27.camel@linux.ibm.com>
In-Reply-To: <1548787074.20210.27.camel@linux.ibm.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Wed, 30 Jan 2019 19:08:25 +0530
Message-ID: <CALUj-gv6Wq_nnyA1m5es_jkkEvfQh_j2yQeDgzJTpNmBAC1Rug@mail.gmail.com>
Subject: Re: Understanding fsuuid policy rule for appraisal and exclusion
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Yes, I am having problem as I am not able to validate IMA
implementation on my device.
Basically, uuid of partition B is not yyyy-yy-yy-yy and therefore I am
not able to conclude whether it will be appraised or not.

If no rule is written for any partition is it appraised ?


On Wed, Jan 30, 2019 at 12:08 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-29 at 14:21 +0530, rishi gupta wrote:
> > Hi Team,
> >
> > I set the policy for IMA as follows. (1) Files in partition B will be
> > appraised or not if its UUID is not yyyy-yy-yy-yy. (2) Do files in
> > partition C only will be appraised irrespective of whatever rule is
> > written for other partitions.
> >
> > My goal is to include a partition and exclude all other partitions.
> >
> > # Exclude partition A
> > dont_measure fsuuid=xxxx-xx-xx-xx
> > dont_appraise fsuuid=xxxx-xx-xx-xx
> >
> > # Exclude partition B (Problem here)
> > dont_measure fsuuid=yyyy-yy-yy-yy
> > dont_appraise fsuuid=yyyy-yy-yy-yy
> >
> > # Appraise partition C
> > appraise fsuuid=zzzz-zz-zz-zz appraise_type=imasig
>
> Are you having problems with these policy rules?  Policy rules are
> handled sequentially.  Just make sure these rules are before any of
> the other "appraise" rules.
>
> Mimi
>
