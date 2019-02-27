Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B9C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC8320823
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oUwKV6Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfB0Q5f (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:57:35 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48162 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbfB0Q5f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 11:57:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8DA248EE47D;
        Wed, 27 Feb 2019 08:57:34 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NRXv54ZlDqe8; Wed, 27 Feb 2019 08:57:34 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 34C6A8EE0EF;
        Wed, 27 Feb 2019 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1551286654;
        bh=xThJvTBKzwJKy8EoviF8M9qZ3I10t60h22JhJ+5o/ug=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=oUwKV6Fie791dANLI2xkkTES2TJqwvAmTJDLiR5n6FvYOr0adlS08iKhTrPIKiJ46
         n0YVLGRyALr9Qf2wJ5Jf1JfIEsyTMS4PhYm7Ra0LdwzUNv1jdoOyjJn48+oDx87ubM
         OdKE4NImM10B7e/JtENa8XODmYvMb86j2S21airI=
Message-ID: <1551286651.3105.11.camel@HansenPartnership.com>
Subject: Re: About PureBoot and TPM based DRM's
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 27 Feb 2019 08:57:31 -0800
In-Reply-To: <20190227155611.GA7434@linux.intel.com>
References: <20190227155611.GA7434@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-02-27 at 17:56 +0200, Jarkko Sakkinen wrote:
> Just read this:
> 
> https://puri.sm/posts/pureboot-the-high-security-boot-process/
> 
> Makes me ask: where are these TPM based DRM's? Never seen one but I
> assume they exist. Anyway cool work otherwise.

Actually, they don't, the article is just restating a common
misconception that the TPM is used to enforce DRM and then saying
they've found a non-evil use for it which, apparently, is using the TPM
for standard key storage and measurement.  Apparently this means we're
also all working on non-evil uses ...

James

