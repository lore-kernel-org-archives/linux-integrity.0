Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C4C433ED
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B1F61481
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhEJR37 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 May 2021 13:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232995AbhEJR3U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 13:29:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50802AC5B;
        Mon, 10 May 2021 17:28:14 +0000 (UTC)
Date:   Mon, 10 May 2021 19:28:12 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ima_keys.sh: Check policy only once
Message-ID: <YJltLKrpw0O4MtCU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210507191414.14795-1-pvorel@suse.cz>
 <20210507191414.14795-2-pvorel@suse.cz>
 <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> On 5/7/21 12:14 PM, Petr Vorel wrote:
> > Not needed to check the same policy twice.
> > Rename to contain 'require' as we use tst_brk.

> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks Lakshmi, merged this one.

And waiting for the other two till Tushar manage to get
the dm-crypt related code to mainline. Good luck!

Kind regards,
Petr
