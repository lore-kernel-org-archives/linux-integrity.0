Return-Path: <SRS0=SAWj=MR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B27C00449
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Oct 2018 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FE021473
	for <linux-integrity@archiver.kernel.org>; Fri,  5 Oct 2018 17:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FE021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJFA36 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:29:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbeJFA36 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 20:29:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04751B018;
        Fri,  5 Oct 2018 17:30:13 +0000 (UTC)
Date:   Fri, 5 Oct 2018 12:30:11 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Fabian Vogt <fvogt@suse.de>,
        Ignaz Forster <iforster@suse.de>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: PROBLEM: IMA xattrs not written on overlayfs
Message-ID: <20181005173011.ia2wk4zszzev3gng@merlin>
References: <81a0a75d-bd4e-25ef-b41b-adb65ac6dee8@suse.de>
 <1538153671.3713.4.camel@linux.ibm.com>
 <0e1ba67f-3091-2d56-a464-07e1a8251e5e@suse.de>
 <2170726.hUdX192fWn@linux-e202.suse.de>
 <CAJfpegtk=OD6GVVOOtBT4Lto9x73vnSGdTMrzK-uTvStE6KxWw@mail.gmail.com>
 <1538601501.3702.217.camel@linux.ibm.com>
 <CAJfpegt52N==WoSQt_GMwZnOPyoV38j3r8vL95Ds0-NakVFueg@mail.gmail.com>
 <1538668350.3702.348.camel@linux.ibm.com>
 <20181005025733.fjlz34pph2hzcsxd@merlin>
 <1538735635.3702.423.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538735635.3702.423.camel@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181005173011.xumNmgAK_xbCSov8jXA6Wpswu4CpR6bZZk1NIoShUAE@z>

On  6:33 05/10, Mimi Zohar wrote:
> On Thu, 2018-10-04 at 21:57 -0500, Goldwyn Rodrigues wrote:
> > On 11:52 04/10, Mimi Zohar wrote:
> > > On Thu, 2018-10-04 at 00:35 +0200, Miklos Szeredi wrote:
> > > 
> > > > Right, if it's done from last fput() then it's at least not a security hole.
> > > > 
> > > > This hack may work for some filesystems, but as you noticed, it won't
> > > > work for overlayfs.  And  if probably won't work for a number of other
> > > > filesystems as well: the fs can assume that f_mode & FMODE_READ will
> > > > remain off if it was off at open time.
> > > > 
> > > > The proper way to handle it generally is to open a separate instance
> > > > of the same file from IMA with O_RDONLY and use that to calculate the
> > > > hash.   There's really no point in reusing the same file and hacking
> > > > the f_mode bits.
> > > 
> > > Is there an appropriate low level kernel call for creating a new file
> > > descriptor that would be appropriate?  dentry_open(), like the call in
> > > file_clone_open(), has a lot of overhead, including the LSM calls.
> > >  Calculating the file hash always needs to work.
> > > 
> > 
> > Mimi,
> > 
> > I have formulated a patch which is working for me on overlayfs. I am
> > using dentry_open(), which I agree may have overhead. While this
> > opens up the possibility of using it for files opened with O_DIRECT
> > which may end up getting the file into pagecache.
> > 
> > Subject: [PATCH] Open new file instance O_RDONLY to calculate hash
> > 
> > Using the open struct file to calculate the hash does not work
> > with overlayfs, because the real struct file is hidden behind the
> > overlays struct file. So, any file->f_mode manipulations are not
> > reflected on the real struct file. So, open the file again, read and
> > calculate the hash.
> > 
> > As a byproduct, we can remove all instance of f_mode manipulations
> > and can work with O_DIRECT as well.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> By "overhead", I didn't mean it from a performance perspective, but
> was concerned about the dentry_open() failing.  If "dentry_open" fails
> for any reason, the file hash will not be re-calculated, causing
> future file opens to fail.  Missing is the test for dentry_open()
> failure.

Yes, I realized that after sending the patch. I added the check.

> 
> By removing the "read" check, re-opening the file is now for all
> files, not just those opened without "read".  From a testing
> perspective, it will catch problems faster, but ...

Okay. Modified to open a new file only if we don't have read
permissions...

> 
> I've had a patch queued that removes the O_DIRECT test, but haven't
> had a chance to test it on ALL filesystems.  I would probably re-open
> the file with the original flags, plus read, as much as possible.

Okay, I have kept the O_DIRECT for now.

I will send the updated patch after some more testing.

Thanks,

-- 
Goldwyn
