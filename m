Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795184947;
	b=nQaSjWPZKP/e1FxQQ5ojnfLU+cWCL6nBCi/da6R2/ijwKVgV1GDhxsaO8QMtNBnNOR5l
	 UlhifXURYu+tl4EyTtlIFwZ0zZqZzY8fMhnrM4jcgSxRdoPyQ57zW3dehG8ul6V/paaht
	 MzrY6u2e+7XkR5AiuZ0RwHeBKeEomXtVlWc4dvWPU6PlGZ5rGuBks6StovX/W2ZWaQEih
	 QaAJTuC0Fr/CUbGVO8gFSjrAIo7MVi2dOCS2C39JqkFxQmWkLOF5QL7ftXFffOVQJtGHO
	 BNKqRapyfKnR30xGfKIbxll4GYTKQSLGjIwzigm8ZZygvpYSPNWWD94PF0WkfYJhqJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
	b=jl2d23wrJv2axID1N2kcBATUgYNgvhdnMIRSWmbTukMVVw6+qMwpPnZ7E4GiPVe1C4H7
	 CbMa+zya/Nn+LOKeb+OQqBxHoEZfL8pDu3BoiT4YN7N+TH2a44CI2AB9XLsRFNapV5o5t
	 zA+OyepjaUDGMnVKsdbIPvDPkskLDgGx+yvoGBdNlr5ykeVYVjeAHWg8OH+5lUBbsgWIJ
	 HklvlDj2w/pSQ0ZOWth2+YXnWgyrBPtKyCWmIjWUX6SkMgs3jzsebwgYJyYt0lK0DzKyB
	 yL9X1EtC/4x9hfjacvLPnNTWm3Cwq7dozqGdYzQnSIw2RBCv4X8lTPFq5+qO9I9AWlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="KGPM2/li";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEE606A32C
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 14:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDEE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=KGPM2/li
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5127c7abd5so162901466b.3
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 06:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795184945; cv=none;
        d=google.com; s=arc-20260327;
        b=btDpVle7YYRDgl+k+WOGNhKesktx97pCHoBd/Rh2gsaf5otxpeMtn4cCznGtDImJEm
         kZqk9tDygTOH2WQYnG6CD2lze1VXnDPV+3ipEo97C1SjHHi6TQDdQ/ZJ1UFJLWrhhn+K
         I3MXfOLwjg6jB8ozc1nXdxANFlhl2ogQr0hWAsuWNxEo+K4fivk3IvRSRX/j/k60v+//
         cFWjSYqLwlHGvD6v9O70oFLPCz/0wnLJPZrm6SjrvVMUlG9Z3epu8R66nC2iEMWyGsSO
         +l4EUQIYzmPleBL/qBVVTpZBqYLhyWOKe14VcKGTqFP7fOgaFmDU5v4GTGa6YbE87oZw
         LUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        fh=qPszf00sg6H5uURViy3fOBwW13oI3n9IHkvMbSoIef0=;
        b=k7sfo26dqVIRGnvceepDF0R6dXJR2BZ1oLId5wfaV2nknqK+e2ovLHrQ/R6hZsCw9K
         /QPWaXKVHTqKxeMURyolOW0xrAcxUf1qH4IYu+m0f5UaW7bcwCetO5z4YahonAD1NaZg
         sL4r3zfBsBLNcgRHivSMJuiA7KUOziWcATyaUowXa/bYsY+Fod4wR2aZie76sr+leKpK
         zBxAwypiFvUnxI3oXFRiV99aaDwnw+dmqY2jm1o8JWTn/AE3LHrI8Avfgy5P8utKQ6rJ
         30FciyfIGtxD5MLd1W4g7NQFUi6w4JlhTCg4xUyrcGaq+Tww3S0iv1f263Lfwrqd4+Gt
         Xaew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795184945; x=1795789745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        b=KGPM2/li2EqKJYsf/Gv0WBthhS+7luPZAuNGPpKyoFR0Tzkw/keRMcPSqNncdo+2u3
         uZ+z8CtXzAHyFe95zXtUVAzd3/EqXdFCu6If/GIpuT/0EUC5sR2s5ZHQAtrFj3wHUQ0Z
         IXdKQpGDDTztrw1WwuQaleOUwzoMUx9m7ewvakMso9Ku4mvH+wudthJmCerHjg1bYbRV
         o1ynKSSNX6Rg214EU/v8oT5eMHlVczo/yhDp5h56i+74PPC6D1YDy+Ll9n4D/UClUXHw
         Cli1pzyCwK1zM/moRyGGU2j/ZJ4fZUiQSbjkpPtk5urWyIMeD44Rglud1eb1xF9kceFu
         b2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184945; x=1795789745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        b=TdJ78pRGmxq/Q4c3iBvxIQBxvbRQMRuZ9dS1O3ODrEdUpo0Yga1SBenmA42tjS18FQ
         JPoHQqKuNnfmY0m3Prptx6CCGbJQNgxHBPBTSEDxcU8Tj32Af5bB9tYqfdNIaZuimNIr
         9Ccijd3KyNNUr3MMwXPIKNGQmsZDWNw5s/qneNGg9fpkThoW+8rVuCpps+wH9dVfPQlU
         RX3NEvix2Imybqifsn8+Re+ySEWSt9Q3IPyb9NIJ68t4XBrGBkscwgjnE+we1qeT6eyb
         uUsuxmNRL/uHFzfigyOOcTSS02b0Wul/owWPqmWtvN1hQ2r88/K+s0WxQ7PcsnNDAqhC
         ARhw==
