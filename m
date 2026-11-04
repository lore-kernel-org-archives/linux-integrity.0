Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=Q/krW7zehi5jfP1Za96/bhGdHKEdbvJZ9gv5sFpsWFNCQWzSuBQzCeZpEx69xrZoqlgs
	 db5+X5uJ4tVO3d5zNgyan9NIeD+vJGyEk8kpRfYNF6QjPa3ampYNdn9FYzROmJW0cz59h
	 Tt0ZFqktfgOUbxVq9582smj1GmVrL7C4sXbpUEKpTsO+ox9xzHifdYmKKgQKBru3oMIRb
	 mxD03TW1qpL4joW3IzaAIayDgTnJ9PQ3gdjLvloxXtX6c0JXlIRPVTLFzeNemAr6OY/O3
	 ok2nFqtPqoPRnzOBRcdpNbThQwvd1b/GPLdnLoHMLHIJTaW3h8ZkejQnTiIXuoLj33w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=1IYkjFGpCLcxxtZijrXOIC240uFDLOZtliYQ5zE03h4rlFwHrTYMDReJePVfcGu46gDj
	 4uMwGPqnCTeie8+Kw8uzqWIKYMEOC3c57+qKQRqtdl8/yaL6LhelcqzN39VdCQYgTD7A9
	 Efp1cPLHGFAsrptPK2T5Ftn/Dap5u3eQRabOt1uktzkZQ1mcmvDByRqcw+YUSOBnTl5or
	 ytJc/R2kC2FynGx2dyrJ3oRxOIEa3LDEq8xLa2KEHPkS8MPc1QA84f7nob0CCYGGM2Qib
	 4GXr2+Gh9E9n73NGPuIKwL+mneT0KKDc9sbJDeVqXyeHsOs5a1gn4v9fcimXDYrVLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7320609765D
	for <linux-integrity@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7320609765D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so1943077c88.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=pERCtvEVThFct4PYIcCOORShZbXk1o7lDJKEVPKZQ7iMcfd/rDo+scyEIVNDnlYL2G
         C/uPrqcAWlnBz3ujwOKe8EYqNX6hMSbzRch/U65mweLfy58I9aLAZ4/qETtwmXKGbn7A
         XB4ORZqK3x4gZnNNMzm/sNZkBZfaeAbM35z14HTawPdbKChvQbxX5lcs0Pe0eGQZ8kUh
         Ss0CdJo+4n8BEk7zyioYtjyZeKJizZ4/YsmHaPqwVa7p1njgRahhJJy2/4EpT/rFCrgv
         Eu0OoUJ/wdkcWg3PoOm8OfpJ2YSeXe2mG0FnuMZyNVedu/8qzdwPvDuTLuKC+MX2LBk7
         L2yg==
X-Forwarded-Encrypted: i=1; AKwUvBwoSJr8uGzTu+1AjsrwTm/n0afGVdKDaY/UEsLgBrUvEgoAFjE8myNHgx9bu98YhbTzT9G7rbl7PyP2bROxDdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HeVEX/1wG0U8U5p/6CmHhuE55yqymGb1q4XVqIG67nuo2wvbv
	o26ReCUwNMs/KV5A095/DMVFhfB9q46yOa7AzZvmyfo9fGRII/UpFf4=
X-Gm-Gg: AYBFou367NGWj4ekuJcnwkqMMhXcYoj8akoA4xRThtclnIwIdlf6NJQUKZWu60cXBzL
	PDgzMfIqiY8i0i56lJc6CtrOIJ1wXtu0UYn132NW5U9whVP3HJBOod8uZs3UdZWzoCQoYs81F8J
	ia1FlvGz0vZb+g6GV7qSBpA2mTENRitkybo81+qPwyj62VPA7ujIRPxjevnLKMF1YAu9PlQEL0C
	dzn+AE5cpNF1QEvtCY7ST2p+Hj6vhlUAeUTPUp/yYzvlyzUPQcUdlbB1DARn8um04vIupX5HpfI
	156/omzX66+zYYo7bTKdFl4SSTyCaiCG+6S4A9hFe2J6blMUUgc9EgIe6PHz/xe2D8uT0sg6nCi
	zzQX2ZcWCCIptLH3HdxTNZTZ5FSF5kWNpMyHeAD8q8jF6btWY5RpYwQwDQ5SobyacxO1DTbLJzm
	xdzOtFYWszl79/JeQnsb50MY+lDFOr84ya5372KIGMnxTvOTv9+npvG2/nWsxAPhIMJlNzOdRSv
	EXN3HGnVTQ1Kh4ag/lQt4smbWNp1KalyEHD3p09tyPsB9obOttVB4qYeRuEn/gPVdWbwIrpsay9
	uZyONuCrNA96wlusz+7zIMQMtMhjbiF+udIwaVQdpEXitr/mPLqTTXfFVT6Xm+Js
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
