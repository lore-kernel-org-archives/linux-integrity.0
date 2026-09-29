Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7083D565F;
	Tue, 29 Sep 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704226; cv=none; b=iwdxFviXXqjNv95oAdR1jyFvyZ3uXG+lL9ESWhYwouCsYtTYkbHeST+/KUVzUfmuIQIP72BCimLv+kTVZ8ENud/rYsoiCWp8UOxGLMR/hgRSNYXY2ODPupmHrmPUnlfR99kbayJztG52x6Bif2hISQ7aDyxenA/4tWkSSMSYDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704226; c=relaxed/simple;
	bh=fqy/KGzP5bC4EJaWOAOCL9hrE1L9mgrAlAH7+phURg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8ipjea7AJud9vEGuXL1CQZjG9oMeCSMtkxM+At4DkAkDq7ZCQ27d6phm91LotQoFwGZ6PJS5YbuX0rqD2XFi//keKPKtoKxAbaFFzW/5urE52sNKHKz1AuD7Wepv8R6sfOGk7TiD0boaOPzhjENejlM3wWFWwQJsNic+7NQcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id BD7451649ED;
	Tue, 29 Sep 2026 13:44:30 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id 5ACAC164958;
	Tue, 29 Sep 2026 13:44:30 -0400 (EDT)
Message-ID: <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
Date: Tue, 29 Sep 2026 13:44:29 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 Adam Alves <adamoa@gmail.com>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
Content-Language: en-US
From: Sean Meadows <Hellfire@unspacy.com>
In-Reply-To: <araNsEodZ3NXf9qT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58


On 9/25/26 11:05, Jarkko Sakkinen wrote:
> 
> Thanks for providing the information.
> 
> Bugzilla bug under discussion: https://bugzilla.kernel.org/
> show_bug.cgi? id=217890
> 
> I also found fix attempt of which 3rd version somehow went past me:
> 
> https://lore.kernel.org/all/20240308145313.40932-1-adamoa@gmail.com/
> 
> Does this or disabling hwrng sort out the issue?
> 
> I got one other idea too with no empirical basis (just hypothesis): perhaps
> release memory mapping on suspend could help firmware.
> 
> 
> Br, Jarkko

Acknowledged.

Disabling HWRNG via kernel cmdline failed, and since my research implied
that path would require a custom kernel, I shifted my efforts toward
forward-porting Mr. Alves's 2024 patch to 7.2.7. It took some work, but
I have successfully compiled it and got it booting on my machine.

The patch appears to sort out the issue so far, but I'm only 43 hours
into the test. As we discussed previously, this bug can take days to
manifest, so I will reply again once I cross a week of sleep cycles
without a crash.

I also have a USB3 debug cable on the way in hope of capturing the
hardware state during the power transition. That said, if Mr. Alves's
patch continues to work as well as it has so far, there may not be any
need for that.

Sean
