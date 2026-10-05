Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1E1F7916;
	Mon,  5 Oct 2026 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174231; cv=none; b=R/Z2vmK3kbppd0kPyNs7uNJnvZRo+SgsGgm+zbGNKE/LhGhaSEGSNNHi4hwKoPimoZlmYe9DAD697bElEPhhNQcofDxyAhcyuI1LZ2jkBemJNRwq0PiMNp2FD76qTcXG+ENKlT4K6Z2ZaaxYNwesrkMGnQXsKpL0SKEiME2Hq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174231; c=relaxed/simple;
	bh=5KJ1uAc9HPpdtW0ubmDdX8yr6Z9bgopg+sjfzYI4JB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bnl5fDKhs3gS1t8Y+9TPE+pappDnHTDEbeIHrmaGjypxtXclITiPCVU2dyQtbs/QWR1/lllAobIF6sTlOeBGDW0YEo5lia0pY7J5jnYX1mzwH34LdptIicihP6ZHyKFh5qk94AG2IU9asUdcX+lQ3305qjROkcfDENTRNg4o3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 87440228c07411f19a56ed5b684f684d-20261005
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c008ddaa-c707-4d64-957b-70962ce10072,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8735a29f7ba440602aab403c692821e4,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 87440228c07411f19a56ed5b684f684d-20261005
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1122790045; Mon, 05 Oct 2026 12:23:34 +0800
Message-ID: <aa976135-27f4-4c4a-a9e0-a5a3347b514e@kylinos.cn>
Date: Mon, 5 Oct 2026 12:23:31 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tpm: fix log messages in tpm_init()
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>
 <asMdetm05nGIBbyn@iki.fi>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <asMdetm05nGIBbyn@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/5 11:46, Jarkko Sakkinen 写道:
> On Sat, Oct 03, 2026 at 04:27:55PM +0800, Pei Xiao wrote:
>> Make the error messages consistently prefixed with "tpm: ", and fix
>> the tpm_dev_common_init() failure message which was wrongly copied
>> from the previous step.
>>
>> Assisted-by: GLM-5.3
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/char/tpm/tpm-interface.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index 1ccdbde98b69..666a1c654c02 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -524,13 +524,13 @@ static int __init tpm_init(void)
>>  
>>  	rc = class_register(&tpm_class);
>>  	if (rc) {
>> -		pr_err("couldn't create tpm class\n");
>> +		pr_err("tpm: couldn't create tpm class\n");
>>  		return rc;
>>  	}
>>  
>>  	rc = class_register(&tpmrm_class);
>>  	if (rc) {
>> -		pr_err("couldn't create tpmrm class\n");
>> +		pr_err("tpm: couldn't create tpmrm class\n");
>>  		goto out_destroy_tpm_class;
>>  	}
>>  
>> @@ -542,7 +542,7 @@ static int __init tpm_init(void)
>>  
>>  	rc = tpm_dev_common_init();
>>  	if (rc) {
>> -		pr_err("tpm: failed to allocate char dev region\n");
>> +		pr_err("tpm: failed to allocate TPM workqueue\n");
>>  		goto out_unreg_chrdev;
>>  	}
>>  
>> -- 
>> 2.25.1
>>
> 
> I NAK this one. It is not fixing anything.
Hmm, this is a cleanup, not a fix—just a very minor change to an error
log/print. I noticed it was duplicated (with the alloc_chrdev_region
error print), which made it impossible to tell which function call had
failed (it might actually never be executed). So I just brought up this
cleanup along the way.

Pei.
Thanks!>
> Br, Jarkko

