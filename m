Return-Path: <SRS0=SLkk=3L=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E3C2D0DB
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jan 2020 20:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C621835
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jan 2020 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kvZOepP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVUFC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:05:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53926 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUFC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 15:05:02 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A0F12007679;
        Wed, 22 Jan 2020 12:05:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A0F12007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579723501;
        bh=VkKFVv9AeIsNp0khDafTW1BBobp2dQUzk7DlpNA1WeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kvZOepP7QvtQdOnbBQxDFcMif1b5f1bXdbkUpI62NFjS1vJzbgoNav7quPt5+PvCM
         E1RBM9/F1G24thc4mbYQZTneeFzbi6Y5by5Z6KvbX8cPx9irNGL6JPw2/YtHoLzsuq
         Ry8jFQbuFCzuctr5yfKrlpKjOOEbNsv/Bp4FXCio=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
 <1579634035.5125.311.camel@linux.ibm.com>
 <1579636351.3390.35.camel@HansenPartnership.com>
 <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
 <1579723379.5182.130.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fa7ec770-6552-7538-7393-c23410b3a1ba@linux.microsoft.com>
Date:   Wed, 22 Jan 2020 12:05:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579723379.5182.130.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/20 12:02 PM, Mimi Zohar wrote:

> 
> Thanks, Lakshmi.  This requires moving the code around.  Instead of
> doing this on the current code base, I suggest posting a v9 version of
> the entire "IMA: Deferred measurement of keys".
> 
> I suggest making the switch from spinlock to mutex, as you had it
> originally, before posting v9.  The commit history will then be a lot
> cleaner.
> 
> thanks,
> 
> Mimi
> 

Sure Mimi - I'll post an update to the patch set shortly.

thanks,
  -lakshmi
