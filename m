Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB0C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1120657
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfAORYF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:24:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:53728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728736AbfAORYE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 12:24:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B91B0AD14;
        Tue, 15 Jan 2019 17:24:03 +0000 (UTC)
Date:   Tue, 15 Jan 2019 18:24:02 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [PATCH 6/6] ima/ima_violations: Temporarily remove the printk
 rate limit
Message-ID: <20190115172401.GC2954@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
 <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jia,

> >> +	reset_printk_ratelimit
> > This should be called in cleanup function.
> > Actually as it's called only once I'd put it into cleanup function.

> I recognized that ima_setup.sh already defines a cleanup() so I cannot
> define another cleanup function in ima_violations.sh. Do you mean moving
> reset_printk_ratelimit into cleanup() defined in ima_setup.sh?
No. You can define redefine local cleanup function in ima_violations.sh after
loading ima_setup.sh and call ima_cleanup() in it.

+ you can change setup in ima_setup.sh:
TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
(see testcases/network/stress/ipsec/ipsec_lib.sh and testcases/network/stress/ipsec/ipsec_lib.sh and it's usage).

Cleanup of something defined in setup should be always in cleanup function and
not in any tests as it's called always after tst_brk() calls (some tests might
get skipped, so cleanup cannot be in them).

Kind regards,
Petr
