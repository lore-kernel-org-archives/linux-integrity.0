Return-Path: <SRS0=6sc8=R7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FEC43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 09:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981CA21773
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 09:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1JE3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfC1JE3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Mar 2019 05:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73EDEAC0C;
        Thu, 28 Mar 2019 09:04:27 +0000 (UTC)
Date:   Thu, 28 Mar 2019 10:04:26 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Weihua Du <WHDu@suse.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190328090426.GB32178@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327161638.7407-1-pvorel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> Petr Vorel (3):
>   ima: Call test's cleanup inside ima_setup.sh cleanup
>   shell: Add $TST_DEVICE as default parameter to tst_umount
>   ima: Add overlay test
NOTE: I've posted just the third patch (didn't want to bother with
LTP specific non-IMA stuff. These are in LTP ML [1] [2] and also
downloadable via patchwork pwclient [3] [4].

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-March/011512.html
[2] http://lists.linux.it/pipermail/ltp/2019-March/011513.html
[3] https://patchwork.ozlabs.org/patch/1067177/
[4] https://patchwork.ozlabs.org/patch/1067178/
