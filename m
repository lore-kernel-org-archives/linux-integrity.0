Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995760;
	b=Jl2b94HANjYrbQNuJSVFDVtZ6T9L/06FOAbOUGx0rrGUKnzZm9LrdbbMCFOWKHc/rFOx
	 uLMOfnTl/0z/plgiUx3xu0wWHpuLKuXP11epmNGksc27x36zlLhL/NcUwYJfkxeZeZ1LA
	 IDtGVdWoav3qrzBW/0d2mQw9Krtut+1IB/OzjD8SloTxMLxJGP+z9npcdbmgT0leyoGl2
	 a0A0AsxBoFlhjWpHLLnAO7GKiYdhUyP0S5y7Q86ZMFW4xI1jNcS5WwA8njqPADSHExnh7
	 xOGcxg6isFn6essApymJzqgGQ3uiSYxCZkEAOhxpRzgvG+FBqExx1uFvT9tQfKKe5VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
	b=SRCXBjmj19RH89HUgEd2OvYSP2IzKfSZjxyDJgqr8ym8Rm1GNJpLNZU0oEAKePW0O0CD
	 oxjiZrBX0G8fu1iThv6wegZedl5V1shW40j+IRhABMSWkm1OY3EMEV/jRF7SBauQbvVN+
	 QHK9u9vh2S6s3aMCD+uYhxFL+2Ul6wJ+LEpSxGQ1wDouQS6a9kltb8PYVkbu/V2Zzk5ON
	 lU9D1+Gx1JFmDfQFXSGdvCvmzfWx571nWtEhgNIbz515C+HTy+FdxYN3hp4ZSudkEAt3b
	 TOiX6KsBI+TyD3M43mW6c0pNB7o7BxploxdXdGjFbco0VUo/F2/mFdP9DMm3uTxdsPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=bFysKzKl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C606A320
	for <linux-integrity@vger.kernel.org>; Wed, 18 Nov 2026 09:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=bFysKzKl
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c511c0e2826so20583766b.0
        for <linux-integrity@vger.kernel.org>; Wed, 18 Nov 2026 01:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794995753; cv=none;
        d=google.com; s=arc-20260327;
        b=esc9tQPnipZELlYcd8h7wmJeW9Lr6ykZTqXpzawYSSp0sIqWzTozRhiQ83Vp/bkJW/
         9jc2TWcSRh3u2A8Urc1geWbvx/UoLZlTouOo5H5hJG9/Ku7TEUk4iZaDN9lCHqT2WGWu
         dexVoeUd4r+wh04nuJ0tWBcKm8i53e2pKoiAGI57KoxJZyTdAjvaYxFsUhB9VNjPMcmq
         Byng3GwRkqOWyVx//h+L9My7QdkdsJdq/m7j6bR+eSc41u3rdh9DEitI852zMbaSzhnY
         nZV8TJd7S3z+sE9jDeILk1l5Lqp6d3BD6kI+zVEJcwm2Rirux1KnWX17RBEQewDY7Ya5
         sIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        fh=QYv6+5TLcr5EkQeDfEs6WEoT/eeX4lCcfQWe+8lBiko=;
        b=ShiQ576cUP3sRyWlRCyJ7Twt21Ho0n+Ou3VqMCoTv/HCtvDuzPcvYmfJaWDtc2YssC
         XF3rCtlu5MI4FdHqedleovbvfoCorvyqcH+BFpZpyuEIyUv8Mr2WUY7fxbTPs64niDnG
         i69ix61dnGN+lOfaCQDVv5XeNATSgHxqdGyE16Zmood8sb0kSVtqdxTBGTB461cHZ1MD
         JXzcavmYtEoiPD2fwbawr7qKnEdfyzwbyjvdAo2Dzr607WxErUgwXnjeMJIo6BuBvaB7
         A4EwfI7nB7u+rBwiBx4NuKwhi9TY3NjB7VmHbdkq7UkJpD2ZErUgK9brccfeLE2sVq38
         INfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794995753; x=1795600553; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        b=bFysKzKl3BMCNocpAfYC7/aJh1MOAWQ7YzzDrZYZ334ZSPk6IEeETAjh8QuZ+4lQfK
         /iYRw8ji1Fxtl+cU4Yj1D3rPtz59p1vxdURIiPCbLfUsx8xUR/QDNc/v3TT0UKnpBi5g
         +aj0EqyD7G8XCLGfE/3v9Xg6h/3huxJc8IsD7w+yW3uhhKhMni2MFJy1l8yy0WHcXvCO
         ypUitwLhyW1wq1zd0EN1lC3xRiiGt+nZYTWh9e6G1TXiMMnUWDIpqMN+4is9A0OO/XAQ
         Da74g0FrWvFw9BgnCS/xMD6YEFyad6sA658faJZ26qpB3OWeVSUMWdSzhrhMvPrdA291
         Vx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995753; x=1795600553;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        b=pZv4YcBx+1vfRqZO4oYKeJP8n+U1YX9mXn6ZzGpQqSJE+4WngkDxbFV2epWqn96jD2
         UGONtduxD1OBR7ag/gkZwVQieqwdrQNm4abpdMtcEqEr51DjN/rlb95cyA85KSNc5edZ
         YLducmpVd3ZPCYkG4nic+H3tLPdeDkWTK9cwdulHzN/DgdzlxTuJdcFXovH5JctYLu/R
         gfg16YTycAueiA6nrLCTVTy4xox92e4WJ9P01xGBJGx34hPT7Hk2rlhmdWq/B1POH4kR
         Z/atB62WpMohCuw18jM6vvRBfo+lsPhLXSFeD9g1aINP6YZHfRRQFRuliB+lYNr+khYE
         gn7Q==
