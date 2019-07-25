Return-Path: <SRS0=Qop3=VW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C0C76191
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860F021901
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 14:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfGYOIg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:08:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50942 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfGYOIg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 10:08:36 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EFFA572CC6C;
        Thu, 25 Jul 2019 17:08:33 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B6D3F4A4AE8;
        Thu, 25 Jul 2019 17:08:33 +0300 (MSK)
Date:   Thu, 25 Jul 2019 17:08:32 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] ima-evm-utils: Do not allow fallback and unknown
 hash algos
Message-ID: <20190725140832.lyfchzy2i6s5njnk@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190725061306.30515-1-vt@altlinux.org>
 <1564062242.4245.113.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564062242.4245.113.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jul 25, 2019 at 09:44:02AM -0400, Mimi Zohar wrote:
> On Thu, 2019-07-25 at 09:13 +0300, Vitaly Chikunov wrote:
> > Falling back and permissiveness could have security implications.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Thanks! šPlease update the README, removing "(default)", and rebase on
> top of the "param" changes.

In my understanding this text in README should not be changed, since not
specifying `-a' is the same as `-a sha1', so default holds. Code
handling this is not changed (which is in src/libimaevm.c:87).

What I changed is some other unexpected switching to sha1. Like when
user specify wrong hash name in `-a'.

So I will not resend this (as there is no changes). And I want to rebase
`param' & `imaevm_' prefix patch over these two commits.

Thanks,
