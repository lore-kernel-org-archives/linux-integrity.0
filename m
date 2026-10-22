Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699642;
	b=xH1FmydyQ+cbAoPL69PpTQLf0kQ7f6ikIdABa39+tkEwE0ZLopm6RXjZlxdieoWwJPLS
	 06pmhqA22hSwIkMLKclRO30ODLg3Ac49qZMCYJd/Unuca+f/HsDx7Gg+DmvxbUyDEXPoQ
	 leOo8+XkwkQIBjst3Bi6/fFLhWmByEq3AldsPM/fcHUo1XGdkcNHyuyZ8Mhd30r2BR1nO
	 c9mD/bgMDW+3GJLfjXlhH3AZ6CvHwW/uHIcRusTr2ADxiTN7mVbmFgNWHiE3WZZpR36nK
	 REgu8vGcPCIYAybovGHeAXfbaWnWdOgBqyOrKQiQ55SIgFGeHoaYV4kXG+qBLKFXE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
	b=vw0oMIrgzgfdqH2a+PalLFtkkDh/GsM362PT52KIO/UhX7rFy4P6Tn2r2QxZPaP32tjQ
	 to8ag8TFNPRyz0NDoEC7Wqj1kUasmf+q9sFMb7wMrNJO3jnE6ib/AOFr+NvKfNnTOPJOW
	 WLaByJjoDmBi6C2q6ROyQvJLitRuz2w7NH4NINhAVBM8efxrFPWX92nCSdbGQZ4KsDYwU
	 ipxtlZeeO/YKXwwexkn/lRdiSvzV/UhpOUSAeRqSaGICmZZAMmO1kVhqHo2JfrNWWViiQ
	 j+PtAZ96j0n3mNJP1BMxm3ZamA+SlIsrmu/xMl/Sba2DVxyZ5xfcCzUIeKd2yDuX5UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Osb13x+5;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2525606A330
	for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 20:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2525606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Osb13x+5
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c450ab1483cso26116266b.3
        for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792699635; x=1793304435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=Osb13x+59CHE2TJjxc8hBoRM5VGQRODqLH8vySd15DcuQBJ5W71roeDUMhbnZdwiwp
         PNGsGUtaWmDw6R0Srx0NVFHSNWLzlWNCEkcEnOqE+n7wThzS9dVNDvtyReUM1VZz0Moc
         vdJSA+2D/y4+9om/8ycxv/4BZ9r/R6ef+zn/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699635; x=1793304435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=Q9Z7vQONrKpy0Ky5YS9LGVCPaK1Y2onQMKodwWsAvwVDkTK7GbRsiaqQjI1Mfl4c4Z
         UK7ZO7ihuiPksLl4RYklH7A0wfyq1fw2NW89bWoRG4jdEzTu/z32vXeDwIf1UMUsf8tU
         Sc3mlmxR36DDKL/KM03Xn+xUJbASrdKZkriLvV1vFfi43OaNJukj+mE2IPRH5gRTdKqH
         kHDs5lgFBn8cTmTkEcP97Xlc7Jg/4FsRHoe24NXZY/5obMK0Yw34vE8U9WVb+uY+ldTL
         pUnHlQWM8hhA8J1842eun7Wqldk5f10zYjTVfOJKyxTjoFggE8KFsp6iIJAnlqUzejOC
         Ggmw==
X-Forwarded-Encrypted: i=1; AKwUvBzu8Hu+UZ+J5R9QoLGs+hqUjp0PXXTASXZksRfQzr1fnrIH5Z4wpwCAnp8ooR1nadeWbFFIfSXXHRgju3uaX+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaEIebQUr41iVW1aRa5S9PxH/edk3mSmNopWMRUUXKPV7/ulgj
	4g+HWHMUvpCPj66TYSEhsu32i4HJKVaIglHO/mfEwXl/puuqzbUt00pOxafqBuIoSfKfmhjKdSH
	QPo5J44c=
X-Gm-Gg: AYBFou0JgIW/xBnS0TYTJW3am4qds/AoiRrSNyBuxkP/NaFSbv0lD5h8z31+aj9awsk
	TghoyKpd3OtthPVICLXZ4NiMlEYeb5uFVaJ2fiIWy5GmvifFt7nXz5kPFRxxj+DVp576KLDS5Wv
	8O/xK3AGQ5bB5QpoYuJsLXj2DrBG7wSxmmj2BLyGvzzLQydJMbyOkjY4AoA+9Agr6pNPrL+PuLz
	ZhCdFXwXRbpPjvLyVMBdkwvNSL1+bXTFr7GP+mTSezQ3kFJsq5T5KSDTGF9M5oOaBQJsSpqG9LN
	d0lBuwK7cBEYKVDFRUf8b16MuHfHgAAT97QDlBkLIUdXkcWQMTM3j1eRYD+k30Fi74L3Au4sg1E
	Tb3rp7lnuyok7MsgHPsMrvChoag9YqVOD3DV5tk64/uqeW0p4bPuhF5rl2dcaTgEukPTJ9643lO
	0FrK1DpTPpJwbTgXI4HGnnFL1Mz2nbnfDPcZIsij7QKTg0XFvn98I03EUA9ZazAwA5UAghExWV9
	Kko626glAQQUptIwsA57qwxtvf/rcVWPHd1XG/J1iGWASDCae74RAH/duExDzYB+NQP32XsqPXF
	Rq4hFirKACtMwSUDV2z7z8Cfr3Siew==
X-Received: by 2002:a17:907:7ba3:b0:c31:9a1c:de76 with SMTP id a640c23a62f3a-c46a927edb8mr32776866b.14.1792699635123;
        Thu, 22 Oct 2026 13:07:15 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5a8c5dbsm26390966b.4.2026.10.22.13.07.12
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 13:07:13 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso25977066b.2
        for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2026 13:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy488PYjBJ6EAvKb0aisoOqWcrKcJ8PG6BxM04LG9uaZ+wj9YvCOTyuFT4cSzUD7hae1ns8qLw5NlwMG5JYMVw=@vger.kernel.org
X-Received: by 2002:a17:906:dc93:b0:c42:a326:78a9 with SMTP id
 a640c23a62f3a-c46a940fb59mr32870866b.42.1792699632620; Thu, 22 Oct 2026
 13:07:12 -0700 (PDT)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atjKs7PTN8CgndJg@kernel.org>
In-Reply-To: <atjKs7PTN8CgndJg@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2026 10:06:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
X-Gm-Features: AclHuK8nlFozT4sO2BQre7T2aT1PPMpnD_lYchNmr_bb0lScPlgwfBadd1Pr8mY
Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 04:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> A patch that Kyle Zeng submitted addresses a critical bug [..]

Note that breaking local KASLR is not a "critical bug". We just call
it "Thursday".

Breaking KASRL locally is trivial using just all the normal local CPU
timing attacks.

KASLR is there to make remote attacks harder.

               Linus
