Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572793;
	b=fZ2CcDQSpnHHo1T1vgASLxmMlXVwhKOLJj8psttVveXqH/XkpRqDlI8vu4bJJmOEpOpT
	 42lytWGRICqCkmqn+NeqEAWhjSLdoxy0dy+gF71QVgBaYL33+7Ub46MlN9NmaXh2DiDOW
	 8imeumCJZwQ120OKj2nCDe4jswxAEoHqS/4rKVKlKv818iTQwMCgSh4238i+Kx2YfH1du
	 RVFK6Mw9M8XVWk99+UagutdSR3bfKoe56I72kTPzf0wofJDa0EyK+Ra9XRJO5xEZWAm/e
	 CPfDHLHSy0xpzSbuEs6lOVbv79RoufR39iAQNb4dwST4TkDY56vqZNiqvrTF3nULTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
	b=sLcQ/5RtUt0+xYwqUhYbdkC2H+xMbuHF+ouCCZ4GcsHs6i6quS4UaSwVOcrnKRtS5auq
	 xlHE3oIS8mxIRm20Lh2buCIusPpBjEAiZNZkNhsmBdZiAzDrzRWKflY+W1CFfCXGVZElx
	 dHOwhMWVaWh/pTQZuqVuQIq3Q3pSqwHSI+TR/B696KFiuYHkwdWGfRhhvGluLdl5WGRun
	 lpFRPiwin7/KZ7EYZwQGVBzJqf6/zNQL5xVHkwISWJngZsAnagm3AQeSJkSeouGikWcii
	 memHTT9Qxo2/qic+f7mMClVxrqbBdM+cp/JeAgjZUUOIREOp1mm5YDDtLfu5VUM6Sxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n4HxuxQC;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AB606A31E
	for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 08:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n4HxuxQC
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06c60065fso340895b3a.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Oct 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572792; x=1793177592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
        b=n4HxuxQCqnew/uzBCFBXl9JM/FUybwmzHZedUalx6HnPy+gFSnup1v1oIqINM9mG8d
         59xRtEIvffxG6LLWjFm8AUXTAmrL4WUHJF3SN+E/cQ5eQH6RUWLqkQvLGTSsx8u5P+2i
         S2rtHo16giWUSAKVEdIghcH7CB4oNU/mzZkNwqrjm0kGw0fbfBsnEh80sxE8ZaLlNufS
         +upD6IyYCtJRrvSuHt0tvukfn0Jm33m3QQj0cUvSifqRlAGyyiV33PJjHKeIitHk4rF3
         bO/w37mjmImsru0WB1Pgsus/ktsL+0vo1QW8KyeVsUozxup5sumLfhP928ov82sVx5vF
         7yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572792; x=1793177592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
        b=HOwi1bFAgr2XiQK7QNtbMQXguVj3bDHqUO1NRexlDTWogWChbBkjsFzr2wtwTggw4C
         dNveYXTeZBVu0Vb/vNi7abhUG46sDdy9v2O14A8K2M13ZB9r+hDwbs9M7jJsQ5+D9QcA
         c4akYYG881g+n+cOngazD1uJYEtU8+e/WVCiRnUREFsH5Ai2yHaONsN9LE/oypqzZZB3
         IwpUFgbXidL8HOvIS30XHBFBk9UUL+3boEjuRHg9t84ekT5hLgfr/tZZaH7pEFoOMmJW
         BibC0H91A44vd7xnZZJNzUe6TzPIExTjyk3Zn35MASgzojDyG69BSmQahJ3zCAMbQU5N
         20tg==
X-Forwarded-Encrypted: i=1; AKwUvByrJqACly7HxqKZBUo7Lk3RqsErD2BzA4p3MaeBeDX3NUsph/OlfME4YCQ/0Lg3zNV0Qa/FgCR3OE/l7g0AoRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuPoz7Bcs0ysdi2G51m7f6a9HVkqMKhIlfTo9uoWi11UyEZkgE
	ENzkIdds0KtGNZFrH5Gv6znbYwT7H8QdSGqy9orYpreahXryv5JEqeh3DCLcGwz4tIY=
X-Gm-Gg: AYBFou2IzdyRP5xC7p1WXCCQ4vgXJTizKesHr3wLrN90BShnyY3hW1Ed+sJDTs4Dal7
	lx/AXw3fZ/SlsDCVJCWERgG+qCn0oScwH+mg9KO6ZF2ty2HdJ5ojDRCinnlE+KpJtsK1+fjzjIj
	uIrayKKvdQw3NEsWWEpa1mNJnwOWtxKAoNkzwpnil41V0I++t38Lw3jrnOKT1yYXWaWrCmQve+n
	FLiSY/B6ZgHOUbBJIZYyV7ItHBOtnvZsTi9g0wOJy49Cc6+T3Zr5P+R7RCAJm3IjjCRkdheBHJC
	HmCo1VVREh1Fk3bav80kqTZPxoj4o67ikwFzhIZA+3acbkaIJkhjZWhFav3CrIJwO5D7r9TUCBm
	frGjhUrlhaDZJaNcEM1quoUxE2egzdEbWwB86qHVaJVfBdn/DMU8JLLtTT91f6VwFT1PlJjeKJN
	d3ks9u2MB5QgfvlfqU8psQTKRCc8BjqQe2LSn7k4USs4H3Z7Pd0q3hRXd0fiZPFeaSq3x0avASo
	59g847WO4eAWzw6/wuSyOOhBKLlekuVgR9mGLin5v8Daziq1zbHOOnQ2PQYdGe3Kyb5UjIH+N3o
	4vc8b6kQRwI4XNqXwNWeb7OGa4GPSCGrmGY8iQ==
X-Received: by 2002:a05:6a00:810:b0:8a0:2b8f:ba7b with SMTP id d2e1a72fcca58-8a089b82570mr1155273b3a.0.1792572792205;
        Wed, 21 Oct 2026 01:53:12 -0700 (PDT)
Received: from 675-reply.eml (awork131052.netvigator.com. [219.76.131.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895d8e70sm611023b3a.35.2026.10.21.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:53:11 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yuqi Xu <xuyuqiabc@gmail.com>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Wed, 21 Oct 2026 16:49:34 +0800
Message-ID: <179257257405.72348.17698648428918034727@gmail.com>
In-Reply-To: <ateJA_WanjASrIUM@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com> <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com> <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org> <20260930033300.30295-1-xuyuqiabc@gmail.com> <ar8hhrjQQw_yfghj@iki.fi> <ateJA_WanjASrIUM@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jarkko,

On Tue, Oct 20, 2026 at 06:30:11PM +0300, Jarkko Sakkinen wrote:
> OK, so now that I was writing summary of TPM pull request changes, I
> came into conclusion that this is not a bug fix, unless you can show
> from TCG specifications that this is possible spec allowed behaviour.

I cannot. Part 1 identifies a PCR bank by its hash algorithm, so one
hash is one bank. In the TCG reference implementation, TPM2_PCR_Allocate
keeps only the last selection when the same hash appears more than once,
and TPM2_GetCapability(TPM_CAP_PCRS) returns that allocation. A
conformant TPM will not report a duplicate.

> So I can keep the commit but would remove fixes and bug related tags
> from this. It is essentially hardening and safety measure but not a
> bug fix.

Please do. Drop Fixes:, Cc: stable, Reported-by:, and Closes:. The code
change can stay as hardening.

> Do you have something to say that I might have missed?

Only that the commit is not on the current master after the rebase. I
can send a v3 without those tags if that is easier than reapplying it
yourself.

Thanks,
Yuqi

