Return-Path: <SRS0=GcCo=CG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162BC433E2
	for <linux-integrity@archiver.kernel.org>; Fri, 28 Aug 2020 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317582086A
	for <linux-integrity@archiver.kernel.org>; Fri, 28 Aug 2020 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgH1MuV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbgH1Mta (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 08:49:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0E6FB5AF;
        Fri, 28 Aug 2020 12:49:59 +0000 (UTC)
Date:   Fri, 28 Aug 2020 14:49:24 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200828124924.GB15355@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510>
 <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
 <20200827225417.GA29921@dell5510>
 <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
 <20200828060554.GB15251@dell5510>
 <3c720a7060a846088f8e60ce8b5c032467e97f23.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c720a7060a846088f8e60ce8b5c032467e97f23.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Fri, 2020-08-28 at 08:05 +0200, Petr Vorel wrote:
> > BTW there are also plans for reboot support [1] [2], that could be used as
> > workaround for configuration without CONFIG_IMA_READ_POLICY=y and
> > CONFIG_IMA_WRITE_POLICY=y.

> The reboot support could also be used for carrying the IMA measurement
> list across kexec and verifying the TPM PCRs.
Adding into my TODO list. I'd just run whole test ima_kexec.sh twice and reboot
in between.

> Mimi

Kind regards,
Petr

