Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F32C433EF
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Sep 2021 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C7960FDA
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Sep 2021 12:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhIMM0r (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:26:47 -0400
Received: from mxout70.expurgate.net ([91.198.224.70]:26312 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhIMM0q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 08:26:46 -0400
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPkhy-000OBp-TL; Mon, 13 Sep 2021 14:05:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPkhy-000OA6-9M; Mon, 13 Sep 2021 14:05:10 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id E0D66240042;
        Mon, 13 Sep 2021 14:05:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 6B451240041;
        Mon, 13 Sep 2021 14:05:09 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 009F320110;
        Mon, 13 Sep 2021 14:05:08 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Sep 2021 14:05:08 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_i2c_infineon: Fix init endian vendor check
In-Reply-To: <20210908134002.GY1200268@ziepe.ca>
References: <20210908133416.12408-1-fe@dev.tdt.de>
 <20210908134002.GY1200268@ziepe.ca>
Message-ID: <03fd525968fcd8443a96e5ad441140ab@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.16
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1631534710-0001D4F7-557544FE/0/0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>> By converting the vendor ID with ie32_to_cpus() to the correct format,
>> the TPM chip is recognised by the driver and works as expected.
>> 
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/char/tpm/tpm_i2c_infineon.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> vendor should be marked as a __le32 and so forth

Thanks for your feedback. I will push a v2.

> 
> Jason
