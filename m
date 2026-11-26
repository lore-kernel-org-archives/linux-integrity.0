Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702119;
	b=wVNTtWTB9ToHIidwoEwRIp1VATlQz+Dak6uO4wqfv7Ilfdlo09+dxySFUWStO1lJ6cXK
	 D3w8YMtkyLRnI9WOU7MeEAhb2B/1wv0gztIRhmbGpUblWRGr+qVgM5R+nRSpDR4ZRGFJa
	 Omfr/qzhqK4nFD+O3Gbi4ErdsjgQYTDqcMgEnu7O6to326B7AlpR/gz8QoA5m/KAUkMqY
	 XV/dedK8ZAH7FVlFIAJPioXAPFIjUK1dHFaIJ2b84xlD2dHebFNkK85PARMbRpvWOffp5
	 tOxM7HNyxt7UMn3krZozZfsS2rEwMthD68YmLOvBvxWMZmQT9vau9Ju6x5yGUsJG0lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fWXq+2jy46Gh3ZV0MvhLA/7rLTtY2IZQAf+aCrKyZOo=;
	b=amTtd8PXusmvrWnhWni6Cv4HmYZ7Bo1xmm8yiQ3E0aEcdr6g2kxFswW66vLpV3ThK2Ah
	 aMV+fkxqa4E+PtJSO/S0DlvvLbwgZ6XmXnHsmjtOata2q6sCkwSn4ThYRIZH1XTyff8n+
	 oCFz+rx6NkApVLUOHK+aPMPB0SKSfkW+SF7w0HsLNAKtL7rp+vL+7UT0kGZEENCnLwhMs
	 Jw32DSLy6o0WhknZoXzdfBjW/8HC5mPTa1K7blghpiQSSNFcN2KHHxlsr841Tbk79k4x6
	 d6QXMndDntwtx+5imChlZjrPjHwioZqcHujot7sXfTA2JAchy7Pm+W/2po2rhUQ3w1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=HR8ahns3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F63606A31C
	for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 14:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=HR8ahns3
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d581da0aaso976243066b.2
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 06:08:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795702117; cv=none;
        d=google.com; s=arc-20260327;
        b=WItjAgSPHTgBQ/Dsqxg5DgnswFMh83YeeLpw01xKWJuU3wF610nrqCQwrIFiMJVPhb
         R//qecJhA5jwBwUYaXdjzGrfZlfAkvnEIWg3/G0apmeyXIj0CClWjyT9o4m6enAB9hD7
         VAF6iDHspdA4FuPThu6COtEC+8xCp8tQEbU53Vf0aV3+/l7u1ZApNNyBmWYxctrQUclj
         b7OWmlpct+tUapfS2cloarXZiSDfN6KCtwxHwCdZy8VIpNhc2w2N3yWENiCaFfkti2LI
         YFTQRD2WIyrM+64nub6qXxP8TUl7T+wHGcLgnh5btwrvNE46Y80kd3Y9/UhVQzeJg0V5
         Yz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fWXq+2jy46Gh3ZV0MvhLA/7rLTtY2IZQAf+aCrKyZOo=;
        fh=ASQq5FYg3w1n4WAxvAmJqhzRAVqkTcQoPOlhMvI4CPE=;
        b=D2XD7AoRjEQ3s9RkGhRxXBcNqUZDeX+C1pZpwMf+echvgkVgTcVZ1mPgt56Eknqbpv
         KHDCbabufQ64FXOU2Rv9ida6E4Et9x3LxCD08cEROIxMykKz4uOMwpOwlc5I6VmdOgzk
         w/ivY8FiJScEcQF51ohUp98wBmES15SKcVv2qfFluZhfBG/wX7ftYxH9BuSPol8tNkm/
         ItcDoYsijG9V4vnX/6Sx7OTCPAjSnZ16eXQ6AvBvb1cm1RVrsT1iqqMZVwJ/vYTPJ33t
         rEvNrfKeXW/dT0MdpEK5RMZ075FH4o0e5+Eyx5tcolyyGdZNiJCw7Ilin0hetjaQq36B
         AgTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795702117; x=1796306917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWXq+2jy46Gh3ZV0MvhLA/7rLTtY2IZQAf+aCrKyZOo=;
        b=HR8ahns3qwuAhoW0hw9HTmgsr0BAAW0rNNJQsSEr+jLXiCNzUBG4/kyaapy4P2cbxJ
         VrDfk1DVPaJuxlzqMTLYlB26btFGHFZR4GRcVPQu++pKTCZyG0lTG6ICUyz6G9POsRDR
         toQJ1aszLe6o70KQaksYZ9qnsxKbUOu15LVA6bkfsSY4U28i8HPS+aAcYnmPk4uDl8Gj
         8oDhGuV7HAY9mhG+TXno2m54MtIjOnGZtrjFdA1+VAN/i6rr8ANK72Tuo9UcYg7F6jd3
         NBIAlWRey6LPB9Pfk82xyJawMysA2JSGMO4bAgSd91FS/2clRduTDEY9Q68+g8paeIJ8
         2c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702117; x=1796306917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fWXq+2jy46Gh3ZV0MvhLA/7rLTtY2IZQAf+aCrKyZOo=;
        b=CSoq+py3WrDfb7y/KeD9x43mWqXUkYfo6fWzJ0yjB3Pkqdb5PNSJgmSDcvpQQYH+QL
         sBpJgakNmykF8sFwsje9htmJG4OuBS5cKV9sUzgC1x3md67nqAOobXuZejl3BtqHw6yn
         VxfVvh3OE8ElBoKm8vHCwr8Ow446W3usZ3irVptVEek/ZH4OcQqDU/qnMIpNuRB2j8MH
         r2mBR0ulz9hfhJwqwFv0nOgbyMVrnF/WvTRChWTrt31Vd+joXd4vL/JOi+zt1Sfnj24O
         KbKaf0QoUMNX+j8Qpv0FwcoLHM3ASkXT7Pk8lYe+xgG7y2Qq2AydpgWEjE4MoAQt/Xrs
         U2Vg==
