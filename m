Return-Path: <SRS0=qkAG=BR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF83C433DF
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 07:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C1922CAF
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 07:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHGHR7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:17:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGHR6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 03:17:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5F37ADE0;
        Fri,  7 Aug 2020 07:18:14 +0000 (UTC)
Date:   Fri, 7 Aug 2020 09:17:54 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: Re: [PATCH 2/3] IMA: Refactor datafiles directory
Message-ID: <20200807071754.GA9748@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-3-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803184726.2416-3-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> The IMA datafiles directory is structured so that it cannot be directly
> expanded to include datafiles for tests other than `ima_policy.sh`.

> Move the contents of the IMA datafiles directory into an IMA
> datafiles/policy directory.

Why it's required? Can't you use glob for inclusion?

*.policy for valid policies
*.policy-invalid for invalid policies
*.policy* for all policies

BTW I plan to use policies for other tests than just ima_policy.sh

I don't refuse this patch, I just simply don't understand why it's required.

Kind regards,
Petr
