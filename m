Return-Path: <SRS0=A9B8=2E=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD0C43603
	for <linux-integrity@archiver.kernel.org>; Sat, 14 Dec 2019 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F369920706
	for <linux-integrity@archiver.kernel.org>; Sat, 14 Dec 2019 20:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rjsTJDax";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k2w8qJ7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLNUhQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:37:16 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54520 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfLNUhQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Dec 2019 15:37:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 700AD8EE0DA;
        Sat, 14 Dec 2019 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576355835;
        bh=LzaReTAdtogW40UtKmhlbZw9yoAnrWbaFJSKReF451k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rjsTJDaxev8/jveZBK8tehg/R3zRuJYiN2ElIwclufxCtO0k5mXmiZl2h7sYURWFs
         xOfMyPyTH7G8GDTi55RoMDf2TxID5jtW3JuosMoIwQMEyrj+9G3/6uo8SJMZ10cs8m
         TeAxh9b4ydoowdTRXl+/q5g8O5ggr1IaOni9e7vc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RCmoDPvA22pW; Sat, 14 Dec 2019 12:37:15 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 92E9D8EE07B;
        Sat, 14 Dec 2019 12:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576355834;
        bh=LzaReTAdtogW40UtKmhlbZw9yoAnrWbaFJSKReF451k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k2w8qJ7eXRuahExcgcIVlpXF94F6ljibM8ruaTqxNsmZhm543YRmXZ4e8+u2RuOYy
         8VfvUJ9l1Ffw8pOuk4iL4OAMP84sC4gt4VyikgMt0OhFHtQyZRXxZgTxFVXD3BZnG5
         F+3p5glGsdW6Zw3JQWNXbGmWmx65MZhkV2YX1DG4=
Message-ID: <1576355832.4035.10.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/8] Fix TPM 2.0 trusted keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Sat, 14 Dec 2019 12:37:12 -0800
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
References: <1575936272.31378.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 16:04 -0800, James Bottomley wrote:
[...]
> The big problem with this patch is still that we can't yet combine
> policy with authorization because that requires proper session
> handling, but at least with this rewrite it becomes possible (whereas
> it was never possible with the old external policy session code). 
> Thus, when we have the TPM 2.0 security patch upstream, we'll be able
> to use the session logic from that patch to imlement authorizations.

I had a discussion with Ken Goldman on Friday where he told me this
wasn't true: we can actually persuade a policy session to do a non-HMAC 
authorization (for the interested, the trick is to use
TPM2_PolicyPassword in place of TPM2_PolicyAuthValue.  It hashes to the
same policy but the former sets the session up for non-HMAC and the
latter for HMAC) so I'll add password based authorization to policies
when I respin the patch set.

James

