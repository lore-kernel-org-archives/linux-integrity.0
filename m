Return-Path: <SRS0=84RI=BD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55110C433E1
	for <linux-integrity@archiver.kernel.org>; Fri, 24 Jul 2020 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394FD206D7
	for <linux-integrity@archiver.kernel.org>; Fri, 24 Jul 2020 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXUPq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:15:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXUPp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 16:15:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21988AD0B;
        Fri, 24 Jul 2020 20:15:53 +0000 (UTC)
Date:   Fri, 24 Jul 2020 22:15:42 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
Message-ID: <20200724201542.GA85567@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com>
 <20200724131845.GB24626@dell5510>
 <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lachlan,

...
Thanks both for ack of the changes, I'll merge it on Monday.

> Hi Petr, these changes look good to me. I'm not exactly sure the convention
> here,
> since I originally wrote the patch, but feel free to mark me as
> Signed-off-by.
Of course I'll merge with you as the author of the patch :).

> Thank you for working on this!
> Lachlan

Kind regards,
Petr
