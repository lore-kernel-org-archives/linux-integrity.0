Return-Path: <SRS0=oKkn=DV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C064AC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Oct 2020 18:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE362222C
	for <linux-integrity@archiver.kernel.org>; Wed, 14 Oct 2020 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ibtqjZ5B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ibtqjZ5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgJNSYK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:24:10 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:45102 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728969AbgJNSYK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 14:24:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9DFCE1280089;
        Wed, 14 Oct 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602699850;
        bh=8iBFvTIDoDefM60Uy7VqRbhIBoOaZ44/XOKi6gEvOQ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ibtqjZ5BUS83QzWPZmlvTkgl9Z/KV+XCzz0YHeTUFGzdF9UC+9ooEPaKpZcQRxHcf
         npDSEjC4ihE2jFbAxcb6A2oXhYlp7mk9TnrNPbwba4zapTMTA42C6pxzNMIyYWHd/c
         1L8pE/in4nGIzgRusliNNN40lK5xBvrXdRzCqaX4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MIVls0OFK2yQ; Wed, 14 Oct 2020 11:24:10 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4586A1280082;
        Wed, 14 Oct 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602699850;
        bh=8iBFvTIDoDefM60Uy7VqRbhIBoOaZ44/XOKi6gEvOQ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ibtqjZ5BUS83QzWPZmlvTkgl9Z/KV+XCzz0YHeTUFGzdF9UC+9ooEPaKpZcQRxHcf
         npDSEjC4ihE2jFbAxcb6A2oXhYlp7mk9TnrNPbwba4zapTMTA42C6pxzNMIyYWHd/c
         1L8pE/in4nGIzgRusliNNN40lK5xBvrXdRzCqaX4=
Message-ID: <7729a41ac22dab84a785bc7a6228af28b814a33a.camel@HansenPartnership.com>
Subject: Re: WARN_ONCE triggered: tpm_tis: Add a check for invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dirk Gouders <dirk@gouders.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Oct 2020 11:24:08 -0700
In-Reply-To: <ghsgagsnag.fsf@gouders.net>
References: <ghsgagsnag.fsf@gouders.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-14 at 19:57 +0200, Dirk Gouders wrote:
> On my laptop the check introduced with 55707d531af62b (tpm_tis: Add a
> check for invalid status) triggered the warning (output below).
> 
> So, my laptop seems to be a candidate for testing.

I'm afraid this is a known problem on a wide range of TIS TPMs ... it's
fixed by the patch set I'm trying to get upstream:

https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/

But in the meantime, it's harmless.  The TIS code at the point in the
trace is trying to send a TPM2_GetCapability() command which fails
because the locality isn't listening, but the design of that command is
only to trigger an interrupt to probe the interrupt handling nothing
else depends on it succeeding.

James


