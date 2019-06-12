Return-Path: <SRS0=7aJQ=UL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B3C31E48
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Jun 2019 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6671D215EA
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Jun 2019 15:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409368AbfFLP31 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:29:27 -0400
Received: from fieldses.org ([173.255.197.46]:51294 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbfFLP31 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 11:29:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A0C41E3B; Wed, 12 Jun 2019 11:29:27 -0400 (EDT)
Date:   Wed, 12 Jun 2019 11:29:27 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
Message-ID: <20190612152927.GE16331@fieldses.org>
References: <20190608135717.8472-1-amir73il@gmail.com>
 <20190608135717.8472-2-amir73il@gmail.com>
 <1560343899.4578.9.camel@linux.ibm.com>
 <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 12, 2019 at 06:09:59PM +0300, Amir Goldstein wrote:
> But if I am following Miklos' suggestion to make i_count 64bit, inode
> struct size is going to grow for 32bit arch when  CONFIG_IMA is not
> defined, so to reduce impact, I will keep i_readcount as a separate
> member and let it be defined also when BITS_PER_LONG == 64
> and implement inode_is_open_rdonly() using d_count and i_count
> when i_readcount is not defined.

How bad would it be just to let the inode be a little bigger?  How big
is it already on 32 bit architectures?  How much does this change e.g.
how many inodes you can cache per megabyte?

--b.
