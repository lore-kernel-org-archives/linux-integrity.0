Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767297;
	b=SyYhUbNMixMwszEvo5pTGDIR8aPbOj0NzfJbQpb0RNhsdE7M2Y3/u3LC0jh/rSBHBj0H
	 KQv/s265jZ32ZmMWUWVx5ndmi/UlWUkSeBsdo3vyKZ6UkMuxNxt62F5W5sBjfFULI9C2m
	 WgT1l5EqzKwcU2FKO9iDyApoFMN8vpupUSj+b7IXAOpNuEfK6m1eGZSwrYlDneUYvs7l+
	 z8amBpyTX4QzeQrsCMbYP1z9nzcWLkleAwVqLhRFA+c8F/6PJT11blmCWX+ieyZhTDL3l
	 bTo4UcgxN9XssCBNN+NMHgGOdmcdKTDmw9uUUFsg5gUByqUee6MQPmXXDrGjJT9T8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=I+P1U2fZQk8LkgGMD9Ju/ieUKgcY3iLQF3rMOHD/qzio212z4miYnd5lfqMXtAeZ3aKg
	 jE8BP/u6J7KPp05x3ptrTafHTt5PP3E2HxdiqxMXeEdpvF1K+Dj9K4S60Fu7mIgO22F1U
	 s92kTl2/S2yhCalmEU/odyaFRzgWRqtqEf7P8xSuEfJ6Ldm9EVOY0g8pSLaaMUYee3KzR
	 T/GY7M7N2l/PVBPdmwRCCfgyrJigvU4hVBWrW1puYL0aiG2u/46q7hcIcl6FC/UakNcJQ
	 z1xnj/TRDMY8u6tYXqD4D2BsDAhLshWeBS4VF+eriQWpu0DNDI+Ah9+1gzggAnav0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F606A32E
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD8F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1253071b3a.3
        for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=VrWxNaAj17Lh6QahAyhD7rONhTRKAAac2ZwvMsM2EmfKP7WSyUpVRDthLwqqhZ+gTp
         kFhSB/ygQsADDNfSLjVlKwRRjH98e8L3KQBbSwtjlNBKqr/5iiB/OMi1V+tBT2IGr5g2
         xq+ZBZfcZdExAjFradq9DqJuh9J700M4Prkbr2urXKoZWbcjtTPCBeQCUbWzknTIuYKF
         vEHbhhyLrw+LXUlNh0Unx/Mz8Gssb15RYv4oe1CpFs9X1Tgqp389FYyLPHdXkLDudX4q
         bAlPSxK13M2xc+hjgqVNOFC76BO+HkOsMwMbr/yAw8HwrG6EWYmPH0qJIbIzMm5JSx4W
         D4BA==
X-Forwarded-Encrypted: i=1; AL+hErEaVDuGf8ey6++riSkv7foOIDlwQ9Oo/gdgL8rkAP77YN0iDFs6Qdp1kvHcEVq0blvlN2xxzduUhjLBM8cEGRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DObJxJiLiZfJQS/J3qPsKb0hjEC2g7TgH7FBtZmk20dv6Skz2
	1BhMkQtfwwAAid2CP3nzbgHMzO0xplFgfnw9LuH7pHTyPVf4+JkxWzfR
X-Gm-Gg: AYBFou0NW98OlqtiprKdjZyX8FfzavT35NKiEMsmqa+VcEaDO5zQaXI+H6m4tsXYfEs
	kwe6Pf3nVqGd9XFmykwi8Xcf6KMvAF4eCTu3z23ZmAem8UGoJNwSujJuKeSSktCy1E+k05+jhPk
	BzbFbI73ngfYYSt42BLHdldDgRDlE1ikXL87dUgpufEKz6Q4j8RVQ8u528FGmeLONBlOADVaIkm
	qBNxGOVv/MhHJy6o7pR8l2jee0gkbocyMn40u8drngmW3oC7n1T6Leji4254vL8wy2j7PWM4ZRc
	ZxsW8zXZMhWvGd3DyFpWZgfPXx9JF5eAhy8Yyc90T7Q4ZpGODn2zZA+T39wyf80EFPPHiu/RvRQ
	1gT7cYPCUdR5pDnAiFnjoY0MK+xtxa0jooRzeB9gyj3/X3v3zvBtyIDU1MkQzveWcCxdQEJzXds
	Xts0Otvopjek74ByRPMyoSs38cCwQ+UgCeTbnruDVveYpKtmW52ep3FSTTlCyT4tnCnNeorbe/G
	deucmQ+aCYIT3157JPltLXZ9kzBf57sZTaKVklX04ycm01VmpbK38igId9aAxJe1671TO9XL1t8
	pSfPerW1b2U7ZZFso+yi0d8k2nTw+gQoZLR3bK5B3tyO9VEO9pzKdFMOTFX1W2kchy7eBxHQZu2
	SIZFyownuEDDXLi87RxlLU7BUrxNba1sDAQ==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
