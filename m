Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA22DB791
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349130; cv=none; b=YHr5xaHmCQLRaSmZsqxpG9yLsUE8uQRQP66yg9zTRWpYaj7DAaM26/KBpPEg9eOHvdu617vOKb5Ec/osvJK5LoRKOKDDO13+b3HqCwui7hkea2y/d/0mwoeOmZaJ4JY7rD5gqjyVRHm+rNmhniVIvnoR49drao3zynaSmKmT+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349130; c=relaxed/simple;
	bh=q/jOT0aSezOBSpE6+6RycY5gUNZ6DERvx3WJ8/EXdUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G09ikt3XIcL8O3UezbbXWpvbmmgWmGMml7tHdgzujXFlMLpg768wPRXx7F4+3rWVDxMtnDbD/kJvQm9dVi+GJSnEthb6S5rSxdioflCKe/B+dpcuGu1X0miEaemLZiMMeQb61eWEEepNjkrK/hvVxQXHPaUM3Wen/PogrVYfCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGAKfdLm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGAKfdLm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so7964085e9.2
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349124; x=1788953924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYZ6NU8jX/7XJB8VagafYKNIpfybNyjtFYVwXJsyJqw=;
        b=VGAKfdLmwPqDAHyHZT0xMMWrql2D1RGgneRVFwxIBDo3gLR5RgRw/BxTQSXV9dYOPX
         erYDCfiaPvQjVQVhx3Z+m8a1LvOspwAQ8esrm+g/rQoGAPkRvSm53A/d6N98sWM02KHs
         S0B5dFuYwMxivRcGlUqybl99gsTi0axKHYgJYmVaK4KQk1Tk/OWQhvyieAIQOTI+kBC+
         tPkcU8NxRRfmcTIJJ0TTRI0ajBUFAINgvOhqSXGvhZTEy+YMhEHZZqSfytj1MX3rvegw
         flQz+sht0wuP/UIJos/JHjQyIA8cNVPt3qiy2uKx0bQ1s6txLtLuC7ch/8/hPPkQs7Ex
         OA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349124; x=1788953924;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZYZ6NU8jX/7XJB8VagafYKNIpfybNyjtFYVwXJsyJqw=;
        b=KkAkagyfu3rrYUd7vXVE5s49kNzg0HovWj4bQvLrNC5k7+4XzFp/MTxxXP7udCPAiY
         YYKfAy8Rjb7WoXKnI8hDvez+gtjUZPnkiV2RVrNh5QYeRlP1cNeymBxBDDbluv4Axpu7
         QjwOMCSuyzcTlKpTpAUE88/tq67KzjV9Rj7e29j+i7FXAnYZNroWlTvWy7lc62J996sC
         8uFNCmgbkwVpy43fnokXFwl6njdZEe6cM3HrsM8Wf2toy06lx+ndjbEh/ukxUVrzpTba
         zOJqq+9f5j/AaimW31wLOX80BBPnuWqhgO8QxobmOSW1wzfLemwdKvwV5MR1yT8ysfb7
         wYzA==
X-Forwarded-Encrypted: i=1; AHgh+RoO3/ZNFLHcDcWGHBszsRYjhwnMvn5uoUxJFkRtzHIW2L+HZNNrN4mNLZP0WBuwybjJxajOZilLCmNy1rIPkpM=@vger.kernel.org
X-Gm-Message-State: AFuF++kIm3bgE7vh/uT5H6kyjAaLWhu3+J5rQDCh8x2NpUQmmqG2z0LX
	8uXIJTtKPjF93uGBrJDX7qtS6208ACH74vMgbnHFhpdcbAI1vMl1yh8g
X-Gm-Gg: AR+sD10zU3bayhQJavn8eOe+W/64oGZjZE6BmWhR6gJqmgeVkS2sP4ktHPlst7BIQoL
	XnD9EZhHpmtQgvWUMxpy/wk+7UKg5X0nnMhEBk8It1EGpgelxVCLsYT17zHZQz7IhTRQ03Cuctb
	t+Nj0ptSO1aPEJQ/1V+mwqL1+dL/GGTqtFNoOHkIEVmCuhgsfm9rdcqzv1EDQlmT2gyzjiK7O7E
	PkxuUX1YZcA+hQ5ep80ZT+LK3bunZYCJcxOCnQi4eNfmOB/YXVd1ObAIqPg1qp6rGzr6xT15RwE
	ch2KOV9pmgYHAP+thoA/wTHKfMehx+YwoRx9JLybAPXdBkRXxU1bw4SnQm8rExcNAVjyPnLvnd8
	xG7QDqq3j7JPN7JHcmgnLVweJgYXJ9yoW7f8dmKEC7hBwCsGcH+Tlra8TVqwtNZEkdxENFf1ihm
	TDfqlISbn+Lue2Z1jZBksEeOoKpo1m+WX+4O9mGpF2T3tOPYnwv0IvNHnsIXhX5czLBgZ4NYlAZ
	sz8FmDOQg88qZAYC/xr/PLZMxOHRjHjwZfcDFlqwyGGYtQQWHxTylKb+w==
X-Received: by 2002:a05:600c:1d89:b0:49c:ed8f:d094 with SMTP id 5b1f17b1804b1-49ced8fd250mr10166605e9.10.1788349124161;
        Wed, 02 Sep 2026 04:38:44 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm85608165e9.13.2026.09.02.04.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 04:38:43 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <7b7e4b45-dc5c-4328-bb51-5d1fac4c5586@gmail.com>
Date: Wed, 2 Sep 2026 12:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: allow users to specify the pcr index with
 IMA_MEASURE_PCR_IDX
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260824162215.1572367-1-julianbraha@gmail.com>
 <35ae5c9fd60874127d15f5fedb84c0a90e56eca4.camel@linux.ibm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <35ae5c9fd60874127d15f5fedb84c0a90e56eca4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mimi,

On 9/2/26 01:54, Mimi Zohar wrote:
> On Mon, 2026-08-24 at 17:22 +0100, Julian Braha wrote:
>> The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
>> frontend, so it always uses its default, 10. This means that the
>> 'range 8 14' is dead code, and users are unable to specify the pcr index
>> value.
>>
>> In a previous discussion, Mimi explained that users should be able to use
>> this config option to specify the pcr index. [1]
>>
>> Let's add a prompt for users to specify the pcr index, when EXPERT is
>> enabled.
>>
>> This dead range was found by kconfirm, a static analysis tool for Kconfig.
>>
>> Signed-off-by: Julian Braha <julianbraha@gmail.com>
>> ---
>> Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
>> ---
>>  security/integrity/ima/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index b3a9f86809b0..2d5bb19ea6ac 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -46,6 +46,7 @@ config IMA_KEXEC
>>  
>>  config IMA_MEASURE_PCR_IDX
>>  	int
>> +	prompt "PCR Index for Aggregate" if EXPERT
>>  	range 8 14
>>  	default 10
>>  	help
> 
> Thanks, Julian.  The existing Help says, "If unsure, use the default 10."  Could
> we make this recommendation stronger?  AI suggested:
> 
> 	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
> 	  that IMA uses to maintain the integrity aggregate of the
> 	  measurement list. Most attestation tooling expects PCR 10.
> 
> 	  The default is almost always what you want. Only change
> 	  this if you know what you are doing.


Thank you for your feedback, will include this in v2!

- Julian Braha
