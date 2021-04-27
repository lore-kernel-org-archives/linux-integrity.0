Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC837C433B4
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Apr 2021 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CBF613C2
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Apr 2021 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhD0W0r (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Apr 2021 18:26:47 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54980 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhD0W0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 18:26:47 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BA72972C8B0;
        Wed, 28 Apr 2021 01:26:01 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A526D4A47A2;
        Wed, 28 Apr 2021 01:26:01 +0300 (MSK)
Date:   Wed, 28 Apr 2021 01:26:01 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Subject: Re: [PATCH v2 2/3] tests: Add program to create IMA signature with
 new API call
Message-ID: <20210427222601.ednotpq7gur36g62@altlinux.org>
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
 <20210427193133.1718367-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210427193133.1718367-3-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Tue, Apr 27, 2021 at 03:31:32PM -0400, Stefan Berger wrote:
> Since the new API call is not used by evmctl, implement a test program
> 'create_ima_signature' to use it. Extend _evmctl_sign to also created
> IMA v2 signatures with RSA keys using this test program and compare the
> results.
> 
> Evmctl's signature creation path is unmodified at this point, so the tests
> ensure that the existing sign_hash_v2 and the new sign_hash_v2_pkey create
> identical (RSA) signatures.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/Makefile.am            |   6 ++
>  tests/create_ima_signature.c | 111 +++++++++++++++++++++++++++++++++++

Why not add this to evmctl?

Thanks,

>  tests/sign_verify.test       |  21 ++++++-
>  3 files changed, 136 insertions(+), 2 deletions(-)
>  create mode 100644 tests/create_ima_signature.c
