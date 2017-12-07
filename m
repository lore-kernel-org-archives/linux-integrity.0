Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:43792 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbdLGOuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 09:50:19 -0500
Received: by mail-qt0-f173.google.com with SMTP id w10so18079147qtb.10
        for <linux-integrity@vger.kernel.org>; Thu, 07 Dec 2017 06:50:19 -0800 (PST)
Message-ID: <1512658216.1350.16.camel@redhat.com>
Subject: Re: [RFC PATCH 2/4] ima: define new ima_sb_post_new_mount hook
From: Jeff Layton <jlayton@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 07 Dec 2017 09:50:16 -0500
In-Reply-To: <1512657359.3527.49.camel@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
         <1512649584.1350.14.camel@redhat.com>
         <1512657359.3527.49.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-12-07 at 09:35 -0500, Mimi Zohar wrote:
> Hi Jeff,
> 
> [The IMA/EVM and the TPM mailing lists have been combined as a single
> linux-integrity mailing list.]
> 
> On Thu, 2017-12-07 at 07:26 -0500, Jeff Layton wrote:
> > Sorry for the late review. I just started dusting off my i_version
> > rework, and noticed that IMA still has unaddressed problems here.
> 
> <snip>
> 
> > Personally, I'm not a huge fan of this scheme. It seems quite invasive,
> > and doesn't really seem to address the stated problem well.
> 
> A cleaned up version of this patch set was meant to follow the
> introduction of a new integrity_read method, but that patch set was
> rejected.  At this point, I have no intentions of upstreaming a
> cleaned up version this patch set either.
> 
> > The warning itself seems ok, but I don't really see what's wrong with
> > performing remeasurement when the mtime changes on filesystems that
> > don't have SB_I_VERSION set. Surely that's better than limiting it to an
> > initial measurement?
> > 
> > Maybe I just don't understand what you're really trying to achieve here.
> 
> Based on discussions with Sascha Hauer, he convinced me the i_version
> test is basically just a performance improvement and posted a patch
> that checks the filesystem for i_version support, before relying on it
> -  https://www.spinics.net/lists/linux-integrity/msg00033.html.
> 
> Mimi
> 

Thanks for the link. That patch looks good to me. Any idea when and if
it will be merged?

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
