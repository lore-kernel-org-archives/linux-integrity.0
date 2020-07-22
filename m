Return-Path: <SRS0=Ujs8=BB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE663C433E1
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8B720771
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 14:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgGVOpN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:45:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40416 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgGVOpN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 10:45:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4A37072CCDC;
        Wed, 22 Jul 2020 17:45:11 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 32E174A4AEE;
        Wed, 22 Jul 2020 17:45:11 +0300 (MSK)
Date:   Wed, 22 Jul 2020 17:45:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200722144510.l5qwn62dlanbuul4@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1595428021.5311.93.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 22, 2020 at 10:27:01AM -0400, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 13:47 +0200, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  NEWS | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  delete mode 100644 NEWS
> > 
> > diff --git a/NEWS b/NEWS
> > deleted file mode 100644
> > index e69de29..0000000
> 
> Really annoying having to include an empty file, but without it,
> autoconf fails with:
> 
> Makefile.am: error: required file './NEWS' not found
> src/Makefile.am: installing './depcomp'
> autoreconf: automake failed with exit status: 1

Maybe current ChangeLog should be renamed to NEWS?

git log is better changelog, and ChangeLog is really condensed and
suitable to be NEWS.


> 
> Mimi
