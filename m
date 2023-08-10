Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADEDC04A6A
	for <linux-integrity@archiver.kernel.org>; Thu, 10 Aug 2023 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHJSvD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjHJSvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 14:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439B26A6;
        Thu, 10 Aug 2023 11:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1361E666D6;
        Thu, 10 Aug 2023 18:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63DC433C8;
        Thu, 10 Aug 2023 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691693461;
        bh=NSkGbMBrXlI2FAVWP9Rd7SCJidmHCcnOk63L5ZoPqTQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=KtlUKDwpLMlfroBNGgr7h78ncFPfcaE3jBRrRqwWxTDH44W5gemQ4kaBHuN/SHRuP
         nx+HqDxRxA5NgXJm72RYdMHqk4ixhL1qh0mJhCeVqVauXmvg7loPnCbIjP5FO/3DI5
         3xm/3nEQuLjvcPARaOm34lmZQ269d/3ROzMFI/P3sNhEqzGQRLyFRJJLZ2fcixbWVe
         jdgkP6pNfqSleA0N69+lJxbdtjN0Fyi9SHyKoZfGMmhhE2dda59mclt1x9X4zDkjz/
         +ZXiOxpqZD9WCeI36SYb0LsnHfFvn4yVvdukLNp3Zi2OUg96yCoivKmnNp37pdkfui
         HtCAWFRYVBinw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 21:50:52 +0300
Message-Id: <CUP3A3AUHCLX.3DYKJLJI268QS@suppilovahvero>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14
 Gen 2 and 13s-IML
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Takashi Iwai" <tiwai@suse.de>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230807140125.18486-1-tiwai@suse.de>
 <CUMJWFCIG9EI.13F7LU8TYAUE1@seitikki> <87il9qhxjq.wl-tiwai@suse.de>
 <CUOYJI68K3KG.39YM92JXBEIQ9@wks-101042-mac.ad.tuni.fi>
 <87ttt7rkpq.wl-tiwai@suse.de> <CUP1O7LTI58J.1VQMCH1YS0EXR@suppilovahvero>
 <875y5mu6uh.wl-tiwai@suse.de> <CUP2RGNHEZNL.28S24J3GQVAE1@suppilovahvero>
In-Reply-To: <CUP2RGNHEZNL.28S24J3GQVAE1@suppilovahvero>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 10, 2023 at 9:26 PM EEST, Jarkko Sakkinen wrote:
> On Thu Aug 10, 2023 at 8:48 PM EEST, Takashi Iwai wrote:
> > > I'll submit a patch asap, and cc you. I put the conclusions
> > > to the description.
> >
> > Great, thanks!
>
> It is out now:
>
> https://lore.kernel.org/linux-integrity/20230810182433.518523-1-jarkko@ke=
rnel.org/T/#u

I put this also hanging to my -next branch (mirrored to linux-next).

BR, Jarkko
