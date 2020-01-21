Return-Path: <SRS0=ac69=3K=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFCC2D0CE
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 20:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9224656
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 20:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eZhJmakm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgAUUiq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:38:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39004 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUiq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 15:38:46 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E32BA2008819;
        Tue, 21 Jan 2020 12:38:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E32BA2008819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579639126;
        bh=39hRDfcQoedGytqRqIp/6T1ZCaQPsUpXvrhCIte/taw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eZhJmakmz0bsFphuCLNYJ7RtxE+ijV4PfcNO94/c7nk1lWIBY5xF+b+pGNIz8ANta
         ZVVcFf3bdyrBRSdA1LQwXQhOcjlcEK2yaPIC0BmcNh6aTOleO0ElMu0iR9TdkmI36O
         zlgZiqHYC5tzGODOOaTLotQpBq3cUGqb0sQk/7Zw=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
 <1579634035.5125.311.camel@linux.ibm.com>
 <1579636351.3390.35.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
Date:   Tue, 21 Jan 2020 12:38:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579636351.3390.35.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/21/2020 11:52 AM, James Bottomley wrote:

>> - really small devices/sensors being able to queue certificates
> 
> seems like the answer to this one would be don't queue.  I realise it's
> after the submit design, but what about measuring when the key is added
> if there's a policy otherwise measure the keyring when the policy is
> added ... that way no queueing.

Without the "deferred key processing" changes, only keys added at 
runtime were measured (if policy permitted).

"deferred key processing" enabled queuing keys added early in the boot 
process and measured them when the policy is loaded.

We can make this (the queuing) optional through a config, but leave the 
runtime key measurement auto-enabled (as is the config 
IMA_MEASURE_ASYMMETRIC_KEYS now).

  -lakshmi

