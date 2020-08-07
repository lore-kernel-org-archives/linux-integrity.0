Return-Path: <SRS0=qkAG=BR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCADC433E0
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01FB20723
	for <linux-integrity@archiver.kernel.org>; Fri,  7 Aug 2020 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHGUub (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:50:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGUub (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 16:50:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EB2BAC50;
        Fri,  7 Aug 2020 20:50:48 +0000 (UTC)
Date:   Fri, 7 Aug 2020 22:50:28 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
Message-ID: <20200807205028.GA6551@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200807112929.8984-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807112929.8984-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

FYI: this patch was resent in [1] as part of [2]

[1] https://patchwork.ozlabs.org/project/ltp/patch/20200807204652.5928-2-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=194714

Kind regards,
Petr
