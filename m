Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F3C433DB
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Mar 2021 07:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C7A619AB
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Mar 2021 07:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCWHQm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:16:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhCWHQR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 03:16:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0849AAE20;
        Tue, 23 Mar 2021 07:16:16 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:16:14 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] IMA: Allow only ima-buf template for key measurement
Message-ID: <YFmVvvqhLpTGAvVU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210322173709.22150-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322173709.22150-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Mimi,

merged this one with slightly updated text of docs and commit message.

...
> +check_policy_template()
> +{
> +	while read line; do
> +	if ( echo $line | grep -q 'template=') && ( ! echo $line | grep -q 'template=ima-buf' ); then
FYI: parentheses are not necessary, thus I removed them.
> +		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
> +		return 1
> +	fi

Kind regards,
Petr
