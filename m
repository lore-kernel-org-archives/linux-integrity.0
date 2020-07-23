Return-Path: <SRS0=QqB2=BC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C547EC433E4
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jul 2020 17:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B1C2071A
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jul 2020 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWRF7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGWRF7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 13:05:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AB9CAC50;
        Thu, 23 Jul 2020 17:06:06 +0000 (UTC)
Date:   Thu, 23 Jul 2020 19:05:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] release feature discussion [renamed from
 Drop empty NEWS file]
Message-ID: <20200723170556.GA20782@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595428021.5311.93.camel@linux.ibm.com>
 <20200722144510.l5qwn62dlanbuul4@altlinux.org>
 <20200722145047.GB18945@dell5510>
 <1595431869.5311.102.camel@linux.ibm.com>
 <1595503098.5211.85.camel@linux.ibm.com>
 <20200723115457.GA26679@dell5510>
 <1595506070.5211.103.camel@linux.ibm.com>
 <20200723122934.GA30011@dell5510>
 <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
 <1595514618.5211.131.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595514618.5211.131.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > > Also, having docker based travis setup helps to test build against other distros
> > > (we have it in LTP).

> The existing travis.yml is a first attempt at using travis.  (Hint:
> help with cleaning it up would be much appreciated.)  Should this
> travis.yml be included now in 1.3.1 or deferred to 1.3.2?  Let's sync
> up on what should be included when.  Additional suggestions are
> welcome.

> 1.3.1 release (~1 week):
> - minor fixes

> Proposed 1.3.2 features (~3 months):
> - Travis integration
> - Support providing the TPM 2.0 PCRs as a file (--pcrs option).
> - Walking the TPM 2.0 event log as the basis for calculating the
> "boot_aggregate".

Thank you for sharing your roadmap. I'd vote for sooner include (it's not set
in the stone, it can be changed later :)), but up to you.

Not sure if I have enough time to significantly help with Travis, I'll try.
That docker based testing is nice, because it's a testing on real distro.

> thanks,

> Mimi

Kind regards,
Petr
