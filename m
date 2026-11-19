Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110592;
	b=o6tv39zbCYOGL9C5jh1WhtB9t+dB0jhpC3LaphrwIP3y+LUaQcbDTDSbdXOV1lU/vDFf
	 k3vb9Al5jdsj6Rk76BnwPN1HZXW7rvkSfU/hWKD1ihMteCrfJb7ZdCzzUUW4+vcqsG11T
	 96qXXwNJI1PYOtkToZDxBGe0yTidfqlqmrKh3DxADcesU81ghQ8VpZDMbrRuftmfCVf9C
	 IDtUZO6dzBdyGT+oJO5LgpR0eRlfCofuVDF9eMn3TODfF5M5ZBrHnMPiFANKxriAo7plT
	 ER20v82nMv7yiYEE4fRTXrQXUczeoCDPUQhmqTwgj3re8sksed/HM/Wbb7JY7hW3yTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
	b=FY9uYJU8yY6GFHJZ/wtBSTxSnoEOKz9lmzJz3QzqQmDsemDQfglgWFDO9t5xpa1QyZ5j
	 p18Ifam22P/UKD7D0n6FTSoW8Ym51sqyKibXe8/lzD/9p6Eha066zPHTJBRLN4gNPBAod
	 nbzOKA0OwLhg7YEEN5HNPY4dmdRbOY/CO+J3/CZS9ejLMFv5mScdzOi7VOhJJJgl9cgFb
	 tt0TB+xToGrCD7S+IOAJ1Tjs9eJh7RczKnxZYii4Lrvd+KFDSTYYO6QFAdb2S3IyR5Lqp
	 uWgvHnpMI+5sJVryeHnLlpp6/DQnhmJotX2i1fyGY3YWdJYgwkl+z+beNPkkxTO+PPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=BDFzAuNp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997CD606A330
	for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 17:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 997CD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=BDFzAuNp
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5118deebcfso7139066b.1
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2026 09:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795110590; cv=none;
        d=google.com; s=arc-20260327;
        b=W9IVDETbSsxUlqNp0Q7ghkgs3AUcOAWE9kptnWEFedGMI6hnkH3LeBcLuhyukzP+PO
         dUq5S2B6DJ51QAU4a3FDRParTTCzEgIaB45XOQFPSEbq+jfxJ7PACz5sSjWkZKwimjOU
         mh59nCzcZXHzAfbGCJtEvhZtU8Ka6JXMnIKL/Zfh80thxPtREght08YBOMJo8EuMK43R
         aGVVPGk331jfGQJRwNj0dGGrN3H61sjH1bvPTKkeqZYcce1TJix0XIatHHL6AKsTi1BH
         GUl2gHDnfjdTjuDI2N9sz/CRbrPYiqSPyatomyzh6ADquq2uDu7GhJXitgVdrAUBdfJm
         PTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        fh=XveYLMctT+Kg86i121AcVq28ED3pjJkADVX6OzX8Rbs=;
        b=nQQ/igOpZHVjbVZRXZP2A9papYDS74BS/REfKtdei1u/w4iTdjBENorMbKt5pTlB8U
         bTJGZ7r25U4ujpeBURa+3z+/rEb71qm0BptrEO+bEtYAow0RNa76R1hxmrKm1vs16oof
         U3TgNeQIcN3gA4/lI/l94KF2L6kxVpUc/eafSaYrT7HWQmF3/zDRTjHolxJyDyjRBvsY
         tnHUd/3LyPYAiJOiepa2mtEwbUfKL02bs2NcMzYH4pPZC/Hwcg+ZZwNnZM9JEYJ/z+Kf
         ugViUgAud9xqReafT8DNUWMR6DgWFDNdYKis60DWGGEy2VINfvGsII9OQ/Xe7/qXFzkm
         NKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795110590; x=1795715390; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        b=BDFzAuNpRvvcKd/LuWfKHb0Up3yVJK+lUdRHw+QAkLWhRGbKgaDhPyUL+XgX1qkSB0
         KO7wVl3Injn8WCdGcF6KS5G6p4PzoZxufMdeSy+FshWVIeuVb0XURSX4XNfGitKoED9+
         2SHwoor2xnYoAyS+HVcqrAu49HdzMTILfgwi8W9Scl5Bm3P9ijv6S2No9HS4l+9xe5p7
         dTG3SJGgGaxbQDUFXAZjmta1OcEL7s9+bRWSoMeFMzRKF/8w5pa/F9Sq29fDmyWUqSqw
         CrB7DFdjOySfyTim15Ah3kei8YaR/HGLNrwLSWFaH8JEqaVA+juXKaEcD+MtgLP3YpOb
         iStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110590; x=1795715390;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        b=au8k9WaLIZ6LdHcZVdouoX4OAv/38nssa8X6dhuzZEa6GchnjtvdKzFVdf/gxNEH0r
         iL+orpw2XsslWcNDavXK4YMe5jbVWrDd8E5Oc2SxfFSWzCz0+e0jyScruk7o8fveQkCl
         Rr4G5dYVFIe9C4EpvZgdTMQBBkM0luakOURaxLbukG3EWOfZGxBmbZpdI8E+jNuTMYT/
         52WcogEzrFUpZ1yvaoaLvAN/gNZQoDbdSfPTP4ug0KeFoc89AVNo//zEffo/LVcymZII
         nLSvcOznRw/uFP2nIlxxXj3cwkHL8cpjnTh7yJeMT6lUQlkCtzdz+TaqrUfA618q7+Wu
         irKg==
