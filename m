Return-Path: <SRS0=eg0d=RL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DAC43381
	for <linux-integrity@archiver.kernel.org>; Fri,  8 Mar 2019 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147C20851
	for <linux-integrity@archiver.kernel.org>; Fri,  8 Mar 2019 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCHVt1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:49:27 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50688 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHVt1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Mar 2019 16:49:27 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 016E072CC61;
        Sat,  9 Mar 2019 00:49:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D7DC84A4AF6;
        Sat,  9 Mar 2019 00:49:24 +0300 (MSK)
Date:   Sat, 9 Mar 2019 00:49:23 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v2] ima-evm-utils: convert sign v2 from RSA to
 EVP_PKEY API
Message-ID: <20190308214923.qwhvr27btsmwa6ss@altlinux.org>
References: <20190206130653.5503-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190206130653.5503-1-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi, Dmitry,

On Wed, Feb 06, 2019 at 04:06:53PM +0300, Vitaly Chikunov wrote:
> Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> This enables more signatures to work out of the box.
> 
> Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> is doing proper PKCS1 padding automatically (tested to be compatible
> with previous version, except for MD4). This also fixes bug with MD4
> which produced wrong signature because of absence of the appropriate
> RSA_ASN1_template.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changes since v1:
> - More key neutral code in calc_keyid_v1().
> - Fix uninitialized sigsize for EVP_PKEY_sign().
> - Fix memory leaks for openssl types.
> 
>  src/evmctl.c    |  29 +++---
>  src/imaevm.h    |   4 +-
>  src/libimaevm.c | 277 +++++++++++++++++++++++++++-----------------------------
>  3 files changed, 152 insertions(+), 158 deletions(-)

This probably should be rebased and resent after you make decision on
"[PATCH v2] ima-evm-utils: simplify digest alias handling".

Also, this is ping.

