Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0B40DFCE
	for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613257; cv=none; b=Yzak3i3vVIsDqHdQJfQRaODzyETykPmDEpALqJ2oPAHUEOC9Jaa1ZK6Xfq+80vouj4i84PAatlYzOYettE/KQCQHx8E3ztTBJXJZYJ6iVFYNSTmKhJ5jiAqUXC+vr25XAgXkgrUjHwvQzO3w6mO9CblD55JogABFqWUsrkH6sak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613257; c=relaxed/simple;
	bh=QL7KPy4odOKc1bH97bE6jdTF5sS1FJVzuPNk/j3Emh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALMSkjGf4YxsqC6ez/KxyEGqRNk8g2l0rY33edUfySrHkgpOH8Dv5IBuoV0yT5cfHaSbmXCCAgYgeBfSjGW8YEk7e7xQm2ehp5PGOfEEUhG7EW56VdwYTPEAGyXC1zoekHK/CarqPOr77i4N0ZYmaZ6SFpcAAHQwo3cJi92epqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYr0/ZI7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYr0/ZI7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba388bc0a9dso409649966b.1
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776613254; x=1777218054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DQpHRzG2dpj1+h3dh5/1xl0f5jDtHEF4mQnKjswjWI=;
        b=EYr0/ZI7zg58FmkLl5geT+6x/iBxYUrVv4WaAli6HPqELoQtC5jFA4xkdPsq5yQ0zV
         nuVLAXIGpVqLhbMgjDEIjF1ReI6ZboKzCUyE5GZIlQt8Nc5LEEYuzCaCJfOwcQRX0dvc
         gBcfdtQIQ80sh08Fv+xcUlpaXYYfQCzf6Tg+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776613254; x=1777218054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DQpHRzG2dpj1+h3dh5/1xl0f5jDtHEF4mQnKjswjWI=;
        b=URoXoU1v9AdJa3tLc1MHHaQbFxgbAhrrFYwlarYNsdyI/YjAka4EdU4FqLkmNxaHmE
         OjpvMXfjPLxhLRVUE7UHznX73KgZbduz+nzKvRKTWgRl9OaPshAV03ByTD4nADfo1acI
         Gt/OTPYEkMA9NqsS+/OpBEj8aTID1vKBH5B9BrqqYEJC6VIPgJClZ7kPZdm+h+vlGCqK
         WfUCpnXzcN+AFUXxAd3qYswpU8wbQnS/Y5FcfPyY7/LFxSS4zu0J+9OXc8boiFYed02N
         dt6AZVIvc8AixEDOSi9L0FL+qHLKiZuoE0Mc83/KoA4XWi4vQQpWO7cS/QpKz34hgVTN
         +Cww==
X-Forwarded-Encrypted: i=1; AFNElJ960CLRtfyYa/eGC1Ak8YUZbPdjwk5H5hvfUtNJTup8oD6ciUSBVjEveeAzNPJvZQUPMK0AIwwT0CCizpjyLgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1q79L33TDdMijLe9oxL8qH0B2h88dyBZySO8ZiamCC4Ja1sV
	2omSsBZKYr+ZvW27Pnml2r7E5pYmCS6HMVbZVVv/bAFBYxsB/1Dx5P1vvpFsmY2Vwvq8a1GqYL3
	BJPj5crs=
X-Gm-Gg: AeBDieuHPz872+AaUJt/hOGFZCAQpITo9TS2ZMfjG7ZjbMyn5gyF+rCW1iySD4YtbRb
	xv1Jj14YcQwIXAa8XQBgZF376JFJ6vmmw3+owfVR8yqwQ9/vPKaoZXGKdAFW01+89yfvHu2C9rh
	HG+IE8LQfh8Q+OaM36O6/rKnnx6LoP7PJ4JuE9jjQ75mxeO/vA7ANjVpt/gQC/ZlV9+iMXPdOXZ
	+Z486+BLSvL7WGeMgpVGckZlrGnfaR8NegDAaFiyke4JKVYHXbcprBScvanxb/T0DH/UzbaLfGX
	PmF3j7rM3aXYhodUUFvXJNI1Te7VJEmiqEWOyFILgXm735iZsaoVfdS57NokrAUSgf4nbeS1xRk
	I79gcRmly8OhTHGqIXUOfvgGzecKLoziEOt6CORPNXliyteoqfDeaxU81SYSt4St12ZVVBIYaMR
	rbmDcrd1LpqnQWEypX9MJiRfynMjE1SNQgR90QltkrQfcUS6ayqXXik6269YnVx9XpGiJ6GL7sn
	Ikli0KYG+A=
X-Received: by 2002:a17:907:3d43:b0:b9d:4658:7ffa with SMTP id a640c23a62f3a-ba41b9d3b03mr499839666b.49.1776613254045;
        Sun, 19 Apr 2026 08:40:54 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bae2sm268451966b.36.2026.04.19.08.40.52
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 08:40:53 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67482e67171so1707535a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 08:40:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8nwXn7dTXDT2rY0CTn+boRdjmwhHKb0tVAIF6Lawmi0URlQXHlmwzaiYg3Vu70lE5lZNORWw5/AJD7k+4kKMk=@vger.kernel.org
X-Received: by 2002:aa7:cb49:0:b0:672:75b2:e8dc with SMTP id
 4fb4d7f45d1cf-672bfde2481mr3319839a12.24.1776613252524; Sun, 19 Apr 2026
 08:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTM2CO_mlNYViFU@kernel.org>
In-Reply-To: <aeTM2CO_mlNYViFU@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 08:40:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
X-Gm-Features: AQROBzBbPG47JCZ2rrBAeE1uhqsels3vK-f4rGGurHRaQ72-6a4DiEdzOsg2MtQ
Message-ID: <CAHk-=wiPWCUHsNvzKep7z4VGaL-Brx6Zmh7Efn28WWTPbwn5dA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 05:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains accumulated bug fixes for TPM driver.

This is all very recent, not all of it has been in linux-next at all,
and stuff that appears to have been there has been rebased.

Why?

            Linus
