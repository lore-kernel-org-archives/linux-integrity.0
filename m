Return-Path: <SRS0=olBO=TP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD0C04E87
	for <linux-integrity@archiver.kernel.org>; Wed, 15 May 2019 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A9A2089E
	for <linux-integrity@archiver.kernel.org>; Wed, 15 May 2019 11:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfEOLeQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 15 May 2019 07:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387422AbfEOLeP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 07:34:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81D7BAF2A;
        Wed, 15 May 2019 11:34:14 +0000 (UTC)
Date:   Wed, 15 May 2019 13:34:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190515113412.GB22920@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <bf41c3b5-baf4-ba7a-2136-dabbbb817473@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf41c3b5-baf4-ba7a-2136-dabbbb817473@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

Thanks a lot for a complete howto!

Kind regards,
Petr
