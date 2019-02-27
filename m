Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC951C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74782133D
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMVoQfrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfB0O0v (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:26:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43575 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfB0O0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 09:26:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so13535671oib.10
        for <linux-integrity@vger.kernel.org>; Wed, 27 Feb 2019 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8upNUPQJJ6H2qjIkuc9zw7Ov5mhvlkVF6NyWSyZapU=;
        b=RMVoQfrtle6yaJUJJupjsb57U0Oq8ag890PA2JKjex/Cxq6m8hBIrWXZP05bi9XEx8
         NsKLv1gN427lk0muVnGhNVRDqqgMq7OjfNhvSFc90JbKp/F5qBbnIrvnBCigSR8ieKEK
         4ax3S18mHLyUqoxA2nUjaIKJH1AWjdSwBWs7qVhdd9Z7AjfNtdd5+BN46VY+9PJDzgOT
         Pmumkp5wpUIeM/RqC9Jj2LSwocgZWj89KCc9bcidWo/bmU5IMWDVk1DcuKEDqab26dO9
         iU3lJ7DlmffMasM+iFPkgHYyaA8IXfgAYd5dzRtlckLxlUpyOjM+uSfvQ6p1Zr9184EX
         imXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8upNUPQJJ6H2qjIkuc9zw7Ov5mhvlkVF6NyWSyZapU=;
        b=iLOzLLmPliIpuYYaOGGMucUQOpG+aT9EIc9A6LoTZKAOgjPs1iF70TJ+o5fvbc088J
         13lyM9L9uHAgbeKO0CBPMbv3PzoD/WpRcE/ulC1DjzKrM45uPeZDoqnZ3HhpgX/9/geo
         b1RLDA+RmOl4kWBtgwMfEJXsAsHjJiRCoYofC0uKxn6Gi61YX88B+Uc8biL51OmakRky
         UPqyF2mPlssd8EUkKmM/XTOhgPQf9tjL2vKXcakcpRM6AWadn9mln5hXu+YMMTRstP4g
         ZCYg82pDg/hLuOW6CMvVzmzQT7ksX2pnHyqN85AkYy6eRkZPwGT/JqInQvA7tEs4SpPx
         dwqg==
X-Gm-Message-State: AHQUAuYlq5/epOeccULkTsxLVzh7JOI2oKBjeevXvWnHg8y/FfMn/xeG
        61DEDJRXZiyHl9KApI7Rb0sexa6D02otCDRr4nNu6Q==
X-Google-Smtp-Source: APXvYqyS00nRptso/0gXba63jbsXd5fa5QBBUKHBZpVExROmtlJn9gVtohjMX8fv9V/1EGcYS3HdUSBRKbJpi8SYP+A=
X-Received: by 2002:aca:d607:: with SMTP id n7mr1034086oig.3.1551277610085;
 Wed, 27 Feb 2019 06:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com> <20190226215034.68772-5-matthewgarrett@google.com>
In-Reply-To: <20190226215034.68772-5-matthewgarrett@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Feb 2019 15:26:24 +0100
Message-ID: <CAG48ez1wFq89wL+vF_6ua-tcG8Rne0KsGfwdJ09mv_G7A=MoFQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] FUSE: Allow filesystems to provide gethash methods
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 27, 2019 at 3:24 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
> FUSE implementations may have a secure way to provide file hashes (eg,
> they're a front-end to a remote store that ties files to their hashes).
> Allow filesystems to expose this information, but require an option to
> be provided before it can be used. This is to avoid malicious users
> being able to mount an unprivileged FUSE filesystem that provides
> incorrect hashes.
>
> A sufficiently malicious FUSE filesystem may still simply swap out its
> contents after the hash has been obtained - this patchset does nothing
> to change that, and sysadmins should have appropriate policy in place to
> protect against that.
[...]
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 2f2c92e6f8cb..f63920ebce85 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -705,6 +705,13 @@ struct fuse_conn {
>         /** Does the filesystem support copy_file_range? */
>         unsigned no_copy_file_range:1;
>
> +       /*
> +        * Allow the underlying filesystem to the hash of a file. This is

nit: "to provide the", or something like that?
