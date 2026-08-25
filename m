Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F73EE1E9
	for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650938; cv=none; b=bK2cYh3ezw0bsll/Q1MKD9znVZujzQobKqw2yphZlTvBiazKPqapy0yCMmBxP4x5tbHZDothKiSxpNfgrNu4ls1VgijWbUWR8zqO3RWvAqOtazMBIvthLusaxTK/kCMzFYLH3x4N7hDW+MDNPpq+U1thTgZmDR5EIDGC0Aa+u4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650938; c=relaxed/simple;
	bh=TRCjrVT6a0nm5nOjYaRUYlFXYFxAVmK1oCXXhDKXrQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FIk6tSwZJZFJ8WAXmhx80jaqpcLS0Qvuzz0ckxyzlA9l+Yfaw0+nHIwqdJifDIMExGjxqTt67QLx2SpBw50AV9N7GSI53mH3w0+RlF5JtSuRPcsTgJYrsVgJT6Q29pAYPS1cugwgfhIHdHVLQwmEqOSA6Ly/VB/ki5RYSR1e1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJkQrKGH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJkQrKGH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4996c452e95so2467855e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650933; x=1788255733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmTx7tD1rUFhIsjzkYVNdRt+/Y88by0P9eG+nC4RYUI=;
        b=nJkQrKGHMg+QqYc9gXw8NbGWR+jTs3nnBYuDucUOfqom4ztT9+UOAFrhGuL5NzbEXo
         4xKAbV9XzDi2DUI1V/Ifzx+5u6nMDZ+7b1fjgF9yhtW8wj8d+dtKVJk73p6B26Ch9HCj
         fYSJ6WK8j03C2mhN/tlGx+QYP1T5ohuzx2xDjuXjEaI2uLt4mZDjHR0DD2LvKFiAkt0T
         rwAEIXveV0gvJf2YC/sVwFCfb+Py3swp7hmE94i9xnPPAmBvuucuT2PGrD4kmkA0X/9Z
         zpS16GY/F/j0q0W4Qck0hDvrfXO2pTOq9IQVklBjAlTMFJGzT2+SbH9vzddTcWuMZED2
         id5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650933; x=1788255733;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmTx7tD1rUFhIsjzkYVNdRt+/Y88by0P9eG+nC4RYUI=;
        b=q9SPjI4q9B0dCeJYXaskn8XS8Q79ofO+N37nhYP9PZ88MvGNB7sUChaif/O8sBUUXa
         /lLLqP2IH68RihPKDzZwincPiLnJi1KjdFZc6eOfUnZvkYe2vPoeHhhmdpIkTlFyL5Zg
         HOs9AjTh4+XBWWbuo5c0CdSEf+AnqYAOTZRyvalJzsV3SeZ0kGCu0LqRcx3xyfkUcEVD
         U9Y4UjPfmwvtNqNue9sf0ivnmA0EBEp67G0ZIiCbGzElBnMMqaLUpPCJLHV2uWjviE4R
         a/KmffW6s/YgVav60VkOzBlkRVkVe4U44rP6zvgu8S5iNPbx5zAvQvxIcoxhRG4uQ2gS
         yHrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/A6KOeN9bO3cIdvT6iA5Om2Y89RQp8YGKjTbk7hEOX9Af+zWLpdBegml19Chx/FMH7jsE1i7dN/h8OK96k3I=@vger.kernel.org
X-Gm-Message-State: AFuF++ls0IUK0xJjQu5I/UmCfMyehGWkBPPo05W8mTqgmVLyMDqVpbMp
	/Yf4Y8vqYfS5HYr6cTRfCg/9oZC5NLR89lLquooARMrklGkUXkyvjWIG
X-Gm-Gg: AR+sD12muSYfsUG6zY/sVV/EFPGBSkiZQmlob98pPNOwMfH+i8Wzj2PpJHNQRRYHUA8
	+8uvbiEKPn12aAAcxq14tpV+rVATlOibF7BYkVZDHBs+cAuGv6hwpXDSfU3FKVsOkJXPzHCUH9J
	koEFhNQFqz42eFi+Gpdk0dEvNmQrjDpHXVPPZJ+ljHPYj7/OEAbZD9VJSLLQqZohpOFVcFW6pAY
	rPl4RQfZYEMblz+DJLUrxuoa0p3DE8oQy/e9Ht9eKrZAmmj+yUbQdpuqRz2yyVHcjnW+CuwUHco
	/aA2CXbaxE0oCTYWo3bGUqFi+6Dlgl6ZUasS5jeVRsjQz3beQnI/4iZyEYOlvz9AXQFgYgka7jQ
	rMn0rXrPg0tOidwhpg8CenzdjGzcVOplQ8L1nkQHm6pE5272k+CYKdr3PDh6mOaDb3KNC6Olr7m
	UU34IKydmmXGGQcPOJ4eZkFV7ixlIn1t7HpdoRiJ4/oBqbU32InXIkIBP1sTOluduFI7vaALH8k
	3jF9w7WNeXN4X1VjxoIkriCv8y2RPI=
