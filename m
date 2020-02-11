Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD37C352A4
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 03:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729912080C
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 03:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgBKDKw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:10:52 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:39617 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727962AbgBKDKw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 22:10:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8AAEB181D3026;
        Tue, 11 Feb 2020 03:10:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: group71_5e7f9e52c8b5d
X-Filterd-Recvd-Size: 1344
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 03:10:49 +0000 (UTC)
Message-ID: <225b88ac1abcb293bf9d55ca53009015b1baa81c.camel@perches.com>
Subject: Re: [PATCH v2 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
From:   Joe Perches <joe@perches.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 19:09:34 -0800
In-Reply-To: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 18:47 -0800, Tushar Sugandhi wrote:
> Log statements from ima_mok.c, ima_asymmetric_keys.c, and
> ima_queue_keys.c are prefixed with the respective file names
> and not with the string "ima". 

Series seems sensible, thanks Tushar.

Next time you might choose to use

	git format-patch --cover-letter

and write in the 0/n cover letter what the point
of the patch series is.

cheers and welcome... Joe

