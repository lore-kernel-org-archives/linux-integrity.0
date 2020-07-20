Return-Path: <SRS0=WCvd=A7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C76C433DF
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5920C2080D
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 08:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGTIOC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:14:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgGTIOC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:14:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C2E0ADC1;
        Mon, 20 Jul 2020 08:14:06 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:13:58 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 2/3] ima-evm-utils: output specific "unknown keyid" file
 msg based on log level
Message-ID: <20200720081358.GB11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
 <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> When the IMA measurement list contains file signatures, the file
> signatures are verified either by calculating the local file data hash
> or based on the file hash contained in the measurement list.  In either
> case a list of trusted public keys needs to be provided.

> In addition to the list of known/unknown public keys needed to verify
> the measurement list being output, the specific files signed by an
> unknown public key are output as well.

> Output the individual "unknown keyid" file messages based on log level.

> Example 1: "ima_measurement" list of known/unknown public keys

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
