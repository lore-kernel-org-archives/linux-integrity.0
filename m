Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5512BE639
	for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622059; cv=none; b=TN/0nfKJaixWfjaNNrNyGww7zw6l8nowA3xt/XQAoM3Ee7DZLtPWntegqzkUJQcxrKCkAXtBXcc1Ipka46c/WBd4Ms+Cxs9HrJ2m035yxWb5GvX0QNymxXcksLbhpLD89qEZnDfhMrCOeOUeF4/E5k363ntuFfit4txnqR0kexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622059; c=relaxed/simple;
	bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
	h=Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type:Date; b=VxGZzFvBHAoKo2Qu274S4d9Cl31n0mwX0RXklDOXgH6SPaZM1ymb55vNauEn3u8sufuHYiu66+6AZfnEoo7LZh6mHgPANE47zPrwElFYkgrtXE4T7B5SqIy/o/DGjJB7ZZYzpKlUluxGZeLXeVmqu3A+k50rmLROHs2M/E+Cw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SuhNrP93; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SuhNrP93"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so5730435e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786622056; x=1787226856; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
         :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
        b=SuhNrP93AekBoWo5M8umifdELwhfvzblw1hnii0mfT7ZMOP3aLcyrjzuRHJi//YHjx
         CJhvApE3VDtehfigzBOJ5wqgofwAAFeAH/2uBDqGBD0KVbgR2B4DF7vAZu0FcPhDhIOZ
         Xt6AUIFMNLwsgMbv++evcI3+K+h2VWQesAnpJXQID0pHEg00JqbhrG1p9uLLdppnoylR
         JSKBYMfoF3Uwrh2Nf63nQeMS/seD3I/I5o5+JyabvzxObi34dXEtbuPaxTqzIUxg6q7V
         IKSOiLIJ+wMA1lbKoOHgGRkUyoAFc8BOOc1wYAZCA6WJyRIJ9r+HptT3qs5hLSidCptl
         QV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622056; x=1787226856;
        h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
         :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
        b=ak6DiQvrg9Od6I1Gpl+Gr4/tfCQieOCq+yphL93sHLo06SzLK2lKIWUXq6jIfGorzh
         XQht3Mz1bWeh1UFmYs9/ROiLXvnZoYBO7LSUKSa0Y73t2+yNnD0g12Ouj+gsh7Kmtr6q
         ubPQJfXjVAF9Ety5Mj/Rk33r0JiauZRwV8Ra9xVGT3TWLh9L1sf1ZQQZ/odrZ/iZM95A
         7nVTqO7xvGYpkLxshCXz0hewrAkykc0Ay8GRP6nTsV5STZklk2RXd7d53ytcwfVDCunn
         KpnTSPchp48+A7ZNLjp1wZIjHqwhfMozYYUiTbjL+1RsxPutn3ylhYNVogG4KHroGcnV
         hXOA==
X-Forwarded-Encrypted: i=1; AHgh+RpRcm3P22BkaHHShANJfZA0xMK5sONnqINweiwBCuEMLWjMat8IsCHZH0kQmrUqb482wzqQ+yGznBAgTs5Zxns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+a9/6jihuXdzZekcuC9LgIf8SUM7UsArlaBgN9T7TeKEKaUP
	1bYGnLfqBjTpYYlPiBfMBUCaPBlGbbEZSapMGC+xLVUMPipamRG2RARe2JF67pkMv7g=
X-Gm-Gg: AR+sD10tB1faN/8I/Y4/gvhbgDQejxjsiLQ3G8H61eMjYGTPLHz68hvz3XFmxpXYY37
	HpQ+JDlcFTQHzBdPWrNxJkh+VDXIM8WHe5g9HSVuF5iqMzDVT7YjBunmCSbuFEAhbJS+lBwp/cP
	/lZsnR+Wz+Iq4DjWpqcR/N8kvbYTRxLC9yKvRpsJxrNBkW1NVZd0w8My5gb2y9RY0m8Ba/br0Nw
	3k+86V8+mNjC8skrT915f0CXdblrgs1Uy0uAyDMAZV1nB8teip3Pxnu4uMr+ctYTYLUhrIwfwtr
	P5RnRDDQ5p+7iQIyZ73YCSiqF5zKNhzNCVZ73LqS6Ag5+Zu8/sTTMd9w+oNud/8spbPD0EWosZT
	W0G5Hd842AszXAQ7UAI4gPIT3Zuqpf45lNgF0OUw/ZWVsR6Ypqo1zYYTeKRxOGkCKx2/BKwUUXq
	C+kcbq+m2+51+fj67TuJb/hp2As5KIBtjPd3NbbSGfgIVTFpAq0PPW3Vj7XfZtiUUDxTdnIq0=
X-Received: by 2002:a05:600c:35c1:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-499821bd037mr67274325e9.3.1786622055871;
        Thu, 13 Aug 2026 04:54:15 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b03cd0sm64515475e9.1.2026.08.13.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:54:15 -0700 (PDT)
Message-ID: <6a7db067.6ab3636b.258558.972a@mx.google.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
In-Reply-To: <20260813112524.1849695-1-pvorel@suse.cz>
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Use tst_umount()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Aug 2026 11:54:14 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com
