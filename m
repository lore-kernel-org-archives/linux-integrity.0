Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795177222;
	b=2VS8RMeXfxp1x7CnQcOaJBixcdRBjEPKRhgXl7/BEHRwUqMH7IAX+Q13QIPva80sk6ru
	 URo93MCSVqh6yoO87r6Jvf9lYy8a8YjN4+vYNTYfNVuVfcgXB6YL+IEXXBtFOXcs/RG8O
	 UPti1N+EMPkIGwypo8rKsII27fGA8dIi55naBsE4p9cNKpjT9lBHH7ErzDZ1emwJdF76x
	 ryrHvyqZgBYxoYZUvg4hc9K3IUJRjA8gw35eQomOKvJLVI8MKVH2kRVImhBS8TwQUUlBU
	 jLJmlx0/lHkg0BFKcMJCULUYWHZQtQEWZmOVPmGZU/j0h5wHvdZJl3INQWFf6GtrRAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
	b=QVo6SyUkiYiDgwWy0RlB1pwpJZljSC5trztZLk155pX98hGfEa/s5U6jUqYQUuuxn/wi
	 Wr7uIu2Txy6d37zuIqcwLJKhjtPbNZhtjUvK1lWjs6oN7+ABkrgQM476ofTHLtkKfT5NZ
	 BQwGQFrzVkRszalnWO6onpTfyULdUIixdOE2Yo4+5NWAo8EmocyM/khH6KJ4AwbtDPgiJ
	 S+kas1r1pbweVIMFbFgn1gm9gBHw2pHknMpM7p8S7aYNBj/go+yzYEvszYosGxpXQ+oH8
	 Y5QoNEh5jWAlJjKbyAs9mAkn8b79xkj9zIK9LciqE4plDmlyUBvUb3nTyvXlC8KyjVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="f/v4uMn4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5E60A2602
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 12:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E5E60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=f/v4uMn4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c513a854320so150926866b.0
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 04:20:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795177221; cv=none;
        d=google.com; s=arc-20260327;
        b=fLiyktStn7w6XoZKUpNe4V6bXdQCBPIQ6ETUFjYo3Pg4vzElbUW/r/Sghbi51XO9D1
         9XCH73+ecX2FrKJWQhY6cZCOQndCVoOIRroYo62bjHm7nxVIfRSra/NiJSPP5VSypyNl
         0q2VcU6pbtddMt7jtBUkiStcljlxxUZjCSC+M+cAKjUh0WRZS/xRHbCBiD1C7hqmMiH3
         BGJk1ByFidZHracQFPasgAw0IXdwwpGxtB1WVgzWgd4Pu3vtBlTU9BpX8o+V/SVQvAD5
         K8gwz7egqJzn6uvtnsgbNbYa3JyvEbVzqCUCs+ya5L7Oc0R0+znn6XQ138vaExpDPIWH
         A0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        fh=XsRjWkp1+a7x0nF4Aw2xH4BpneQGIPlRYeXDdUJImOI=;
        b=pVfplj8BD8c0wULnkXmLKRyoU6XsJ4xv5fYxop99KeoQOZWrIJV8rnGDbcUisfOKpK
         EmroOLS3LI/a1VbN6y4elVLYYW9oD8DCWM9yay+lSy5dg8zLQ4cMfCM06vi2/gq05XWr
         Wf2VpelhugOA7ddAR2eh4HYmjoKG3rg4mEt8C80A6/81h/GnI0Oxn6+HhmNyLcw0F/io
         sD9imtWask3Jgh6JP5NKIJwamxRfqui9Y2MIAq9AliiqidTfYvlAklwAXKT/fSagdTv7
         H1q5Yw5VEFYGDskGeD5/GBB361DcaR7umralGAqOWDmLRqknhYeFAY61mA9B3K/hBWR9
         WOEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795177221; x=1795782021; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        b=f/v4uMn4J3fQGmL3e8hL8H6GpITgmTc+j+FxBSUEKNQWWCcZHMZO2Tt7vAhawDk/7d
         trHE7f0BDEtIUdZzG0iJO3hF5E5gt/NNUkLKDU8QAp8gsYRxWEQ2DYavxXHQbsuyBs3u
         0roHf7zcHoItpEkApyGHqmHVB2Qb3K9j5J9KRFsv/e7xsQwFeNmaP05ELmyRkOzWiO81
         eYleydYZC/heAiZP7H6TM6wz/Y77Eg+n5V3frhEA6xCtCSr4nirpr7hcOxguEDPo3D0N
         aPbLGMINMqBlgpedk0Eg00B24dolXOAKRcSfek/2OLCk2Sj1dKcyQWWu7fifkIeOKbWf
         4p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177221; x=1795782021;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        b=jbsF+jochosp/kK954cFkZEbPG6wXTyobgn7nCl9+IJWNeRzwFFFI9ec/LjbeGdN63
         BIZVE0kL/IFb4A7c4x1RWiAggKXuCaGSkHgvJvCxrqSoIPDrtst0CVZIakLf7yHoRMK+
         13fpkVtz1YKKLqgLVl41Bf40E4j/gr+CQuqvDg+NqBijTb3DZ+msJNURVGhUeVl8+Exw
         +2C6LEVbIby3p9bOqX4eI0wncGaaojPvuWsaCjOYaGRtYJ0Yop7Zz58Fexjh0iXCQ8mI
         QH20uySueA/ho6a3JI7c0ydmJFnHmQAvqTmTlJXieBr1z+CNogkBknzrsUfcIO2GT7fg
         c38g==
