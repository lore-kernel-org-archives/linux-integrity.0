Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7253AF667
	for <linux-integrity@vger.kernel.org>; Mon, 11 May 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487037; cv=none; b=EeWCf3ycOedJaSqYf+l1z8dY7v0NprpHAgMw50bC4iwF+sK1fUzNQdiUla29UPYl486L5X0/v3RrFPPSgfQiGn5aOOdflhAI1EJuMgTcEHqyrjlS0diybGFnWdGgYobefHuSo2WYnsE5AfF7t5bPh7+I+cfZhSdepOs4yTRLGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487037; c=relaxed/simple;
	bh=b2Hf8nyIP6xq6oi9O82jXi7fy4vY12OyVdOny1brLIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpFgBd1MPcN62ZSJEZB8mbvQXVU5SvF1BJE6kYcV/8hKx/EkAhrgo4ci+vfdvC1fIZ2VcZJfJhSj9LMIoI6a27wMwbpjsEWsy3lCEZE8ULCav6UbXBGZRB/ypFE3UOf1cQMekc2v+6I70ygZSnJN9d+lIMQGWoP3jdTQLJk/Z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOYRckNB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOYRckNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D68C2BCF5
	for <linux-integrity@vger.kernel.org>; Mon, 11 May 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778487035;
	bh=b2Hf8nyIP6xq6oi9O82jXi7fy4vY12OyVdOny1brLIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOYRckNBww0hsW0JWq+QzMZRlXfqdF8qBcDJXiuAjzc6v2Tl4c0fygPcGbhRtvTTW
	 IFCBeLbvDTEQNUqo5EPJk6qcR0mTkhA4mmy7LWcwTm2d3ve4hL1bQ/0K0qVkGVKWcH
	 MD5plE50yF1zvGR+B0cO/yO6a0cLAThh5JsRQwYQjUNozD388yxWrxS2C5R9jXtmKL
	 LHH/95Vhy6zdKJMpx0Z4UVUEy6JMFCXDj01cNq9VUdmPxju26mqN3INRyiVoJkUaAO
	 o79OQPLOD+Gx802la0eF4RCPnbft3D/j+HMJgc3VdZmyclBKC+hTX86CWI+fw/0//+
	 aY8fEkmK16pLg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso3938013e87.1
        for <linux-integrity@vger.kernel.org>; Mon, 11 May 2026 01:10:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxdDdIdW4P5/nGkmyATBRC2WGieli0vIctYUVzg8HcvdKiikwtB
	UrU1JS62yiA4zdAvY7L+v95brerD+yTw0OQXnVA7qG2+ikY972M268c/Sn1r2FS9jKrsg8eQA/h
	ZR+q/oBpdSzhxoBsBQw6yXeWhyQgmm1M=
X-Received: by 2002:a05:6512:3989:b0:5a8:891f:388 with SMTP id
 2adb3069b0e04-5a8b709d36fmr2065976e87.29.1778487033305; Mon, 11 May 2026
 01:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509185108.2681198-1-jarkko@kernel.org>
In-Reply-To: <20260509185108.2681198-1-jarkko@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 10:10:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
X-Gm-Features: AVHnY4KCktiDIjkKY1XWWWRgXjTjZN7hq0huZFtBQUeQG6bYGoySbiCtgkgk8wA
Message-ID: <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:51=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:

> wait_event_interruptible_timeout() evaluates its condition after setting
> the current task state to TASK_INTERRUPTIBLE.
>
> With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
> path is used:
>
>     tpm_tis_status()
>       tpm_tis_spi_read_bytes()
>         tpm_tis_spi_transfer_full()
>           spi_bus_lock()
>             mutex_lock()
>
> Address this with the following measures:
>
> 1. Call wait_tpm_stat_cond() only while tasking is running.
> 2. Use wait_woken() to wait for changes.
>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Linus Walleij <linusw@kernel.org>
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9=
b990217a8b9@gmx.net/
> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Linus' change only unmasked a pre-existing bug but it is the change
> realizes it in tpm_tis_spi.

Took me a while to understand this but looks right to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
