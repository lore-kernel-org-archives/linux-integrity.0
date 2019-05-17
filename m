Return-Path: <SRS0=XCI5=TR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB85C04AB4
	for <linux-integrity@archiver.kernel.org>; Fri, 17 May 2019 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABA221726
	for <linux-integrity@archiver.kernel.org>; Fri, 17 May 2019 15:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfEQPlI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 17 May 2019 11:41:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729000AbfEQPlI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 11:41:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D4BBACF5;
        Fri, 17 May 2019 15:41:07 +0000 (UTC)
Date:   Fri, 17 May 2019 17:41:05 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190517154105.GB11796@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <1557889279.4581.14.camel@linux.ibm.com>
 <20190515120853.GA22992@dell5510>
 <1558044649.4507.10.camel@linux.ibm.com>
 <20190517075057.GA12489@dell5510>
 <1558090823.4507.50.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558090823.4507.50.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Fri, 2019-05-17 at 09:50 +0200, Petr Vorel wrote:

> > If it's ok for you and it's a valid test do you give an ack?

> Of course!  Thanks!
Thanks! I'll add also Ignaz's description (create README.md in IMA folder),
thus probably send a v3 to ML first, but not expecting to get much review :).

> Mimi

Kind regards,
Petr

