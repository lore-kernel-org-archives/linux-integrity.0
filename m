Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09002C4338F
	for <linux-integrity@archiver.kernel.org>; Thu, 29 Jul 2021 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41A560F12
	for <linux-integrity@archiver.kernel.org>; Thu, 29 Jul 2021 11:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhG2LKX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:10:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33718 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhG2LKX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 07:10:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 02B1F1F43DA0
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] char: tpm: Kconfig: remove bad i2c cr50 select
In-Reply-To: <20210728215346.rmgvn4woou4iehqx@kernel.org>
References: <20210727171313.2452236-1-adrian.ratiu@collabora.com>
 <20210728215346.rmgvn4woou4iehqx@kernel.org>
Date:   Thu, 29 Jul 2021 14:10:16 +0300
Message-ID: <87h7gdqstj.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 29 Jul 2021, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, Jul 27, 2021 at 08:13:12PM +0300, Adrian Ratiu wrote: 
>> This fixes a minor bug which went unnoticed during the initial 
>> driver upstreaming review: TCG_CR50 does not exist in mainline 
>> kernels, so remove it.   Fixes: 3a253caaad11 ("char: tpm: add 
>> i2c driver for cr50") Cc: stable@vger.kernel.org Reviewed-by: 
>> Jarkko Sakkinen <jarkko@kernel.org> Signed-off-by: Adrian Ratiu 
>> <adrian.ratiu@collabora.com> --- 
> 
> These are missing changelog. I guess tags are added, and nothing 
> else? 

Hi. That is correct, I've only added the tags you suggested on the 
first patch, the second patch is identical.

Adrian

>
> /Jarkko
