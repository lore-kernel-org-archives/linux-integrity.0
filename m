Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E62628D
	for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468802; cv=none; b=DF4QcFmZa/niIARq8gt/6lR3VU5WrU9Tf8b8bq5r5jITKficwE2sj8zujdr5LZ62fO6soAzWUYreA6nyg0X9fOQh1yiDweAwn0KqnyCMo09l2KCXc4O40KheupzU0IwwcQ6Y8Z8jBRu/jxjqrlGKTKWXfPvscFgCBri9AlHup6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468802; c=relaxed/simple;
	bh=yuSs65kmHYr77xDwVpF4Dy3q5+xnqgRpHPWIHPWI4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2aYTeorn80hQNoGs0oAFsgpaeGpT3vzT7zBqlS7eHY4wbZRSvHxciHmH1sueNgO5g2mb1DXt4lTGNy0Kl/LwaiScJ9wSrTLaBNp/fbblMqf+nfKHFNY4QKmqmRD4AHoZSzi9DRfMg0Ir+E93uwD7LOr3leMc4GGY0esNR7qBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WN7bSlcS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WN7bSlcS"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C37BC3F290
	for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784468790;
	bh=uze8fnz61OwWI97EkVILqYaHqEWDohgXqld8ghdnvzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=WN7bSlcSuCiomU1z/KveXFjFOzBLn96ihy/p/P5Os8tvcPYRCh4L7zSHmvTT7VGjw
	 DtFAgqe8N0cvVg067GIQk9AS/Mb1eJGrGGrm7puybIGd78BMoHj3SadSppjKtJuHN5
	 s6IIiltSBbX+te0TdKCbly3E/rXz8DbPZf3PesVde0CAEKIEkqR9g5cxE15A6G8dt+
	 l7IeoAt2LHl2fRxWowkswSY2PU3rPYXDoOEDAGdz/dyHsSHDjdWeE2lTZmW10e0T0T
	 TLAnDtLwdYwep4R3RUuXNtgXnQeNoGuIfjJAB5S/8gwHw7YnQCqcOCntPEsPuYisCR
	 E+7FoB9DhcITILuztedsc7yeHDkId1cmR2JOuoScqjwPOKEYVY2Hf5Ut062JyS7M3F
	 1i4m5v8pdlMeQW8lLWfcFxjIsAJ/0JWRgM1zJvA5j6OhCcIQwnHX0+ba/Yroz3BwKS
	 H8TtFJEd8zJ/1K4QP6e9cRHstOS2GGhIFqR1G1zyxTlZYnVae2YQpFLdcGGl3rtMvy
	 k/PDC3kr2raPBMt9/6XbmClgB/5JKm8444EBfD1Xnc3MOBYWAhpAzK6KHkMImMtxrw
	 l74woXUmKcGOz8Ha9Bvy7TSFK77wPjDH/i/N1+8i+5S/WMgty8V43x/Np2BUSnpCdx
	 6+GjwsBYqf/QInEjQnGYuiJY=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47bbe3b9705so8353788f8f.0
        for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468790; x=1785073590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uze8fnz61OwWI97EkVILqYaHqEWDohgXqld8ghdnvzI=;
        b=SeYY8VL6hZ7QgKwVX9rkynZyxfeATM6p0ScqFFInx5NdTc5p86mR/DPtO8D5qonPUA
         55e6sj0vLElc1hXhGMxrU2O+P9tZdjdNgftytwDGPjVYZgpK0I6WOFBex63HxaLw9Q2x
         J9YSnXN9l1fcIWSxl4kMorKw7DHKjPLIHPW3JPfkC5pi8CKlW2xLdm2IgaDdPGEpyYMe
         bm8VIwbqHzOXqOwYzXBKQsZVeklr2ti4szHF0GT5FEtI/wn/plqA39691/KqKpWO4eMM
         YRP2O8VSd+iu38fDpE0NNgq1PtqSZ6OrIPbG3yka852zZwpsjVHw4qgo3RyAlMLPmpLe
         c0RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEt6gcmdcYx8OmSYl+SaNYRYY6mWr+QuaBqycWjGyaAD7h2/dU0FDVfYklJN+cvAUA+92Xc3EbYh4Pl9/xPwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyciUpgqMbDulTl7Pfd0srhb+cumQKAd4rMAVyMWuTTb7WPUxVc
	HQoFjFcHMWRBcM9ZJOHbCgSluJiAsGGb7h4W9wsqhRR+tWKGacvsZb0upqysK5LE/COyuVm86CN
	b/2KbrIRYB7opbWrODOconf8qtglujpDTdmD+ywDCsyA+yJ7RsEt9OmI/SMFEoQYI09mKP+l0+S
	33/hyU46siEA==
X-Gm-Gg: AfdE7ckvNj5I5gjlXD5r1YrBsMson5v3VlsoMB6sIITaZ1Tgl5Apuzah7eEivPpUVI6
	jd6/MqaDPa7JlPdK1Po+dGewCdJ5WeA2H0PJrI+3zyJmM+rJ9PxFEodlbu1j4l2DQIRtI7L98IQ
	1qktb2Wwwoy8s5SpqM4aFWbx6amlQDkGbuI2nTrVt7yYDOI+QlnOXk6QiCpei0+zgY8mWq2hfE3
	zG7xlCRcf5UQ83ENVsL7cUXwrmXdlGcDcQuQZhp3lheTHDqLMMuUWTN+kSP+U3nSabSPsjjMZ9v
	Z5YooHn7C8YmnWI85TnI+kfZWrQDEPm+1EUps0A4FzXOkA7j1wjdGr2RgFclEZ2wqaJfKlU8cvR
	ynQ5l1wNXbhVXoURHxNuMy8kU/u6gdFOVn3dvjuAPBayywfF+y9oULSPCrkDYAvuvuSx2gVb9iD
	JM0YD3+PlN
X-Received: by 2002:a05:6000:4916:b0:478:2698:72f8 with SMTP id ffacd0b85a97d-47f62335823mr10580107f8f.49.1784468790258;
        Sun, 19 Jul 2026 06:46:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4916:b0:478:2698:72f8 with SMTP id ffacd0b85a97d-47f62335823mr10580088f8f.49.1784468789897;
        Sun, 19 Jul 2026 06:46:29 -0700 (PDT)
Received: from t-14 (lfbn-idf1-1-452-109.w86-242.abo.wanadoo.fr. [86.242.159.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed244asm19771318f8f.20.2026.07.19.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:46:29 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	david@sigma-star.at,
	upstream+dcp@sigma-star.at,
	zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: Re: [PATCH] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
Date: Sun, 19 Jul 2026 15:44:07 +0200
Message-ID: <20260719134409.3336365-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alv7LVoTQJOMyk2J@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 19, 2026, Jarkko Sakkinen wrote:
> As said, code changes themselves look reasonable but the commit message
> is painting a picture of impact that this bug really does not have.
>
> If possible strip down the paragraph and add fixes tags (if possible,
> I can dig it up too). With those requests send v2.

Agreed, thanks. You and Richard are right that this is not an
exploitable OOB due to the struct layout. 

For v2 I'll:
  - reframe the commit message as a correctness/hardening fix and drop
    the exploitation and "how this was found" paragraphs;
  - add the Fixes: tags myself (they both trace to the DCP trusted-keys
    introduction) so you don't have to dig them up;
  - keep the code changes as-is.

Will send v2 shortly.

Thanks,
Fabrice
