Return-Path: <SRS0=yK61=4A=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF25C2BA83
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Feb 2020 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14FA206ED
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Feb 2020 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgBLPtJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:49:09 -0500
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:49478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727458AbgBLPtJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 10:49:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 35642180A68D7;
        Wed, 12 Feb 2020 15:49:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: play61_4f690e963e011
X-Filterd-Recvd-Size: 1651
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Feb 2020 15:49:05 +0000 (UTC)
Message-ID: <b9acb7868a1e225db09830d859bfd4cc6ac6330d.camel@perches.com>
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 07:47:49 -0800
In-Reply-To: <1581521161.3494.7.camel@HansenPartnership.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
         <20200211231414.6640-4-tusharsu@linux.microsoft.com>
         <1581517770.8515.35.camel@linux.ibm.com>
         <1581521161.3494.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-12 at 10:26 -0500, James Bottomley wrote:
> Log messages are often consumed by log monitors, which mostly use
> pattern matching to find messages they're interested in, so you have to
> take some care when changing the messages the kernel spits out and you
> have to make sure any change gets well notified so the distributions
> can warn about it.
> 
> For this one, can we see a "before" and "after" message so we know
> what's happening?

https://patchwork.kernel.org/patch/11357335/#23134147


