Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005AC43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1741820989
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPAbYALv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1741820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeK1BNG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:13:06 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53448 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeK1BNG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Nov 2018 20:13:06 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so34361277ita.3
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 06:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2jR7WU/pi02hRWySsT3E8g1EePsr82UCiisX91SySI0=;
        b=pPAbYALvkBH5Dh4kV8uJfnmShUMQE59btebxkitiAVR0EnsE9nORsZ08+zzqEqIOYs
         P6l8HFzmPWyAiWqbHiR6f5NIUNEj9xU9NhsBs/ByQQjqgOksycgmwKeTOhscrl6DF3dV
         U11gI4giZAG1KptQDkBLxdqn8TRZkmZyVDYjF5y02UuesXzGHMTfujUOcKlN2LNK94W9
         FfSQteyx15CA201dSKyeH080tBc9PjEG2lACpJ7BOGbfOKhOO9++T2UNdsVljUfg5lY5
         DhurCiDmwwaa0ANmO2z2Nvy1/AYnqMNKvqrID10J1qwkY3WmrKwsXB2OeBrheCzkSD0w
         vtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2jR7WU/pi02hRWySsT3E8g1EePsr82UCiisX91SySI0=;
        b=Xzyx0eiHhYiLXWslYlhVbSsFdXv1juM/barobaHDjh9wUgP8tEbYMj3q4K4mETTolc
         Y6u2GmSyY9aHT/EW9iRnizFJ7eeMB40HFZ936CU4HJd00q2S01XCsonV7zMNncfiBfVN
         /R+HDjNy7/AeSWy1lnXsqDhIF+fVCKFFwPYjAZgSjEwkkWLMT/gjl7rAMPmVq98LaljA
         2++Bes/EWQVnbq4VFfELhRkmbLcYGbH21NDTQ5Thzftb0CqHkFUZCmMC8EtkX6NDiafT
         ccpNMEGS7rNFNgHem3x1Bl6Lkq6qbflJ/Vgkk/OG2CQ7PSFNlmN0rmKIfPS0PgedSm5I
         zXmw==
X-Gm-Message-State: AA+aEWbZ5S2KFGcO2WPHkROMnvaJ/PJtMf2n+jxrKJGINHXv4E44ubW9
        KoeBFmDgZiISaefVDrthdZ+GjVMPy8ape++1F79ppA==
X-Google-Smtp-Source: AFSGD/Vqigxl5VDvXae4WlRNyifytsOfCN5ebV1fjQgWUSckvqUkpomYPRWxgkw090xfd84BhW+6qoEfvdKUZF0RTPA=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr4185540itf.166.1543328102031;
 Tue, 27 Nov 2018 06:15:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 06:14:41
 -0800 (PST)
In-Reply-To: <CAOQ4uxj3s=17xB7Nkcav3cXZRQVFkiep0wqQXR9FG_NEE9onDg@mail.gmail.com>
References: <20181126163847.xy3acvltyeb75nb4@merlin> <1543320309.3902.137.camel@linux.ibm.com>
 <CAOQ4uxj3s=17xB7Nkcav3cXZRQVFkiep0wqQXR9FG_NEE9onDg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Nov 2018 15:14:41 +0100
Message-ID: <CACT4Y+YWPAVh3PFEfk6MBf3Wvi3_mdZDx__XcbG0JFfo4Yquhw@mail.gmail.com>
Subject: Re: [PATCH] IMA: Mask O_RDWR if FMODE_READ is set
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-integrity@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 27, 2018 at 3:06 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, Nov 27, 2018 at 2:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2018-11-26 at 10:38 -0600, Goldwyn Rodrigues wrote:
>> > A file can be opened with open(O_WRONLY | O_RDWR), so a FMORE_READ
>> > will not be set, and overlayfs will consider another copy_up() on the same
>> > file leading to a deadlock on mnt_want_write(). Fix it by masking
>> > O_RDWR while opening the file in read-only mode.
>>
>> Shouldn't the open itself fail if both O_WRONLY and O_RDWR are
>> specified?
>>
>
> Well, open doesn't fail, so what can you do? prove that no app out there
> is using this bizarre flag combination and return -EINVAL?
> You can try...
>
> BTW, the freakish thing about O_WRONLY | O_RDWR, is that it actually
> translates to !f->f_mode & FMODE_READ && !f->f_mode & FMODE_WRITE:
> OPEN_FMODE(1|2) = (3+1) & 3 = 0
>
> It would make more sense if O_WRONLY | O_RDWR would have the
> same result as O_RDWR, which is exactly what happens with
> ACC_MODE(flags) in build_open_flags().
> build_open_flags() would be a good place to check and fix this abnormality.

Good idea. Breaking userspace is not an option, but isolating lower
kernel levels from this sounds reasonable.
