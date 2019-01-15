Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4FC43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856B820651
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 10:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfAOKuJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:50:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:43600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728642AbfAOKuJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 05:50:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECEC1AD12;
        Tue, 15 Jan 2019 10:50:07 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:50:05 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jia Zhang <zhang.jia@linux.alibaba.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 6/6] ima: Use ima tcb policy files for test
Message-ID: <20190115105005.GA12143@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
 <1547494342.4156.188.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547494342.4156.188.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Jia,

> On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> > In order to make all tests running smoothly, the policy files should
> > keep up with the default ima tcb policy.

> Keeping the policy rules in sync is a good idea, but some of the rules
> might cause a regression with older kernels (eg. NSFS magic).  Not
> including the rule, also poses a problem.

Mimi, you added NSFS_MAGIC into policy in v4.2 (cd025f7f9410 "ima: do not
measure or appraise the NSFS filesystem"), in the commit is Cc for 3.19, but
it's not in origin/linux-3.19.y stable tree (v3.19.8). So regression could be
from kernel <= 4.1.

> The kernel headers package includes magic.h.  One solution would be to check whether a magic name is included in magic.h.
Interesting approach, I like this approach. Policy would have to be generated on
the fly, but that shouldn't be a problem.


Kind regards,
Petr
