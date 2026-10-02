Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262F4EDCB2
	for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957468; cv=none; b=q38U/SSTbtojjfvf+nS6LPeSOt7seUg8VLJy619TZPDUb5iFiiFptuAioWz49LdtE66idpkwT+vLZdYiqKLeW6gXKdkp97KzZGHxmAoBsvHHdaJuarP9YgFRVdYl0qlwI/bF31HiJKH2LH/4J8cAy61u7BcM/FP3+h6bN0j6eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957468; c=relaxed/simple;
	bh=k6EIrKXphmVYtwYT1711/8oYKVo3ADl2w1gIDOT/428=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRe3XOs8rhfPzCdRyNSKsCqYYuBYKzqnTc78MhHxTR33vDC9QwyhobV+RMsRXwUYfe3AKbwhx7srSzBhSnWOenPNxgfEWWSIBVqVE7b+FxrSZHJ59UnZMtNuEuXzbQxMDRXGmg8br80nA9O4ubo/7qY2/zYT/7iyaM+Bj2vl9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SyIpzk7W; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SyIpzk7W"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e20bb4583so10749166b.3
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2026 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790957463; x=1791562263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxVPiCTrxqmZkgyyCrGRaSaA/i4Dd2Lh1oLkXXkYEhk=;
        b=SyIpzk7WdLc0zFMHMC++NW7dVImEkeJdrbA61PmSly4Eop1d9PJ7CVnDjCqFybhH/P
         G4otyqCw/1HxspFB6t4/UDyRCSDsTuq/JysYWTPmURsvcHt6a/LEd9/ynB0Xu9APRqdc
         SH4EqdKnORkbSsvSs+pG4Rtlanludd1EqeaWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957463; x=1791562263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxVPiCTrxqmZkgyyCrGRaSaA/i4Dd2Lh1oLkXXkYEhk=;
        b=U5vGLMyigNHWkWVD6Zlh0S6SURQgyKkdxw2W6Qe5aKKTs+14MrfjytDg4NT9NVXL4y
         BAVXpzJgNHXW3KSWvV++BanYPsqJ05LrJBHNp4xOlGE250ArPHsapUdWjQRaImwfanZy
         s78q3vxpFL1KJLO17/5CJpuF7Q+lY0u6zo7ucgS9GyxXDMRm2J1hnQ5qKHAHw538fkjc
         h2rF3YVavTalHCwlNsf1sckq826upCQucf5WjPg68DX4B0jktE517csrcDHdzgvQ7qWn
         HbsQo9rH8APLQ3Ug5tSlkErukthcTI94F063ljZSLvQt5g084X6dPp/pozMia4cCSIMg
         KkIw==
X-Forwarded-Encrypted: i=1; AKwUvBy3IkDnPRb5XqJPH8hTv42fGexfLJm56r1cd3KZoyOl0XUTxYhwbBEPmD/mnMvrPDPfr9GqoHsZwnEx7wFvw1A=@vger.kernel.org
X-Gm-Message-State: AFuF++kSC/mAzkYBfRjuR9chatCvZ4Er1yIX//iKP+6AirOHk73hellq
	S58MGI6HIAFybebVyHWIQT9w2FQFfz9/NE9wNWacOYX53JQ2hLZMiZzdgqQ64zLqKC7+zCuSGDA
	EyxBkN4s=
X-Gm-Gg: AYBFou2xKeSrW2zaWKWLs0WbQKieVBvv14YWfNUMW6UZK0DpwqoD6so57fOZDtP0SVV
	koXFvEgBAJ4LRdor9ddEcdv+Y0T2KQ4zLD1EBTEMtAbY4zHyV04KFC3Yj1e6jxuemXb7hYbd4fW
	yKKtR+i4WvQ+QlMD5HkNh7wGIzYujoN+FwPFymGeNd0eybJvqxJFQ0Kq7BKN6xk4hXubxgV/i7/
	sdAVR3BrSMRfYUNKSQsLeydcNLa9ObNhS2NT0e+dKKVL8rgszBGKX1P4A5bFJ/lKfVvswckhmXF
	WTWRN06uZWbvxvIxzGjsP0KceIxYsQ7goJnGL6lToqMOvyU2RzjxoV221VF78W2yi7zijXy15tI
	8flviNmxf5/FYk9a08SnjilPewy/NlKCfC7A2fRLMI0Bm0zikIFs/Cd4WbNjDH74g4UXZ2mTrVk
	oGWRq+FX1WCu15vkveBMMn6jTE/kFDVzCeIWVZJcB5MJmyn0/466HMFidyMvtcL6QQFjdzt4YKF
	wM7izBW57ZmOMNP8wzsEDV/WJSIABgBtFGLjLADJLf6+wGrNA==
X-Received: by 2002:a17:907:9801:b0:c2a:fcf5:c6b4 with SMTP id a640c23a62f3a-c2e4b2ded87mr250769366b.49.1790957462856;
        Fri, 02 Oct 2026 09:11:02 -0700 (PDT)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com. [74.125.228.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd05446sm101759066b.19.2026.10.02.09.11.02
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:11:02 -0700 (PDT)
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e2050feb1so11949766b.1
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2026 09:11:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwxnGG3aTMYb4s30ESCWqDaeD8QwQJ8rztNLLDYMR7Wd32Hxcypi+RVkqOcIyWzqH7HuWLrYoU40+EjUno81mc=@vger.kernel.org
X-Received: by 2002:a17:907:e1d1:10b0:c2e:4e08:19a8 with SMTP id
 a640c23a62f3a-c2e4e081c49mr157712766b.5.1790957461853; Fri, 02 Oct 2026
 09:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ar9D-mM-KA9P_pJC@kernel.org>
In-Reply-To: <ar9D-mM-KA9P_pJC@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Oct 2026 09:10:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>
X-Gm-Features: AclHuK-xk4Cejur6T8G1Bze0Dr20QtZHSq4M1Cl_MKyKmEbexAadoObtNJQHGiw
Message-ID: <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-v7.3-rc6
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 22:41, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Please pull these bug fixes, which have landed after v7.3-rc1.

Jarkko, I've asked you before: please write an explanation for your
pull requests.

"Please pull" is not a reason to pull. The "which landed after
v7.3-rc1" is also not talking about what they do.

The tag contains three lines of text, and none of those lines are in
the least helpful or relevant to the contents of the pull.

It doesn't have to be much. For simple driver fixes it can sometimes
be as trivial as just "Misc trivial fixes". But in this case it
clearly could have been something like "Fix tpm error handling and
buffer size bugs". Merge messages and pull requests  don't need the
_details_ - those are in the individual commits - but they should have
a high-level "what happened" overview.

And this pull request is actively hard to parse. The subject line says
"for-next". So I have to look at an email that is actively *trying* to
make it hard for me to decide whether I should pull and gives me *no*
information at all about what it contains.

Be better. Please.

                LInus
