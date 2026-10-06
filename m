Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F32DB7BF
	for <linux-integrity@vger.kernel.org>; Tue,  6 Oct 2026 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255844; cv=none; b=oFG6CvySgwcDzzHptD+z2O+fTw4d2X7dtRemGqm/YkY8KmwBLUhyXAHn4i/cezsLGOnFy5XmYhsQPJiQ/hgdJ4LROnWgbURYzZAAjBX7EXSSC9sbxUoKRclrG1NHDXCQJwnhuzl19z7BQH8FLiSLbvFDLJEoZoubGa9RB1Ip1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255844; c=relaxed/simple;
	bh=+iRtHVWesahzFEipR/js2nH5JPwfcMhBKYLMp7reF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go7SVxgkzptqV7IQhxgvOnG2zyYgj5nUi+DP8QTdBdcr5XwvLVRahxf+8R0SV/31Gf2YUcx+ToOziizWEKQb3CoZz9jlzIz5DMFsVfl3Vu1aUfMvPXFbZ6MTGz1U3CfQ3ewztam4wWgA+OEqgimF1lmNqK8IQhbaX+PlljKjcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=afYDO5Vp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="afYDO5Vp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6aa97edc48cso339023a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2026 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1791255840; x=1791860640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkS28LzVsZhO5NSW9OoNXPMGjm1DC13xh2NDUcHdEi0=;
        b=afYDO5VpQj3ZfVHpe6rus9XnbUYc3H7liXGO006YLu0beXHRJ79xTKNCQK5Ey4ctFp
         OS5eC9sBo5pRV4lzcG6olygUerEEEEL+rVE9pWBencq7QfAlOBUyJSE6au3DyJIIvXyz
         2vwW/VHbU6E8mZzoe6ZXWF8wF6HJUxtZUjYLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791255840; x=1791860640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UkS28LzVsZhO5NSW9OoNXPMGjm1DC13xh2NDUcHdEi0=;
        b=nxqzVQtOHjsh+D//PquYRc+usQo3MwQ3LyCCvZJ4aT527Pmw5VLYBbw2+dg2NLuuEp
         wZqQAPrrfmqiUvzEcCheFtO5AA2gwF3/gzELq4QR/2N3Fh7C5tmbfOYAnHF8Tj0/WQZx
         emlWPP3FZVOykHcd7HG+eLYoi9aMj1E8ceLlC7LitGJ4bHX+92hlQYrLAHcbEsYf2ej3
         ZsQlgq+b2U0KoyYelw171e+fumshj0Dv6Z/9S/k2kTLr3+dB52aJhCGQ3kZDdZeQiUIC
         0fVEiSnpPm6bjA/A+xg00JI4bO16bSxnDjawa5V8wq0uGJ+FAMFvKQGTWLv5Hp7QKJlJ
         gwPw==
X-Forwarded-Encrypted: i=1; AKwUvBz2oaTPaXkhrN02J4ZK9R280FYyjfEGtybB2Dua1DLI8DcpTgocfLZgb1oLDfvG2o0g8aL5F2B8arSA3YlC/2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmrK4R0Izwd7spQqbkMiksJIcMgjs/nBUWAWq1tGfLOw3BV2Km
	IfekfPHOpIVEpmJCYzt54rs2o8WsRYiWg8RG0WSLfjYRoV7ADUgF7lQnig/+7ZGLTIwmWTAhN1K
	XuRwaMas=
X-Gm-Gg: AYBFou110ZDvNqvfs9vnlGn5l0GmkfdckqlBG5U8Mo9eOk9SaMdYe/F3xWYsv693mjw
	jm7nkqAxRJnfsDbBiiS0tCv8aJaMIQ0EKcXm8K23j1NUvRtEWTv0y2lwM/SLR/uErL1/O2q8q3H
	3hy0V/edcWoVx/CIo/wQHC232wr43h1VrjivIxj0g0vXCRMWLeJwXozN3iAx8vp+/bmchAnEqXU
	R+Jx0xn1gYS+993EkPZ4I22OdPnyKUm8zMzTIpd92hxs33QHsIfx5LeheRFLbaRX8ILjK31Iyt4
	syZnVJ2CZ5gs0i45Shuf5pBpFBNH/RbIMGZiwgG32AD96OuWG5q5FxdRXkfkifOsYrTN1F5BUc9
	GLIe+B8nKAKMzRxIRAHWlkxK5VRXF0W8c8uH0Wd2+Hs0gV535NAWITqR5DsZoDHx+wJgTPEbwrY
	abT5c97aOSjSaWx0OXOhHQA40ZqaldFlukma9wlkaDWL2XnM93cubEAgVDGehFSki8MkLd4ktS8
	zwsS3B365m3trgI2XMPRKkbfljFNX9EtoCZ9XKheeDsMyrZ
X-Received: by 2002:a05:6402:194d:b0:6ac:6fe6:b391 with SMTP id 4fb4d7f45d1cf-6afe29d0f55mr18826a12.18.1791255839824;
        Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afd8c6a22esm486876a12.24.2026.10.05.20.03.59
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso309973a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2026 20:03:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrBaGUZ3XNc8rwhcKg0kgHeF5/o2IaGB9dyZytqtB8SKZ4X8C7iUN6k3okcxdQ2GQQ/8ce38uajPvWyvyJFJA=@vger.kernel.org
X-Received: by 2002:a05:6402:510b:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6afe29be63dmr21481a12.11.1791255838871; Mon, 05 Oct 2026
 20:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asQo0Kb0SF0vZcHa@kernel.org>
In-Reply-To: <asQo0Kb0SF0vZcHa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Oct 2026 05:03:42 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>
X-Gm-Features: AclHuK_NZp_-mPHhcS8aNBup4i1rRUZq8vjroRbwWPtPYmjv6VfHjj3cm0et3aY
Message-ID: <CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS changes for v7.3-rc7
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 00:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I've started to take steps towards better quality PRs.

Looks better.

It reads like an llm, but that's perfectly acceptable use of tooling.
If it was an llm, you can tell it to be a bit less verbose, and that
it should prefer imperative voice ("Fix it by" vs "The bug was fixed
by")

                Linus
