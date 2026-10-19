Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643B488231;
	Mon, 19 Oct 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394145; cv=none; b=epGG+4X+YJ0xueB5L0JqebuHRPnI1XWUac5RSOjb8BRk2Kxoc+6FQ8XhmtUosC5rXfte5jqKutifvCEwZ//i6y/5Oybn1HRx4aCwSmb09b5jkw/1VPmcBRwkIirNxFK07AxeGQqIoU6zawJQpfzvU6N9W7y0IwOMtOC247F8J+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394145; c=relaxed/simple;
	bh=UMZUR7gUCfjNCY9orYLVit8W+HlozrZrt+Fr2OQk2nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ith5OIyMwZq8PV08HU5Q/JmNuOZ+kUFkhlaTxaSI49JGb3gTOXWnkgSrDimq+7mFO9oOevSlTrSXldhNv4ZZIYvuWl4Y6VU9JuLRLbvY0zVNhc5G5rzDI7PjhugdygzPqjWHqqNfsIz6927V2L9+ZKjVn3zObR3WGkcAVcpvHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id E4DE4164A0D;
	Mon, 19 Oct 2026 03:05:43 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id 790CB1649F0;
	Mon, 19 Oct 2026 03:05:43 -0400 (EDT)
Message-ID: <24255490-d0b6-4793-aa7c-2954bd52383e@unspacy.com>
Date: Mon, 19 Oct 2026 03:05:42 -0400
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 Adam Alves <adamoa@gmail.com>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
 <asfXObGNaZ9Z8CwN@kernel.org> <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
 <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>
 <asqUgaKpEJbo8g87@kernel.org>
Content-Language: en-US
From: Sean Meadows <Hellfire@unspacy.com>
In-Reply-To: <asqUgaKpEJbo8g87@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58


On 10/10/26 15:39, Jarkko Sakkinen wrote:
> 
> So the gist why I believe that this might have effect is that every 
> transmit reverts the state to the initial state. That should erase any
> weird state that firmware might be in (usually not that great quality
> code).
> 
> I think Mario's patch is good overall for the stability. It looks to me
> that we are catching some weird state inside firmware where we don't
> have direct visibility. Or this is my guess at least.
> 
> Br, Jarkko

7.3.0-rc6-g587527648af0 with cherry-pick
9154aa6c4b789d23e59d599c330cab2c4e915401

strings /lib/modules/$(uname -r)/build/vmlinux | grep "cmd_ready"
Used to validate crb_cmd_ready responses.

The patch failed at 201 hours, on the ninth drop into S3. While this
represents an all-time high for uptime, the failure demonstrates that
the Intel PTT can still enter a corrupt state.

Where do we go from here?

Sean
