Return-Path: <SRS0=nr5y=A2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF6C433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FA820578
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgGONhn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:37:43 -0400
Received: from [195.135.220.15] ([195.135.220.15]:56596 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731174AbgGONhn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 09:37:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC3CEAD88;
        Wed, 15 Jul 2020 13:37:45 +0000 (UTC)
Date:   Wed, 15 Jul 2020 15:37:41 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
Message-ID: <20200715133741.GB32201@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200715132817.8529-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715132817.8529-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> instead of checking in build time as it's runtime dependency.
> Also log when tsspcrread not found to make debugging easier.

> We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> thus pcr_none.c was dropped as unneeded.

> file_exist(), tst_get_path() and MIN() taken from LTP project.
BTW these parts holds Cyril's copyright. If you ever add copyright to
src/utils.[ch], please add it there.
Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>

Kind regards,
Petr
