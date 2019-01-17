Return-Path: <SRS0=OrKi=PZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF67C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 06:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB020855
	for <linux-integrity@archiver.kernel.org>; Thu, 17 Jan 2019 06:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYTHhRON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfAQG5S (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:57:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36812 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfAQG5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jan 2019 01:57:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id i73so3578295ywg.3;
        Wed, 16 Jan 2019 22:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAZ9Rjt/6RcjXhH85PnciAGkkz1/sDx/GrUCk6jhoDw=;
        b=YYTHhRON8CLZcwG4jIMMwJ571mICQnDdFez2o0PtDgIx8zaxLkTsyQNfKhih3L5Je9
         N7VUun8FwMdap07neffEAL/vHYn8qH5Ez0FINBw/vpffVS860fzr4GZCAJbVL81RhKWl
         kz4dKJ9TnIafi3dx+8U9O0zdY7DSZu4BOvUVL/H62+lLM6JgxDKNuagR8ecxIZy4nyjI
         leLGNAL5m77sYUYyrgsIhw2iFWXwvcOfHK11ubKU3qF/v/gmDF0HF1Frbz3PS1ZtRBQ+
         A9rZnZkH2psfJsJvMnd08ZWSiiS5FTt84xhmN8rIXbWbhK8u+CpTras+cFucKMzO/FI1
         l23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAZ9Rjt/6RcjXhH85PnciAGkkz1/sDx/GrUCk6jhoDw=;
        b=V6iFevXaM77L7ygb1zJbzDi9FejjeFKFnpgMpAmP7MPL+dLYs02JcIkqYOA4nsPPpQ
         VR5gyNJejybBQdWuzG5C4rQaxLipIS1n85V0q0tgZ5EkXidYzbqE8A1VQ8BbECxxG02m
         Pl8eJz+aAhumYE4NfXHRQl6iCu/N+jIgsmmjkIF7nDc3UsJmFD3qs0uLUu34Oz0eqwzG
         7XMXL3MwVFbTfksmnztzQs3TN3wbtp24A6If3KhDJJVBNiIePkWQ1Z72l6MLL7yfqnzg
         lburJ0yTR6hrzrFliNgMcnmdy/FrfXA5XKsFXbbtj7B47Tg74AGA928c+m0HqBtnGF6k
         VtOg==
X-Gm-Message-State: AJcUukda9eVHBj89dx94a7G0X87BKfcGYHTaFhU5qqUDdIbwcDZN+JlD
        6F7wQR2gZfas/Q0EHHy4uk4Cld+sivbZmhGObxM=
X-Google-Smtp-Source: ALg8bN62KxmGc8dlk4eIQYe4Y2kfanUyR3PoewzNj/ag6Z1rmRh6+spo/dLtK6o0LNaUW1+gVUNoLnJ4wJgiXP8ejNA=
X-Received: by 2002:a81:3558:: with SMTP id c85mr12020824ywa.34.1547708237629;
 Wed, 16 Jan 2019 22:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20190116173945.mmnwsw5bglk6yryj@merlin>
In-Reply-To: <20190116173945.mmnwsw5bglk6yryj@merlin>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Jan 2019 08:57:06 +0200
Message-ID: <CAOQ4uxgDi38dX0VLfHZ8R_fesN=0rBQB7Cw0ObRqy5fUqFepTQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: IMA Call ima_post_mknod_path() on copy_up'd dentry
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>, zohar@linux.ibm.com,
        iforster@suse.de, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 17, 2019 at 1:22 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> Since copy_up() happens when you are modifying a file on overlay,
> it is still a new file for the underlying filesystem. Mark it
> in IMA for re-evaluating as a new file.
>
> Putting ima calls within overlayfs may not be the best method, but this is
> the only one which I thought would work.
>

Doesn't look right.
Overlayfs creates the new inode with vfs_tmpfile() and I think that is
where you should plug the IMA hook.

> Here is a test case:
> mount /dev/vdb /lower
> mount /dev/vdc /upper
> echo "Original contents" > /lower/existingfile.txt
> mount -t overlay overlay /mnt -o upperdir=/upper/upper,workdir=/upper/workdir,lowerdir=/lower
> echo "New contents" > /mnt/existingfile.txt
>

I bet you can reproduce that same issue without overlayfs
by creating an O_TMPFILE from userspace.

The ima_file_check() hook in do_last() does not cover the O_TMPFILE
case.

Thanks,
Amir.
