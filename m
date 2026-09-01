Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060E43CE46
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278814; cv=none; b=dq0XiFGPHbkqjTLsedEEU4wWSXD5QwLMnt2PCq1+FVIZv2B89hhzzxycx8FCx/HFVxn1z4AWdn6iXWjbCOm7bgKYZKcpFeTa09qUCrMlpwa3NInOwk1vmXwDXI1waFrj4yIqwhE4lIlPWXhAuvbSS7Gre+EL58TeRFw+foo/EqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278814; c=relaxed/simple;
	bh=q44ZV+VsKxN6JVRQY5u21IK1dlCmX3i+WcEkxuAqjPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIQxRRpi/natnbDXa14fei2dp44PPpFI2Bowe5pCYfeHcEMTdQ7R3eHHkGUMrGxG03conbxZGE7YIELG/AT23JktK6VwZAaexYiwr8GRzW9KeBYQnPZIDu4nMiy+Mfmr2374NCwElw83QFhyxl9LLng5RgM5fVNoTe7s6nHA5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daRE5lx/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ozPbe9/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daRE5lx/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ozPbe9/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788278811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ePc7Ut/AZztzEtumFTcDNqc3j4BQeQVeG9iOBqVe9vA=;
	b=daRE5lx/lNpGb479CIkFDxKimYrwm0mbY6KKvUknDcyV6BldKnLSBOxVGCBEEl3OHFfM62
	VbaK6Iwf5f9GcwvwY2Cq7zPHDTLSBifVwpDJvhL31lIH+CEG8ZMtreEqrRA8PH+XOGjin6
	ABZQRI0IdZ/k6S1pvPQJaXDCvqM3vCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-YvRs66-tOFSasPfuoAR0HQ-1; Tue, 01 Sept 2026 12:06:48 -0400
X-MC-Unique: YvRs66-tOFSasPfuoAR0HQ-1
X-Mimecast-MFC-AGG-ID: YvRs66-tOFSasPfuoAR0HQ_1788278807
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4843e59c32dso26275f8f.3
        for <linux-integrity@vger.kernel.org>; Tue, 01 Sep 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788278807; x=1788883607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ePc7Ut/AZztzEtumFTcDNqc3j4BQeQVeG9iOBqVe9vA=;
        b=ozPbe9/5WDwGH1fWjT0773KwUQi8GCMJLM7ImUQPkyfOB79ylGpaYfaWDF1+01OeWV
         UUD2UpX/xC4K5jq8hPUC+MySGszejvApt+jNJJeb491AV1Pn+eTmJVn1hjiQC7z2YUFL
         WP4c0g1gtuKYLtWxoR3d+u1F01A18dQ4PHNCpfd/+dmQngwZuENEdRFCMq1SzRDkoYic
         NNNZePL/NFzY3ueWXjegn5hEwnWDwAIpRfoEAJViQZ6tdRqVxpFrf6O3q0jFaZFZj2Ii
         cxW3pewgwpPwEc4+Efyc5dq4q0lvqHaB3rEJ/ge4GZtra+lRAsMYJaxWfQi5Goktkc8b
         tvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278807; x=1788883607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ePc7Ut/AZztzEtumFTcDNqc3j4BQeQVeG9iOBqVe9vA=;
        b=pRUsDINj5+DTgmyFk2z6Pfxz+2bPVH/Xa2c77neNs1xou6855VSfuiJGMJ96lIxcwN
         qlNfOC7tOL10legrbqF77jGJ2zfvEQ8rhPtHx6AbJUzKon6SfJlLJwVoC2wbhPi9rLuV
         MfCNW1KUGkRHGicwlfglQuf4cOzlDiPdzLYu7/qhH02C6WEVkNnTm7rq9nqaag0/ltfZ
         L31bR3qMTjVxAcYLwf4PgyKvTo4iJ9o4kn7hVs5UnnEyDSt2Va8IoecRV4CvZZ+ouIlO
         QIJGENCHsooVKhWiJ4Yj7C1IjJcsZUpyNk6s4sz2SpmAN50QDOhru4Cg639m7JQnLaG/
         mwVA==
