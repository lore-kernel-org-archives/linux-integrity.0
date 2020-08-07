Return-Path: <SRS0=qkAG=BR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4272AC433E0
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252DD221E2
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 14:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGOaa (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:30:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHGOaa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 10:30:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67CF0ACCC;
        Fri,  7 Aug 2020 14:30:47 +0000 (UTC)
Date:   Fri, 7 Aug 2020 16:30:27 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
Message-ID: <20200807143027.GB3247@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200807112929.8984-1-pvorel@suse.cz>
 <20200807141524.GA3247@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807141524.GA3247@dell5510>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> ...
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > @@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
> >  # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> >  test1()
> >  {
> > -	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
> > +	local keyrings keycheck_lines keycheck_line templates
> > +	local policy="func=KEY_CHECK"
> > +	local test_file="file.txt"

> >  	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"

> > -	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
> > +	require_ima_policy_content $policy
> > +	keycheck_lines=$(check_ima_policy_content $policy "")
> >  	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
> While working on this patchset, I wonder, why we don't check for
> 'func=KEY_CHECK.*keyrings' in single grep call instead of grepping it twice.
> IMHO single grep call is enough. Or am I missing something?
OK, the order can be different as (according to doc [1] as Mimi remarked in some
older mail) only action is fixed on first place, order of conditions isn't
defined. Thus this would make it:
grep -E '^measure.*(func=KEY_CHECK.*keyrings|keyrings.*func=KEY_CHECK)'

But both tests have the requirement in common only 'func=KEY_CHECK', thus I'll
do some preparations for next test.

(+ we didn't require measure, thus dont_measure could fit into previous check as
well).

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/ABI/testing/ima_policy

