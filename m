Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C93CAE99
	for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187390; cv=none; b=IHuQ1EF9ZVUU8ccUiIiFKjoCaN0FEoignxZuJ49v0yGNikq7YGP1j1fn1EuRG/1WJ68gowx4NtQXIFlUIRHPd5sUlS8csRGR/qQxKB0QMR0tpjksDj1nb68b991mK3mSWpxAvcMY8Btq6+XBgY+fKLrZqquU7UXPkGz1mr7P3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187390; c=relaxed/simple;
	bh=RS4sMkfTvFYE7AM8t/lpidonFFEmgBkgYNWP7YOVbnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giuS8LYGtNzXOE2zbUqRjeEppi0xCOLBlU50pNB5YcBnZrPGizjSjxv9XC1AfM3hkS8vPagq+Scxqqc1pLC0LIb8dECK9e5SwxuAvlgmdR9JxPNBN665bVci1aVWE0GhTbLwby9JXQXN36BYDXxMXvIFmyITPKKRXgNDOAjYFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ya2qK29c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ya2qK29c"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c167aa9500dso430212166b.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785187386; x=1785792186; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HopFweete7JiAcK9AfHYQfunXxICnvR55+iTDr8jE2I=;
        b=Ya2qK29cA6uxZECt1FzPpWHrx+HKRFMmKNeG4F+SF1zN8whqupWAE3pA2/8vOwnTFg
         1wwTBFLAj9h5tI19r1VY05F4kBgfMyfoplQ9mriRjGT8UCelOpcffBb8N9q5GRDePTDC
         Yi3Ze5CG2wnX3kyPd1eG0oRXRf/KV/XI/+nMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187386; x=1785792186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HopFweete7JiAcK9AfHYQfunXxICnvR55+iTDr8jE2I=;
        b=aAWCJJ+vS/559Qz0lI1ybsO8eD+dhU/uXwfYSQPDSwLyHqa5DUOmENtRFsFfiyq7y+
         lXKJHfDmedXM08EkHqKEFA2HgHi3SfXKaEki8+vrPOTIKOQJfPQgtP95T/ZDug88mGqL
         0RxB73Iyu8ptMuVZFqjMUm0OC6Jh7D1B3jrW/qHskg6E+fn7Tmm2sXO4B48UtXh8nuM/
         j9c7ytsaWuQBcvj4SxVy87z9O8Jn8KgJDqAWobd/PzqV0gzu69xNdAYIVol4t5798wD4
         3eYCUqTyGijSWLgCQIbrb63wLnwH11mQDrb6+RfNgF8VodYcbNZ6wazom2I4AOTRqt/0
         XS6w==
X-Forwarded-Encrypted: i=1; AHgh+Rp+oul6N08PuTCo1uvfewR6u6dEYKEOdkVXeiwnnxC7gz3i2GEfnRE8dNyz/1m/mAKFXMTweo2nSi2PKBYlxyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IbnGgztx8Mvjshhj4tEwQ4DXs+D5mzB96NVt7gcBpSBvTCao
	c3+vspwBTEZJ3a77fcvO9/7EwZQs31m5j6c/ZbNGd4z1ZSDIRZeHUHh5Ay8uS/l9u/J3vyKES2+
	WZWyJwr8=
X-Gm-Gg: AR+sD122euZ/also3v5UaQvAXv35hwTqdn+yKZ7ks6aa30sFFTU7jKnAdvMNN7+jdx5
	np5hs1j2ZpooDKS5gpL4IjrBkkSgLGqZTZnHCsgijA78uXoL1pRJWpgC8Ea5WIUdwp0zsCvKDyO
	sNm2Db8dourV9QCxZtEHQxnzPTB1K0hKgO4C3pzOY/Rf4JgNrMuJO9khm+t+aMHHuNC5fraL5tn
	MtM22lowxByu4jG5+Zwl2668ZaicoX7/RTJwv1DwO7vHWyJh+8xy3ql7p5ZRZWI4oZMlpcqaHxf
	sTBJN/9qpKPc3rt6eLlMIA/2Lhor+38WPMVTmOR04e4x/X+m52kffKaa0Fwx766tWYGYyOo/2gO
	vqQnoFnt+2q+Gd8VwwzyDA3vLPbu2C5BuBsee+zM64bKIKC6pe+Xd+G3bVcqyYfVlAre9sho/eB
	SMIG3WNnplRp/3OsEER92fDUEAaXjbS7xyn00mMr3W+ffQU88gl5p4U33q76N3iw==
X-Received: by 2002:a17:906:9f8b:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c1f68fb05dfmr36854666b.7.1785187385855;
        Mon, 27 Jul 2026 14:23:05 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f19c57sm674239166b.58.2026.07.27.14.23.04
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 14:23:05 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fe400c14aso2913951a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 14:23:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrmo8c5nO/EX2CbnJP8kcS3lq4bDh++icLDegC/RpM74xy+mudqCaq0e9gwiJr3GHmzhhrnc7m87aKWzwAhDss=@vger.kernel.org
X-Received: by 2002:a17:906:eec6:b0:c19:5d7c:ae72 with SMTP id
 a640c23a62f3a-c1f691b5cf2mr31384066b.32.1785187384769; Mon, 27 Jul 2026
 14:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amenZnA_QgqwMNeC@kernel.org>
In-Reply-To: <amenZnA_QgqwMNeC@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jul 2026 14:22:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
X-Gm-Features: AUfX_mwib83YoilcdlPj47fvLuig6sMdQiV0Di9mKNp1biJ0RxnNpzwkKIq32tU
Message-ID: <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: for-next-keys-7.2-rc6
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, 
	Fabrice Derepas <fabrice.derepas@canonical.com>, 
	Michael Bommarito <michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 at 11:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains bug fixes discussed in [1] and two fixes
> (in one commit) from Fabrice for DCP trusted keys backend..

Please don't explain commits with links. The commit log is supposed to
be legible without a network connection. Links are ok as supplements
and background information, but not as a "this is explained by link".

And the pull request is supposed to have what I can useas that commit
log (either in the email or in the tag). Yes, I edit things for
clarity and consistency, but I don't want to follow links and try to
figure out what some discussion was all about.

So please give me an explanation for what you are asking me to pull.
Both so that I see what I'm pulling, and so that I'll have a merge
message explaining things for later.

I've done this myself this time, but please make your pull requests
legible in the future. The patch series you merged even had a cover
letter, please keep track of these things and don't make people search
for them.

             Linus
