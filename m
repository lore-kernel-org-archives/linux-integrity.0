Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253745;
	b=m6DzjFwNnGz4BQrtB8U5Hy00ftXtqqVjRQ4ocykzKBhSKBFO3280lereM+gvb9Ynsyo/
	 iqbul54KkyeTWHJVCvklkTC6m91GcLUqNUT+69pqNDCcrcq1MMHdGfywpNYE4at86Flnq
	 XQiStOACR/ys9ECFnWwkfxjBdlEUsDu9HAshKgswTaVKWXEPjy4rcdNF2C1SnT25ygfDQ
	 G49Y9YpAJJX5aiJqp4Q8YXMSqrYhlzQq/u7GiVWMgP5ctM5R++suLDu2welJRzjAdjz6U
	 Fg3mfiFk4XxWGOFHppMHLNNVHjNA//sLRby2ml9X0BBclzG0tcBh7SfJlwMAHfdwzKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253745;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
	b=mbtWuaM0xK20jOt2YGzM+7x6YgA8gIaYGVocvEDm7sdxxwaFqTJfn8SpM9Q6TLKqZkAH
	 r3IEXKHxjHKP3U5kNuT/BVOB/fwqHA3PEFbFlef1f1cTxjdvyCINvYey9LqOR33aLC6Pf
	 afSIBzMOBrBuIFs1Zd1rYAsz2n+i2CJER+HC0o7bQFufpU3kk5t9eY8tl93YioqCN/3so
	 i3Q1TdTEk4isiO5qprhE4UAI6jXmvJGARQJ/Mvr3/lsK+6bDvFV7cQX8jmSgumH6ZlDkn
	 vR54DAFNprikI8RsAwaLJRaLOO4LeGc6Jbkj186tMYhobL4bHu7s8gWEer8VZDRbYfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E8606A333
	for <linux-integrity@vger.kernel.org>; Mon,  9 Nov 2026 19:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 456E8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so13513465e9.2
        for <linux-integrity@vger.kernel.org>; Mon, 09 Nov 2026 11:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253743; x=1794858543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
        b=mUHMEoj0OktUW/gb+YstIYDORhlprUaT3Pl55EnG/nnLaburszuAJ7iR0RpMpIYrWn
         i4MGo9eOItoB+uCiroF4/NKwPuT+ukO31zRR6TPXlgiWd8CfEG1mbH7fYrCsjnhxlTGD
         g3CMw+u4t/Rau9ep8XyurDkuQBZDTMgKy5EVvDa9xLR/TR/XqLMzE/SyTDX2u1NyizBL
         xqYWKaRXgC4vS6yGPoXSoazHeEmmveUJAE++5Q27OCEhlOgR/EQOYs+rHcrblIOQ6ON3
         iaXGctQWb7AMuQ5glGB776CyEL1/ygEj4zenTZ11NR7O01Xx96FNKxWZtqxqBcOCGiM+
         Axbg==
X-Forwarded-Encrypted: i=1; AL+hErEtcwUGq51SFtbgVRwcLmCh5N7+qlV3VdLMkHfWRawWW+p1n1Fd+gU8e9j52TzOU7VjUdB2zWQNthmvliOMtbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VbXT7zbQacXT4uAYbxHPl1sQzD1lidOCWEHX9q9B3nr3aHRbx
	2vZrU+zNjSYdDhg7Hx/ISLglGYvetJOzfJ3G2HedNmzPIQb+Oh3B15kt
X-Gm-Gg: AYBFou39iOX44IBTFxjEp2pW85O8MSrImqQxX3B9AQj94IAYKskRDZJ4m7fjQBF5VNZ
	SMlTniixTrDz6dnE5j+RY60XxQ0dhbR63G0RjYsOkLNIuuROjddtI3bYjWfaFTfaB5M1AyygCEM
	EwhkPl8IrGkUr7UYOnVE+ZKSooRBb1eiMvoyEwXff1ikDUnRNWmnh3iLgWkBcmuYpG3kTmfH1zd
	2bfWZIq2z3VhwjdbOm2AwoKSgy9HoHURpV7hlY3rEHF+UF0pp9HRHqiGDpE5VP0JR0j4zkaNPUr
	KljPgBXJCT1KZbeyyZsyDYMx0bXrMi1qTj2tduBP/cn+kbfZSQENcQ9nLls7owvWcW9nuUeQdWv
	OpDiAldgRuTJ+SKya+OhxBX6JHv65TM4Zzw2dt8V9RP7/2VhrbtxjR50cuPSMGjY6gbpSugLfMF
	kQZ5vA8FjmiRs6OhwnblwdCUm46A+33KpCOXpM9bmIwN87QBa+2UuwAy93aCCk5qv0sIDY0HK0o
	cWWpZxyt8mW4+4um6zPWmpMf9Uazz5K3CweOtV6d8FIMNHiy0qRTwIj4Z71CNnuXB9Ejp187NcQ
	oU0O1j7BY1QP2JunQPwsUb22GXXSdO/Ej1knEFIeOTxvySdJj0YvXekhvJLoMoRTW3G5wtE6X8e
	znQhVDYV/2BSLNgqRtyFK9uLu1rz0pUqrMOrJu7pLWzDkWeUjxIWxNse0loWXSQc=
X-Received: by 2002:a05:600c:1d29:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba023376d4mr4246085e9.11.1794253742529;
        Mon, 09 Nov 2026 11:49:02 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02300988sm6618615e9.0.2026.11.09.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:01 -0800 (PST)
Date: Mon, 9 Nov 2026 22:48:58 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avIjqp3n29DKkpPp@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <avHelQ1nxsDVcQkZ@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHelQ1nxsDVcQkZ@kernel.org>

On Mon, Nov 09, 2026 at 04:54:13PM +0200, Jarkko Sakkinen wrote:
> 
> Are we migrating to C23? I've not followed this too closely.

Google AI says that we will adopt C23 next year or the year after.
I argued that it would be would be after 2030 but AI said, "No, there
is too much juicy stuff in C23 for kernel developers to wait so long."

I don't have a pressing need for this patch to be merged.  I was
just playing with some compiler related tools noticed this.  It's
the only place in the kernel which uses "bool" as a variable name.

regards,
dan carpenter

