Return-Path: <SRS0=ZD6g=O3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91871C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 04:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A51217D8
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Dec 2018 04:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLREGd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:06:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37964 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLREGd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Dec 2018 23:06:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gZ6eL-00072K-MV; Tue, 18 Dec 2018 04:06:29 +0000
Date:   Tue, 18 Dec 2018 04:06:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: cleanup the match_token policy code
Message-ID: <20181218040629.GT2217@ZenIV.linux.org.uk>
References: <1545092089.4206.5.camel@linux.ibm.com>
 <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
 <20181218013348.GR2217@ZenIV.linux.org.uk>
 <1545102007.4206.15.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545102007.4206.15.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 17, 2018 at 10:00:07PM -0500, Mimi Zohar wrote:

> Could you expand on commit 5b2ea6199614 ("selinux: switch away from
> match_token()") patch description.  All that it says is "It's not a
> good fit, unfortunately, and the next step will make it even less so.
> Open-code what we need here."  And there's even less for the
> equivalent Smack patch, which just says "same issue as with
> selinux...".

match_token() would require messing around with strsep() or something
equivalent.  It's not a regex; foo=%s has no idea that comma is in any
way special, etc.

As for the next commit...  Killing the Cthulhu-awful mess in
selinux_sb_eat_lsm_opts() (allocating two temproraries, concatenating
(comma-separated) non-LSM options into one, concatenating (pipe-separated)
dequoted LSM options into another, then splitting that another by '|'
instances and figuring out which option each piece is, etc.)
is a Good Thing(tm).  And having to dance around the needs of
match_token() adds extra headache, for no good reason.
