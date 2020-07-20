Return-Path: <SRS0=WCvd=A7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF8C433E1
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407A52080D
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTISu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTISt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:18:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E93EEADC1;
        Mon, 20 Jul 2020 08:18:54 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:18:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 3/3] ima_evm_utils: indicate "--verify" template data
 digest failures
Message-ID: <20200720081847.GC11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
 <1595174524-4976-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-3-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Helps to indicate when the template data digest verification fails.
> Indicate the problematic record in the measurement list based on
> log level and fail verification.

> fixes: ff26f9704ec4 ("ima-evm-utils: calculate and verify the template
> data digest")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
