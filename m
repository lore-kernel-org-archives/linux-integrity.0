Return-Path: <SRS0=uJJC=2Q=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D993C3F68F
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Dec 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3761E208C4
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Dec 2019 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NebnD6df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLZSc6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:32:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57536 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZSc6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Dec 2019 13:32:58 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 451E92010ACB;
        Thu, 26 Dec 2019 10:32:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 451E92010ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1577385177;
        bh=Ks2uqU/zXG4QN1jPsTtYVXcZbM2+fajpkP/NKcHdHO8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NebnD6dfHXKKjwclYoBMRlAeD7c58g6yp4w0YmGwH437LomHLRXO4dSoye4rmp3C6
         fh7H0Po4htorEtch5rRf+xJfoPanfbcXrs/muZdO8P2LnKdYiNl3s822EYgdG7Xsrl
         RNvgX5vhHVfCngaykdZl2KYKCxKgCfgXvF3UfANE=
Subject: Re: [RFC PATCH integrity] IMA: ima_queue_key() can be static
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
References: <201912251234.hUAOr3cc%lkp@intel.com>
 <20191225045416.34tsl75acckhabsr@4978f4969bb8>
 <c31a5f8b-2db9-f8ad-51f6-b6e471b05737@linux.microsoft.com>
 <1577370477.4487.11.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c720e040-e57e-9e5c-6ac5-883b07f6eca7@linux.microsoft.com>
Date:   Thu, 26 Dec 2019 10:33:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1577370477.4487.11.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/26/2019 6:27 AM, Mimi Zohar wrote:

>>
>>   From this patch I understand this change is done. Is there anything I
>> need to do to address this issue?
> 
> No, I'll squash this patch with the original patch, adding the
> requested tags.
> 
> Mimi

Thanks a lot for your help Mimi.

  -lakshmi
