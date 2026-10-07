Received: from mail2.g24.pair.com (mail2.g24.pair.com [216.92.166.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8A37A4AB;
	Wed,  7 Oct 2026 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.92.166.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390812; cv=none; b=VCqadS5xGrPdwueYmTIoxdMO3ZSV3nY2RhGLkeu45mLDS8AV9ym1H3J+dDrxWR+28AdK+d3j7wIP+pd/DIxCS+JbTtXq2nI2ogvrgqrU0aU0GJfx8fjqKdVGL5HOwBwYERrjJdYRqnaAPDceJc4zm29t1P8P9WMEdaeh6UAGshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390812; c=relaxed/simple;
	bh=xb+DcSAvKRUXE70JMyK/Agn1GXkayNlcudew7EnWp54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0bZe2/UD/mMh0LlyRZaBdexW21lcxGfT0AbPaF/eJp34lwqU/fut6crwwfFFCPJkxHA47XHF/bLioI3I9iJnhBIxNwtn1T5NSsXvKIkov5rGYuu+wn8o6wXb2KnUst7/4Leu/L+2QUglpOX4Ery3FrWs2VENOeVUvu5pOl9dL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com; spf=pass smtp.mailfrom=unspacy.com; arc=none smtp.client-ip=216.92.166.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unspacy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unspacy.com
Received: from mail2.g24.pair.com (localhost [127.0.0.1])
	by mail2.g24.pair.com (Postfix) with ESMTP id 88290168D8A;
	Wed,  7 Oct 2026 12:27:02 -0400 (EDT)
Received: from [192.168.0.71] (1969776-static.lxtnkyaa.metronetinc.net [217.180.199.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.g24.pair.com (Postfix) with ESMTPSA id 27855168D82;
	Wed,  7 Oct 2026 12:27:02 -0400 (EDT)
Message-ID: <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
Date: Wed, 7 Oct 2026 12:27:01 -0400
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
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
Content-Language: en-US
From: Sean Meadows <Hellfire@unspacy.com>
In-Reply-To: <arw609M6mDiqhQwJ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 216.92.166.58

On 9/29/26 18:25, Jarkko Sakkinen wrote:
> There's a commit with title "tpm: Call cmd_ready/go_idle for each command
> transmission", which is strongest contender to make a difference to this
> long running issue.
> 
> I.e. I think it will improve firmware behavior given full release of
> resources per TPM command.
> 
> I'm including it to v7.4 pull request.
> 
> Br, Jarkko

Hi Jarkko,

I have to break some bad news.

Testing Mr. Alves’s patch first led to a failure at the 60-hour mark.

Mario’s patch—"tpm: Call cmd_ready/go_idle for each command
transmission"—failed at 55 hours.

To give additional details: with Alves’ patch, I ported it forward and
tested it on kernel 7.2.7.

With Mario’s patch, I downloaded the 7.3-rc5 mainline tree from Linus,
git-grabbed your tree to get the TPM patches, and then cherry-picked
Mario’s commit. It was applied and built without issue. If being cherry-
picked onto 7.3-rc5 left it deficient in some way, please let me know.

I then proceeded to run 7.2.8 with my new USB3 debug cable.

I initiated an S3 sleep after a fresh power-on to get a baseline. I have
complete logs saved, but I’ll simplify here to keep the message short
and succinct.

1. systemd-logind[483]: Lid closed.
2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
3. systemd-logind[483]: The system will suspend now!
4. Kernel enters device suspend phase | driver callbacks | many lines of
confirmation as drivers and hardware transitioned

45 hours later, I tested the next S3 sleep and the following occurred:

1. systemd-logind[483]: Lid closed.
2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
3. Deadlock | USB3 DbC link drops immediately

I don’t know what all can be captured through this debug cable, and this
next thought might be nonsensical as a result. Would you benefit from me
installing Windows and snooping on what the Microsoft TPM driver is
doing to prevent this deadlock?

Thank you for your time and patience,

Sean
