Return-Path: <SRS0=mSwu=UN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B92C31E4E
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A656C2173C
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfFNOOz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:14:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728913AbfFNOOz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 240A5AED5;
        Fri, 14 Jun 2019 14:14:54 +0000 (UTC)
Date:   Fri, 14 Jun 2019 16:14:50 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] ima: Add overlay test + doc
Message-ID: <20190614141449.GA24614@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

thanks for pointing out all the typos and wrong grep (previous patch).
Going to sent v5 with fixes. Just one question below.

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/README.md
> > @@ -0,0 +1,83 @@
> > +IMA + EVM testing
> > +=================
> > +
> > +IMA tests
> > +---------
> > +
> > +`ima_measurements.sh` require builtin IMA tcb policy to be loaded
> > +(`ima_policy=tcb` or `ima_policy=appraise_tcb` kernel parameter).

> This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
> occur during appraisal.
Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
I require ima_policy=tcb here, according to Mimi [1]

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-June/012363.html
