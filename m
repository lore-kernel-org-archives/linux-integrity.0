Return-Path: <SRS0=/8cw=Q4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D06C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17D82084D
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfBUNRP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:17:15 -0500
Received: from moth.iki.fi ([212.16.111.74]:46490 "EHLO moth.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUNRP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Feb 2019 08:17:15 -0500
Received: from [130.188.13.218] (218.13.vtt.fi [130.188.13.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msa)
        by moth.iki.fi (Postfix) with ESMTPSA id 811AC2A0088;
        Thu, 21 Feb 2019 15:14:18 +0200 (EET)
Subject: Re: IMA fails to see TPM chip (rpi3, linaro optee)
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>
References: <9cd0d399-2b11-779c-f767-660ea61721d9@moth.iki.fi>
 <b9da5231-10b8-0d88-3d90-edfc6fb7b9de@moth.iki.fi>
 <192719a8-d583-b7cd-07d2-b693e2cc982d@moth.iki.fi>
 <1651d634-9a88-4511-ac51-a69648db8259@moth.iki.fi>
 <1550753358.17768.85.camel@linux.ibm.com>
From:   Markku Savela <msa@moth.iki.fi>
Message-ID: <776f0386-6c4d-9ad4-929c-44ba9fd4c9d0@moth.iki.fi>
Date:   Thu, 21 Feb 2019 15:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550753358.17768.85.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 21/02/2019 14:49, Mimi Zohar wrote:
> This problem was previously discussed here -
> https://lore.kernel.org/linux-integrity/trinity-3e6c2430-417d-4eef-b06
> 7-e30d68592b4d-1506716047790@3c-app-gmx-bs69/

Yes, I've been reading that thread, but as git novice

> Right, for rpi-4.14.y kernel, reverting commit acddd39 ("clk-bcm2835:
> Read max core clock from firmware") allows the TPM to be initialized
> prior to IMA, but is probably not the right solution.

.. I'm not able to find this commit from linaro git (I don't know what 
command to use...).





