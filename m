Return-Path: <SRS0=v5+S=5I=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E3BC3F2CD
	for <linux-integrity@archiver.kernel.org>; Mon, 23 Mar 2020 16:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153012072D
	for <linux-integrity@archiver.kernel.org>; Mon, 23 Mar 2020 16:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCWQR0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:17:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57496 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQR0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Mar 2020 12:17:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3840672CCE7;
        Mon, 23 Mar 2020 19:17:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 230C34A4AE7;
        Mon, 23 Mar 2020 19:17:25 +0300 (MSK)
Date:   Mon, 23 Mar 2020 19:17:24 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
Message-ID: <20200323161724.uljnhparsske5ijm@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <1584973422.5188.247.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1584973422.5188.247.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Mar 23, 2020 at 10:23:42AM -0400, Mimi Zohar wrote:
> 
> I really appreciate your creating this set of tests! šHowever, when
> you first posted this patch, I asked you to break it up into more
> manageable pieces to review. šI understand this isn't the Linux
> kernel, "just" some tests, but there is good reason that the Linux
> kernel development requires large patches be broken up into more
> manageable small, logical changes.
> 
> I've recently asked a few people to help review this patch. šI
> understand that it is a lot of work to break this patch up into
> smaller patches, but it will simplify review.
> 
> If I was to break up this patch, I would start by making the test
> driver and each of the tests a separate patch. šThe test driver patch
> description should reference the GNU documentation, with an
> explanation as to why a custom driver is preferred[1].

I don't use custom driver. Default simple driver is used, I think it's
called "Parallel Test Harness".

There is only two tests - ima_hash and sign_verify. ima_hash tests
ima_hash evmctl command making ima hashes and verifying them;
sign_verify tests {ima_,}{sign,verify} commands making signatures and
verifying them. (They are tested together, because they are related
(verify need sign first, evm sign can produce ima signature too) and
can verify each other).

Thanks,

