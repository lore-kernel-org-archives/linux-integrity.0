Return-Path: <SRS0=DtY+=7J=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E3FC433E0
	for <linux-integrity@archiver.kernel.org>; Wed, 27 May 2020 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB072075A
	for <linux-integrity@archiver.kernel.org>; Wed, 27 May 2020 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgE0UPd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 May 2020 16:15:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:37928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgE0UPd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 16:15:33 -0400
IronPort-SDR: XNAzeZFY8Exw1Z+NgvbhnjyRKh/y1+iGEKX5qBCIl1Ik2Q6NAeL1H+DVBg6lty23Ez5xJH2Zqx
 /pBrmQWLwydA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 13:15:32 -0700
IronPort-SDR: Wlc8ouIzAYvIUiR0AT0/iHLj1lutDu+PBYkUs0WPLXaLEKAVUcNytQFTNlL8Yr2hYqlBc2nx6f
 KLyIA6GolsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="302578712"
Received: from lkakolx-mobl.ger.corp.intel.com ([10.249.43.73])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 13:15:28 -0700
Message-ID: <d6b4591c49f01f24b0dbfd25c8792a3f506d6cae.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mario.Limonciello@dell.com, James.Bottomley@HansenPartnership.com,
        peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, jeffrin@rajagiritech.edu.in,
        alex@guzman.io
Date:   Wed, 27 May 2020 23:15:26 +0300
In-Reply-To: <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> Thanks, I don't pretend to understand the nuances of this particular code,
> but I was hoping that the request to revert got some attention since Alex's
> kernel Bugzilla and message a few months ago to linux integrity weren't.

Removing linux-kernel from CC since this subsystem internal discussion.

Seeing the whole thing first time today.

Bugzilla is the first thing to ignore when busy. It is good as place
holder for bugs, but all discussions should happen only in LKML. There's
no official requirement to proactively use Bugzilla for anything.

That said I'm happy that people put stuff there so that it gets logged.

For follow-up's use only LKML if it is important to you. Those will get
processed.

As far as this goes, if nothing is heard from me, check that you put me
as CC to the original email. Otherwise, I might have missed it (by mistake,
not by purpose).

Honestly, I'm not sure what point was this patch when there was time to
wait for months without response. Why the passivity for all this time?

/Jarkko