X-Forwarded-Encrypted: i=1; AL+hErGVca8rCvjOdVJANM2vPyN0YZAJY3z6tkB+4LykRiKopkJykWH1mQiyN2xZdw94yT+lmHH283qwmcGKBhL7wAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aW29Yhw/DvO4Bu2ZG8TeRMfacXVAW6+YWEXPqzeh/GmGcL6BX
	HFL+9ieT+AxM++mT5zgIKMRGpx5P9zlaMWJ6L3+mqqF9rHaTevzc61oJ/c9dn+Ro/8lQf7+sgrK
	n8t6UNqiutUMzjqzeCmij2RhsPD79YGZXbnJMJNB1dw==
X-Gm-Gg: AYBFou1Fo5s+8ZWG8D4+t8ZZmZfQZDy75JCDH5+jt1yThMpg9NOWEb9VByfy9q4XupG
	JbxuWsoSrF3XFwqjVqBAYscF54cymbjdZmtC04mT+VudX+ycL7lF2AjkY7aRIsD9gTex7VSY4YJ
	4ldIj+MazFgDPQmX6GWrniGGbxQ5gKISeLjK47T3LJ7d4A/UWWihP+OOwfyr5+0/uYU+80K7OVk
	frh8o+Tm13SEm1eqN/WsrX1hM0nFwYIQUTwS6zo1bxwK3dfcw9o1JttndTTUQg/HXGZZm7/auqV
	NWREbDbObzeoq1pY/06O7iRtQJHfd/NVzNeh34bCsfPX4DLgfZsu6xLcomol2XIomf2TfAA+6tk
	0kTu54z8s6KkjK44EgNyQiYlLNAxS6ohxZPvyldfiTOOt/IdYJaTG/84=
X-Received: by 2002:a17:907:960a:b0:c40:4965:72cb with SMTP id
 a640c23a62f3a-c510e148c2amr181497666b.21.1794995753370; Wed, 18 Nov 2026
 01:55:53 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <alvD5nOP15O5B8Ai@kernel.org> <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org> <avxJ9MxZ0PoWbQTc@kernel.org> <avxKqn-PlzJyxVdK@kernel.org>
In-Reply-To: <avxKqn-PlzJyxVdK@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Wed, 18 Nov 2026 16:55:42 +0700
X-Gm-Features: AclHuK_OB-KbT-AGKLoVYFZj4MHc_UtbK05YckQfXNXzeGf1DWEJlXVBx-HXIJw
Message-ID: <CAG6=z5uvRmJ38iCOeAOKjjVfpfSXJK8Ta-MmCMNmCWqkqiw6Bw@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 7:38 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, Nov 17, 2026 at 02:35:04PM +0200, Jarkko Sakkinen wrote:
> > I think this would be more feasible:
> >
> >         if (current->flags & PF_IO_WORKER)
> >                 return -EIO;
> >
> >         if ((current->flags & PF_KTHREAD) && current->io_uring)
> >                 return -EIO;
> >
> > I.e., block io_uring entirely.

Hi Jarkko, thanks for the review.

These checks do not fully block io_uring. With O_NONBLOCK set and a
response ready, io_uring calls ->read() inline from the caller's own
task, where neither PF_IO_WORKER nor PF_KTHREAD is set.
loop_rw_iter() declines the inline attempt only when the file lacks
O_NONBLOCK:

    if ((kiocb->ki_flags & IOCB_NOWAIT) &&
        !(kiocb->ki_filp->f_flags & O_NONBLOCK))
        return -EAGAIN;

I built a kernel with both checks applied and the injected offset
still reaches tpm_common_read():

    BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
    Read of size 16 at addr ffff88810c3455d2 by task python3/134
    Call Trace:
    _copy_to_user+0x4b/0x70
    tpm_common_read+0x1e6/0x360
    loop_rw_iter+0x235/0x5a0
    __io_read+0xc6e/0x11a0
    io_read+0x8a/0x180

Reproducer:
- open("/dev/tpm0", O_RDWR | O_NONBLOCK)
- write() a command, then poll() until POLLIN
- submit IORING_OP_READ with sqe->off = 0x1400, without IOSQE_ASYNC
(this is how tpm2-tss opens the device O_RDWR | O_NONBLOCK).

Checking current->io_uring alone would catch the inline path, but
then a process that uses io_uring for anything else would also lose
plain read()/write() on the device.

For v2 I propose:

1. The read position fix, with your review comments applied.
2. stream_open() instead of nonseekable_open(), on top of 1. With
   FMODE_STREAM both the VFS and io_uring pass a NULL offset to the
   driver. This follows c5bf68fe0c86 ("*: convert stream-like files
   from nonseekable_open -> stream_open").
3. A kselftest: lseek() and pread() fail with -ESPIPE, chunked reads
   of a TPM2_GetCapability(TPM_PT_FAMILY_INDICATOR) response match a
   one-shot read, and an io_uring read with an explicit sqe->off
   returns the start of the response.

Br,
Rustam
