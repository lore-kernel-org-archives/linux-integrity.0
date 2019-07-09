Return-Path: <SRS0=xYmq=VG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D86C73C46
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Jul 2019 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF52082A
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Jul 2019 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGIPnh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:43:37 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37602 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIPnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jul 2019 11:43:37 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D86C372CC6C;
        Tue,  9 Jul 2019 18:43:33 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C059A4A4AE8;
        Tue,  9 Jul 2019 18:43:33 +0300 (MSK)
Date:   Tue, 9 Jul 2019 18:43:33 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: Re: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
Message-ID: <20190709154333.33345iepccstscpv@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20190707234837.4866-1-vt@altlinux.org>
 <1562599850.11461.43.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562599850.11461.43.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 08, 2019 at 11:30:50AM -0400, Mimi Zohar wrote:
> [Cc'ing Roberto, Petr, Thiago, Prakhar]
> Now that we're including ALL the kernel exported hash_info algorithms,
> a colleague suggested defining a list of deprecated hash algorithms.
> šInstead of preventing the usage of these deprecated hash algorithms,
> initially I would start out with a warning. šIt would be helpful to
> indicate which standard deprecated the hash algorithm and year. šAt
> some point, we might want to prevent their usage in signing files, but
> not verifying file signatures.

I think this is not a problem, because user explicitly states which hash
algorithm he wants to use. Except for SHA1, which is also silent
fallback algorithm. I think this fallback mechanism should be removed.

Also, return values of sign_hash/ima_calc_hash/etc are not defined
clearly and callers have weird checks such as `if (len <= 1)`. I think
this should be conceptually simplified and made them `return -1` on any
error.


> evmctl "ima_measurement" doesn't support custom template definitions.
> Also missing is support for verifying the "ima-buf" kexec command boot
> command line and the "ima-modsig" template appended signature.
> 
> David Jacobson started writing a regression framework and posted a v2
> version. šI'd really appreciate help with cleaning up that code.š

Maybe tests should be integrated into ima-evm-utils too.

Thanks,

