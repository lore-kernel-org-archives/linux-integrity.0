Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E9343D9D
	for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783886098; cv=none; b=t5CbhwirWwYu9YYo+z2KcKeaixLhUmhRdmW674PydpU/Md9TleDEnvNylF2+sYUijvxADIealxCEz3/iJB1Bf3HCwnZmLxI5w3mRuqdaORH9ZtPo+SBJBiokPbOkFqQoLWbhwsVTcj3FNyy0sb5Krt/HfEwvciPMEIUVZ6cgZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783886098; c=relaxed/simple;
	bh=1kvan+vx5y4l8LFStCU5oqy8mYYDYnYZjGgPGVifyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl1bes4+ZDMy5pe4mcpS+gPrvj2hFu9ylAe4TaytRMhhEdIddLwrXuO1LfKYJjuiIyxgZ7zBBiLYeWGegM4iVvMI10w1Wx72rpIAb4Ria6ZpGO2uGZcfFxBkZ9Mok3Jh33BoHShd6GHZI6dJTV3Jskz9pMO+vxJUE65JyXh8Xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQkn6FNz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQkn6FNz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so4518465a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783886095; x=1784490895; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0VV9UQ3tklAc3FhQMVhQNd2mzbWD93fBONoSN0BdPw=;
        b=SQkn6FNz0PzG6V6Ax010QIPn8GsI77CQ/MNqa7eMqKUmTWKTQXkaxQV2dQKcwlrlnY
         0kNYAHDRi9q0nd7vBjlOMjJqkX7QU4fQ0s+MvTDnNb2MRWIA+O7p6Gom7fLjeR85LnOa
         HYamlMSvtpim9OcxWB+UhUVZIQWxom8MUmDDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783886095; x=1784490895;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F0VV9UQ3tklAc3FhQMVhQNd2mzbWD93fBONoSN0BdPw=;
        b=cvwvChI8ywz1emEQ0UmQQjhxgsKxbDleX0caopcLooreoORKwABswkeY/dinq0BXlE
         s4FOJ1ypIWWkq6MYi04YedG31aQFQfgU9JzL1x/2L+pipumjsp73ZZprfvhZgZ6O4y8K
         i4l+hfbHPxUAgdtPb/WNUxSKnXKa0jAgoyJUWcfNMzl1G82yDHLl/GJr3hhZHKyu8wUy
         LFE1k4FIywBf9O4wn/ovN0BaYeKLlsz7hXjqnRusFFPjJ6mJ+adoEP7LQmiS5KGO1k6z
         DeYQEVfHBwXii1sLQ/i86LBYyCx0g56/mwcl91m6K4X9Rwc4+kRb7FairMI2QS4Tm1cV
         yxCg==
X-Forwarded-Encrypted: i=1; AHgh+RrgYt78iJJIMtUqJZVgEw1XctwD1Vle2Or7KuN/bHeQCF0pbknLWaKPHA2yoFGAoyjf0Z9L6LvOl8s4qdp2t2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34yjkTkzRf93+gAg0ZU4I7814o/VOzoRIhxJQdlB1/uAjgybE
	/CElgzzu36y7FBIjkjYaCm2uy+/GoJSiR+u53Yg4V9aPCqtvxa1KwxOp1KmfHFU2TyGHhuZMdMC
	ajss5XWI=
X-Gm-Gg: AfdE7cn5j348twPqi2Hd5r0w19o42qS0t4+oqf+yDD4nzfycYMQOxafJLy7ilQi9dBX
	pWGaIa3+nx2b3oUuzETnWTpuBsmeAsYYpN8O7p/M5ALRgWvlAATwS2AgrdDCSWVyGuJ67pnCMpJ
	MEA8C99YsBH+Zwhkb6YKF9riNrBAbL4I2SfkXWPYvIQOT0Cz8SJAIxb6+9cWCSCN/mhnZ41j4Hi
	R6rAJIUrk7h+rdRWj0G9mUrLHZJ8h2FqT2Osi9eewEOjdOawYVsyGhrc1D59n+hgio9szPDSxAX
	4TFm3rc6fOuDD40SvutitPfYCx7SC4Xlr3ySVzM9DEoX5phdLBgFHSQoa2klewHo//4ceuOP8PZ
	hkILizUqbMCen2zcoegqi/OskE2+5GjBIE0jspAjHPmZntq/SpBzUZtijeju4WwEMefdiB2Opf+
	1uMB3Qylv6L5x1VDy0Djm4dtXurjdQ5PAFp9Jl0XU4CYWAoLs2WprAYE62NuVULWkQkW0fbGc=
X-Received: by 2002:a05:6402:538c:b0:699:f3b8:1673 with SMTP id 4fb4d7f45d1cf-69c5f0d4cfamr2727384a12.18.1783886094793;
        Sun, 12 Jul 2026 12:54:54 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa613d4e2sm8241868a12.24.2026.07.12.12.54.54
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 12:54:54 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so2711689a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 12:54:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqKWcYIqWy2POTR33ltkhGG8oPuPW7jjOlOsWDq2NpCqAygOIJtk4ZWAKLNlEKDcNVWmMTLGa4OQ+iF1E+uwLE=@vger.kernel.org
X-Received: by 2002:a17:907:70c:b0:c15:f69f:a175 with SMTP id
 a640c23a62f3a-c161f3aa55emr277371466b.62.1783886094122; Sun, 12 Jul 2026
 12:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
 <20260712171147.323213-1-yong010301@gmail.com>
In-Reply-To: <20260712171147.323213-1-yong010301@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 12 Jul 2026 12:54:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnwJc_QRQ6x_xLrtuUj8ia=6z6-RqeoQe=QCycwKb=LA@mail.gmail.com>
X-Gm-Features: AUfX_mxIqp9BwQni7oj2xhhxFUZUBEIrvb6hAsoVFk8o0ynLMjoMzW6T3IceRHQ
Message-ID: <CAHk-=wgnwJc_QRQ6x_xLrtuUj8ia=6z6-RqeoQe=QCycwKb=LA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Make the TPM character devices non-seekable
To: Jaewon Yang <yong010301@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	security@kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Jul 2026 at 10:12, Jaewon Yang <yong010301@gmail.com> wrote:
>
> Call nonseekable_open() from both open handlers.

Ack, this seems to be the simplest approach. I'll just commit it as-is,

                 Linus