X-Received: by 2002:a05:600c:1392:b0:499:a660:f4ae with SMTP id 5b1f17b1804b1-499b8353024mr204215045e9.1.1787650933330;
        Tue, 25 Aug 2026 02:42:13 -0700 (PDT)
Received: from [128.93.83.149] (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d63553d6sm23460235e9.8.2026.08.25.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:42:13 -0700 (PDT)
Message-ID: <a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com>
Date: Tue, 25 Aug 2026 11:42:12 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Fourier <fourier.thomas@gmail.com>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating during
 resume
To: Richard Lyu <richard.lyu@suse.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260803092240.18348-2-fourier.thomas@gmail.com>
 <anpm2fdZEwOlnMwv@kernel.org> <aogdHNl9HLMR89cW@r1chard>
Content-Language: en-US
In-Reply-To: <aogdHNl9HLMR89cW@r1chard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you all for your time and comments. Revisiting my patch after my 
vacation, I now think none of the barriers are actually necessary.

On 21/08/2026 11:40, Richard Lyu wrote:
>>> memory reordering between the wake up and clearing the flag is allowed.
> 
> When exactly can this reordering happen?
> 
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index 12b7394b34bd..7f500797b7a7 100644 --- a/drivers/char/tpm/tpm- 
>>> chip.c
>>> +++ b/drivers/char/tpm/tpm-chip.c @@ -173,6 +173,9 @@ int
>>> tpm_try_get_ops(struct tpm_chip *chip) if (chip->flags &
>>> TPM_CHIP_FLAG_SUSPENDED) goto out_lock;
>>>
>>> +    /* Ensure that device is fully resumed */
>>> +    rmb();
>>> +
>>>      rc = tpm_chip_start(chip);
>>>      if (rc)
>>>          goto out_lock;
> 
> Where inside tpm_chip_start do we actually need to avoid loading a stale 
> state or flag?
tpm_chip_start() reads chip->locality for example.  I'm not sure it can 
be written to concurrently but some drivers write to it. It might not be 
a problem as it would just trigger a call to tpm_request_locality().

Since speculative writes are not possible, so rmb() is sufficient; in 
any case, no need for a read-to-write memory barrier.
> 
>>> diff --git a/drivers/char/tpm/tpm-interface.c
>>> b/drivers/char/tpm/tpm-interface.c index f745a098908b..2de12b02f62b 
>>> 100644
>>> --- a/drivers/char/tpm/tpm-interface.c +++
>>> b/drivers/char/tpm/tpm-interface.c @@ -474,13 +474,12 @@ int
>>> tpm_pm_resume(struct device *dev) if (chip == NULL) return -ENODEV;
>>>
>>> -    chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>>> -
>>>      /*
>>>       * Guarantee that SUSPENDED is written last, so that hwrng does not
>>>       * activate before the chip has been fully resumed.
>>>       */
>>>      wmb();
>>> +    chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>>
>> Can you rationalize this change?
This change is mostly based on your comment: tpm_pm_resume() is called 
after the hardware-specific operations have been performed, and the flag 
must be set after these operations are complete.

I assumed hwrng corresponds to tpm_hwrng_read() which calls 
tpm_get_random() which itself calls tpm_try_get_ops(). After 
tpm_chip_start() is called, tpm_try_get_ops() can return a valid 
pointer, and tpm_hwrng_read() can work.

Individual drivers implement the .resume() method by doing 
hardware-specific operations then calling tpm_pm_resume(), so ordering 
needs to happen between those hardware-specific operations and 
tpm_pm_resume().  This ensures that the order of operations is:
   - hardware-specific resume operations,
   - tpm_pm_resume(), including clearing the TPM_CHIP_FLAG_SUSPENDED flag,
   - check that TPM_CHIP_FLAG_SUSPENDED is clear,
   - run of tpm_chip_start().

If tpm_try_get_ops() succeeds, then tpm_chip_start() is run so the 
hardware-specific resume operations are complete.

> 
> I agree the clearing of the flag should be moved after wmb() to 
> guarantee that SUSPENDED is written last, the flag has to be cleared 
> after the barrier.
> That part makes sense.
> 
> My remaining question is whether we actually need the wmb() barrier here?
Revisiting the patch, I agree that this point is not fully clear. 
Looking at the implementations of tpm drivers, most use the 
tpm_pm_resume() function directly as the .resume() method.

Three drivers implement specific .resume() methods:
   - tpm_infineon.c: which uses writeb/outb that adds the necessary 
barriers,
   - st33zp24/st33zp24.c: which calls tpm_pm_resume() without 
driver-specific operation depending on the config,
   - tpm_tis_core.c: which makes a self-test before calling tpm_pm_resume().

None of those cases seem to require a barrier at all.


