Return-Path: <SRS0=Ujs8=BB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599CCC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418F320771
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 14:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgGVOpO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:45:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgGVOpN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 10:45:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40FD6AE44;
        Wed, 22 Jul 2020 14:45:20 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:45:11 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200722144511.GA18945@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595428021.5311.93.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Wed, 2020-07-22 at 13:47 +0200, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  NEWS | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  delete mode 100644 NEWS

> > diff --git a/NEWS b/NEWS
> > deleted file mode 100644
> > index e69de29..0000000

> Really annoying having to include an empty file, but without it,
> autoconf fails with:

> Makefile.am: error: required file './NEWS' not found
> src/Makefile.am: installing './depcomp'
> autoreconf: automake failed with exit status: 1

OK, it does not work with the new way.
It'd be better to touch the file in autogen.sh and add it into .gitignore, but
let's ignore it.
I found that when looking at rpmlint errors, I just don't package this file and
hope you never start to use it.

Kind regards,
Petr
