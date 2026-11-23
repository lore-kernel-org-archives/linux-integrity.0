Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795453911;
	b=D7Xp+lFp+H5JJI0DZe5ADL6WsuBnlZ95ZzCS1Z3OSLxhHOpVX/cxwSMzqKKxbt2ctDXZ
	 jH32DiPcgMCrYZbG4bo1inGwJOdLEJoEw01RkG04oXmpbvmIYVdLKYOMKxbsqsKeORBJp
	 lX7lw9wuE/s2ULhA0e1Ef6bm/qkjKnLq32CifeE8LbyW3Qxv3qIHLk/7oNXEZhYe/A9gO
	 +8bSVB/S9MQdJ245nm48JlEjvtvnkG4n4PjlZfgtOaa/JzFXqGONdDiQmOR1UdxklCxTw
	 Uk14oLRFWOyMEQUSUiyKRF5uKlqrOIqcnygJV/HOMadvLHIc4lcs1YR490gB8vBVFYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6zmRgo0gFPagKYr2g+7G2GW6y5yAil61y9s8jKpkWdI=;
	b=MVV97lk5G1dOgRaEx1a5ORrnsrsqnrwViSaxbTkTjG2WXKEkM+/C5WgjJJ1Zh5+dlE8B
	 IBiTWO7Yj0wWkNn/A0xMbuG87Skx8aYpUVqh7q2/4+gBQNJQZQtvyyhSy75mdj7nRFi8T
	 tfmJjkBuCB0UJkCxXmYmxv48koHHq8ZDIv8BMspHmLt9Y84m9R/FgMaRQn2QJe16TG2aX
	 jAqmoWYHGHeil2ZALeo/DvZIrQNsK53r7tfpdsdBumbzUqK8LIOZ+H0tXgvbKYkWmtN4w
	 a+vdefqYvWyVgbJyCgEtefinlTwhfGMHmnEp+70dD6c2mmK0ToUKrw54YTPiGyEUcgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=cG0siZSF;
	arc=fail smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B7606A31F
	for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 17:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88B7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=cG0siZSF
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a1623d0so244822566b.2
        for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 09:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795453909; cv=none;
        d=google.com; s=arc-20260327;
        b=aj87xpyRadkXFN+qJnwnKaM5SFaMFY1xOMu+vDgkC6g4+m4LVq6wbQiKwDQTC0R5m2
         d0pGDp5LtAnqGehJMPBDecXXomlNF95l21xSC1m+XlQs4VdefjdX5trj3GXDPYSt9CIG
         iprV9196kdrMq0W8JYqltO+EBCyhxx6bXBkLI+CncGRfX0FQyi/Y83w/VaHbSSLtxBSR
         bZrKkjswr+++VfX5lMyFdiOrHjU9UhwnN8z+65D+TXWAlSb2kdghTgMyJfu/PeMkAzvO
         XFQYPI821JoyNPLmQfb3iPTI64eM2hcwrsoOcXG0n5LZ/9EMtPCilFUFAJHS6e2vmY0d
         QPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6zmRgo0gFPagKYr2g+7G2GW6y5yAil61y9s8jKpkWdI=;
        fh=gZD2DLErjzwLW48OFQvkuChK2qj2I2rn8onPcpqgpPk=;
        b=mWgtWA6CMw/jG7P3A9e2zAU/bnLfeBBz/jHpRn58fzTR2jtcqsu+/p2o9rH0mwFw4I
         3GSC4EoXzK9Hb8r8/xRvwqNrAEkogwDT44XIU8GxU9np1ofh7kmJ08kv6JLetE6BtkWw
         wzU8AXQ8LnjRJ+Z63QyOi6LohsLyuT+RVoYXKHKMKnGJeFEEfnqpT0APp6cBV3TLtu8D
         zlzjz4SgWh2jg+OcpDXMZ3r06yPT9xezt84QJMAmrp8667+lEgTXS0Xt0/attCOuf0CL
         2IGRC77x6NosYI3r1VNJa9NvVir6LcQcu6hk6cF8ZwEczSjqFc/RZW3Y0gx7FEVOSZGP
         w5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795453909; x=1796058709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zmRgo0gFPagKYr2g+7G2GW6y5yAil61y9s8jKpkWdI=;
        b=cG0siZSFYTpd4R6ZgQYJ8SXc+bG8ElcPj1nCBKcIlsZY4shb3awIkUOvQn5pkSc/b1
         lHPS1ExBDwp3M3cWTFoG7f0+Z5cx6Necf4BvTT5DlfzagAveWt3Tm6oSaG9VsQW8cltU
         GxbnXZvB4TRLielIYojVRurnjfGdsldtDi7GIsCla93CpWdxcqza94lGl6K2cioZt3Mv
         XIKvTFrwZUnX7pjtmu8DjwRXwK+reMjdG2Sxetn3ND3EaqRCfymK4LZGFl3s8TJ4Tzrr
         j0uxvZOoNSKTYXINbEvfcK3Xf5gco+Ed0Jx9vbG/998jlDxaPtjtPqcf5F/3IpAkttME
         Ksag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453909; x=1796058709;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6zmRgo0gFPagKYr2g+7G2GW6y5yAil61y9s8jKpkWdI=;
        b=RQDtxHOGF7gv33tBFO6g/b6lBhDefpA9NA3wne3FcxE2/5f0pz+XvDwBOaKN7I4jTC
         tjz9Q7JLmHpa+7X4aZRgl4phDucmbelWvj7bCUMNGpJuaj0yxDEy/7hPSYGb0SrKjmu0
         gvjF/cMkwbVf6v49wBCRhNkt+GZgz5WF3YYGUvTn46SIKSSG7A8AvkVymN3zvS3Fq+vV
         XVvY8qsI8H1tqGNOejWjGObdjsM483iNJTN43VCGnLJn5jaHN1qVMQAmuVny6WsBpBUF
         QwYjsuMqVwUxGgugm7sQvNJfCNB1Z9irBiMlebTc+p1DOHx9o2Ua1BrsI9Mq2EivP4um
         wn/Q==
