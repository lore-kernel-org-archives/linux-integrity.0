Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE27AC433EF
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Jul 2022 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiGKCvH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKCvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jul 2022 22:51:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D0643C;
        Sun, 10 Jul 2022 19:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 327FDB80108;
        Mon, 11 Jul 2022 02:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862D9C3411E;
        Mon, 11 Jul 2022 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657507863;
        bh=H18WbEDpqrNp4Wv/6cAAcQW8aWlTFhtktPnU33Y3Uxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEZzuuCgh8b0tXrC0+uVi2NuujwZ69Vja/JfuKIVq/DZ5Jq94cL9CDud/73zslcND
         RK7vWMJq84ADpRIlO/BgpVEWWr8bhmVyW4WyhMsqUkEkEY58mHj0bHZPGBY1iBu2VP
         Aq4VIQZRFb6PVYv1y96R+Gx7tHpAIDzIWGi3QhidVcBm4ys6VWmBfDUgCOpyZU/p5z
         rcbq02lqSMQFum+ON3ndRzNa8gGuZvTeJWDiNkOxCV42vXRigOJmdWyBJNIUozEMA5
         NKYx6lmN8Z5BksFjM751mlCA/mld8sHub2OkNKBJTnr2Jb2SIE3ZPv6IEgRKmchO7t
         YfHtq9HcB3Gnw==
Date:   Mon, 11 Jul 2022 05:50:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <YsuQEoVuVa00gIdE@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org>
 <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 04, 2022 at 07:45:12PM +0200, Lino Sanfilippo wrote:
> 
> 
> On 01.07.22 01:29, Jarkko Sakkinen wrote:
> 
> >
> > I'm kind of thinking that should tpm_tis_data have a lock for its
> > contents?
> 
> Most of the tpm_tis_data structure elements are set once during init and
> then never changed but only read. So no need for locking for these. The
> exceptions I see are
> 
> - flags
> - locality_count
> - locality

I'd still go for single data struct lock, since this lock would
be taken in every transmit flow. It makes the whole thing easier
to maintain over time, and does not really affect scalability.

This brings me to another question: what does this lock protect
against given that tpm_try_get_ops() already takes tpm_mutex?
It's not clear and that should be somehow reasoned in the commit
message.

Anyway, *if* a lock is needed the granularity should be the whole
struct.

BR, Jarkko
