Return-Path: <SRS0=ac69=3K=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94BC2D0CE
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04F324655
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ke+o3F8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSA4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:00:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSA4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:56 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id F394D20B4798;
        Tue, 21 Jan 2020 10:00:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F394D20B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579629656;
        bh=rEbmD/ZAcgYTqg5lv22gHg3BuIS3XcVwAuyZ8ZucRnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ke+o3F8JNJKUXLW8G/r7NY15sJb0k8OJM9cH1u8tH7ydq01p/8XTMiTadGcYv3rUa
         2tbdZzpRJxsThyHa+kheNH82qgi/wgWn1w7/aohJqryUVu5MVMUM9kjGPsgrFHMe7z
         RQPun7nIlFwFKrJQhM6JNZT4TNq9OUZ0rfkEO2Vk=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <47a0ef08-3142-3e7c-a136-784767ba8370@linux.microsoft.com>
Date:   Tue, 21 Jan 2020 10:00:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579628090.3390.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/21/20 9:34 AM, James Bottomley wrote:

> What exactly do you expect distributions to do with this?  I can tell
> you that most of them will take the default option, so this gets set to
> N and you may as well not have got the patches upstream because you
> won't be able to use them in any distro with this setting.

I agree - distros that are not sure or don't care about key measurement 
are anyway not going to choose this option. Only those that really care 
will opt in.

My goal is to not burden the vast majority of the users with this 
additional overhead if they don't need it - particularly, small systems 
such as embedded devices, etc.

> 
> Well, no they can't ... it's rather rare nowadays for people to build
> their own kernels.  The vast majority of Linux consumers take what the
> distros give them.  Think carefully before you decide a config option
> is the solution to this problem.
> 
> James
> 
If you have suggestions for how I can handle it in a different way 
(other than config option), I'll be happy to try it out.

thanks,
  -lakshmi
