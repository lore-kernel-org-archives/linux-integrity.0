Return-Path: <SRS0=ac69=3K=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC23AC2D0CE
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E98F206A2
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NUOVdFzk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NUOVdFzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAURex (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:34:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60408 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgAURew (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 12:34:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 597FC8EE180;
        Tue, 21 Jan 2020 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579628092;
        bh=vcYNFOeLQG9On2rFmCpXuIKj7cjYAwyM8qk3B50z018=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NUOVdFzkm+/32Ol+TaRpDzUod5DduXpbCNSF8OsNEf6HDz60bv/uluBHVBUMr8ik2
         dCycmIpURSjQJn4fnBapBJys6DMybqorjLUWebT6pdJFytEB8mfcDEiw8Cgaq4+CEA
         HfOF6FEiV5ZyD5km00z2s4lbdZv0+NwIq42pdxI8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8c7TChbFVXin; Tue, 21 Jan 2020 09:34:52 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7AF088EE0C9;
        Tue, 21 Jan 2020 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579628092;
        bh=vcYNFOeLQG9On2rFmCpXuIKj7cjYAwyM8qk3B50z018=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NUOVdFzkm+/32Ol+TaRpDzUod5DduXpbCNSF8OsNEf6HDz60bv/uluBHVBUMr8ik2
         dCycmIpURSjQJn4fnBapBJys6DMybqorjLUWebT6pdJFytEB8mfcDEiw8Cgaq4+CEA
         HfOF6FEiV5ZyD5km00z2s4lbdZv0+NwIq42pdxI8=
Message-ID: <1579628090.3390.28.camel@HansenPartnership.com>
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 09:34:50 -0800
In-Reply-To: <20200121171302.4935-1-nramas@linux.microsoft.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-21 at 09:13 -0800, Lakshmi Ramasubramanian wrote:
> Enabling IMA and ASYMMETRIC_PUBLIC_KEY_SUBTYPE configs will
> automatically enable the IMA hook to measure asymmetric keys. Keys
> created or updated early in the boot process are queued up whether
> or not a custom IMA policy is provided. Although the queued keys will
> be freed if a custom IMA policy is not loaded within 5 minutes, it
> could still cause significant performance impact on smaller systems.

What exactly do you expect distributions to do with this?  I can tell
you that most of them will take the default option, so this gets set to
N and you may as well not have got the patches upstream because you
won't be able to use them in any distro with this setting.

> This patch turns the config IMA_MEASURE_ASYMMETRIC_KEYS off by
> default.  Since a custom IMA policy that defines key measurement is
> required to measure keys, systems that require key measurement can
> enable this config option in addition to providing a custom IMA
> policy.

Well, no they can't ... it's rather rare nowadays for people to build
their own kernels.  The vast majority of Linux consumers take what the
distros give them.  Think carefully before you decide a config option
is the solution to this problem.

James

