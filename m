Return-Path: <SRS0=s/8x=P7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E41C282C0
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38721855
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfAWREN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:04:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfAWREN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jan 2019 12:04:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDE94B108;
        Wed, 23 Jan 2019 17:04:11 +0000 (UTC)
Date:   Wed, 23 Jan 2019 18:04:09 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [PATCH v3 5/6] ima: Rename the folder name for policy files to
 datafiles
Message-ID: <20190123170409.GA11731@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Jia,

> If we choose to run ima_policy.sh locally without installation,
> a failure message is reported as following:

> ima_policy 1 TCONF: missing <path>/ltp/testcases/kernel/security/integrity/ima/datafiles/measure.policy

> TST_DATAROOT would be extended to datafiles but the policy files
> are actually placed under policy.

> In order to make it easier, just rename the folder name to datafiles.

> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---

I wasn't sure about this one as make install isn't that hard to do even during
debugging and policy is more descriptive. But other tests use datafiles as well,
therefore taken as well.

Whole patchset merged, thank you both for your work.

Kind regards,
Petr