X-Forwarded-Encrypted: i=1; AL+hErEjoGZx94BrEcnjgH/pZA9wR772D1xJRboynkpFxj4YSODNrpKjJ+lto5hr78/g0DSypkKprtLj3oPcsstQYzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OeNAFG2geNu0tnn2z47NsWE7XzS8oAIh9snIgT6A7/+xBas0L
	T5rjAzcxQ4VNIjUNajb64r1LWZqOlkjOl0bhllTxOgWUEnlpthJZtEV7Cj/s21CEOyxwkCbXFD5
	rtzxhqJhjBWnw/HyZZ/+H5wenKz+rsneArNUu2FA7VA==
X-Gm-Gg: AZFdTZd1Kzx8LNs7w42X3X0se9pd/Y/zFepmU/9+dbYvlAP/ZY3QrKK6T/wq0fhORWF
	A+7y/kRwh41A08B2cH0iXAzdAGzZILJnibF+k0cEftZe2cNV8+xT6R7Vg0rLMWjsSK62+TWahgS
	YX33EdVm9cK5Jw7UqW4AUnZk8F9UQg3Cdyt+6dlyM66SnHC/zjjLkDBcx2jaC1p5OiC9QOYLgG2
	iijK9e2kLpmEXVWKgqLnzOs5/fCK5EG6hLknl7WM3+uzrfaDMgaFdD7nSrvSeyWnu2IlvimS0Yg
	EltQQuXuJtIHYLWeZxUf1V1DkoeG9rhEwlfVpxA+PNOTeFnLNwXyxyeLP3R2EVdDVZYAzM7SlIG
	4nbUCBMCe6SlEqRHMT7S8gANhbO+GsSd55A==
X-Received: by 2002:a17:907:ec02:b0:c50:aa10:d898 with SMTP id
 a640c23a62f3a-c513a859528mr312083666b.26.1795184945410; Fri, 20 Nov 2026
 06:29:05 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
 <20261120121614.978396-2-rmustafin@cloudlinux.com> <awA8o4oIq81a7J1z@kernel.org>
In-Reply-To: <awA8o4oIq81a7J1z@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 21:28:53 +0700
X-Gm-Features: Aa3M54ovtmNup2lPY6rNVpSaJu-oUVw9OB9JbjDeYfkHzHe9GxRDZx2A7BPFff4
Message-ID: <CAG6=z5tzc8DG-7gU03mKs1JxqEzUULwBinfHKtYWyPycKkG6mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: Track the response read position internally
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>, 
	Jaewon Yang <yong010301@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2026 at 7:27 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Fri, Nov 20, 2026 at 07:16:13PM +0700, Rustam Mustafin wrote:
[...]
> So... why does not this block uring? You are implementing a feature
> as a bug fix, or so that it appears.

Patch 1 also fixes a plain read() racing a write() (the second trace),
which does not involve io_uring, so blocking io_uring alone would not
cover it. Patch 1 is small, so it might be easier to backport.

The io_uring block is posted on top of this series:
https://lore.kernel.org/all/20261120142116.1630010-1-rmustafin@cloudlinux.com/

It depends on this series, because the new ->read_iter() would let
vfs_iter_read() callers such as Coda reach tpm_common_read() with
their own offset.

Br,
Rustam