X-Gm-Message-State: AFuF++kbLV9Kl+GzILFKxl93Yyx8OCNREPkt7BF7g6di83U+MSB4QsMz
	0vAq203UNNiWEyZFaPS+16vRQeE4BigjPJkFhRTbV6TtuGLV5Dp9PtJaGRmvKATXDMlokDSvtKZ
	AtL3ByHFO/m1xBB3pv5RX9X3ZeidHyzje9tPxRSAij6AD85GQVWuDQTFF3SDCFZr51pGkzA==
X-Gm-Gg: AYBFou2ON/tULoSsHkKYeqIiME0kIe46UZ3gm3rJ5HxsX29UZzdINNJrt4AuJwOA3xf
	sNCQvoM5YSOKIXGDXk2fz4UIv5IlfsJWOTb99A89JLlUWxzCDDwaPvczE8HebS99ZiuFwX1ClkP
	MHDbk0D2hVfR7iQsTJnY6dNCRSwbfjn7rTeFN72blyGf8jelVzUkECcmBy5J8C6ok/lHmJspeUK
	OSsBvX9S1ToWdbjCg16f7L08/WcHA0fVDdtq1zTSVcJEmVmYQ8J0xQTy/j+mDADYe8B8AG/vWoE
	ep54VQW9N+9tUfvJmVsiDiDzaDiIxNCKzKDPBDTCHRXL0CuAW2110u4X5gi9sasW/mMpi201eH0
	IIO4dpTl46Gim93HfZwAHg/VGOANjzvIHHPLd+26+IgReXg==
X-Received: by 2002:a05:6000:470d:b0:482:e8f9:c6b0 with SMTP id ffacd0b85a97d-482f79b1e7amr57844695f8f.13.1788278806701;
        Tue, 01 Sep 2026 09:06:46 -0700 (PDT)
X-Received: by 2002:a05:6000:470d:b0:482:e8f9:c6b0 with SMTP id ffacd0b85a97d-482f79b1e7amr57844520f8f.13.1788278806034;
        Tue, 01 Sep 2026 09:06:46 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d787b8sm5977548f8f.29.2026.09.01.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:06:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 18:06:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Stuart Yoder <stuart.yoder@arm.com>, Chu Guangqing <chuguangqing@inspur.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <apb2LdIAqUHROYBt@sgarzare-redhat>
References: <20260901142955.187856-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901142955.187856-1-jarkko@kernel.org>

On Tue, Sep 01, 2026 at 05:29:46PM +0300, Jarkko Sakkinen wrote:
>In all the pre-existing call sites both @iomem and @iobase_ptr are
>either NULL or non-NULL.

I don't know this code, but I'm a bit worried about iobase_ptr and 
*iobase_ptr. IIUC it is true that iobase_ptr and iores are either NULL 
or non-NULL, but here we are removing the case where *iobase_ptr is 
NULL.

Now looking at crb_map_io(), IIUC iobase_array is initialized with NULL 
pointers and the code we are removing was the only one initializing 
those pointers IIUC, or am I missing something?

Thanks,
Stefano

>
>Thus, add invariant for this and remove a dead basic block.
>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> drivers/char/tpm/tpm_crb.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>index ceb4100ba400..e7a61f36c58b 100644
>--- a/drivers/char/tpm/tpm_crb.c
>+++ b/drivers/char/tpm/tpm_crb.c
>@@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
> 	if (start != new_res.start)
> 		return IOMEM_ERR_PTR(-EINVAL);
>
>+	if ((iores == NULL) != (iobase_ptr == NULL))
>+		return IOMEM_ERR_PTR(-EINVAL);
>+
> 	if (!iores)
> 		return devm_ioremap_resource(dev, &new_res);
>
>-	if (!*iobase_ptr) {
>-		*iobase_ptr = devm_ioremap_resource(dev, iores);
>-		if (IS_ERR(*iobase_ptr))
>-			return *iobase_ptr;
>-	}
>-
> 	return *iobase_ptr + (new_res.start - iores->start);
> }
>
>-- 
>2.47.3
>
>

