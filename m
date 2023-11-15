Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nZ6obCLJ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CC91AB
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 11:21:51 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2566A20B74C1;
	Wed, 15 Nov 2023 11:21:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2566A20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700076109;
	bh=SaBUovaOZgPZmbXPH57FNEVFc+ljV6c65NGm0njD1cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nZ6obCLJUSUBATwf80Ckn/zRTdXg8uJvglKGcSt85/6sEjSXcT6Gk4Buz7k6kwVLP
	 0g9jPAom16Gu/crQMF+BBpQk7sT6Qj59jDBGbCZ4L8+Tn7GfG0pGplpKc40LFTfj1v
	 Xpdw/iJmrljgwXIzNkMgIpajEUpQfauHM7gI8784=
Message-ID: <d7f7c59e-a71c-45b3-a125-78fd6cd31e3c@linux.microsoft.com>
Date: Wed, 15 Nov 2023 11:21:48 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
 <348e6e3ebd1c6ee1c85cd12f15591f32bb699fdc.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <348e6e3ebd1c6ee1c85cd12f15591f32bb699fdc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/23 12:51, Mimi Zohar wrote:
> Does this patch set take into account kexec_calculate_store_digests(),
> which is called from kexec_load, and verify_sha256_digest()?
I am not yet sure if my patches will impact the
kexec_calculate_store_digests() and verify_sha256_digest()
functionality.

I will investigate further and get back to you as soon as possible.

Thanks for bringing this up Mimi.

~Tushar
