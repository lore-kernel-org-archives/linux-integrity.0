Return-Path: <SRS0=+O7K=63=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8FCA90AF
	for <linux-integrity@archiver.kernel.org>; Wed, 13 May 2020 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E220659
	for <linux-integrity@archiver.kernel.org>; Wed, 13 May 2020 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgEMMnr (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 May 2020 08:43:47 -0400
Received: from ozlabs.org ([203.11.71.1]:52125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbgEMMnr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 08:43:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49MZ9D4QCHz9sSk; Wed, 13 May 2020 22:43:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
References: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/ima: fix secure boot rules in ima arch policy
Message-Id: <158937375594.3526905.9967004768395504429.b4-ty@ellerman.id.au>
Date:   Wed, 13 May 2020 22:43:44 +1000 (AEST)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 1 May 2020 10:16:52 -0400, Nayna Jain wrote:
> To prevent verifying the kernel module appended signature twice
> (finit_module), once by the module_sig_check() and again by IMA, powerpc
> secure boot rules define an IMA architecture specific policy rule
> only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
> not take into account the ability of enabling "sig_enforce" on the boot
> command line (module.sig_enforce=1).
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ima: Fix secure boot rules in ima arch policy
      https://git.kernel.org/powerpc/c/fa4f3f56ccd28ac031ab275e673ed4098855fed4

cheers
