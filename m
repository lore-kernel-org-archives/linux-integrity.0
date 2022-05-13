Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E925C433EF
	for <linux-integrity@archiver.kernel.org>; Fri, 13 May 2022 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378971AbiEMSBP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 13 May 2022 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbiEMSBP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 14:01:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8FE53B6E;
        Fri, 13 May 2022 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56167CE32C7;
        Fri, 13 May 2022 18:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D195C34100;
        Fri, 13 May 2022 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652464870;
        bh=bT9WSf6Q+kU3vx6ueinWSpS4WAwrSc/VPDx8rqRStic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4+pFJg5Hw8C3SdIDJU44wYbaJzEdL7WJargPWrFnv4voHOWNoH02serFgqUNbvWp
         6JPhSoVj25s+4V6LD5h+nYc8eSGeMu5Drv5WHtRIFZ8g2YuepmdjX7THLQjVOh2qNG
         p20Z+sARLjeYLDdrwhegvEyAxORRake8WR6y5tG8sDXl65tLaf6U/SMxI7a271giuR
         4gO2p+pxHcitNTG4AmTYZSu9ni5EH4vlxGv/G1trkxsvxX7ReJSKcNGSOYt8sj3NOY
         3KOEAAH1Rg9yKheOmPvLPgzGHGL/O3HqnSxn0kKa/x2t0KDBAQXtgIYm8W3lsj7sIw
         WHm88OX8nVsBA==
Date:   Fri, 13 May 2022 20:59:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 2/6] tpm, tpm_tis: Claim and release locality only once
Message-ID: <Yn6cjJTj1SdS73pY@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-3-LinoSanfilippo@gmx.de>
 <YnudhZZGXf87U3bd@kernel.org>
 <f576a24d-d175-0153-9992-f6dd80d57b62@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f576a24d-d175-0153-9992-f6dd80d57b62@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 11, 2022 at 09:29:57PM +0200, Lino Sanfilippo wrote:
> 
> 
> On 11.05.22 at 13:27, Jarkko Sakkinen wrote:
> > On Mon, May 09, 2022 at 10:05:55AM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> It is not necessary to claim and release the default locality for each TPM
> >> command. Instead claim the locality once at driver startup and release it
> >> at driver shutdown.
> >>
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >
> > We are doing what we're being because of Intel TXT:
> >
> > https://lore.kernel.org/tpmdd-devel/20170315055738.11088-1-jarkko.sakkinen@iki.fi/
> >
> > Unfortunately cannot accept this change.
> >
> 
> I do not see how the patch affects the crb code since the only changes concern the
> tpm_class_ops of the tis core. AFAICS crb uses its own set of tpm_class_ops
> which are still used to claim and release the locality.
> 
> Or do I miss something?

Ugh, yes breaking everything when TXT is used with tpm_tis.

> Regards,
> Lino

BR, Jarkko
