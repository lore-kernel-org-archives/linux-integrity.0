Return-Path: <SRS0=MoMd=BP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D3C433DF
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Aug 2020 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CACC22BF3
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Aug 2020 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHEIgz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEIgy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 04:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3A55B677;
        Wed,  5 Aug 2020 08:37:09 +0000 (UTC)
Date:   Wed, 5 Aug 2020 10:36:50 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: Re: [PATCH 1/3] IMA: Update key test documentation
Message-ID: <20200805083650.GA5028@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-2-t-josne@linux.microsoft.com>
 <20200804043504.GA76360@x230>
 <1ccacc7c-392c-ad45-2806-048177953acf@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccacc7c-392c-ad45-2806-048177953acf@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> Hi Petr,
> Thanks for updating the readme. Should I send a new patch with
> the changes you have proposed?
No, I'll just fix it before merging this patch.

Kind regards,
Petr
