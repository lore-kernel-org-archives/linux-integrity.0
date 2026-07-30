Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807E3B058A
	for <linux-integrity@vger.kernel.org>; Thu, 30 Jul 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446164; cv=none; b=XwsNsTFr1E2tTJh/fjDel7p12gTyY73Jv310ozulGcr6idd5l2Nz/h9dL2guVcKCKigpU8iK6ls7R0Kf6o3rE6UkdVyaeezPKrYNFi+TwTVQADr1oGpLn4I6IN8B3vnI41R4YZtImZuXtrHdEIGtAK1P+vZ6+/vJGQwR+Gi2b8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446164; c=relaxed/simple;
	bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlJFhe1UTXJHAQbUrcDwt9meYudkkbktEXh1wRzO+N7PJd3r6Q2c5YZScGBvbpCuF3oTYPbaz0btl94kBlR+CG4TrjDEoGB8a+QLJs11JGe2M2krsPG7IRmNaUSfy2Kj38HdbTAzhNHniI+7YKpuetUIOa1vj8Kk/yoa6Y5dxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdANWppI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdANWppI"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so193647a12.3
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jul 2026 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785446156; x=1786050956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=gdANWppIZaHHVrO4NaZ0vAnYOeETJRqHszRJALyTxCLTqgXFXrtYSNK//frvSJEA1M
         3XJJ9haOTo6G6TFEVFdIkZaz52Q8g5dIQV2bVosoXWU/WWUFW/93r52sljYl22mpBKl/
         2MLJqA4PXP/ZhvSSifBMiJxZWjtupSytErT1RK1s73DP0GXqpIkcM5CzcKqA+eoYZkU1
         8HpTUNx7+9bcYo5oBcQR8sogLak4n13pvrOpuY+MEVc05W3e9bhnbfFlWDdj5mvoouCI
         HnAYRTRyxcZIqKGWZbU3wEQlEpc7dIhx8SWOIQw7iUrd9xDOnXw6dWZtVg/1OHfI5+BD
         2i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446156; x=1786050956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=gF6pucpQHwAAPlK5rs/88j3LuW6zlw71SgoR8NjFgLLogdVoZNJq88iVY8t4eytYex
         0Hnj1usKdmiCQpvl8YZOrxnmtUk6PaP/EVMSWcyjjydQvqD4gt09Ay+VNXYEm+Wv9AnD
         s8FgSusj8nz4Gnc7sH32Jhvz4rQDJsexBCxaZY8IzxnmGuuzcvMfZLx3PAB7paZAdQzp
         Zj941rhn+hNYL0jiRbm7h3QYu/EYwGOArt6Q115yDwIXQ8/ycUBJfBJtSm2u/LOA+x3N
         ZTmvgA7TpnlL7Rux2/BCsbiYUQoSbEOeqZrdOyKFyxDiXyvQxGIxVxgTOU0IgXq957+9
         XSmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1YCHNTgsVbQyDa6CN0bYiwa53bssrFvTBUDp6Gl5oSwzLNIBHioLBN57NA/V+eQhGjWb/oI1PuOYh8JWq1Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUY/0CBGARbfpZ0fS5OxlMvJdf/WLXpp+KDJQ/Q5rg5xdsmzuc
	9d4pwAf3wL6GTie5M37uP7MmU+Cxu8gpZGsLYpR8QKL0OKyJVZ+9j4c=
X-Gm-Gg: AR+sD10TVA1xRD9CNJFqEuCXxyPS7YeIsCA9WC4+DViCv+y51hbkAIoQ5PMjOnYZOb2
	gM4gdhF0PVxDKBglTxKr+YsLPNXLhd2Gkdr0CQlBgjS8exLGHSb7VHfQUcT6vNwH2tIviSJX95b
	/9fb+xyhDLlpWe7V184tihKFo+bSPBK+pA9MLtCgc0KdSJotiHJ1XvLWOHeTPWQqOSqEkBW5BYP
	5FnPPvxsKiNggjLrsOSSuDpUeeoB+Jw4PxwiNmXc9oLDiiw6FChseIiGu34BN+3xLysYX+G+Sb+
	EshPUvpqOMaw9GXp6yZ39HDnZkl83PvaNPZZ2rOqd9tibH0DAT64RpjzEzY19Pnf2wpkCaDXJz8
	JkGW5eaPcMac1BARenykiBUEcqEE8CP9gJNwuRATS9N4PbQdJ9ZORBGaGJO0H5setvZQ9KjKI1n
	4k6ZL4uA393Fk8FDIbyktQ5ZVYPWxQCTHZRELA1fyde31gcEgkJQnVc6S+XAgfpk5ruSeUfbmtQ
	YLa6gT41xnAOf6LAnIjNqj/R9CWkzjq1k+5QQ==
X-Received: by 2002:a17:90b:380b:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f9c0abaecmr3050277a91.40.1785446155807;
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.221.78.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7263cfd9sm36251186c88.4.2026.07.30.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mingo@redhat.com,
	paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	tglx@kernel.org,
	westeri@kernel.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Thu, 30 Jul 2026 17:15:42 -0400
Message-ID: <20260730211542.1422-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113209.GF20844@black.igk.intel.com>
References: <20260730113209.GF20844@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Agree. It should be preparatory patch for the series.

I think ur ideas should be implimeneted AFTER the patch, because this
patch adds a kind-of important feature to T2 macs, and well ur ideas
are for code quality, and well it takes time for patches to upstream
