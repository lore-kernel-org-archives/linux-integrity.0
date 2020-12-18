Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB1DC4361B
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Dec 2020 11:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A81A23A62
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Dec 2020 11:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgLRLqT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Dec 2020 06:46:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:41744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgLRLqT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 06:46:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07D87AEA3;
        Fri, 18 Dec 2020 11:45:38 +0000 (UTC)
Date:   Fri, 18 Dec 2020 12:45:36 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <X9yWYJ3P/Qhlesq7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
 <X9sXxGacmaPYN8hp@pevik>
 <3df04bcb427a225de4fe7cb4886a3539b8735dbc.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df04bcb427a225de4fe7cb4886a3539b8735dbc.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > So, can I merge the patchset with your ack/review-by?

> Yes, I just finished reviewing the patches.   Other that clarifying the
> patch descriptions and fixing the one typo  ("tmp" -> "tpm"), it looks
> really.
Fixed those typos and commit message and finally merged.
Thanks a lot for your several patient reviews and suggestions!

Petr

> thanks! 

> Mimi

