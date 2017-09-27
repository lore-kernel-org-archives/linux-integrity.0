Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46007 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750854AbdI0Gnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 02:43:52 -0400
Date: Wed, 27 Sep 2017 08:43:51 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] ima: Support filesystems without i_version support
Message-ID: <20170927064351.l2g53e6k5bjksfc6@pengutronix.de>
References: <20170913141513.14114-1-s.hauer@pengutronix.de>
 <20170920072337.2xqn6v6oum5tdxhy@pengutronix.de>
 <1505909187.3817.117.camel@linux.vnet.ibm.com>
 <20170921094426.4dn5qrqnabtbysxx@pengutronix.de>
 <1506442043.3677.92.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1506442043.3677.92.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 26, 2017 at 12:07:23PM -0400, Mimi Zohar wrote:
> [Cc'ing linux-integrity@vger.kernel.org]
> 
> Hi Sascha,
> 
> Jarkko recently announced a new linux-integrity mailing list that
> we'll be using for both TPM and IMA discussions.
> 
> On Thu, 2017-09-21 at 11:44 +0200, Sascha Hauer wrote:
> > On Wed, Sep 20, 2017 at 08:06:27AM -0400, Mimi Zohar wrote:
> > > Hi Sascha,
> > > 
> > > On Wed, 2017-09-20 at 09:23 +0200, Sascha Hauer wrote:
> > > > Mimi,
> > > > 
> > > > On Wed, Sep 13, 2017 at 04:15:13PM +0200, Sascha Hauer wrote:
> > > > > IMA uses the inode's i_version field to detect changes on an inode.
> > > > > This seems to be an optimization for IMA and not strictly necessary.
> > > > > Just ignore the i_version field if it is zero and measure the file
> > > > > anyway. On filesystems which do not support i_version this may result
> > > > > in an unnecessary re-measurement of a file when it has been opened for
> > > > > writing without anything actually being written. For filesystems with
> > > > > i_version support the behaviour doesn't change.
> > > > > 
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > ---
> > > > >  security/integrity/ima/ima_main.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > >  I'm not sure if this patch is appropriate, but even when it's not it
> > > > >  would be interesting to know why it isn't.
> > > > 
> > > > Any input to this one?
> > > 
> > > Sorry, I'm still thinking about it.  For filesystems that
> > > automatically enable i_version there would be no difference.  For
> > > filesystems that require a mount option to enable i_version, this
> > > changes the behavior.
> > > 
> > > This is slightly different than not caching the integrity results, in
> > > that the cache is only cleared if someone opens the file rw.
> > > 
> > > (Jeff Layton posted a patch that replaces the i_version checks with
> > > atime/mtime.)
> > 
> > Looking at that patch I think that using i_version only when
> > MS_I_VERSION is set is a useful change because otherwise IMA
> > ends up using i_version when it contains no sensible values.
> > 
> > I can't judge whether mtime is fine grained enough on all systems,
> > but I don't think it's necessary to use it.
> > 
> > My version of ima_should_update_iint() would look like:
> > 
> > static bool ima_should_update_iint(struct integrity_iint_cache *iint,
> > 				struct inode *inode)
> > {
> > 	if (atomic_read(&inode->i_writecount) != 1)
> > 		return false;
> > 	if (iint->flags & IMA_NEW_FILE)
> > 		return true;
> > 	if (IS_I_VERSION(inode) && iint->version == inode->i_version)
> > 		return false;
> > 	return true;
> > }
> 
> The only reason for a new function would be to call it from multiple
> places. The other place would probably affect caching the integrity
> results.  This change you're proposing is simple enough to reason
> about.  If we decide at a later date that we need a new function,
> we'll refactor the code then.  For now, could you make this change in
> ima_check_last_writer()?

I liked the new function approach because I think it makes the code
slightly easier to read. Anyway, I just sent a new patch to the new
list.

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
