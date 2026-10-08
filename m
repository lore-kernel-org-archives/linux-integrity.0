Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F83F787E;
	Thu,  8 Oct 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496580; cv=none; b=esGCPuRg1N7XielnjdnwcWSUGVhXPWrXtAx4P6sXhINmBY5zDte1Py498tl/ahVOBb90M6IrKXY28FT1srcBBs1rn8fJf4OyDGrjLN9/asixgtjAYn++QZMU7xtI0yjPGoQJIlIHj1ilITLmYTz4OizJ1F/ngyE5mujVjX7xjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496580; c=relaxed/simple;
	bh=iciqArxOAYo5A6JswSaQCT2gUlousAWTH8BqX695PPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmNdD+vWbtlKqM7Hwbqf47M6y4sGYid/abmYwcWq8vv4oHQ6+U58bPNn5lKTonVtoritIrTHp1KNcsyi4I+VrB4FkmnUkABuHZ69x8CJPDM95A5pbmsUmDCQCLPzBIUtS7SxJFUqR6Yr2eNouKKXPEvHEJa/y1hZIqlXf9qoEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id AE6F1168206;
	Thu,  8 Oct 2026 17:56:11 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id 3C8FB164A5B;
	Thu,  8 Oct 2026 17:56:11 -0400 (EDT)
Message-ID: <2db92c1a-815c-4db2-adfa-3708152ec8f2@unspacy.com>
Date: Thu, 8 Oct 2026 17:56:10 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
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
Content-Language: en-US
From: Sean Meadows <Hellfire@unspacy.com>
In-Reply-To: <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58

On 10/8/26 16:00, Mario Limonciello wrote:
>> The patch I pointed out this in bugzilla but the patch I had in mind
>> is:
>> 
>> "tpm: Call cmd_ready/go_idle for each command transmission"
>> 
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux- 
>> tpmdd.git/commit/?id=9154aa6c4b789d23e59d599c330cab2c4e915401
>> 
>> The reason is that the commit message highlight a bit similar issues
>> as reported in the bug.
>> 
>> Note commit IDs do change in my master branch so best is to look it
>> up from:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux- tpmdd.git/
>> log/
>> 
>> Right another reason is that then the driver always the TPM in the
>> state as it is when the driver starts.
>> 
>> I'm not sure about Windows but neither disregard it as sometimes we
>> do pick behavior basing it on how Window does it. I'd still try
>> Mario's patch at first.

Checking my notes, I cherry-picked commit 
19931faa1d75fb858d86aaf5b0e79d34a2379094, which I understood to be v3 of 
the patch.

Assuming I made a mistake there, I've started from scratch and applied 
commit 9154aa6c4b789d23e59d599c330cab2c4e915401 instead, which should be v6.

Once the compile and install are complete, it will take at least a 
couple of days of testing to determine whether it prevents the corrupted 
state.

> FWIW the issue my patch fixed manifested at bootup; but I definitely agree
> with Jarkko's hypothesis that it could apply to other TPM implementations
> and at different times.
> 
> When you tested Adam's patch I would like to point out it only 
> automatically applies to one board: "TUF GAMING B460M-PLUS".
> 
> If that doesn't match your board you would need to set 
> tpm.sleep_locality_preserve=1 for it to apply.
> 
> If you're sure my patch alone isn't enough to fix it you might try 
> combining patches and setting that.

When I ported Mr. Alves's patch forward, I altered it to enable globally 
rather than targeting a specific board, so I was cognizant of that 
hardware-matching pitfall. After booting, I also verified via `cat 
/sys/...` that the parameter was live.

That said, I am not entirely confident that Mr. Alves's patch is the 
correct path forward. Even he discovered that it merely extended the 
time until failure:

https://lore.kernel.org/all/
CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com/

His last message on the topic indicated he was heading in a different
direction—stating he would submit a separate patch if it bore fruit. As
far as I can tell, that follow-up patch never materialized, though I
cannot say whether he simply got busy or if it ultimately failed to
solve the problem:

https://lore.kernel.org/all/CAHwaaX-
j37rq4+DCNSRAgPmeQmrYZiX2sLv4ugBjPJSj9LPxcg@mail.gmail.com/#t

Sean