X-Forwarded-Encrypted: i=1; AL+hErHIgld/udfHI+loEd/oi7WwcIe9jFOLLDRnT+QdNE/WgwIU8nmA2CTcrtFq679qWPpMN5gk2xU3FIH/wuqFtyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BLvLXLPbuky5XmZ95ZOR3nUBWHqO5ekHq7/k0ypuWYmFZWlt5
	XfyR9BDnipaQs118RmH9kgRdw8gEUJpMtUKiulSRdK6Xpht86oYTwd/5pQGfnqHDSHBKIpsOrmL
	1eIDe9VagE0zElwbOqJMdOD9LuyNFRerpYUtMme1m2Q==
X-Gm-Gg: AZFdTZdnD5T4ifPx5Ec9fd9KWtEZhyEymZb/DyfpkN28jMJfDjCJnroANEK6mgSo6zg
	UG/+srH9gTyv1glS9ZQnLmi5pJdkiUCNBsBB7LXRLH48KWKV1ey9hIMJUwqj3Gl4YDd3tGc42MK
	MQmq6Y6vfV4r1Lui8MDiA1mX6e+l1CFvtRnuKOeop/n5EJiTWsp27ezMBqqemNtuCJSkp5Kjwj4
	gCfm2UPinYlgcBimhkCWkC3ERAnE3sZMX/tE5/1NbgtutuYTr6HO106Mw9wEpslrB9Co4CV5YGM
	GapuldEPT+WB+MM7MxGgMjH91T9n7YS6JPx8+0YQCOL2AVEQ+28UZbFDBtELFXXca/YkiCf9lbz
	LhQa1pb03dZq7kUb/TV+YF9ISk0k8ADGppA==
X-Received: by 2002:a17:906:f10a:b0:c49:b8ec:a9e3 with SMTP id
 a640c23a62f3a-c513aad202amr871113566b.43.1795453909164; Mon, 23 Nov 2026
 09:11:49 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awGr_tB3QXwnW1G2@kernel.org> <20261123165638.2161305-1-rmustafin@cloudlinux.com>
In-Reply-To: <20261123165638.2161305-1-rmustafin@cloudlinux.com>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Tue, 24 Nov 2026 00:11:37 +0700
X-Gm-Features: Aa3M54qI_gigBtcVlB0bVVMCDfPwHMSLIUBI_RteTpbOu_KmpWlOErFZfJySAUQ
Message-ID: <CAG6=z5tCJNyaPbOBYRCskXTCGkbJ_Zteg9Y-N_FFdU6Ag5FxDA@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: tpm2: test that io_uring reads ignore the
 file offset
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +#!/bin/sh
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

This should be GPL-2.0-only, as you asked on the RFC; I copied the line
from the neighbouring scripts. I can send a v4 with only that change, or
you can fix it up when applying, whichever you prefer.

Br,
Rustam
