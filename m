Return-Path: <SRS0=WyGQ=Z7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB5C43603
	for <linux-integrity@archiver.kernel.org>; Mon,  9 Dec 2019 23:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B85206D3
	for <linux-integrity@archiver.kernel.org>; Mon,  9 Dec 2019 23:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RpwA+yt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIXdb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:33:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42190 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIXdb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 18:33:31 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A687205D07B;
        Mon,  9 Dec 2019 15:33:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A687205D07B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575934410;
        bh=kWQMpmteAElyhNw3lYY9plKkwcO7W5de84ECeD7ibdA=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=RpwA+yt+9++7bNTEaVvDuuS8V2g83vD6cis23VA5Ti/AllHU37K1P7fepozJtbvxJ
         fqPvbYkSFEnL5nWVYNTLFX2gr2bT8yShGlwBSv9hjalDNYz1x+9C/qADPgcuySmHIP
         jqm6jPo8+eJPQFE7ksXAUptu4cg3Ck37gg+vaZ1k=
Subject: Verified the key measurement patches in v5.5-rc1
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <5254346f-4ba7-c820-e127-d46b84f2e6e6@linux.microsoft.com>
 <1575927416.4557.25.camel@linux.ibm.com>
 <3322befc-d1b9-41cf-aabf-0259fe3adb2b@linux.microsoft.com>
Message-ID: <25655efd-df10-5a6c-6a56-51bd187911d2@linux.microsoft.com>
Date:   Mon, 9 Dec 2019 15:33:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3322befc-d1b9-41cf-aabf-0259fe3adb2b@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

>>> Has this change been signed off and merged for the next update of the
>>> kernel (v5.5)?
>>
>> Yes, refer to the linuxppc mailing list archives.
>>
>> Mimi
>>
>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/
>>

Just wanted to let you know that I applied my "key measurement" patches 
(that I'd posted last week) in v5.5-rc1 branch and validated the changes.

Verified both the non-deferred and the deferred key processing patches.

Please let me know if you were able to review the changes.

thanks,
  -lakshmi
