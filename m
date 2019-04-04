Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CBC4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C30206DF
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfDDWhS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:48656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728663AbfDDWhR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 18:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C69A8AB7D;
        Thu,  4 Apr 2019 22:37:16 +0000 (UTC)
Date:   Fri, 5 Apr 2019 00:37:15 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Fabian Vogt <FVogt@suse.com>, Weihua Du <WHDu@suse.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/3] ima: Add overlay test
Message-ID: <20190404223714.GA12544@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
 <854e62ce-5e5c-7ea7-0291-0d3eaadf3fca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854e62ce-5e5c-7ea7-0291-0d3eaadf3fca@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

> thanks a lot for the LTP integration!
thanks for testing and your comments!

> Am 27.03.19 um 17:16 Uhr schrieb Petr Vorel:
> > Based on reproducer made by Ignaz Forster <iforster@suse.de>
> > used for his not upstreamed patchset [1] and previous report [2].

> Just for clarification, as the test is only referring to IMA: With IMA
> everything should be working already, the problem during copy_up operations
> was fixed by Mimi and Goldwyn in
> https://patchwork.kernel.org/patch/10776231/.
> As expected the test passes on my IMA-only setup.

> My outstanding patchset is only necessary when combining IMA with EVM - in
> this case the test will still fail. I hope I'll be able to resume my work in
> the next few weeks.
I'll rename it to evm_overlay.sh.
BTW I got (with TST_NEEDS_DEVICE=1 in ima_overlay.sh) failure with ima_appraise_tcb kernel parameter:
[  741.070585] audit: type=1800 audit(1554415774.087:46): pid=1491 uid=0 auid=0 ses=3 op="appraise_data" cause="invalid-hash" comm="ima_overlay.sh" name="/tmp/LTP_ima_overlay.eZxnT8LMZ7/mntpoint/merged/foo.txt" dev="vda2" ino=3496 res=0

which looked to me as good error.
I didn't get any ima error with ima_policy=appraise_tcb, which is supposed to be
according to docs the same (and setup code in ima_policy.c looks to me like it:
both just set ima_use_appraise_tcb). I wonder, what is wrong in my setup.

BTW can you share your setup? ima_policy=appraise_tcb kernel parameter and
loading IMA and EVM keys over dracut-ima scripts? (IMA appraisal and EVM using
digital signatures? I guess using hashes for IMA appraisal would work as well)

> > +do_test()
> > +{
> > +	local file="foo.txt"
> > +	local f
> > +
> > +	tst_mount
> > +	mounted=1
> > +
> > +	ROD echo lower \> $lower/$file
> > +	if ! echo overlay > $merged/$file 2>/dev/null; then
> > +		tst_res TFAIL "Cannot write to merged layer"
> > +		return
> > +	fi

> I can think of two additional tests here:
> 1. Appending to a file (>> instead of >)
> 2. Creating a new file in the overlay

> These cases are using different code paths and may fail independently, so
> separate tests would be handy.

I'll add them into v2.

> Ignaz

Kind regards,
Petr
