Return-Path: <SRS0=GycC=O2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEEC43387
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083521783
	for <linux-integrity@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545071529;
	bh=Bxiyt5TOcJIJkJoYK7dLeb0fzlyUfhwcb+24gPm5SNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NzobXfKcMOVPNsrmXXef7GJW70PHx8WzBiz2hC4vZ51PjQIpddEYLwcbFOngLueNT
	 lV49zU1ZOwhhpSsrEH3h3+MT97DHz7x3PrrQXhrbe9BjpOqHs12GrM4VNUsPGBf+tV
	 7SuaIJK4mYcRrd4/rBcfsl/BTwJZQXicwCNwya8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbeLQScJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388003AbeLQScJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Dec 2018 13:32:09 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149A42086C;
        Mon, 17 Dec 2018 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545071528;
        bh=Bxiyt5TOcJIJkJoYK7dLeb0fzlyUfhwcb+24gPm5SNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSVyw5XpbTy8ovSwZCEx5mTh14apiTsZjgfIyqsYIMFJ/Z7UNOmBuFjRkcD9Vu9LS
         R40NnWZe36t9AIUV/pDVxySaOa2TbETpIB+Gkr3aixCj4Q9TL1VJaDK55jp8DiNPzE
         eh2j1PkNdgTMO44v4f+Tt4skGG3SME6vc1v7zPjE=
Date:   Mon, 17 Dec 2018 10:32:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181217183205.GA141684@gmail.com>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217164949.GA18626@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217164949.GA18626@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 17, 2018 at 08:49:49AM -0800, Christoph Hellwig wrote:
> 
> > > Given that you alread use an ioctl as the interface what is the problem
> > > of passing this data through the ioctl?
> > 
> > Do you mean pass the verity metadata in a buffer?  That cannot work in general,
> > because it may be too large to fit into memory.
> 
> Have a pointer in the ioctl and do get_user_pages on it.

I don't see how that helps.  The Merkle tree can still be too large to fit in
memory.  In the worst case, it might not even fit in the address space.  And I
don't see how get_user_pages() helps either over just copy_from_user(); what are
you proposing to do with the pages after getting them, exactly?

- Eric
