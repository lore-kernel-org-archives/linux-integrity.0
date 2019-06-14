Return-Path: <SRS0=mSwu=UN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFCAC31E4B
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5011821721
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Jun 2019 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFNOqR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbfFNOqR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 10:46:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 950A7AF99;
        Fri, 14 Jun 2019 14:46:16 +0000 (UTC)
Date:   Fri, 14 Jun 2019 16:46:12 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] ima: Add overlay test + doc
Message-ID: <20190614144611.GA869@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
 <20190614141449.GA24614@dell5510>
 <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

> > > This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
> > > occur during appraisal.
> > Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
> > I require ima_policy=tcb here, according to Mimi [1]

> Oh, sorry, you are correct - "tcb" is correct in this case. I got confused
> as the documentation is included in the overlayfs reproducer patch.
Maybe I should put it into separate commit.

> Ignaz

Kind regards,
Petr
