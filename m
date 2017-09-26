Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965626AbdIZQHe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 12:07:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8QG56mE052911
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 12:07:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d7puvxgn7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 12:07:33 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 27 Sep 2017 02:07:30 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8QG7SNi37945498
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 02:07:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8QG7JxC010830
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 02:07:19 +1000
Subject: Re: [PATCH] ima: Support filesystems without i_version support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        kernel@pengutronix.de
Date: Tue, 26 Sep 2017 12:07:23 -0400
In-Reply-To: <20170921094426.4dn5qrqnabtbysxx@pengutronix.de>
References: <20170913141513.14114-1-s.hauer@pengutronix.de>
         <20170920072337.2xqn6v6oum5tdxhy@pengutronix.de>
         <1505909187.3817.117.camel@linux.vnet.ibm.com>
         <20170921094426.4dn5qrqnabtbysxx@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506442043.3677.92.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing linux-integrity@vger.kernel.org]

Hi Sascha,

Jarkko recently announced a new linux-integrity mailing list that
we'll be using for both TPM and IMA discussions.

On Thu, 2017-09-21 at 11:44 +0200, Sascha Hauer wrote:
> On Wed, Sep 20, 2017 at 08:06:27AM -0400, Mimi Zohar wrote:
> > Hi Sascha,
> > 
> > On Wed, 2017-09-20 at 09:23 +0200, Sascha Hauer wrote:
> > > Mimi,
> > > 
> > > On Wed, Sep 13, 2017 at 04:15:13PM +0200, Sascha Hauer wrote:
> > > > IMA uses the inode's i_version field to detect changes on an inode.
> > > > This seems to be an optimization for IMA and not strictly necessary.
> > > > Just ignore the i_version field if it is zero and measure the file
> > > > anyway. On filesystems which do not support i_version this may result
> > > > in an unnecessary re-measurement of a file when it has been opened for
> > > > writing without anything actually being written. For filesystems with
> > > > i_version support the behaviour doesn't change.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  security/integrity/ima/ima_main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > >  I'm not sure if this patch is appropriate, but even when it's not it
> > > >  would be interesting to know why it isn't.
> > > 
> > > Any input to this one?
> > 
> > Sorry, I'm still thinking about it.  For filesystems that
> > automatically enable i_version there would be no difference.  For
> > filesystems that require a mount option to enable i_version, this
> > changes the behavior.
> > 
> > This is slightly different than not caching the integrity results, in
> > that the cache is only cleared if someone opens the file rw.
> > 
> > (Jeff Layton posted a patch that replaces the i_version checks with
> > atime/mtime.)
> 
> Looking at that patch I think that using i_version only when
> MS_I_VERSION is set is a useful change because otherwise IMA
> ends up using i_version when it contains no sensible values.
> 
> I can't judge whether mtime is fine grained enough on all systems,
> but I don't think it's necessary to use it.
> 
> My version of ima_should_update_iint() would look like:
> 
> static bool ima_should_update_iint(struct integrity_iint_cache *iint,
> 				struct inode *inode)
> {
> 	if (atomic_read(&inode->i_writecount) != 1)
> 		return false;
> 	if (iint->flags & IMA_NEW_FILE)
> 		return true;
> 	if (IS_I_VERSION(inode) && iint->version == inode->i_version)
> 		return false;
> 	return true;
> }

The only reason for a new function would be to call it from multiple
places. The other place would probably affect caching the integrity
results.  This change you're proposing is simple enough to reason
about.  If we decide at a later date that we need a new function,
we'll refactor the code then.  For now, could you make this change in
ima_check_last_writer()?

> That is, when we don't know for sure that an inode has not changed, we
> must assume that it has changed and remeasure it. When in doubt we must
> make sure IMA is working as expected, everything else is performance
> optimization.

Agreed

thanks,

Mimi
