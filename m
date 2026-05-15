Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E8404889
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879731; cv=none; b=LCWfFE0kVHAwmFqvLZ1GF9SAM+SHDkMbwsIFq9okLaaOrT8Ppm9xmqKIy/M53emcWYDeLT1ohyHbFUMT3Vk3iD0/nFU3K/EN/kC8rEQFM0iNxZKE6od9FK8a4cIVhFRMs2CrQ6CZtynmzGz9O2Wa1RGPhAbSQt1kYsJ2hYIHV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879731; c=relaxed/simple;
	bh=kbvK6cuaNQpZn6Q9g72Q+TOpf/2ROUnAJihI0oZoubo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXxa+lL76pvLTsaTrYRbqID4PSBUfaxVoVEj/+GjlTWDm6w2lRtz+jESTT6WI/6QB7+ZbLV/9Xz0r/4AUpqlcOk0hUlTT72ZbSdbgYJ38BqoDdSVDNx6sWF27hdMqkEUc+qz21kLmT2y4DE3WhwRanw6ux6IlxrYRwrwt95nGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9OputCr; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9OputCr"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso374975eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879729; x=1779484529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=o9OputCrmArK0qB9XWlHF/QKy9zlHBWFInzZrLIt4PpmYMpSYUW/atSgYmLlgUM3f3
         XQigHp+a4Zv2AXXBarW6f+KVLGlpORIk3Lz9XpkEPVhgevaX3pNxUgtWBbvcp0bd2SOT
         bXAHdAnn35Nia+1dkLc0jWevh3S7Wpl0bpu8juF223uNnqlu6TjcLkJ29SE3/imlzEsJ
         qrQ0p/s8SbX3PesAM/CSUB23lxUVz/gXlmeAStw17Jra8vDv4spFo+sgBeCI+aTcdrG5
         4KPpFb8pNCMi68b71RFVGuY1sy7Y+uTy06kpVfSsgaeC6RLXeGW1CiQT8dg76RfN0yjZ
         jzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879729; x=1779484529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=CEqj8BrlENpU6A1K9HHmzdLiYAh/R6cpGO2hIosQPjCIedBlhsTylc39sBBKAm3f+j
         /OR5Hm3cy58K6bf1eBGTCatDlf2rGxes0Fx5jfFOiv7QWGf3jlnqBjx9w6O9+63+vrqJ
         myg+/M60FwvlMx1DQ2mHzcAxY1+TF5Sr/WABPAKPGVMShc/ekPdIQLQPUkXCiL37DUH8
         h9iviqf59UQnL04837FwXbefIn+W7BvXpNpA8hpeOWD2jZawkpICq/Nrkg3S8onOliXT
         zlNkkQBbfwhb+5F+SRMMsYhnK0kr/yB/N2Wajq15FDseFY2PQY4ZgBx12B+SsllPYW2M
         UZ8g==
X-Forwarded-Encrypted: i=1; AFNElJ99oxKpNkXkTkbf8obUm+8EU3U6uA/D+N32BGCX6Js+j5H+eEN+MaBKQj9L2Yz8qcs63RAsWqkJ/YLF9qi0Hnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkElWmkb4Ea55O0Zg0gBJMJjXpI/ZDuJ5cIgqJP710ZLy9zoJQ
	Yuc6b08MwF2Z+VJEI8wX1aBsO6vGr2vUU+JFhyfT2own47qeou5QsJWa
X-Gm-Gg: Acq92OFND7RbR6GZDhoZwXQi7RBlLB+v4zlst5aQkc9BiqdJgH3jv5MjmHT4jlIzv8L
	nkxHsbkb8V4UvEKKBf72oyU43q77JSHS+DSZfXOppmA6gKCrlXo/FcM+Bax6b+nQoUVEU0EH770
	YKK87lchINS1HTeRbeWE6/nSSV1h5tDItvlGav91hAdBlkXoN0IgyW0KUXm0m+obYbVWjkxhYKb
	jGWphxu4K2mPUu3G/a3NmR87iG4wCW5WtkRhKi5SRf7r67ZXPs9wV4eKOUsYgIjiDnJdJnYnEz+
	ckz7K9agxxjokLJkkj5nVXhdmKMVvgYRjAi2Jz12hAz3LrNmwZmk35ixpFMGeccBWcTDrKzel7U
	u3476LdZ/MFDgmozRaUiOFRFwKrCvvembeDbOdCYpceZB6uGHHhFPssN7HqhTyiOCvNsE6GQfHi
	Ds0A+3kdZVc9q6HOYPbVPNx4nBpYrezCI=
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id 5a478bee46e88-30398618b3fmr3091136eec.17.1778879729276;
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm8268038eec.4.2026.05.15.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 27/38] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:59 -0700
Message-ID: <20260515211410.31440-28-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information
into the TPM as early as possible before using the values. This
implementation uses the established approach of #including the SHA-256
library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha256.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e283ee4c1f45..071a90f23ae0 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
+slaunch-objs			+= lib-sha256.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha256.c b/arch/x86/boot/startup/lib-sha256.c
new file mode 100644
index 000000000000..f60df97f9244
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.47.3

