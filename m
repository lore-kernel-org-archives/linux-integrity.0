Return-Path: <SRS0=quz6=VJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FAC742D2
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 23:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004E5217D4
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Jul 2019 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562973223;
	bh=yXVnptWkMQUEWVa3VDEyGHLehn7bluNwmArHXf720bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BAfMmSka8Bww4exG/PF/CUY8KRP0DZCC/iRzCZaqYsD0mQVWLkZDbwMIsEEtSekJr
	 MjEH50MUVnbY8diOUA9bxGM5oOaDnPK5uZ0j6GI5EMWb9zK+ElbWsEsBMHmvQm+pKz
	 1Vid72YaloJj7oRQEU5zSLj0keghje84fNhmNqHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfGLXNm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfGLXNm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 19:13:42 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779362146E;
        Fri, 12 Jul 2019 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973221;
        bh=yXVnptWkMQUEWVa3VDEyGHLehn7bluNwmArHXf720bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAv4IqjD3PMSxT/RjZBrk3izCUdm+4mskfnPWwjfIu9xjj1AtVG+PSnOGkaF8W/4P
         u43/pjnjLVWPDTrZIYTQePV7z6UxqPzAqsyXhvV6oEs8n53cfh2wUAHgVVhBEoRZpP
         Dcx+g9yFBzc+CYyJW/WaIyJviLRDqsKeErMylsYw=
Date:   Fri, 12 Jul 2019 16:13:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] ima: fix ima_file_mmap circular locking dependency
Message-ID: <20190712231339.GC701@sol.localdomain>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <1562964097-8578-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562964097-8578-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On Fri, Jul 12, 2019 at 04:41:37PM -0400, Mimi Zohar wrote:
> The LSM security_mmap_file hook is called before the mmap_sem is taken.
> This results in IMA taking the i_mutex before the mmap_sem, yet the
> normal locking order is mmap_sem, i_mutex.
> 
> To resolve this problem, rename and call ima_mmap_file() after taking
> the mmap_sem.
> 

I don't think this is correct.  The normal order is i_mutex, then mmap_sem.
E.g., for buffered writes i_mutex is taken, then when each page is written the
page may have to be faulted into memory which takes mmap_sem.

What seems to have happened is that due to your patch "ima: verify mprotect
change is consistent with mmap policy" which was in linux-next for a while,
syzbot found a reproducer on next-20190531 for
"possible deadlock in process_measurement"
(https://lkml.kernel.org/lkml/00000000000054e5d1058a6df2eb@google.com/),
which already had an open syzbot report for some other reason, possibly
overlayfs-related.  The same mprotect issue also got reported in 2 other syzbot
reports, "possible deadlock in get_user_pages_unlocked (2)" and
"possible deadlock in __do_page_fault (2)".

Since your patch was dropped from linux-next, the issue no longer exists.
I invalidated the other 2 reports for you but I didn't notice this one because
it was a much older syzbot report.

So I suggest just invalidating the report "possible deadlock in
process_measurement" too, unless you think you think the older overlayfs-related
deadlock report is still valid and actionable.  It doesn't have a reproducer
and was last seen 5 months ago, so it *might* be stale:
https://syzkaller.appspot.com/text?tag=CrashReport&x=1767eeef400000

- Eric
