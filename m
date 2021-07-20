Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74960C07E95
	for <linux-integrity@archiver.kernel.org>; Tue, 20 Jul 2021 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588996101E
	for <linux-integrity@archiver.kernel.org>; Tue, 20 Jul 2021 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGTRZV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhGTRXa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 13:23:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D734C061767;
        Tue, 20 Jul 2021 10:57:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r21so5050132pgv.13;
        Tue, 20 Jul 2021 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SCAKzF0tltAo+Pg+kpBSA9SJBNPxZag7K63bR9QNWCg=;
        b=pdg5TYcM1Cl0VsmQbhMNa8sYNIEJH8H51172d0+hqAss/yurQL1w6IqVlhi3f/cSKw
         caZCR4hwmhO8PJ5GUvQok30Glm4+D9rV0Ek1qDXDiSsbVI+Ba1G7e8zXxZCgwNFbTC/T
         LfBA0qW4ODLnz4K85YAFJIkgKTADsgh+4aa3SoZa0QYS78NrsXNlFucYfU40LgyOmuR9
         +pBVhcimC2Ge4kTIRkexJXuRTvgQnGwzoVCbT9OSM3YvGy1RUaHNfjSpAN0W4tgug43B
         mCbIzKmJGEFuhdVHUn2HdqrXtbf+jXGkX91zoVB9Q3kjz8wLszrqCQZsysivfUENIDsy
         r1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCAKzF0tltAo+Pg+kpBSA9SJBNPxZag7K63bR9QNWCg=;
        b=SyD+F/qulhD3621NGDw7odCGJI9XBQjIO4Fsz25ENhQDXfJEmZaPCvUhvp4/1Bd44f
         n664qPC0gRtmsgEDO9PFIeoMtV9/5hJBFOhQqJcTSfec5DBQIVPk32A3RCPYihvGIO0P
         zA3szeMoMUie5xfAkDEjUaLDUALZ7a1aHc87ScQLxwrvrE7pbiQULXj9qUyMPh9on1uZ
         A41pnKyB71P3uFcswXfb0XMJoWlqnLb3ydFqkBaJvtQ+jotNovLDKV+s/oow0Wo9thAp
         XW/w4yfx6+iUVasXvn/H7iVhYiIn6HUrCqRIhv+N1x2Dlh7yzfEgnWSwiDTwm0IeRDWO
         86ug==
X-Gm-Message-State: AOAM530uPlkMsoBOERrz4VZButBm6c9JKdBAkQ6vMg4rcfN9x7Jh56hU
        euqbU9IOGzmTKZu/gmTk6zk05sSTJ5fGGA==
X-Google-Smtp-Source: ABdhPJyOofYfNzSsraRCOWDoI1H6DDvPp61gZ5+EqN2yeLt81U0hpw47GbNkHpaq0dTS/aXHCscP5w==
X-Received: by 2002:aa7:8254:0:b029:2ed:b41:fefc with SMTP id e20-20020aa782540000b02902ed0b41fefcmr32748440pfn.42.1626803840552;
        Tue, 20 Jul 2021 10:57:20 -0700 (PDT)
Received: from [10.69.75.79] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p3sm1494718pfw.171.2021.07.20.10.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 10:57:20 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210716022332.GC3232@sequoia>
 <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
 <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
 <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
Message-ID: <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
Date:   Tue, 20 Jul 2021 10:57:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/19/2021 7:32 PM, Florian Fainelli wrote:
> 
> 
> On 7/19/2021 3:49 AM, Jens Wiklander wrote:
>> Hi,
>>
>> On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta <vikas.gupta@broadcom.com> 
>> wrote:
>>>
>>> Hi Allen/Tyler,
>>>   The patch looks good to me.
>>
>> Thanks.
>>
>> Rafal, is it OK if I include this patch together with the rest of the
>> patches in this patch set in a pull request to arm-soc?
> 
> I can take those patches through the Broadcom ARM SoC pull request, 
> Rafal would that work for you? We seem to have a bit of a maintainer 
> coverage blind spot for that directory.

Applied to drivers/fixes: 
https://github.com/Broadcom/stblinux/commit/4ecd797b7e16eb7f1b86fbfd7e4a7887b192535b
-- 
Florian
