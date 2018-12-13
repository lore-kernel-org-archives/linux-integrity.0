Return-Path: <SRS0=vu0O=OW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04419C67839
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D720645
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85D720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeLMMes (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:34:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44772 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMMes (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Dec 2018 07:34:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gXQCS-0006nZ-KZ; Thu, 13 Dec 2018 12:34:44 +0000
Date:   Thu, 13 Dec 2018 12:34:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-integrity@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH] fs: Evaluate O_WRONLY | O_RDWR to O_RDWR
Message-ID: <20181213123444.GN2217@ZenIV.linux.org.uk>
References: <20181213115717.p7ncktng2ihxw5md@merlin>
 <20181213121000.GM2217@ZenIV.linux.org.uk>
 <CACT4Y+Y3Kv6LacRYzZbuNqOAMC7=z-oYUn5aQbN7j-R_JJq6RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y3Kv6LacRYzZbuNqOAMC7=z-oYUn5aQbN7j-R_JJq6RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 13, 2018 at 01:16:45PM +0100, Dmitry Vyukov wrote:
> On Thu, Dec 13, 2018 at 1:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Dec 13, 2018 at 05:57:17AM -0600, Goldwyn Rodrigues wrote:
> > > A user can open(O_WRONLY | O_RDWR) and the options are valid.
> > > However, OPEN_FMODE() evaluates both FMODE_READ and FMODE_WRITE,
> > > as negative. We also need to protect the lower layers from this
> > > anomaly.
> > >
> > > Solve it by dropping O_WRONLY, so O_RDWR takes precedence.
> >
> > Congratulations, you've broken fdutils...  Passing 3 in lower bits
> > of open() flags is *not* the same as O_RDWR; behaiviour is
> > different and deliberately chosen by existing userland code.
> >
> > IOW, NAK.
> 
> I am eager to hear what it means then.

Open for ioctls, basically.  No read/write allowed, no checks for
media writability, etc. done at open() time, both read and write
*permissions* required from device node.

Think of the things like formatting a floppy, for example...
