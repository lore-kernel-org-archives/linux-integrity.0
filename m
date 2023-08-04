Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D6C001DF
	for <linux-integrity@archiver.kernel.org>; Fri,  4 Aug 2023 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjHDN37 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHDN3u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 09:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD64C25
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 06:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B169761FFB
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 13:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A8BC433C8;
        Fri,  4 Aug 2023 13:29:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X++vYF90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691155769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR2EUF+vNn2yXoVXgaFv3sEFT5UMsq9f0jVILE47LwM=;
        b=X++vYF90tYiDDZeJ/VMY9Z30zet+bv1RxsZZTNh78EGJHBIJnXUWusY7dCduoCExdtI26N
        9wjxQMq8wnhK3cgkgi24E+APq8DyEoyyI8KXNKHCy/uZtStVbWzq9moAmoOsgxylN6ZEcm
        dSPCwC4AYxrteX+nfRa7M6VNjsqsRmU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3202ba64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 4 Aug 2023 13:29:28 +0000 (UTC)
Date:   Fri, 4 Aug 2023 15:28:15 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZMz879q9fXcJ1X46@zx2c4.com>
References: <20230803182428.25753-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803182428.25753-1-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 03, 2023 at 01:24:28PM -0500, Mario Limonciello wrote:
> The TPM RNG functionality is not necessary for entropy when the CPU
> already supports the RDRAND instruction. The TPM RNG functionality
> was previously disabled on a subset of AMD fTPM series, but reports
> continue to show problems on some systems causing stutter root caused
> to TPM RNG functionality.
> 
> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> that claim to have fixed or not. To accomplish this, move the detection
> into part of the TPM CRB registration and add a flag indicating that
> the TPM should opt-out of registration to hwrng.
> 
> Cc: stable@vger.kernel.org # 5.5+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM. Jarkko - can you replace the commit in your staging tree with this
one?