X-Forwarded-Encrypted: i=1; AL+hErGyWo1DElmlWSbK5BUWiP/Z8mAsttI/Cl/moib3UJWZ7SHqoCbZdVjreDBfOOY+uPB4lWjOW/YuqJfGrI4WtmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0PPzjCrr/owz1N+5Vv0Fz9Tu96sRjmJI+/cynSP+esRYjQTQo
	REUgBeuw7CbrnLu5EFCEksMApYwYRz2S3/5FHr6aakwtNPNRyiedq9T0ObX0ZAnlbvjS/HGK8b1
	bIfeEKXu4x9kTYLiUuqcYg17FRARuRa6HPjgbAg6ZoQ==
X-Gm-Gg: AYBFou3E/AoMK8zzwLwRnWpCn0R5PuWeaoKpH3vrCQteqOJKVHMQyOXunPC+Rd6zrFl
	SAmCqHbV2ovrPDbm6JT2z6lCAyVjXgTzt/X2UO4B3Ydy6AqYhpG1Lje7jPxKHhI+X6cnbQU1vAo
	FDdG+D823nCzPu9Br5Z/hj5YB0d1su48FBqXxMOpZmLCEKliQ8OZUNwPX3Babn/rAsFzZ8fY4Z1
	dN3FWazd/KlDpTtciNlWyQAxfKRncRayJmPhv9LoaqSS3muzASgECgy6lwSYc4/DN34Akc3uxeK
	LbjpH+js9ZJlhPSMjfgI42OcKNUoYYyhgVdjOGIfWy43YXEDY339LC0YjBJfRu5c9Fp/00W2m+P
	8aj17yyoQo7c59nv5ExgXIfbL7WVV2egZFw==
X-Received: by 2002:a17:906:3b94:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c513ab209f4mr54087866b.35.1795110589931; Thu, 19 Nov 2026
 09:49:49 -0800 (PST)
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
 <avwzid1Ovl4ACkaQ@kernel.org> <avxJ9MxZ0PoWbQTc@kernel.org>
 <avxKqn-PlzJyxVdK@kernel.org> <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>
 <av23L5HBpy2gbm3m@kernel.org>
In-Reply-To: <av23L5HBpy2gbm3m@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 00:49:37 +0700
X-Gm-Features: AclHuK9Q0IcDkucYCJnM_63DevcnoFoQpfJyHRtWSFgpZWzV5JY0H-0a_Kp8-CU
Message-ID: <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 9:33 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> I wrote that out of my memory. I did not expect to be exactly out.
>
> Block uring.

Hi Jarkko,

I looked at three ways to do it:

1. ->read_iter and ->write_iter that just return -EINVAL.

   Simple, but readv() and single-iovec writev() stop working.

2. ->read_iter and ->write_iter that keep readv()/writev() working
   and fail with:

       if (!is_sync_kiocb(iocb) ||
           (iocb->ki_flags & IOCB_NOWAIT) ||
           (current->flags & PF_IO_WORKER))
               return -EINVAL;

   The first check catches normal io_uring reads/writes and AIO. The
   other two are for IORING_OP_READ_MULTISHOT, which uses a sync kiocb.

3. A new per-request flag set by io_uring and checked by TPM.

   Needs io_uring/VFS changes and is harder to backport.

With 2 and 3, vfs_iter_read() callers such as Coda (which forwards
reads to a file passed in by its userspace daemon) can reach
tpm_common_read() with their own offset. Today these calls fail,
because the TPM files have no ->read_iter.

I have 2 implemented and tested. It would also need a check of *off
in tpm_common_read(), because of the above.

Which one do you prefer?

Br,
Rustam
