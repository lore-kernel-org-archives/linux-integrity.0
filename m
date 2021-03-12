Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2148C433E0
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Mar 2021 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ECC64FCE
	for <linux-integrity@archiver.kernel.org>; Fri, 12 Mar 2021 11:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhCLLnD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:43:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:55948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhCLLm7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Mar 2021 06:42:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B50AB05C;
        Fri, 12 Mar 2021 11:42:58 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:42:57 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: Fix openSUSE Tumbleweed
Message-ID: <YEtTwXEhOTiI0mnt@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210312114152.20475-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312114152.20475-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Tested:
https://travis-ci.org/github/pevik/ima-evm-utils

Kind regards,
Petr
