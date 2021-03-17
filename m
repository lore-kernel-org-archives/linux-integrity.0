Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38646C433DB
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Mar 2021 20:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D191964E28
	for <linux-integrity@archiver.kernel.org>; Wed, 17 Mar 2021 20:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhCQUhb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233300AbhCQUha (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 16:37:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7544AE89;
        Wed, 17 Mar 2021 20:37:28 +0000 (UTC)
Date:   Wed, 17 Mar 2021 21:37:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
Message-ID: <YFJoh++5vxSuwJiz@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
 <YFDpFL3CSwMfZ6wo@pevik>
 <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> > > > Just a double check does it always work without template=ima-buf for all kernel versions?
> > > > Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> > > > i.e. v5.11-rc1 or backport?
> > > The above change is required. Prior to this change, template has to be
> > > specified in the policy, otherwise the default template would be used.
> > The default template is ima-ng, right?
> Yes: ima-ng is the default template.

> > > From what you write I understand that "measure func=KEY_CHECK
> > keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
> > template=ima-buf as the policy example so that it's working also on that few
> > kernels between <v5.6,v5.10> (which have IMA key functionality, but not
> > dea87d0889dd), right?
> Yes: In the kernels between v5.6 and v5.10, ima-buf template needs to be
> specified in the policy for KEY_CHECK.

OK, thus your original version - i.e. don't require template=ima-buf,
but keep it in policy example is the best approach.

> > But we should mention that in the README.md.

> Agreed - will update the README.md
Thanks!

Kind regards,
Petr

> thanks,
>  -lakshmi