X-Forwarded-Encrypted: i=1; AL+hErH2ZgyGTxyIU4rleyZYYyfUUHei4bhVpxb87KuzMVtScZZFoqWkIC7OcABaDtz4BXo7VyrioBw9T53BMSVmX9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AczEFdLrw/aPJUFxf7JqkuVeKj2TnBUJGHtwcpsxIbdgWFPmf
	gWpk/3pjGkP7KKsKamJbRMQ0hoyPPUcl590/Ke4jxT21p9S0JDcgpnzw5OfiLxpgHrrdMRwGeCJ
	yyvGjdALEn5gG4N14rMeM622mLLXnHKKldSufdVzPOg==
X-Gm-Gg: AZFdTZeIdp5PswkOaFrnrGWMTt0O/N198nXI/TqU+C927G4ry+y33yQGFn7QlDM6ojQ
	Z8PwuOMDLySmGKi8XlvkQrKu5pMGhHTW1u7lBKaJEsFrsuhop75wxGFZEywQGXaIAWjnztRna1Z
	5gYCwwgcyf4TC9eKjj39SbRZhYV6QVHEYJsbpI2EQ7KcNOsab2PfkhGlYaryhPe9VgrQoywzgI6
	pQGv81E6YqZWUF15HDWgYqmOnHmSL0xZqPFBO7SMvbtvFJnpB71UY/5SYfSd48ATD95PTvCHLhD
	+0Jj/Ikyp9/NcqJC4GH/7W3sbiHgiEbuykxd9Dim+ZnZD0VIjpQH4Sw793eN7qmz0bDBbTuT71j
	fKaG+0ymylvbT/dHuCJgfFDJLj/TFKKcayQ==
X-Received: by 2002:a17:907:1b1a:b0:c42:102f:15e8 with SMTP id
 a640c23a62f3a-c513a999e27mr1682615766b.14.1795702117183; Thu, 26 Nov 2026
 06:08:37 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awXHzblUfp05jZSQ@kernel.org> <20261125065429.1483868-1-rmustafin@cloudlinux.com>
 <awcT0WnnJ-fyovnn@kernel.org> <awcW90qZvOim7dbh@kernel.org> <awcYZNG9f2YSIz49@kernel.org>
In-Reply-To: <awcYZNG9f2YSIz49@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Thu, 26 Nov 2026 21:08:27 +0700
X-Gm-Features: Aa3M54pYCLcfNb7xtzLqr27MYGtUyFN9A6DJLgyYcVB1PLXNJ0HDOIerUcb9Tb8
Message-ID: <CAG6=z5sThdfZLY3mQ+NdzpFYj7bSN-CsV1bEdKCASw7b_b2g-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>, 
	Jaewon Yang <yong010301@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 12:18 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I got them applied with git am. It's better to use separate threads per
> patch set version.
>
> They are in  my master branch now.

Great, thank you! Will do separate threads. Thanks for your guidance
along the way.

Br,
Rustam
