Return-Path: <SRS0=IP2B=Q3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C445AC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Feb 2019 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C52070B
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Feb 2019 08:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfBTIOl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:14:41 -0500
Received: from moth.iki.fi ([212.16.111.74]:46483 "EHLO moth.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfBTIOl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Feb 2019 03:14:41 -0500
Received: from [130.188.13.218] (218.13.vtt.fi [130.188.13.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msa)
        by moth.iki.fi (Postfix) with ESMTPSA id A451D2A004D
        for <linux-integrity@vger.kernel.org>; Wed, 20 Feb 2019 10:11:45 +0200 (EET)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
From:   Markku Savela <msa@moth.iki.fi>
To:     linux-integrity@vger.kernel.org
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
 <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
Message-ID: <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
Date:   Wed, 20 Feb 2019 10:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

No hints how to solve? Anybody?


> In addition to disabling the full selftest, I had to revert
> commit b76c8d5 ("clk-bcm2835: Read max core clock from firmware") in
> order for the TPM to initialize prior to IMA.

..also, cannot find above mentioned commit from (Torvalds) linux tree 
either. Something in in the integrity only?
