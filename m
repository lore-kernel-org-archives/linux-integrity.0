Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573EC677D4
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E4821557
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E4821557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeJHWmd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:42:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbeJHWmd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 18:42:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41783AD8E;
        Mon,  8 Oct 2018 15:30:16 +0000 (UTC)
Date:   Mon, 8 Oct 2018 10:30:14 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Subject: Re: [PATCH] Open a new file instance if no read permissions on files
Message-ID: <20181008153014.vb4hd7xdpbsbbrxg@merlin>
References: <20181005214213.ickkfgu5a7tzzenk@merlin>
 <1538874061.4914.16.camel@linux.ibm.com>
 <20181008121455.za53z7kgfizgtiv7@merlin>
 <1539005279.15382.119.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539005279.15382.119.camel@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008153014.I9xFHQBt1ENagi8CTt8Qw-8TXj5qHFPp6Uo_1VVzUMQ@z>

On  9:27 08/10, Mimi Zohar wrote:
> On Mon, 2018-10-08 at 07:14 -0500, Goldwyn Rodrigues wrote:
> 
> > 
> > > >  
> > > > +	if (!(file->f_mode & FMODE_READ)) {
> > > > +		struct file *f;
> > > 
> > > I would define "struct file *f = file" above, at the beginning of
> > > function, and "free(f)" below, without modifying "file".
> > 
> > I suppose you mean fput(f).
> 
> yes
> 
> > Okay, if it makes code more understandable.
> 
> Thanks
> > 
> > > 
> > > > +		int flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
> > > 
> > > Doesn't O_RDONLY need to be added?
> > 
> > No. O_RDONLY is zero. But I think I should add it for readability. The
> > compiler will optimize it eventually.
> > 
> > > Please fix the line length.
> > > 
> > > 
> > > > +		f = dentry_open(&file->f_path, flags, file->f_cred);
> > > > +		if (IS_ERR(f))
> > > > +			return PTR_ERR(f);
> 
> It's late in the release cycle to be making this change.  Would it
> make sense for now to fallback to modifying the original file
> descriptor on failure and emit a message?

Yes, perhaps and it may still succeed. Won't it be misleading if it does?
Would ima_update_xattr() be a good place? Not sure if it would spew too
many messages if there is an issue. I am all in for modifying the
original file->f_flags on failure. Just not sure about the error
message.

Currently, when we perform IMA hash calculation on a O_WRONLY file with
overlayfs, there is no error in dmesg. Just EACCES on the _next_ write
which makes it difficult to conclude whats wrong.

-- 
Goldwyn
