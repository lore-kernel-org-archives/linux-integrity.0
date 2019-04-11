Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9CC10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 05:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A354220850
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 05:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfDKFvS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKFvS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 01:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC6B1AD55;
        Thu, 11 Apr 2019 05:51:16 +0000 (UTC)
Date:   Thu, 11 Apr 2019 07:51:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh
 cleanup
Message-ID: <20190411055114.GA23472@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
 <1554944374.25614.25.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554944374.25614.25.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

thanks for your comments.

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -20,7 +20,8 @@
> >  TST_TESTFUNC="test"
> >  TST_SETUP_CALLER="$TST_SETUP"
> >  TST_SETUP="ima_setup"
> > -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> > +TST_CLEANUP_CALLER="$TST_CLEANUP"
> > +TST_CLEANUP="ima_cleanup"

> It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> defining the respective _CALLER looks strange.  The _CALLER's string
> must be empty.
TST_{SETUP,CALLER}_CALLER takes setup from the test.
It's IMHO cleaner way allowing tests to set their setup/cleanup functions and
not care that there is also some library setup/cleanup (kind of encapsulation).

We already used this for setup, I wanted to have a same approach for both setup
and cleanup. Sure I can instead add ima_setup/ima_cleanup into tests' setup/cleanup
functions, but both solutions are working and I consider encapsulation as a benefit.
The only problematic thing would be if some test needed to run it's custom
cleanup *before* library one while other tests *after*. But that's not a case here.
We also use this approach in tst_net.sh [1].

> >  TST_NEEDS_TMPDIR=1
> >  TST_NEEDS_ROOT=1

> > @@ -95,6 +96,9 @@ ima_setup()
> >  ima_cleanup()
> >  {
> >  	local dir
> > +
> > +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> > +

> Is something else setting TST_CLEANUP_CALLER?


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_net.sh#L11
