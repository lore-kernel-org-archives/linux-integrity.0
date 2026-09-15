Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62718331A43
	for <linux-integrity@vger.kernel.org>; Tue, 15 Sep 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435428; cv=none; b=jIyl4k1SEJfgAwYYD7VfAwC/I6V+8+VpYP+xPy0AdKd82RJ+uD4VELrzrBoLHvconGvfFga029/8DuMTOUXPRpa9jdDxZXwepR3zc2ZtJjtKg8rjVO0K3ma2EUp54VPG8iE4mC2m6gp11Iox17NWnGODcIq3vv9nrwldMOtJsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435428; c=relaxed/simple;
	bh=L+n2ehzp9oxJW4TxfGWV4j94fVpk+HwOVZhdvIbMw3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPyvfM1QLUegb7EWtLDm6JLCyb5XDTNJJlU4URx816QT2HJ6tQPvjTOxTlvRtoB24QBaKILPipmdezaBZrNOPA7OsGF1DzAs/y4zh1nNr1YEIQZmroFPXbKNF48K5TuvwcGRUpNm9cvfPXzgFgzU2Fz4awdXeTL6AOOIcMfrvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1442f016b0a411f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5c1dd4d1-71d8-4297-95fd-48643d421cab,IP:0,U
	RL:0,TC:0,Content:6,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:7db8b62,CLOUDID:adc17cd77aaf610fede0aff832f51da9,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4|15|50|99,
	EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1442f016b0a411f19a56ed5b684f684d-20260915
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 118609754; Tue, 15 Sep 2026 09:23:38 +0800
Message-ID: <92bcb45d-3387-410c-a85d-f42f6695eab9@kylinos.cn>
Date: Tue, 15 Sep 2026 09:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
To: Nathan Chancellor <nathan@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <20260909082459.796628-1-lijun01@kylinos.cn>
 <20260914233601.GA1539446@ax162>
Content-Language: en-US
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <20260914233601.GA1539446@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I will fix this issue immediately.

2026/9/15 07:36, Nathan Chancellor :
> On Wed, Sep 09, 2026 at 04:24:59PM +0800, Li Jun wrote:
>> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
>> and wrap the struct assignment with pm_sleep_ptr(). The old code keeps
>> a completely empty dev_pm_ops structure -- all callbacks are NULL --
>> as dead code in the object file when CONFIG_PM_SLEEP=n, because
>> SET_SYSTEM_SLEEP_PM_OPS() expands to nothing while __maybe_unused on
>> the struct only silences the warning without removing the struct.
>> Switching to DEFINE_SIMPLE_DEV_PM_OPS() lets pm_sleep_ptr() eliminate
>> the callback references at compile time, and wrapping the struct
>> assignment with pm_sleep_ptr() drops the entire structure when
>> CONFIG_PM_SLEEP is disabled, instead of retaining an empty one.
>>
>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ...
>> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
>> index 7638b65b851b..84a0d3e5f679 100644
>> --- a/drivers/char/tpm/tpm_infineon.c
>> +++ b/drivers/char/tpm/tpm_infineon.c
>> @@ -612,7 +612,7 @@ static int tpm_inf_resume(struct device *dev)
>>   	return tpm_pm_resume(dev);
>>   }
>>   #endif
>> -static SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>>   
>>   static struct pnp_driver tpm_inf_pnp_driver = {
>>   	.name = "tpm_inf_pnp",
>> @@ -620,7 +620,7 @@ static struct pnp_driver tpm_inf_pnp_driver = {
>>   	.probe = tpm_inf_pnp_probe,
>>   	.remove = tpm_inf_pnp_remove,
>>   	.driver = {
>> -		.pm = &tpm_inf_pm,
>> +		.pm = pm_sleep_ptr(&tpm_inf_pm),
>>   	}
>>   };
>>   
> This patch is in -next as commit 2249200ee420 ("tpm: use
> DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()"), where it breaks the build
> for CONFIG_PM_SLEEP=n kernels because some of the functions are not
> visible in these configurations.
>
>    https://lore.kernel.org/202609121207.tM2OfBmR-lkp@intel.com/
>    https://lore.kernel.org/202609121338.qo2mQWRl-lkp@intel.com/
>
> It should be fairly easy enough to expose these functions regardless of
> CONFIG_PM_SLEEP (or add some stubs) but I think this patch should be
> dropped until it can be done in a new version.
>
