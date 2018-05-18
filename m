Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50081 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeEROpp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 10:45:45 -0400
Date: Fri, 18 May 2018 16:45:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] ima: Reflect correct permissions for policy
Message-ID: <20180518144542.t2frtnjhiyttbeda@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180420132857.31332-1-pvorel@suse.cz>
 <1526506479.3254.8.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526506479.3254.8.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi, Matthew,

> Hi Peter,

> On Fri, 2018-04-20 at 15:28 +0200, Petr Vorel wrote:
> > Kernel configured as CONFIG_IMA_READ_POLICY=y && CONFIG_IMA_WRITE_POLICY=n
> > keeps 0600 mode after loading policy. Remove write permission to state
> > that policy file no longer be written.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  security/integrity/ima/ima_fs.c | 2 ++
> >  1 file changed, 2 insertions(+)

> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> > index fa540c0469da..c1265127d1b6 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -434,6 +434,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
> >  	ima_policy = NULL;
> >  #elif defined(CONFIG_IMA_WRITE_POLICY)
> >  	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
> > +#elif defined(CONFIG_IMA_READ_POLICY)
> > +	inode->i_mode &= ~S_IWUSR;
> >  #endif
> >  	return 0;
> >  }

> Thinking about this again, do we need to take the i_rwsem lock and
> call simple_setattr() as Matthew did in "EVM: Allow runtime
> modification of the set of verified xattrs"?

Not really sure, I didn't know that EVM is supposed to be used also for sysfs.
Matthew, does it make sense to you?

> thanks,

> Mimi


Kind regards,
Petr
