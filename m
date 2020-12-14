Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F2AC4361B
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Dec 2020 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67EB22286
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Dec 2020 16:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgLNQiq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgLNQil (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 11:38:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9FC0613D3;
        Mon, 14 Dec 2020 08:38:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id DE2D51F442AB
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        "dlaurie@chromium.org" <dlaurie@chromium.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v6] char: tpm: add i2c driver for cr50
In-Reply-To: <20201211103443.GA12091@kernel.org>
References: <20201207142016.482122-1-adrian.ratiu@collabora.com>
 <20201208173906.GA58213@kernel.org> <87y2i7b186.fsf@collabora.com>
 <20201211103443.GA12091@kernel.org>
Date:   Mon, 14 Dec 2020 18:37:55 +0200
Message-ID: <87v9d4baxo.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 11 Dec 2020, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Wed, Dec 09, 2020 at 02:41:45PM +0200, Adrian Ratiu wrote: 
>> On Tue, 08 Dec 2020, Jarkko Sakkinen <jarkko@kernel.org> wrote: 
>> > On Mon, Dec 07, 2020 at 04:20:16PM +0200, Adrian Ratiu wrote: 
>> > > From: "dlaurie@chromium.org" <dlaurie@chromium.org>  Add 
>> > > TPM 2.0 compatible I2C interface for chips with cr50 
>> > > firmware. The firmware running on the currently supported 
>> > > H1 MCU requires a special driver to handle its specific 
>> > > protocol, and this makes it unsuitable to use 
>> > > tpm_tis_core_* and instead it must implement the underlying 
>> > > TPM protocol similar to the other I2C TPM drivers.   - All 
>> > > 4 bytes of status register must be read/written at once.  - 
>> > > FIFO and burst count is limited to 63 and must be drained 
>> > > by AP.  - Provides an interrupt to indicate when read 
>> > > response data is ready and when the TPM is finished 
>> > > processing write data.   This driver is based on the 
>> > > existing infineon I2C TPM driver, which most closely 
>> > > matches the cr50 i2c protocol behavior. 
>> >  Starts to look legit. Has anyone tested this? 
>>  I tested on an x86_64 Chromebook EVE (aka Google Pixelbook) by 
>> chainloading in legacy mode and booting into a Yocto-based 
>> userspace (meta-chromebook) where I used tpm2-tools to 
>> communicate with the chip and also built and tested a 
>> ChromiumOS userspace in developer mode.   I do not have access 
>> to other HW which has this chip, so it is about as much testing 
>> I can do to confirm the driver works on this HW.   Adrian 
> 
> So can you respond to this with tested-by. It's sufficient 
> because collateral effects of driver failing are insignificant 
> for the kernel as whole. 

Tested-by: Adrian Ratiu <adrian.ratiu@collabora.com>

>  
>  /Jarkko