X-Forwarded-Encrypted: i=1; AL+hErEkgVT4VIKUmD83yV33LwScV+2O0XyU/OcE0Ns925Xi+X/9h2v2ZRj27Si5YlXsdLGHsQgE/hbDfMfQwy15GfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SFmIJCcI0ykMU7RWafo5KAV34Kadugoajqj5lSEJJ3KrTP7af
	tUl/fHiArE1O+xFgIhxcS5krEEHK8WMyCQpwasZgQ2Zk6OlNOjerB1NMFEk/lvDgZBxBIrwZSVh
	cF8AtSOw1EdnrsJW5HLrrhAQop7AOXZn2nO+Zwxo+Uw==
X-Gm-Gg: AYBFou2qw+TKIJeiltRigT/UIUqsBR9ZWSupVFoGAaz+PG636ZavdTMNvaJ05jTDiOz
	iK017xWOH6EQ4peI9F2mwyyF1puOUR3KBo5zZ7ujFqYpR3Jkw0yFIHBNydCwng7zrfUHsRN1cZ0
	MeNABvpZnOp5HGT55pfZkp1Nb9krFVqTXZxgSPmm9wFZJm7fLf9P0J11m278ZZki8yJTJRfwISv
	nwXF2cWV4x+kSQrCMptWi9A86MUgLwj6UuDgtWz6F0R7gx52VSmEX44YihkEyPC5s76cCos4dBO
	lTZPbIYF2sH0N1FOMiRwnwod8F7KFYpojwnsz0curUGXAnqlSRB/bU0oRhkcZdVZodHzga0wpHu
	nA6v5xw/ESg1N6qQG9u8qIcyfPtKSitAUimqO1yIWEcU4mvkP4WB6NOg=
X-Received: by 2002:a17:906:1ed1:b0:c51:2fb:a039 with SMTP id
 a640c23a62f3a-c513a850365mr243467866b.12.1795177220590; Fri, 20 Nov 2026
 04:20:20 -0800 (PST)
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
 <av23L5HBpy2gbm3m@kernel.org> <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>
 <av88MkHFBHTD8Rqe@kernel.org>
In-Reply-To: <av88MkHFBHTD8Rqe@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 19:20:09 +0700
X-Gm-Features: Aa3M54olXavvLpImCYcikZbsYtV4fjBy_7D-xUAbTEHrCt2I1nTcWgO0yQSHO6c
Message-ID: <CAG6=z5tCq-THqRRgF5vMs0=MNmXMp80g8HiQmbyov0i-9pRFXQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2026 at 1:13 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 1. ->read_iter and ->write_iter that just return -EINVAL.
> >
> >    Simple, but readv() and single-iovec writev() stop working.
>
> So. What would be the use case for this?

I don't know of a real user, tpm2-tss uses read() and write(). It is
about compatibility: readv() works today and can split a response,
e.g. the 10-byte header into one buffer and the body into another.
writev() is less useful, since a command must fit in one iovec.

> 2 is a bug fix, enabling is a feature. I guess this is the confusion.

Adding ->read_iter for 2 also lets vfs_iter_read() callers such as
Coda reach tpm_common_read(). Their requests look the same as readv(),
so the checks in 2 cannot tell them apart. That's why I sent the read
position fix as v2 first:
https://lore.kernel.org/all/20261120121614.978396-1-rmustafin@cloudlinux.com/

With it, tpm_common_read() ignores *off, so io_uring reads and writes
work correctly. I'm not sure about blocking io_uring on top of that:
it works today, and I can't rule out users, especially of /dev/tpmrm0,
which many processes can open at once. I have 2 implemented and
tested, with -EIO, and can send it if it's needed.

Br,
Rustam
