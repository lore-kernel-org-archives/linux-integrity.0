Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34306136672;
	Fri,  9 Oct 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507679; cv=none; b=OCFuBINR0kpw+9Ey6FEEBcrSSRQF6N/8co/ZWWaMuvWzeGBo2ucl3wNxXQLtMuF/X2GLsZYj/5EFM0GPALzifQ7Kl+2qCmcQiNOkOj2GK5jNv0Qccw0ZrK5ju8+cmLN3lXSm7t4uDkUYx6gj18zP1tF6wpUMl7qS06O8/WvP2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507679; c=relaxed/simple;
	bh=5o681WT2JcMa4Lay67+1VkJC6lNCwbB9VjmTuQcNFPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNCWs9loCA8ANtSffuAcJjohdUuKfbD+Xzrmc9ky5D9Z2S+0Qxmw2Hj9lNCyAfstHE1qzhPMFwqn3CyRgm5K/3yTeclGb54bK7YUBEHXGybpPEyttM0pfBUDik6UyhOAnfzT3Fh4HTcZdGrfVR+3WKz4OtU4VfuexqCBlDrPTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e91068e2c37c11f19a56ed5b684f684d-20261009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:14e4ba6b-5637-4e74-8698-223140aa71d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:474d0c777375c55cc720d8e150a63839,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e91068e2c37c11f19a56ed5b684f684d-20261009
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 172668676; Fri, 09 Oct 2026 09:01:07 +0800
Message-ID: <c74c47b0-e1e6-48f4-8997-ef264fcbf977@kylinos.cn>
Date: Fri, 9 Oct 2026 09:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] tpm: some tpm small fixes.
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1791421672.git.xiaopei01@kylinos.cn>
 <asfYIg95-qQ4JrL_@kernel.org>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <asfYIg95-qQ4JrL_@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/9 01:51, Jarkko Sakkinen 写道:
> On Thu, Oct 08, 2026 at 09:16:19AM +0800, Pei Xiao wrote:
>> This series fixes several small issues found during a code review of
>> drivers/char/tpm:
>>
>>   1. tpm_ppi: tpm_show_ppi_response() stores its return value in an
>>      acpi_status (a u32 typedef), so error codes such as -EINVAL reach
>>      user space as huge positive values.  Declare the variable as
>>      ssize_t to match the show callback's return type.
>>
>>   2. tpm_nsc: tpm_nsc_remove() doubles as the release callback of the
>>      hand-created platform device and dereferences the chip drvdata
>>      unconditionally; init failures before tpmm_chip_alloc() crash
>>      module load.  Return early when the chip has not been created.
>>
>>   3. tpm_nsc: the cleanup runs twice on module exit because
>>      tpm_nsc_remove() is both the explicit cleanup and the device
>>      release callback; the second run operates on an already freed
>>      chip.  Stop overriding the release callback, which also stops the
>>      platform object allocation from leaking.
>>
>>   4. tpm_dev: a zero-length read() discards a pending response,
>>      breaking the command/response pairing of the TPM character
>>      devices, although POSIX requires zero-count reads to have no side
>>      effects.  Return early on a zero count.
>>
>> chhanges in v2:
>> 1.add reviewed-by tag
>> 2.remove patch 5: 
>> make the tpm_init() error messages consistently prefixed with "tpm: " and
>> report the actual failure of tpm_dev_common_init().
>> 3.modify patch 1 git commit information.
>>
>> Pei Xiao (4):
>>   tpm: tpm_ppi: fix zero-extension of negative error codes
>>   tpm: tpm_nsc: fix NULL pointer dereference on init failure
>>   tpm: tpm_nsc: stop using the cleanup callback as dev.release
>>   tpm: fix zero-length read discarding the pending response
>>
>>  drivers/char/tpm/tpm-dev-common.c | 3 +++
>>  drivers/char/tpm/tpm_nsc.c        | 8 ++++++--
>>  drivers/char/tpm/tpm_ppi.c        | 2 +-
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 
> Right, so I've already applied some of the patches so I'm a bit 
> confused what to do with this.
> 
> See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> 
> Is there something wrong in the ones that I already applied?
hi Jarkko，
  Because this patch ("tpm: tpm_ppi: fix zero-extension of negative
error codes") did not pass review, I resend a v2 version that includes
the patches that have already passed review and carries their
Reviewed-by tags.

Pei.
thanks!>
> Br, Jarkko

