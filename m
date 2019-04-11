Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA5C10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DE520850
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKUVD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfDKUVD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 16:21:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B8E3AE0F;
        Thu, 11 Apr 2019 20:21:02 +0000 (UTC)
Date:   Thu, 11 Apr 2019 22:21:00 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh
 cleanup
Message-ID: <20190411202100.GA31030@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
 <1554944374.25614.25.camel@linux.ibm.com>
 <20190411055114.GA23472@x230>
 <1554985339.7843.18.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554985339.7843.18.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > > @@ -20,7 +20,8 @@
> > > >  TST_TESTFUNC="test"
> > > >  TST_SETUP_CALLER="$TST_SETUP"
> > > >  TST_SETUP="ima_setup"
> > > > -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> > > > +TST_CLEANUP_CALLER="$TST_CLEANUP"
> > > > +TST_CLEANUP="ima_cleanup"

> > > It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> > > defining the respective _CALLER looks strange.  The _CALLER's string
> > > must be empty.
> > TST_{SETUP,CALLER}_CALLER takes setup from the test.
> > It's IMHO cleaner way allowing tests to set their setup/cleanup functions and
> > not care that there is also some library setup/cleanup (kind of encapsulation).

> I'm not questioning the method for initializing this test.  I guess
> I'm asking why bother to set TST_{SETUP,CLEANUP}_CALLER this way, if
> we know that it isn't set.  Why not just initialize it as ""?

Sorry, I wasn't clear, TST_{SETUP,CLEANUP}_CALLER are set by (some) tests
(as TST_{SETUP,CLEANUP}):

$ git grep TST_SETUP= testcases/kernel/security/integrity/ima/tests/*.sh |grep -v ima_setup.sh
testcases/kernel/security/integrity/ima/tests/evm_overlay.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_measurements.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_policy.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_violations.sh:TST_SETUP="setup"

$ git grep TST_CLEANUP= testcases/kernel/security/integrity/ima/tests/*.sh |grep -v ima_setup.sh
testcases/kernel/security/integrity/ima/tests/evm_overlay.sh:TST_CLEANUP="cleanup"
testcases/kernel/security/integrity/ima/tests/ima_violations.sh:TST_CLEANUP="cleanup"

And this variables are set before loading ima_setup.sh.
So TST_{SETUP,CLEANUP}_CALLER get value from tests (if defined), overwrites it
with it's own function for tst_test.sh, where it calls them (if defined).

Or am I missing something?

> Mimi


Kind regards,
Petr
