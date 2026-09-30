Received: from mail-yx2-f6.google.com (mail-yx2-f6.google.com [74.125.224.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994B357D09
	for <linux-integrity@vger.kernel.org>; Wed, 30 Sep 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749864; cv=none; b=G+moYouXEcr/u/4/1yi5ZM6Mdouqpqjayk4hr5VZnqfM2L9nxgxUJIOEEV7T+WW8+drxsgtZKoBjWlFTRevOzRxWGlChbIBgLQKWdfcJRdowv+AFkTuPCZFgz78j8zw1sJ03aOiRRSlnuC1TZaZ2z3BGcmbm5fmNJn7PKW5nmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749864; c=relaxed/simple;
	bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxRZY8OGDl3IOwRtVia/6rCIoBa89cJqbCZtuNqHK0KCLCa5uO2ncGkd2RL4K2gh87Pl6waI3YA1pPP7drO2BVkuXDIiSU0C01+oSVM9g3ppYjc5MDHAZPKP9xIxzEYfL4F+ocNvgkjh2IOKSyLnSo7FaWHNPETW9USamt54XHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k1zxuboS; arc=none smtp.client-ip=74.125.224.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k1zxuboS"
Received: by mail-yx2-f6.google.com with SMTP id 956f58d0204a3-66e61475fa7so1963614d50.0
        for <linux-integrity@vger.kernel.org>; Tue, 29 Sep 2026 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790749849; x=1791354649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
        b=k1zxuboSonT9Gw+GNFRAUm4Axs6Xl6c5soEWCfRHHLeZ8ZoQ0c4TOouY5z1AkZrPzv
         hWGl4bKMsozmHq/A0134Xms+gHVwJcATFj5RD8rTP2d/mqvs9R6eotYE8VRG3CC2D85I
         gS8OiLLlC5ka2gxSNg3dceb7DLifyrdio8dk7Wwsm8LOdik+2x0xVGAzXfYr0ukTfR2/
         2lqnRwHyEkvVQY65R1T9paSOQhfGqaQ3h6QQoF4iaiOkcEJM//a26yVQLgiuJaJr9QS5
         blKe829IjZHenWGBS/umnDLhjrHSCCQeJ6kU/w9dDPe9ezIc6V1cwme/04NYdqjNyxdj
         c2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790749849; x=1791354649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
        b=puBmJqTbUN56UBpSYQUrD7mwFaFtO+zhEXNTpq674PsWdBrnHmrG+rf1LcobNJ5xPB
         Yub+OECiU7NSSuMwvYvTWskgU4MPOtH+dlrZlX4GQ4L8zXNnKEnRvQv9pjjSXufz1cqp
         yFF41FGJMDac6WSFq6YOz04UdgnZruMfypEVdhGl9RGhhwI+GwcFabsXuB4SurV48Jy0
         d7uTOWFG7RtEqL4BH49HgMnxLbijN1rZ1E0XEuSK8CqbJB6Y2W+sWZAcqhpg/0fUN/gI
         LGoyr9qTtmu1a/cefToYNrpxXJa8HPhC8Jn2B33kQSkH0DBMsHmG2lyYy3gVmZzriN1T
         44rw==
X-Gm-Message-State: AFq9FYJD9Ux+0+qe3Ny37/2TAzVyiSbSglvbV75z5iuOSX6bdQBUP27K
	uRI6kiC37m/mHmsJk27iUP9HZTBcCzd6ac1s0Abx0ll0kpGX3IwcGl3ONC6Emybm8aPWEa6tsAu
	JxLyhS+zdA/MKcA==
X-Gm-Gg: AYBFou0bZj5VziqmyXAa/BRRy1oMTWNmuV4L2QNWVybsvgP6IrLCva/W09V2T3iXDtm
	bnuBr5SAcr15sJCiAHVpiXiNFJ9+1nSELWcA3UOoigjiqpbUx2PPHHSxQdy8Z8IU7w1hn0cxfMi
	RxLelbz1G7rvtr2s9SIm5y7Qo/cp4VDnkmcumkSF2czzO9qFMnngnUlHXSBs2Nw6fniQPwUto31
	9S+35UZZAJUcWanm7H9Dz68LY6yveTRWaxIzg/ZaluG6Ys4KcnvvYSCRjk8hEgM/bWB01ED0ObR
	gzrT+IQm2aWFHYjvjuzcIMPstn1JrrLfj0Bg9r7bSnv9GetcIBc6JhWvXTp9thyVooa3O/MBGrn
	Xdy9Qg+VigbEPnPCFlxsgE4lQ02e5k/2UcYA54eFAuC313DPzSdda3bYaqHIocFQm3U+IVpcD7A
	MrmnuwHKFkKK14JoO6sHC6lPSbt3O8PLVGKIIjG4PKa2kb8JvagpGWCBr1bew7XqY0g028Smbiq
	ZaWc1MN3sqoLcNohccYYwlTWF/2z47P5Sl7TKGpY6Zb5nDVMNprX89V4KRq2AlNzg==
X-Received: by 2002:a05:690e:12c3:b0:675:3606:4890 with SMTP id 956f58d0204a3-6768357a1f9mr260728d50.95.1790749849309;
        Tue, 29 Sep 2026 23:30:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:9d70:10e0:9122:9e60:20a6:c888? ([2600:1700:9d70:10e0:9122:9e60:20a6:c888])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac539a916esm2624187b3.29.2026.09.29.23.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 23:30:48 -0700 (PDT)
Message-ID: <215416db-8e5d-43ba-8569-51c8f221390a@nebusec.ai>
Date: Tue, 29 Sep 2026 23:30:46 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
To: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 stable@vger.kernel.org, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com,
 Yuqi Xu <xuyuqiabc@gmail.com>, vega@nebusec.ai
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org>
 <20260930033300.30295-1-xuyuqiabc@gmail.com>
Content-Language: en-US
From: Yuan Tan <yuant@nebusec.ai>
In-Reply-To: <20260930033300.30295-1-xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/29/26 20:33, Yuqi Xu wrote:

> On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
>> No need to resend a new version but I'd need a link to the *report* to
>> retain reported-by tag here.
> https://bugtracker.nebusec.ai/f/675
>
> This is the report. The page requires a sign-in or registration
> before it opens.
>
> Thanks,
> Yuqi Xu

Hi Jarkko,


This bug report comes from our bug tracker[1]. The tracker automatically
collects bug reports from different sources, such as Sashiko and bugs
found by our own tools, and then attempts to generate reproducers to
verify that the reported issues are real rather than LLM hallucinations.

Some maintainers were concerned that some of these bugs could have
security implications, so we currently restrict registration to email
addresses listed in the MAINTAINERS file.

At the moment, we have implemented automatic fix tracking and Sashiko
report collection for the networking subsystem. These features are not
yet available for other subsystems, so if you log in, you may notice
that some bugs in the system have already been fixed upstream.

We'd be happy to provide support if you're interested in using the tracker.

Best,
Yuan

Background about this tracker:
[1] https://lore.kernel.org/all/20260830115546.3942129-1-yuantan098@gmail.com/

<https://lore.kernel.org/all/20260830115546.3942129-1-yuantan098@gmail.com/>

