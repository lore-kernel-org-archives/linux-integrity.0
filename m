Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9452C169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21FB2184A
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 03:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evY3JluV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBLD3n (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:29:43 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32788 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBLD3n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 22:29:43 -0500
Received: by mail-yw1-f68.google.com with SMTP id p17so488547ywg.0;
        Mon, 11 Feb 2019 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+t1DW+eh3Kim5nHOn3BBpzpa6p/cXjO1C2a4Ow7+dUs=;
        b=evY3JluVhBcVhgwf6ZuKHyRxlLmUkaGVxn61uLuIoWOZg5X1OSiZ6MdwGPoZNi12F6
         zxFGMfbyu4l22vEezLd2Tg5FXoygT1q01MsW5sWdQJv3scnAqP5+rp8ZkQwJyj/ri8PT
         5cELJ6XWt9mcj+gMvazmy0RP50GeRqxR834A9SqiOziAbvhjf6L1/htXac3QmzSryktt
         aGRJg/KfTHFZAlLEArNgXA1FXAa7UrVMP23DMRo1HiR2IbDAayUAOkYzOezVqOkMff4c
         W1f+YsTCDFvWsr5a1V046akE9cMvndjjO7mruwqLxtSUinOcEO7epXVngRnvFh9stinJ
         QNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+t1DW+eh3Kim5nHOn3BBpzpa6p/cXjO1C2a4Ow7+dUs=;
        b=FbHSD1hZiaXGa513UZEO5VKK8HMS68GkOtjfJ6JKiiM/jHpaImZJ2QqT83sTZa+tUf
         AUTSvYnFz/es20llQxHG4BsfdMBDtbsrxM6MaBNLgM5OMRp2bR5TGz9fPrCV0p9vv90e
         O8hMasjpnaeb3U2XmWgf17lvptK5uJl53jVT7rPHfBSgSXr5+IZRZ+buVDOs9VfjUgo7
         ThC4uhf1dSGwYskFd9+u0OsfLjIWBB+rrg8/VXPoO2lKfKea/ywQ3N3N0244DH+HZgb2
         hdtCevljwHmNSyoNxaSjF8dTipy6HaJq05P+rsjJ4pIvIGIOx5p6n8EqiCoDet8qoTtR
         TUrw==
X-Gm-Message-State: AHQUAubcSxWyb60c+XwjVHWob6dpKtHCsgdYG0kc6TK5HouBJdZ5nDYS
        SQ2FAHE5fNlYmxUaEEQLNg6X7hHNIwTWnDynPzg=
X-Google-Smtp-Source: AHgI3IZD8vc9yMDRmlrL7jskuFzw2MWzVC10xizAbMWHNS89dKlYsM7OOO4DQF6GCSe1Gnnq0OPEXlmy1QapNQZz/BU=
X-Received: by 2002:a81:5509:: with SMTP id j9mr1181193ywb.409.1549942181892;
 Mon, 11 Feb 2019 19:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20190211165323.9369-1-iforster@suse.com>
In-Reply-To: <20190211165323.9369-1-iforster@suse.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Feb 2019 05:29:30 +0200
Message-ID: <CAOQ4uxhyk7BEmQYf8D6j8FvYJGaxPoa2oJePeF42jbdp__=PSA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Fix overlayfs on EVM
To:     Ignaz Forster <iforster@suse.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 10:28 PM Ignaz Forster <iforster@suse.com> wrote:
>
> From: Ignaz Forster <iforster@suse.de>
>
> This patch series tries to solve several problems found when using
> EVM on an overlay file system.
>
> Especially patch 4 and 5 will need further discussion; patch 4 will
> introduce follow up problems, patch 5 can be considered a workaround
> at best.
>

I think maybe the entire series (short of vfs_create hook) is a workaround.

Let's stop and think. What is IMA/EVM meant to do?
Provide tamper proof protection for persistent storage. Right?

Overlayfs uses other filesystems to store persistent data/metadata,
so if IMA/EVM already protect those other filesystems, we got
tamper proof already don't we?

The issue with overlayfs and security hooks is often credentials
because underlying filesystems are accessed with different
credentials (mounter credentials) than the overlay file access.
Is that an issue for IMA/EVM?
Or is it an issue that IMA policy is path based and may only
apply to the overlay path and not underlying path??

I had already suggested once to mark overlay inodes with
NOIMA flag:
https://marc.info/?l=linux-unionfs&m=154529013929472&w=2
and there was a similar suggestion for FUSE:
https://marc.info/?l=linux-fsdevel&m=151871326115716&w=2

If my assumptions so far are correct, then the effort for making
IMA/EVM work with overlayfs should focus around finding the
places where overlayfs uses lower level vfs interface (often
vfs_xxx helpers) and make sure that the IMA hooks are place
in those lower vfs interfaces, just like vfs_create() patch does
and like vfs_tmpfile() patch did before it.

Thanks,
Amir.
