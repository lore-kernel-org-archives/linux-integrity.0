Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97640096C
	for <linux-integrity@vger.kernel.org>; Thu,  3 Sep 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419728; cv=pass; b=YLS48KQD5sntevlUk5qtWiqflsVo4jqZfgWa0Q+EuRxhalSnHp3lKCD+onY9ElU8lIRW4xIRVDWuhYTjyuk8eo5c59Jfhet4qLT544voKkZqaIGxb4VkB4t7qB51SBAB8FPfPEYY5C5b9Dg7tH7rRpRTyXQPcE8YUqK3KNgEDqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419728; c=relaxed/simple;
	bh=BDxUrAidUvmdE4UU9/YWqxyp9t94nH6PJ+zSqrwq3lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz+O4VDQbXcg+O3j5FbVNB9wo0SvEQAL+dMeckJ2ejAsEXJPAOiJboAVcsormf+miQxS17ljYybB7rqUmQfm4iyTv9Ag0YgpiYheVDmzR9BoW+14ShJ/QDnkOM+dUrvKKVCB8TutDLSLRBNhryNvs496W+L52i2Hs+k8dHsHk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=A842VfL5; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="A842VfL5"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52d7a3defe8so20741761cf.0
        for <linux-integrity@vger.kernel.org>; Thu, 03 Sep 2026 00:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788419723; cv=none;
        d=google.com; s=arc-20260327;
        b=VGybyM3rUTquMJxz4ufAzeFYGcIBmA8NiCYMwB7x+RgSjsplR6ikynbo4r/BAZ2c0K
         ohT/QZopwoBokK3JpGH+rO5kI19pDnKQIbzD7vnYyPIFo2yOyon2kSEkL+xD014Mxqai
         n3olbw4fDTlZps9M05buYFRZlfsZRHi0iE8cHiWU4KrTtO4tCPu5kU+Kz6GslIXOfQaP
         Q+nDIP1/YDXROd69FYKyHHBV0BDuxuFX58ZHgKgA51PBLoLF5ZP56iUGoPVD0Bs6KHIu
         UxFTq9ri3VWTmHp9e50VHoQ9gHyTWUKNWGAs4lc2Y6fFfRC8t38c+PLKts64DwUNGZgd
         vQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/3ZaVDaa28jmLpu92uijSHs8QLly3pVgpirsXkJfs5Q=;
        fh=I/i6DqUFedKtHngbqrwLtY/HSQVKLHYyCcYwJoZEiA4=;
        b=iTwFqAvHQxnzyhKvPT2tAlLbCy+ZNczg+5ZugcB/WOrDyBcb6pVcS152cKlq2666yw
         8J1BN5pf4i0AKa1cQopSDpb5luHiG5EmHWdai1w+Dgif5o5wTMxoRKgcIHmgxgw+m5wy
         4F5UvyULSyPxU5xhOz9gfwj34huZF6B3cP8MG+xSgq9dJoCdJghG/bbp2xyPnsz2p/Lz
         cIAOEFlH6YJvU/gOux42S+y6WX29BhRZ/RTjtCg+3dgBK05KiN1AeIgdfrghDjR5Cxnn
         cy+ZB2VJgpwJprVh9NNPsUjfR+O2ec89AcRx+i6rtaT+UeaCuQepLALpzJlK52ZvQuuK
         3CnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1788419723; x=1789024523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3ZaVDaa28jmLpu92uijSHs8QLly3pVgpirsXkJfs5Q=;
        b=A842VfL5K0OpzSSxxjPNkNV5MiR59ugdH6e1GHMuyaa4pG/yubkJabr9X4Y/U+Jal5
         szQ17bcOR3Lx4dZxqbmD1f90D2Rd1GjBLqWZ+WVc/JIuSJZUqMwoJYDU9ZlA4g6waLkK
         UFfG/IMy3RCUCu5+4tx1PLshY26VwN7Lr32sdnt/LgVophkd3DFDKFRQMXMBfGa9JCpk
         75NVcrntErd2puJZ13YamB2hYuYcXBnBRzKLporwO2iseEfGVgfUFzo2DuIMsBWMEK3l
         d39Z3MTnRmVZTYYUwNIjfMNFadD5+AT1Iz7vDT5Jsr4NoaRwnAcAmOiZz0rwLErkRMdQ
         fE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788419723; x=1789024523;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/3ZaVDaa28jmLpu92uijSHs8QLly3pVgpirsXkJfs5Q=;
        b=UF9DFXkRfwgmAff+yCooW94MErQrNEOJNLAbOVwlH6lAcrwhmmCiCysbq8oa60O3+J
         OmRkluKuH/+Ls6BXozHGraH4DmE6Qpf+p/ooRMIc9Yek/WUKkzMXxvfWsE2xVrP1wu6x
         Jbhtj8mAyiezB99+tq/5VM0gTWMOr+zwV4Z6eN8NoNybCC1WMkrx9STx0nk2MADMe/ci
         BChL09t2uaK67o8arfgZzw+HxWZzk1WstoJlOJisY8+jT6RPCijIe2/fGBeNXOAUXQP5
         LYNL2Zq5Q95EuKc3qEHnP40ca7OoebqoeMnf8AVoGrT7rXrwTV2zoO81R7zuywGgFjqU
         Q8FQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkKOfFNmnW5WP2Kq2msRXA/wkT16eycVVR+kBzCnHTmC7Eo+RcreiQgjLb2MY84GMKB/+5fZFTUgSbss9NWTk=@vger.kernel.org
