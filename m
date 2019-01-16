Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A79C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BDD20840
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfAPHUH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:20:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:45050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfAPHUH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Jan 2019 02:20:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E4A0AEF3;
        Wed, 16 Jan 2019 07:20:06 +0000 (UTC)
Date:   Wed, 16 Jan 2019 08:20:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP][PATCH v3 0/6] LTP IMA fix bundle
Message-ID: <20190116072004.GA10601@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jia, Mimi,

> Changelog since V2:
> - Rework patch 6. Here is a quick diff against V2:

LGTM, just waiting if Mimi reviews 1st and 6th commit.

Kind regards,
Petr
