Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814334071DE
	for <linux-integrity@vger.kernel.org>; Fri,  4 Sep 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520159; cv=none; b=uxdajQQtJKpYTbnVTOs/0D+rAAGMcwo7g18doVCxNaCSgX8Tpc++MtP5LYbT6c3ZXqFCpA7Uq6Kx7sgmbQmWiykR+44WiOJRdkv1o75iCTeJcy+A1ldHCkmB9JIxZdnWU7GSetvnbbxfR4HmWphRhiSwd5ZKnWUS+Vl1/ihTOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520159; c=relaxed/simple;
	bh=YaGljnvWoQzIcgOagfuWcy7uipn7G4q/7MezpQpALh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iafy2xz6oLZUMANsXiJPgvGj9UrHoa+fhVRJsp1TAKG9WOeodpXmvc5fNlcPu4ta60dbtnjC1juaX/B4LaruiJykTX3RPn+AuKAZ4L3EMl1QxBq1z2hEceLcgka5LAxNjNXYKINgB1C5AP2T9oloDpKl6u9oN3O2VYAHdjWpdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcbtlRDy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcbtlRDy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e257a23aso612444f8f.0
        for <linux-integrity@vger.kernel.org>; Fri, 04 Sep 2026 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520154; x=1789124954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7gzrdcRbZFNkipzgWidgs+ChixBs5c4oi8w4Ru76NQ=;
        b=FcbtlRDyNfZpE9lJGApjudRRXyrPEQhedXkV3j77Kodp2mdyfge1KZV5G2iLu7C8Yo
         NEgIYMlUolfPH0gpdtRHRh45HG2BcUV2BgItNo3GTD3ipV/R5cxhtNDoaKOANahy2kSB
         uft+4KSVQ3V+3zlDXgPINn33o9cKV5SfE12eCWL87D7I0pcqJB9lFVFewSQkU2XtSMzB
         YAM/mWkkPCYFvtVh1w5BBXTxkJoBlB5MvbF4lj0e7upovVFgTWXdISeLn2u4uPFYHKiq
         rXMxRoFH1gg0KQpHUZphCKmOmJVlslTV9iWRBz8UxI9cA4vKScxAHnUsNc+yrXCxdkUw
         i00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520154; x=1789124954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7gzrdcRbZFNkipzgWidgs+ChixBs5c4oi8w4Ru76NQ=;
        b=XLSwtDS5lHRuDSbGYPFJXX1x2k0o5oEicJXWDVhmvyNCeFQkMgH5PxyqpLOzPI6Kqr
         lh+GULmm1csvzFpUhF2MGzA002kq+jfUVR7o++pnHt5enXxh4PoLGqfXwgq9ImHGFE/4
         wvj5S+tHBLG+/Dq0reUPwuKlVsidHwQ1JSBSNfXTaCEpTwvd8FbioCKVvCSjc29SpADD
         MG1+gX0azZ4G42r6776ZcHXuVYhgK8e0x1z92i/vsnrgaJVTp5M16x9tyE0HCefelOPz
         CFGTYre9gszLM4TEa7NMV/gQdXBc/YM54NGlOp8Nx2IqLn56stsRhtYu0DizZMuiBmzF
         bnfg==
X-Forwarded-Encrypted: i=1; AKwUvBxvpk2zzrkjsl6Svp1cURT6fy/fj89gm+7gCf9t9K6x2ibsaA2+1Y7wZvrrGniD/3EM5PxJ/Kfq1NkD99bY+LA=@vger.kernel.org
X-Gm-Message-State: AFuF++lmnJcTMCyThW6W+IeLe9wSzRsgJjYImD82vO0u4XGa9XxRrA+x
	0wpoI1Xnv8Bsc+9edCRqLF5CFY1xKrrJkkUsnHKcnTKwDvvmOz64nB3R
X-Gm-Gg: AYBFou3oiYuWHm/OBa95YAaZ4C3/gPt6SQJx5VPY2zVygTm921ZDa7S7E8JUXQ8Eol0
	pcihZldopUL17+jhYt5gpW7dK00P7shEGr4JqszxkSKilwmIOf4/Ed0jY+oCzbVB6u9OcmaP/2j
	ev2plbUUiXewcmfFLec+D8NhbzJ3Lg5MJ/KGhyc24sEOLhuKy6f6/ZnExBUb18EfnZNRzOBl2e0
	Xbu11fMhHGYhyGLOe3RBCZ+0Hs8TyjxkTBzhzP727qXsgKWxo8Mk0FtKkEWKivc2MONSUeoa7PQ
	oyae/0EKTcu9uYXNeJxCeZ1T2VBzw8TFsTIX0zn833/eO+QbGXKhtw5ZLoDNRFqrsLn0bWiewwi
	CLQxrca7UCrjXyKv3x38Ql9i3XSK/DcBwXnQwQtZPxot1P6A/z1Sd7RLFNq5/oh5wtrNzovS9xQ
	+mcaKDkam7UfrWTk3qa6xhXP0IqFBnpbWUOOTFeEZUK6zYrCCrPAIO1U7k/NQeYzXmEar7I2rKX
	eBAfQ9PNHgmxR9LOLh44t20M6Z3m1rGMdvkttFJqjmKRSsFQooW
X-Received: by 2002:a5d:5c82:0:b0:485:8a46:b3b5 with SMTP id ffacd0b85a97d-4858a46b479mr3503706f8f.29.1788520154340;
        Fri, 04 Sep 2026 04:09:14 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm5426934f8f.21.2026.09.04.04.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:09:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] ima: allow users to specify the pcr index with IMA_MEASURE_PCR_IDX
Date: Fri,  4 Sep 2026 12:09:11 +0100
Message-ID: <20260904110911.4087260-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
frontend, so it always uses its default, 10. This means that the
'range 8 14' is dead code, and users are unable to specify the pcr index
value.

In a previous discussion, Mimi explained that users should be able to use
this config option to specify the pcr index. [1]

Let's add a prompt for users to specify the pcr index, when EXPERT is
enabled.

This dead range was found by kconfirm, a static analysis tool for Kconfig.

Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1:
- updated help text to recommend using the default of 10

v1:
https://lore.kernel.org/all/20260824162215.1572367-1-julianbraha@gmail.com/
---
 security/integrity/ima/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a9f86809b0..72654cf797cd 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -46,12 +46,16 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
+	prompt "PCR Index for Aggregate" if EXPERT
 	range 8 14
 	default 10
 	help
 	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
 	  that IMA uses to maintain the integrity aggregate of the
-	  measurement list.  If unsure, use the default 10.
+	  measurement list. Most attestation tooling expects PCR 10.
+
+	  The default is almost always what you want. Only change this
+	  if you know what you are doing.
 
 config IMA_LSM_RULES
 	bool
-- 
2.55.0