X-Gm-Message-State: AFuF++m1MM3QXrLPs2azS+myicPrUl0NZreYqcuicVXVYdyztJ6HgByC
	KLFqAD3EOIlKjbHDNmJje/7BIij3KZcqV+Odf/skHMDq+/lkRP5ypRMko85lhU8N1amIYBgXHFX
	dP1YuzBHaPdxp+1Lzx+43qjfVwmRpK6ueH1LC748mQQ==
X-Gm-Gg: AYBFou30UttLwVMbAnNcXZ+wUOM5+tiJEW1NAgLs9oZVjKBuBk+bn+fFbKqUQtfjR/T
	dvYcqRssszefuKovMWskzwetpH3YFul8Y72KPrWaYCUh+7tQXkqrxwIBrP/ILA8DNXLD/0vOmqx
	exHb/50iWrszJJ6nc99YbKCDh9bFr8JSdx4w1H9Z+Px2Pwr28kRLQeK2JrNKdtiD1likwHNOkyl
	7OM417h6hFDeGjuT722UQ7u+/i0UXfO8LUKSUWVCZjQxEFRglitiiguH230daA5MZBuoLRbeqn2
	AKXyW/m4JNghgee5oMN6yHuEyQ0uRr2xNIS1g92/Ua9pkUJ22nW1yjnRoO/lmqQSzuAJtSDf+iA
	p/FU=
X-Received: by 2002:a05:622a:138f:b0:530:1e1a:fc70 with SMTP id
 d75a77b69052e-53036bc87b3mr104794101cf.1.1788419718250; Thu, 03 Sep 2026
 00:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-acpi-char-v1-0-742c450254dd@thegoodpenguin.co.uk>
 <20260807-acpi-char-v1-1-742c450254dd@thegoodpenguin.co.uk> <60e25773-b3c6-4aae-a687-92e1ab3b141e@app.fastmail.com>
In-Reply-To: <60e25773-b3c6-4aae-a687-92e1ab3b141e@app.fastmail.com>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Thu, 3 Sep 2026 08:15:07 +0100
X-Gm-Features: AcwNN1WIqW6SG0lDemdV894_p4DFDolE7YAmpidzaCNJPpqblz3q1bAvW3wQFoY
Message-ID: <CAA6zWZJRpUzbz20daytHO4ygqKosM=YU8UyBcWnm2sUmaEHbnw@mail.gmail.com>
Subject: Re: [PATCH 1/4] char: use named initializers for acpi_device_id
To: Arnd Bergmann <arnd@arndb.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mattia Dongili <malattia@linux.it>, Weili Qian <qianweili@huawei.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Corey Minyard <corey@minyard.net>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-crypto@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I don't think this is the right approach: I see around 1500 instances
> of acpi_device_id data with plain initializers and only about 50
> with named ones.  Converting all of them seems like a lot of
> extra work, and I'm fairly sure you can just change the
> driver_data to an anonymous union without this.

Sorry for the late reply, I was away.

You can change it to an anonymous union and the kernel modules can
build and then you can go over the code and set the designator only
for all of the entries that will make use of the driver_data_ptr field
(which is the union's second named member). However, you will still
get -Wmissing-braces in your build log for all other initializer
entries that still rely on positioning and resolve to the first union
member by default (the kernel_ulong_t). Adding an exception for this
warning seems like a bad practice. On x86_64 all warnings are promoted
to an actual hard build error via the defconfig. The other option is
to use more brackets instead of designated initializers for the items
that resolve to the kernel_ulong_t but that would arguably make the
code worse, inconsistent, less readable and require the same amount of
churn. Therefore, converting the tables first and using designated
initializers everywhere to begin with, before adding the union - as
proposed here - is the most sane and clean way forward, at least in my
opinion. Perhaps I should add this extra explanation and information
to the cover letters. Unless you meant something else.
