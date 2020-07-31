Return-Path: <SRS0=JU8H=BK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1708BC433E0
	for <linux-integrity@archiver.kernel.org>; Fri, 31 Jul 2020 05:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1083208E4
	for <linux-integrity@archiver.kernel.org>; Fri, 31 Jul 2020 05:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgGaF0h (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:26:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgGaF0h (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 01:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B24BAD20;
        Fri, 31 Jul 2020 05:26:48 +0000 (UTC)
Date:   Fri, 31 Jul 2020 07:26:33 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 2/4] IMA: Add policy related helpers
Message-ID: <20200731052633.GA3900@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
 <20200727223041.13110-3-pvorel@suse.cz>
 <1596138638.25003.6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596138638.25003.6.camel@kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Other than inverting the [ -f $IMA_POLICY ] tests.
Thanks for catching obvious error! Coding late night...

Kind regards,
Petr
