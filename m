Return-Path: <SRS0=vu0O=OW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB4C65BAE
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4C20645
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCcfrcLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B4C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeLMMQr (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:16:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34484 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbeLMMQr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Dec 2018 07:16:47 -0500
Received: by mail-yb1-f193.google.com with SMTP id k136so717671ybk.1;
        Thu, 13 Dec 2018 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cstkpl62t1750xRk4hfj8zLiR6aszm+caoUeTqwM3kE=;
        b=CCcfrcLSVokiO675CSVOVTX9XHY2//inPXnlp/xUQx6LoDE+/KZQ/toVLIl+9nB8bW
         2dp6qbjAGTf//s0wPhKgxidQyIRMcbUn6+CgdPXYBBY2Wpr6IqC4I9oQCwzGYwoWB/2G
         w87wVMx2TyQR13FIj2WysZ4d58iCdNi6aT/hrvCrloPeZQcm0oYN29od9rfw6Sn8iwZh
         ejIHKSWPjWRD5l0cdzenX72IOvp6PO9TBFmex51Osb9mjTtkSXG/6xAdiDsS4re/QAj/
         mx3Tn6ZAOYH+n0NJLxhaU31k7rXFSvJBwXN/jW/AzTmZmYSTG4ctTmJ6bIOW30aceXFM
         en6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cstkpl62t1750xRk4hfj8zLiR6aszm+caoUeTqwM3kE=;
        b=hJKKPQ2R1iqJdXG9o3orDrAz5n33SS0aBneqxA6cilBBvLeUMI5j/OajqjsUUX6SsX
         MKdX6I1r+emOEyrOB0fhG6Ok/hlv1Dus5tIsEA9LeG8at+9U9JxMk5AoiRlKo9Bfif2U
         o9bX/k1hRfLvxZbePKZh1by+dTEeIri3n0MW1LQcmxdvj3gTm28pzGGY4Q+D+eLKK4U5
         evpSpRBEQ8K9HaHyXvqdxubsTilLEwRhPK3KQ2L99HUw3JGPhLe4AFl2/hEPAVQho4bv
         BNN6Lx9baixcZ1AAwaalQRCcAfzFti9ShEcojyV2szKL0kCHvCPxbx+qiSGq2LwqRa/q
         4pjA==
X-Gm-Message-State: AA+aEWZVnRQjC0f31rOe3Y2z2hnT1fwtbBDgmZLT9Xtuz0waQ8vqiNfY
        GPQwlHAiNonm7M5EWSMRsGnYKFryAHvULObnNWo=
X-Google-Smtp-Source: AFSGD/UjXkJl9fYdDJkJBJDqWUdgKQbuDVHvbBp0TXZXqhj8f9ph/Oltl3RXmvfefKRGubknO54HySSiqSDhdjagJ1Q=
X-Received: by 2002:a25:3a04:: with SMTP id h4-v6mr23552237yba.32.1544703406757;
 Thu, 13 Dec 2018 04:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20181213115717.p7ncktng2ihxw5md@merlin> <20181213121000.GM2217@ZenIV.linux.org.uk>
In-Reply-To: <20181213121000.GM2217@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Dec 2018 14:16:35 +0200
Message-ID: <CAOQ4uxjcX0UYptiGjwpQHSEQW0o85Jbxzgp+5t_SODM5DBeC0g@mail.gmail.com>
Subject: Re: [PATCH] fs: Evaluate O_WRONLY | O_RDWR to O_RDWR
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, zohar@linux.ibm.com,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 13, 2018 at 2:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Dec 13, 2018 at 05:57:17AM -0600, Goldwyn Rodrigues wrote:
> > A user can open(O_WRONLY | O_RDWR) and the options are valid.
> > However, OPEN_FMODE() evaluates both FMODE_READ and FMODE_WRITE,
> > as negative. We also need to protect the lower layers from this
> > anomaly.
> >
> > Solve it by dropping O_WRONLY, so O_RDWR takes precedence.
>
> Congratulations, you've broken fdutils...  Passing 3 in lower bits
> of open() flags is *not* the same as O_RDWR; behaiviour is
> different and deliberately chosen by existing userland code.
>
> IOW, NAK.

Yap, sorry, I missed FMODE_WRITE_IOCTL when I made this suggestion.
open mode 3 seems to be reserved to some special case of ioctl to floppy
block device.

I guess it would be simpler for you to accommodate for the special case
in ima_calc_file_hash() by masking out O_ACCMODE from flags before
adding O_RDONLY.

Thanks,
Amir.
