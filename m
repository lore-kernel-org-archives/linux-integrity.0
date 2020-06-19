Return-Path: <SRS0=3kCG=AA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCA9C433DF
	for <linux-integrity@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29A12073E
	for <linux-integrity@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgFSHqT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:56490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHqT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 03:46:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D44AFAC85;
        Fri, 19 Jun 2020 07:46:17 +0000 (UTC)
Date:   Fri, 19 Jun 2020 09:46:16 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200619074616.GA23036@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <20200615200121.GG129694@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615200121.GG129694@glitch>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

> > > > > > $ VERBOSE=1 make check TESTS=boog_aggregate.test
>                                        ^^^^
> 				       boot

> That's the issue :).

Thanks! Obviously everything is working with correct test name :).

Kind regards,
Petr
