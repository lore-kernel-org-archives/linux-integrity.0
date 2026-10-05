Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD4137923;
	Mon,  5 Oct 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181053; cv=none; b=q48jCBK5pxi3F6K6fO0zdy+jT9hfBWOHGg5R1YTTQOwWncM8DK/R/Ig33V/QL/4M9UUEGQU/dYwydBNDziiYtxPdBGY8deIO/b7zxQoTRnhCq1rh6IHTOJB6+vm9/Dxc9t2TkfH13At/Tuh7hHXuLgHGndOqMF+L2vfviYDvD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181053; c=relaxed/simple;
	bh=aDGNUxFnoGNZoKx51Rif4l0kxdmZi6UolPntCC8eR8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtWI0lqVUN5wwioUXcn7jIF3FUKfITmK1AqmNVwLLjFX1+oPg6JbPZpEAtmWILbwjUf296sWO1xJ/yPpLCocuK4GEUA4EqDXwVNdkXfaSbbePJhIUCojPRRBRaUoNy7tvnDi6uW3HFBeqyZth93D+7GYlxCzcX81Sgl57TUdmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6f957b10c08411f19a56ed5b684f684d-20261005
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3c361553-7787-4014-9ec1-90f1dcc92796,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0bad8d6b600c03dd905a494a9d71863b,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f957b10c08411f19a56ed5b684f684d-20261005
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 514251661; Mon, 05 Oct 2026 14:17:26 +0800
Message-ID: <42828ffb-d2c4-4f31-88d0-c4b939631ab8@kylinos.cn>
Date: Mon, 5 Oct 2026 14:17:23 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tpm: tpm_ppi: fix wrong error code returned to user
 space
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <16ff8f5a35246d5932068ce1b01438bc2895a46a.1791015549.git.xiaopei01@kylinos.cn>
 <asMkuS55pG_q8RsT@iki.fi>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <asMkuS55pG_q8RsT@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/5 12:16, Jarkko Sakkinen 写道:
> On Sat, Oct 03, 2026 at 04:27:51PM +0800, Pei Xiao wrote:
>> tpm_show_ppi_response() stores its return value in an acpi_status,
>> a typedef of u32.  Both error paths of the function (-EINVAL on a
>> malformed _DSM package, -EFAULT on a non-zero operation return
>> code) end up as huge positive values when returned as ssize_t, so
>> user space cannot detect the failure with the usual "ret < 0"
>> check.
> 
> I have no idea what you mean by huge value and why that would be
> a problem, and overall this is disconnected from the code change.
> 
> Two's complement value is correctly stored in status up until the
> ssize_t cast, which results the value to be zero-extended, and
> as a result corrupt the negative values.
How does the following Git commit message look：

tpm: tpm_ppi: fix zero-extension of negative error codes

tpm_show_ppi_response() keeps its return value in an acpi_status,
a typedef of u32.  The two's complement of the error code is stored
correctly there, but on return the value is converted to ssize_t and
zero-extended, so the sign is lost: user space receives 0xFFFFFFEA
(4294967274) instead of -EINVAL, which breaks the usual "ret < 0" error
check.
Declare the variable as ssize_t so that negative values survive the
conversion.
> 
>>
>> Declare the variable as ssize_t to match the show callback's
>> return type.
>>
>> Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
>> Assisted-by: GLM-5.3
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/char/tpm/tpm_ppi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
>> index c9793a3d986d..949fb7055bea 100644
>> --- a/drivers/char/tpm/tpm_ppi.c
>> +++ b/drivers/char/tpm/tpm_ppi.c
>> @@ -234,7 +234,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>>  				     struct device_attribute *attr,
>>  				     char *buf)
>>  {
>> -	acpi_status status = -EINVAL;
>> +	ssize_t status = -EINVAL;
>>  	union acpi_object *obj, *ret_obj;
>>  	u64 req, res;
>>  	struct tpm_chip *chip = to_tpm_chip(dev);
>> -- 
>> 2.25.1
>>
> 
> Br, Jarkko

