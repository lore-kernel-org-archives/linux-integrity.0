Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F2C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013220645
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAOPID (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:08:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfAOPID (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 10:08:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30FE8ACEA;
        Tue, 15 Jan 2019 15:08:02 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:07:59 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 6/6] ima/ima_violations: Temporarily remove the printk
 rate limit
Message-ID: <20190115150759.GA2954@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jia, Mimi,

...
> +reset_printk_ratelimit()
> +{
> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
> +}
...
> @@ -151,6 +163,8 @@ test3()

>  	validate $num_violations $count $search

> +	reset_printk_ratelimit
This should be called in cleanup function.
Actually as it's called only once I'd put it into cleanup function.
No need to resent the patchset, if it's the only change, I change it before
merge.

@Mimi: do you agree with this change?
I've seen some issues on some distros when not using auditd daemon,
but now cannot reproduce them any more.

Kind regards,
Petr
