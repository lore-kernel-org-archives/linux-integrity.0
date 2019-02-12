Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8EC169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 02:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69A7214DA
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 02:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4+xh4d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBLCz5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:55:57 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35563 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLCz5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 21:55:57 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so476721ybm.2;
        Mon, 11 Feb 2019 18:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA67PX2yU8DEnB3RxaA4lLlNx2UWO6krk2k5nKWPVj4=;
        b=f4+xh4d0HnMT3BlMhEf1yWEXNNnQnCkATXYxgya73jqYnQKdFHmLHeQFmJxp+KJQ8Y
         dXRn23shaj4KAa8d0IW1Q2lZq6TPToqaW0gb0vbfU/6BtddX3OhdJgte0fu2nIG273No
         cXPcTaoMtkS9ZcHtH8oFeYUNIleD9VXDMugas0WI0AC9dvOBGXMbswhRlW8O0GxnQGwT
         cLZK/Q/B342oalO6wHusRgXu7ZBr95/VUu/fU3tbxx4op6HQIHmTEVG2WtQcpxVXjJBr
         ZoC6HWsMCXP+zH/85tMzDmyyok1yIqUYJSF7Tg46+2Tq6jI1Fc1p1+P0e7cD39XejrYl
         RYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA67PX2yU8DEnB3RxaA4lLlNx2UWO6krk2k5nKWPVj4=;
        b=A63M9Yp6cO2TiiIc06adw8LYJTqqWUQ5zCHScLMAKjXmJ7TUaH4r1Vp4HMZBpMgBNo
         p7E3IFqV5Nl8iOgNeDgE1yh//r47SR4dA052BcVbU3opLZ55rJaDW3CGLh2jEi0F4Yrg
         lMZEdDe/F0K0EsRorOzM+RKkc+p/eUHvroiBE0QrSWn1boxXLZMJmcnduzqSyl4sjPix
         f6Q4ugtNr8xWBpYA6EKckSnoKEkhw7hHvzmCkX0gek+swagTk+mHQWeMau8QDJoa4s6T
         a9Sj+4jy8tSIhOc5sTazvocQyf2VnxhAursJfZ1qczc9sTBDavalImPYLjUq2qYN4uhA
         XqMQ==
X-Gm-Message-State: AHQUAuYzfHBrMYUNKJA85bQx43/ixZ/M+W1piDmiUShricO97o4xTsK5
        PKSnCOGIpujIf9eVrDlgziurzoMx/2/4eQzWSss=
X-Google-Smtp-Source: AHgI3IbkwnR16/zJ3jRdv5Vnx3ENGEULojM/JlV7mWI+z8r9ztWJFKLHWE21NcbJ1BdQWzlkhBNrycKjDdR1rgowNOY=
X-Received: by 2002:a25:8050:: with SMTP id a16mr1123006ybn.32.1549940156102;
 Mon, 11 Feb 2019 18:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20190211165323.9369-1-iforster@suse.com> <20190211165323.9369-5-iforster@suse.com>
In-Reply-To: <20190211165323.9369-5-iforster@suse.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Feb 2019 04:55:45 +0200
Message-ID: <CAOQ4uxhrGtPxUVBfxoiGLh_5+qktC_0CC+CaFrCpY4zYXi9xXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] Ignore IMA / EVM xattrs during copy_up
To:     Ignaz Forster <iforster@suse.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>,
        Fabian Vogt <fvogt@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 11, 2019 at 10:27 PM Ignaz Forster <iforster@suse.com> wrote:
>
> From: Ignaz Forster <iforster@suse.de>
>
> EVM tries to protect these attributes during copy_up, resulting in
> the failure of the copy_up operation.
>
> This patch will skip the attributes (similar to selinux) to allow
> for later recalculation. This, however, introduces another problem:
> As overlayfs does not check the file integrity on copy_up, files with
> an invalid hash will suddenly become valid again after the copy_up
> operation.
>

"overlayfs doesn't check" means the check is to high in vfs and
needs to move to lower vfs layer?
Same as fixes in vfs_create and vfs_tmpfile.

Thanks,
Amir.
