Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF238C636CC
	for <linux-integrity@archiver.kernel.org>; Sat, 11 Feb 2023 15:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBKPQC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 11 Feb 2023 10:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBKPQC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Feb 2023 10:16:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3CA2595D;
        Sat, 11 Feb 2023 07:16:00 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQrbZ-0003t7-8B; Sat, 11 Feb 2023 16:15:57 +0100
Message-ID: <08063f18-95de-bf2d-4f03-8b72b2eac7c4@leemhuis.info>
Date:   Sat, 11 Feb 2023 16:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH RFC] tpm: disable hwrng for known-defective AMD RNGs
Content-Language: en-US, de-DE
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        regressions@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20230209153120.261904-1-Jason@zx2c4.com>
 <543c2e9b-6d82-7ee0-9a1f-e3176aba16e2@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <543c2e9b-6d82-7ee0-9a1f-e3176aba16e2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676128560;52f741d2;
X-HE-SMSGID: 1pQrbZ-0003t7-8B
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 09.02.23 16:41, Limonciello, Mario wrote:
> On 2/9/2023 09:31, Jason A. Donenfeld wrote:
>> Do not register a hwrng for certain AMD TPMs that are running an old
>> known-buggy revision. Do this by probing the TPM2_PT_MANUFACTURER,
>> TPM2_PT_FIRMWARE_VERSION_1, and TPM2_PT_FIRMWARE_VERSION_2 properties,
>> and failing when an "AMD"-manufactured TPM2 chip is below a threshold.
>>
>> BROKEN BROKEN BROKEN - I just made the version numbers up and haven't
>> tested this because I don't actually have hardware for it. I'm posting
>> this so that Mario can take over its development and submit a v2 himself
>> once he has confirmed the versioning info from inside AMD.
> 
> Thanks, happy to do that. 

Just a quick note from my side: many many thx to both of you for taking
care of this!

Ciao, Thorsten
