Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52893352C5C
	for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703949; cv=pass; b=j2H62ay8qOvvTKokn7L4LGEp07g+AN1R50BleWJhPDJ1gkQdagtuouh9TcnlO2x/IHXsOE0CYBMDqURUP4cS0IbbBBV6wKKZijfNxgJ7OwVMhnT42VLNNqEBOBfo5OcBFLJlNRG0EeVHOLe+glGKIqJvcMqt7p1kf1RBelfq7ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703949; c=relaxed/simple;
	bh=S3mAFaz01OOGQD2HIBzg3TVieRr1CUbn2sH0C92IlNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkVY2ZRB9CQFJ9gtDxVsOKIXBqhW9/1PYctw8vfFiadYRYaTNeD6ggza7z8ZX6/B9Sxg9Z7fuztS2IcPhxYQ3BU80CoCfiXodSsg5VTRdHJbRqoCe1KrCaqB71J7fKJAwfxrdibRhBhNGZq43EmaiOpCrGbDiDIw5H6TLI1Vnh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Qjp8s1IV; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Qjp8s1IV"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a093c784b0so41663066d6.3
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 09:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776703947; cv=none;
        d=google.com; s=arc-20240605;
        b=duKs3Empg1577WxX1vB5iOf/ynyKaGp9bJh/V+m4QWor5afj4LjZKKn//xATJTCXJv
         ual5DJGvJ7J+vgl3mxeMqYLHa50gG2Cmm57AvNnGM6dlG+0dPhUdHKwLLAZnNlChvBQW
         9IcqFTo8na04/+a2pZ6t0puF6aPfB+sDQYXt5FHeqenemfeYscye6vTR0aFeRTjYUQAl
         BmO5L61l7UO2fP7AL+XMlrpY3nFQjsWsb0IDdCoibmr5HwDkwMzZcoVpEgqxUZchV08O
         igj9XV/OlXm0SCb8tMl+W6wfv3hpjaDBipwX2feI+w9bgGoi0yLnS2hg/JLOv1bNm259
         25TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S3mAFaz01OOGQD2HIBzg3TVieRr1CUbn2sH0C92IlNE=;
        fh=5WsxGno1/j8W6HpYcIXK6w8a/Xq9LhjyHIUV4rZGrtk=;
        b=SDtIZGSbVuf/RyR8rDf/o6Ww8+IWvBj2OmIk81pvVwlCgFNr2WU6jBmblZQnHTaPtI
         rEEcLBgfNoE+vjjXmzSuoFqJgadmRiaOF8hUZ+kqbbi+M1OkQTKbXyo8ObE4DcLRa3AN
         Trrj6DH0VOvdLqTI/kbWMGH14qUgg9hjlvso3dhasks1MDlqdOrUWoV3si6EJ7sUlZl7
         n+kVY2UrM5YQiDyJ7nHNoKGUrNUCLxQww4nJgrMOrfIBaUZY7/ghju+J2ZpqrKmjS9Hz
         4Vv9eLOmSnZmDLDAcYJEUBbPGgnEPFsmHDnNjtCxQbeZAdNDF150AVg8FArrOtiNTkSD
         ULHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1776703947; x=1777308747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3mAFaz01OOGQD2HIBzg3TVieRr1CUbn2sH0C92IlNE=;
        b=Qjp8s1IVKZO2RcYo6JhnTI8wdt3qCHOUNIpgdE5cQ0OvA4bYFjDpH6A7MSipWiEHgL
         smmbCyAx7rJon88HN3locegZT05t7O6EqsNInUQNzIM99m5cBE9JtZ0J5HETDl7S0j4o
         kPQhe6LDSxZrhSZvM5xcIYrDVXmA780ATRz5zFKmHkLFgl+dPebc7GwwJ0eJWTTiU9Fe
         gOltZLLYXPGQtwlmOrjIKGuMfjAms2ChGiedimGv2dPsoLOyw5riWpuSF0hG9il16Pl1
         Gq3wi2bM8bdZjWgQheki/9PzUZs8m5+l9eTrqb8ipi8fbrYrPVRjRqA2EkPBOIgQZgib
         KNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776703947; x=1777308747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3mAFaz01OOGQD2HIBzg3TVieRr1CUbn2sH0C92IlNE=;
        b=mvjxk06LmewL6MKG+Vz5pv51fspcn28fQGNYXGkZNryRBuT32oHlLkOBCuVFhoSiaV
         PBglsIn0z9NDtdhfp91iGf1ddQ6fTG/+RuvK78hj5r7DdEDuTSsTRr5vqPu2F6p9qzPb
         5gr3Q4+mq5WncagNO3XkeApF+1sw2xyJ/9FCqndlQdQMDPs7PhBbg+7HB1M1rqBXdUsD
         iKr5an1wccNFe9EFUDKhdEN2OtFA5sq1Drdg1b4u+ZgJ3129uCo756r9tt6Zg0SX8kYV
         Ufpo7Os6B/hWeSp8slIlij3tlEQL5VsVatl2cO3lQ9hQD9meRdQNIhReDLfz/FOAzWmU
         vjgA==
