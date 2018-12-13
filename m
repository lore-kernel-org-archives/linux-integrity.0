Return-Path: <SRS0=vu0O=OW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC1C65BAE
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D854A20851
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGhELrWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D854A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeLMMQ6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:16:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50527 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbeLMMQ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Dec 2018 07:16:58 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so3344715iti.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Dec 2018 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBLOgNXEijWVpPtM+pKYlMGOOytqcpJuFmA65npmt9o=;
        b=wGhELrWhL8KOvOsgrB/4xOOL/l1FSE/apeeGAhMKHMuSoEzHCTCK2PrpUHRRHjhqSq
         V4+7QbccsaA0zVOdwSk7nJp6h840JqQ44Lg9RL5Ei0QfXJwPj6uvrXexRdBDmExPIFbY
         e1FZshksMsh6n2RexHgEaw1LuXicJT88Z31Jwn+ixgmwP2NSUNVLH59hO+ZcsaX5AfWY
         C9VYvwWFXJrsx8gwsqyRZkHiMCbRaeDDj3vYeiiX84mTgrtwPTXOIO9VKxaQ5Giuloyn
         njR/HtC6/Tz0sBlfXs60orEknUkapwtp4xkzN6ayuAsH7Vfi1bX0uXHBM3jPP9F0zxlh
         L52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBLOgNXEijWVpPtM+pKYlMGOOytqcpJuFmA65npmt9o=;
        b=FuxxzwrZX0hQn9g5+Thaz+Yf2jCKmDFNBQJa9e7zGeizpbYFgk4wzFQ2DUwcokhZgf
         IFJs0t7hRtMUybYny0QM0AKaY+lWAhUCi3JCdSiqrf+Zywibckc1Zg3qLtUHVsIcUfwb
         0v90OnlSIb+BqRO7VhFMzK52KfdlZrZSoqxZ1Kp5fJMG90UxT8ZeSY3ECHITLmKvwWaq
         7Eq9BQZS9JYqrGHBasi/c/CUygRqd2Up5Ty0nJRMNu4E2ZakTqNdwDs+q81wu4LbzXms
         K3Z/Lixn/cPfrmE/77Yu8zK8/C3sMeBVy3UU5mxIn1B8VcJSHAZ0qGF5xys7KZ6ieFQZ
         BddQ==
X-Gm-Message-State: AA+aEWZn43g/br2yjt4QjJN50lwaVfI3nEyjWkGHNw7jO0TqKnGymWVQ
        mYa17/tdBTHnumAP4Hg9nnwyM9QZWRTZTXUQoPDoMA==
X-Google-Smtp-Source: AFSGD/V4aZYxIbOUnmPkTKiC6AMEhbQjZDq1rthfZJSt8QOYY8SPrZn+BuzfHNG7voiCCLFmaaNK9v2Q53k96eHwyNU=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr8720694iti.166.1544703417221;
 Thu, 13 Dec 2018 04:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20181213115717.p7ncktng2ihxw5md@merlin> <20181213121000.GM2217@ZenIV.linux.org.uk>
In-Reply-To: <20181213121000.GM2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Dec 2018 13:16:45 +0100
Message-ID: <CACT4Y+Y3Kv6LacRYzZbuNqOAMC7=z-oYUn5aQbN7j-R_JJq6RA@mail.gmail.com>
Subject: Re: [PATCH] fs: Evaluate O_WRONLY | O_RDWR to O_RDWR
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-integrity@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 13, 2018 at 1:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
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

I am eager to hear what it means then.
