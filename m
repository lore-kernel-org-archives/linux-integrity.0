Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9BC004D3
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B664B20824
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH/MZqeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B664B20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeJXXLL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:11:11 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41996 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXLL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 19:11:11 -0400
Received: by mail-wr1-f41.google.com with SMTP id y15-v6so1505844wru.9
        for <linux-integrity@vger.kernel.org>; Wed, 24 Oct 2018 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hGH9ddefoC/qMX88z9zeEfIRO6qjxQAzowclTxkgyQM=;
        b=NH/MZqeE1zIuYGkxIz4XZGquEiZOZha44daL89LFgAU7K5jmKN3RIwnCbyvUafhxJU
         zwdVlJeyXyBfqyKX76q+TRmy2CQhOP/yaeKAycHQ8oRpHsvvHA9qsTH3TDMEgUHBAGLJ
         nJBgcABUpD2hSGCz5Vk/pcjdY0SM4gIkSJg2ah+vyblDj49qV85F8nF/7euUzPzgehIi
         9HHBjB15IVoKY3xsYtVNvoPlAktOTmI9crYNgMUgSO9kDe60bNCCc0zeFHRraSZh0VHZ
         LDSzZFSUG5ikhf93ERh9FAd/w/0nww0+Mhb/zCmFoZt1iIXWur+W7rYIdBofa+FrD3EG
         8YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hGH9ddefoC/qMX88z9zeEfIRO6qjxQAzowclTxkgyQM=;
        b=FqO1aMfbMdXy0z6U+z6HmxhXeKBFfBrSNXmgF5mUKDGIcCRIPOPmWPWVy4qvvfSjGm
         cus3CAbJTYpQK1W/67/KUGNOIuRMPbgPu1uCZP1JHldHnFfyEvIKaPDvwP1qKkLacH2T
         N+y58KRIHZviQza+Kub6K6XfQRO+dC0KZg72zOUxif2WRBh+/Zm05xC5odZ1eMGYlqaZ
         srp/yppmSAVUZ29fMmBlLy/KLldl0WNCirda6kJ8JVqavxE8Cxr0fMpHkTT/tybFKinm
         bSl8FLS4PYwhA+5MzTLGZHrfyP1OALEn9iGjSIo+CoxB6N18QErZDVjPlJpDmuq8hDUx
         a4/A==
X-Gm-Message-State: AGRZ1gKyKekhFKH87gH8dA1XtJncTldvJFl9/znB+k6vPW+YuyZi9nb7
        oaZJkFdyL1OVV/zfs+Aru44=
X-Google-Smtp-Source: AJdET5f+4uSngW9piF9/Q0+jinU1lA49kbhAKAF4oMFqxwhlDlCG6oozDgWUpI/HCDnrQEZOaMvluQ==
X-Received: by 2002:adf:9d8d:: with SMTP id p13-v6mr76940wre.12.1540392167165;
        Wed, 24 Oct 2018 07:42:47 -0700 (PDT)
Received: from [10.0.2.15] ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id l5-v6sm3521592wrt.43.2018.10.24.07.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:42:46 -0700 (PDT)
Subject: Re: LSS-EU BoF(s) (renamed from LPC 2018)
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, serge@hallyn.com,
        chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
 <20181011154847.GA5978@mail.hallyn.com>
 <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
 <1539296304.3108.54.camel@HansenPartnership.com>
 <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
 <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
 <alpine.LRH.2.21.1810160833560.14147@namei.org>
 <1539642523.2867.44.camel@HansenPartnership.com>
 <alpine.LRH.2.21.1810160946210.2779@namei.org>
 <1539691005.11939.258.camel@linux.ibm.com>
 <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
 <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
 <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
 <1540301465.2787.4.camel@HansenPartnership.com>
 <1540301816.5583.187.camel@linux.ibm.com>
From:   Monty Wiseman <montywiseman32@gmail.com>
Message-ID: <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
Date:   Wed, 24 Oct 2018 10:42:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540301816.5583.187.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/23/18 9:36 AM, Mimi Zohar wrote:
> On Tue, 2018-10-23 at 14:31 +0100, James Bottomley wrote:
>> On Tue, 2018-10-23 at 16:16 +0300, Jarkko Sakkinen wrote:
>>> How can I join given that I have only ticket to LSS not to the
>>> summit?
>> According to Angela, the badges aren't a problem (they'll let you in)
>> and I can have the the conference staff get us a room up to about 9pm
>> tomorrow (although we'll have to start after the regular sessions end
>> at 6pm).
>>
>> However, we need to pick a time so they can allocate us the room.
> Ok, let's try and define an agenda of what needs to be discussed. The
> original discussion started out by Chuck wanting to get together and
> discuss IMA on distributed filesystems at LPC, and Monty chiming in
> about IMA format.
>
> It seems the discussion has diverged and is now about having a TPM BoF
> the evening before LSS-EU, for those not staying for LSS. Let's try
> and put together an agenda.  Do we need/want another BoF for IMA?
>   Should that be Thurs evening?

There are 2 high level topics. While they are related they can happen 
independently.

1> Changing the TPM driver's tpm_pcr_extend interface to support 
algorithm agility for IMA (and other kernel services)

2> Changes to IMA

I believe all the stakeholders for #1 will be here through Friday. If 
that's the case, let's move that topic to Thursday PM and focus tonight 
(Wednesday) on IMA. I'll let others break that topic down further if 
necessary.

Monty

>
> Mimi
>
