Return-Path: <SRS0=E1tO=36=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA5C352A3
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E87020842
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 16:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CQIuK2qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJQkk (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:40:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57848 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJQkk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 11:40:40 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D32CB2010ADD;
        Mon, 10 Feb 2020 08:40:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D32CB2010ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581352840;
        bh=aaSGaS3ossGyX7+S2hS/dE9Ccz7h7mjOtopCX0c0+Ys=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CQIuK2qOpNJHdLKRXitr68XCYMHmb+/1ft2nDGG66ibVTvv4eUdUxg9hS6O1W+Pwz
         A0fp/USdq81cy/d/rou9m3i4a3p/o5jbD3GJ3Ptq9GqG9ggMkZsxuCw3gCBrKBAags
         bOkZ8zIptlV9x/ArIZu/Clyh5QDV5TFl6zTscuzY=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
To:     Joe Perches <joe@perches.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
 <20200207195346.4017-2-tusharsu@linux.microsoft.com>
 <1581253027.5585.671.camel@linux.ibm.com>
 <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
Date:   Mon, 10 Feb 2020 08:40:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/9/20 6:46 PM, Joe Perches wrote:

>>
>> In addition, as Shuah Khan suggested for the security/integrity/
>> directory, "there is an opportunity here to add #define pr_fmt(fmt)
>> KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
>> defines."  

Good point - we'll make that change.

With Joe Perches patch (waiting for it to be re-posted),
>> are all the pr_fmt definitions needed in each file in the
>> integrity/ima directory?
> 
> btw Tushar and Lakshmi:
> 
> I am not formally submitting a patch here.
> 
> I was just making suggestions and please do
> with it as you think appropriate.

Joe - it's not clear to me what you are suggesting.
We'll move the #define for pr_fmt to integrity.h.

What's other changes are you proposing?

>>>   
>>>   out:
>>> +	if (ret < 0)
>>> +		pr_err("Process buffer measurement failed, result: %d\n",
>>> +			ret);
>>
>> There's no reason to split the statement like this.  The joined line
>> is less than 80 characters.

Agree.

thanks,
  -lakshmi
