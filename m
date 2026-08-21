Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE50455171
	for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305281; cv=none; b=ejoMOMGeEmBvTLbF3HSZ+XYI5Grm5yz/Ah8/hW7vY8z2noMMhygjqHtqWy7xjnRCybrdsvJ1UhPT7nFguF8tDIa3aEfreu23KrHCRweibC2lT8zVDCarUfsC6C2KsUzMEeYuMlbWAzXz9G7r41eGrgnHe+1zvP6qw0fCz6R5A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305281; c=relaxed/simple;
	bh=MDuA7Ky/0oeqZYNprkCuTnPM6OQk5mo/pbNCOuCI3Ao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdYAjNztttd8aFUKUllPdBqYM/LWgpGAr6YD94b/EQkEbgzvb2Z8rT13RhTMHpH64uILdwAj2JCdgtdBPEUqw9U+g2iSmQmEZSfQz0P/54/XrP3PXwrvgy2SZB8BN9dfmA9ljoUMkPCLs2PLk7Ho3B6n2ZAVlbA+LOkvKmtpir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dcb3MIkd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dcb3MIkd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso7545935e9.3
        for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787305266; x=1787910066; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z2vT4G4w+FuGaSUg7rJCxX3eISYj4wJ+Berx4Gi99f8=;
        b=Dcb3MIkdjCrE0U/d3jV9oEkfke4NvwATPfkZVJWt9+h8alEE4C44wQ28PVks3t/13C
         R+C5raffKUA2E1qaWd6/0CJEG6kOBvewT+nfS6zxt7MmT+Km0SqbstDcH8rg1+tTBZGQ
         lj7ah1c+lAEEsIgQCy3ozvyMgRrML8eykopcNTFExH3S5ArR7SBifg5ZdBkQ9hIdihJa
         +BMcCENaYsJo15jCG5JmAqqBTa5j2GvTVSAKAp/P8ZLeOlkGvprWbL0dHDu20Rzhu8um
         o8/7aCEgzOeycrOGjnlq5FgwVJ1C7W9cN2kyYcwla81GPC5mZrMyEwAwxVzMLHXruWuu
         fZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305266; x=1787910066;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2vT4G4w+FuGaSUg7rJCxX3eISYj4wJ+Berx4Gi99f8=;
        b=b4hShVhjFTdW6RmHztuBy0WBVySU4kMEmJvhaBi+3BCsUDpGbDk7k0q87izzlKb/VJ
         dcDLtq1VZ6m2TpII6EvCGsN60OQuOm89Isox4MZi42f5bzgO8rGxL81IuARjkCrl7JsH
         aRqgAegD8HUurIWpGqOVn5A28V1JvzAKXp7VpRngsl8CaZxw4aawUByh203wdCTdejbr
         Uu2nk9n/Thld1qc1Mdq7m70IK7S0AKgoy/DItgTxofd/dkqaYpfKDmfSVn75Coe+7wHq
         QZvioP3+Q7V3rm/LN+otay0AgJ58xN6sqb4nAoF9P9zN50jI6cz0QeL6vfW0vXCB6uJc
         UGVg==
X-Forwarded-Encrypted: i=1; AHgh+RpLbmk4B13nblT5P0zWNGxI8YwFDxrxS4z4RBxl4YLpAULi4gMyYz2JmiPgk6OCG/EH08BObjwpRS5om6/1SH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzqkt/5x08+6MLOgmS+VjUAuFfnDVRBcIw5jy9pBYPOVx+kJT
	6GdrLx7m49CmyzY2Z5hhFb4GIdNANPdqj/s07Ni15Soa9l9Ct5ih3z9eKu0UYNrOK7Q=
X-Gm-Gg: AR+sD11LBf2u7KVGIkKb7ZX+MDW95/0EB30tqAE58qZBs52L0AZDNGfkQBUGAs4jS5n
	j5EiAps12ZN4kWCV7IKShfZ5+txUrILBiAaXpXflgWs2K7+3iIWcpA72HLtfm89+HVMPrZsT2NE
	KoOdJQcMee47lnAVs6L8yYEdUk35I6WM9Z8fRf9tAXbYDsl3MP8T+y0qmhcKnnHhV3GEqVuUv6B
	HGNOzYz120GplApp8TklzBo28cNCoR2kn545R7re0XpzqswP/BnWLuSqCLFfFY65JRNEA4FMZKD
	lotfDBrEQFwJl30i52pUJmFdEDax/LY9jejsDCYyV8gNLGJCYWK53NvN52LBh1hDxALqq6+2nMZ
	JXB1vwdUT77hn363DuIUlZ+5E7BnH3hf22toc6vrIwIyfleX8LlqKomSiNr7eQ6ATLqGOvHW6It
	gchDhjerqDR4u1I8Z3wrGMju+R34V94njviKnnkakCu8WDrvH2Im28vmcMtshJmOkJN1k5+uZM8
	k8YPP0Rm480s8cQpJT4bYUCP6r57MiZY35vamDO6g==
X-Received: by 2002:a05:600c:c493:b0:499:737c:8a8b with SMTP id 5b1f17b1804b1-499b847746fmr65154955e9.12.1787305266266;
        Fri, 21 Aug 2026 02:41:06 -0700 (PDT)
Received: from r1chard (61-231-75-38.dynamic-ip.hinet.net. [61.231.75.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46ca8b6sm2643642a91.8.2026.08.21.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:41:05 -0700 (PDT)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Fri, 21 Aug 2026 17:40:59 +0800
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating
 during resume
Message-ID: <aogdHNl9HLMR89cW@r1chard>
References: <20260803092240.18348-2-fourier.thomas@gmail.com>
 <anpm2fdZEwOlnMwv@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anpm2fdZEwOlnMwv@kernel.org>
User-Agent: Mutt/2.2.16 (2025-11-22)

>> memory reordering between the wake up and clearing the flag is allowed.

When exactly can this reordering happen?

>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 12b7394b34bd..7f500797b7a7 100644 --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c @@ -173,6 +173,9 @@ int
>> tpm_try_get_ops(struct tpm_chip *chip) if (chip->flags &
>> TPM_CHIP_FLAG_SUSPENDED) goto out_lock;
>>
>> +	/* Ensure that device is fully resumed */
>> +	rmb();
>> +
>>  	rc = tpm_chip_start(chip);
>>  	if (rc)
>>  		goto out_lock;

Where inside tpm_chip_start do we actually need to avoid loading a 
stale state or flag?

>> diff --git a/drivers/char/tpm/tpm-interface.c
>> b/drivers/char/tpm/tpm-interface.c index f745a098908b..2de12b02f62b 100644
>> --- a/drivers/char/tpm/tpm-interface.c +++
>> b/drivers/char/tpm/tpm-interface.c @@ -474,13 +474,12 @@ int
>> tpm_pm_resume(struct device *dev) if (chip == NULL) return -ENODEV;
>>
>> -	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>> -
>>  	/*
>>  	 * Guarantee that SUSPENDED is written last, so that hwrng does not
>>  	 * activate before the chip has been fully resumed.
>>  	 */
>>  	wmb();
>> +	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>
>Can you rationalize this change?

I agree the clearing of the flag should be moved after wmb() to guarantee 
that SUSPENDED is written last, the flag has to be cleared after the barrier.
That part makes sense.
  
My remaining question is whether we actually need the wmb() barrier here?
