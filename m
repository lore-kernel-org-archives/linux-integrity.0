Return-Path: <SRS0=Qop3=VW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1554C7618B
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D142166E
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Jul 2019 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfGYPi0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:38:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56634 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfGYPi0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 11:38:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3D6E972CC6C;
        Thu, 25 Jul 2019 18:38:24 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 212294A4AE8;
        Thu, 25 Jul 2019 18:38:24 +0300 (MSK)
Date:   Thu, 25 Jul 2019 18:38:24 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190725153823.dz6brcvoojum47dz@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190725061855.3734-1-vt@altlinux.org>
 <1564065991.4245.132.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564065991.4245.132.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jul 25, 2019 at 10:46:31AM -0400, Mimi Zohar wrote:
> On Thu, 2019-07-25 at 09:18 +0300, Vitaly Chikunov wrote:
> > Run `make check' to execute the tests.
> > Currently only ima_hash, ima_sign (v2), and ima_verify are tested.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Nice! šAs much as I would like to include this patch in this release,
> let's hold off and add it to the next release.

You may include it if you wish, this should work good as is (over my
latest patches).

> Reviewing shorter patches is a lot easier, at least for me. šCould you
> break this patch up? šPerhaps by defining the tests separately, and
> then adding the autotools support to run the test afterwards?

This is just tests, so they don't alter any other code, don't produce
user visible features, and don't complicate anything. Each file inside
of the patch could be understood separately.


