Return-Path: <SRS0=ycu+=UX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FAEC43613
	for <linux-integrity@archiver.kernel.org>; Mon, 24 Jun 2019 02:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75FE204FD
	for <linux-integrity@archiver.kernel.org>; Mon, 24 Jun 2019 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561343844;
	bh=eVtIWza4G23e8nkwdgxlJ1nWu9+dOyfGg7HPFjV2pN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fck+znRLhDCCQH5vEXe+A0YHU9LoK3rp/BuvbPA6B/sG5A7UqvwATKD5vb2gvcL9c
	 QzeR/4coxqCvkcLZUvb9CJy8Le2CJjACcFgU/fTWgVZ2J9yZVO4o3dxMZJ+ZCu38wa
	 BtdtvtQu1GRHr4AsyD4BMjM3RAz1UJpeFF55K7M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFXChY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFXChY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 22:37:24 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5173120820;
        Sun, 23 Jun 2019 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561328289;
        bh=eVtIWza4G23e8nkwdgxlJ1nWu9+dOyfGg7HPFjV2pN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMKazZTUMofc6+GaUrxl0gRRu0Az2WsRhZd1BBoiLi1kNAMZiGlqagI31sm5V/nzY
         bZDMhVaj1ChjfPS+DP9pbwseYniu9hxqQT4xloKlmIZZnVvJ8bCqBG7mxHltlhdpOq
         QJ+kNOzWxPwqJcnl603j4ROnJ5MhkEPIezOJ6ENs=
Date:   Sun, 23 Jun 2019 15:18:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in __do_page_fault (2)
Message-ID: <20190623221807.GF772@sol.localdomain>
References: <000000000000a7a51a058a728a6c@google.com>
 <1559678925.4237.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559678925.4237.2.camel@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 04, 2019 at 04:08:45PM -0400, Mimi Zohar wrote:
> On Mon, 2019-06-03 at 15:04 -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 69d61f577d147b396be0991b2ac6f65057f7d445
> > Author: Mimi Zohar <zohar@linux.ibm.com>
> > Date:   Wed Apr 3 21:47:46 2019 +0000
> > 
> >      ima: verify mprotect change is consistent with mmap policy
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16461c5aa00000
> > start commit:   3c09c195 Add linux-next specific files for 20190531
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15461c5aa00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11461c5aa00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10572ca6a00000
> > 
> > Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com
> > Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
> > policy")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Thank you for the report.
> 
> Mimi
> 

This patch was dropped from linux-next, so let's invalidate this bug report.

#syz invalid

- Eric