X-Gm-Message-State: AOJu0Yxwo1mCsTMtqETvO0EQj3y2moDVEH4iBPGX5JU/MKIt7wR17zdx
	TX3xLqtB+elwuxSFeQzCFS2/NVp4cfqEBPQtwO6HJNoHASlXd31nWmKzyPmJAnW6kl55KDzGWXp
	XdpviUc6MHxiBhnUh7mFd+5Svkcd6qwe/jttdNAeGc6m4cHZ+eJ/qFg==
X-Gm-Gg: AeBDietg2ShZWXETczq51Ne6V1lpBjWVq9LW51gududWQc8sKN2x4ly7Hap8YVsPVl9
	vV3bNgfP0fGvEOG/XdRDEgbRIjn6l2vfyiIeDJI0iXHwl8ZYJPKjudA5Mcf3QiZwTt2rTOxNUvP
	DN0FWcsXzOf9OL2uwOqb7WgB+z4SsOntYudh5Tnjqvtfq2biFG6iFDfS3b5ZTibqhpUo8guah+b
	w4ronoQ5SFu+fdbOnRevqCMklV4l3Fo/YS57qc2uzDklwGcXlz4Pnqq1ZylSsKHpWvCZu+vaOqB
	qt++a35rDSqOiUvPQ9ZirlaLzsr4l2qeskW6ux4xp6WdlDQ6UBwgPLx9sDAi9uUAZ1eBte3Cnho
	5b3nBBtc=
X-Received: by 2002:a0c:e00a:0:b0:89c:d7e3:7f01 with SMTP id
 6a1803df08f44-8b028175e41mr181561396d6.48.1776703945460; Mon, 20 Apr 2026
 09:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5C+AAp7MCCpsP+n8c_ghE-YkwQzy3d36jX9B1H3b+c9tg@mail.gmail.com>
 <134c80cd-1a60-4a91-b088-b4f64e4ce841@huaweicloud.com>
In-Reply-To: <134c80cd-1a60-4a91-b088-b4f64e4ce841@huaweicloud.com>
From: Danny Hu <dannyhu@arista.com>
Date: Mon, 20 Apr 2026 09:52:13 -0700
X-Gm-Features: AQROBzCph-kn1hJFKZCoZ1S4mVgjI7KBJn37whJ450rP4oIjmRlSQa2VyWxLUvo
Message-ID: <CAFn2k5DKPMJPCR6CiOsaLzxUaFpDm94CQveyJGr-nWiJeVuzPw@mail.gmail.com>
Subject: Re: ima: audit log emitted from ima_collect_measurement when SIGKILL
 interrupts reads from slow-read filesystems
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:37=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> it still shows an unexpected condition occurred in IMA. I think it is
> worth keeping the audit message.

Thanks for getting back to me. It's really helpful to get the
maintainers' perspective on this. We will probably just filter out
this log message on our end or patch it out.

Thanks again,
Danny
