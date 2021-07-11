Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9AFC07E96
	for <linux-integrity@archiver.kernel.org>; Sun, 11 Jul 2021 11:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C595F611CC
	for <linux-integrity@archiver.kernel.org>; Sun, 11 Jul 2021 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhGKMBM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 11 Jul 2021 08:01:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45696 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKMBM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 08:01:12 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1056372C8B4;
        Sun, 11 Jul 2021 14:58:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E7DF24A46ED;
        Sun, 11 Jul 2021 14:58:24 +0300 (MSK)
Date:   Sun, 11 Jul 2021 14:58:24 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] CI: Add GitHub Actions for ALT Linux
Message-ID: <20210711115824.sja6kn7qhiij4mrv@altlinux.org>
References: <20210711115539.2400162-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210711115539.2400162-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Subject missing ima-evm-utils, I will resend.

Sorry,

On Sun, Jul 11, 2021 at 02:55:39PM +0300, Vitaly Chikunov wrote:
> Build on Sisyphus branch which is bleeding edge repo.
> Package manager is apt-rpm (not APT as it may look from the scripts).
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  .github/workflows/ci.yml | 13 ++++++++++++-
>  ci/alt.sh                | 24 ++++++++++++++++++++++++
>  tests/install-swtpm.sh   | 14 +++++++++++---
>  3 files changed, 47 insertions(+), 4 deletions(-)
>  create mode 100755 ci/alt.sh
