Return-Path: <SRS0=WCvd=A7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA9BC433E0
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5AF20702
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGTIFC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:05:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIFC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:05:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23244ADC1;
        Mon, 20 Jul 2020 08:05:07 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:04:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 1/3] ima-evm-utils: similarly add sanity check for file
 parameter of TPM 1.2 PCRs
Message-ID: <20200720080459.GA11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

HI Mimi,

> Parameter expects to be a copy of /sys/class/tpm/tpm0/device/pcrs (i.e.
> regular file, not a directory, block or character device, socket, ...)

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
