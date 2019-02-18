Return-Path: <SRS0=5TJt=QZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0297C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Feb 2019 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE620855
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Feb 2019 10:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBRKNi (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:13:38 -0500
Received: from moth.iki.fi ([212.16.111.74]:46474 "EHLO moth.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfBRKNi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Feb 2019 05:13:38 -0500
Received: from [130.188.13.218] (218.13.vtt.fi [130.188.13.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msa)
        by moth.iki.fi (Postfix) with ESMTPSA id C25A92A0083
        for <linux-integrity@vger.kernel.org>; Mon, 18 Feb 2019 12:10:43 +0200 (EET)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Markku Savela <msa@moth.iki.fi>
To:     linux-integrity@vger.kernel.org
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
Message-ID: <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
Date:   Mon, 18 Feb 2019 12:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18/02/2019 11:36, Markku Savela wrote:

>   https://www.spinics.net/lists/linux-integrity/msg01018.html
> 
> e.g., spi is not intialized early enough
> 
> [    4.007959] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> [    5.240738] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)

Oh, and I already have the self test disabled (in above), no effect...


diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 44a3d1623..7e61fc243 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -890,7 +890,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)

         loops = jiffies_to_msecs(duration) / delay_msec;

-       rc = tpm2_start_selftest(chip, true);
+       rc = tpm2_start_selftest(chip, false);
         if (rc)
                 return rc;

