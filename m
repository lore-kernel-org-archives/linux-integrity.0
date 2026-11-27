Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741296;
	b=x8auWD7+o5cf0ataILZzVu2L/vs+6xSw7NcziqisMpADSfkJiZZr6K/k8pRLoe1+Pc25
	 3giDy4KUhzCLGlgl6nyXXbCLE6H8ZCeErPuiCHpCA7mxCN3LUPd0O4xpa+4Yz0ouqMcOi
	 POl9y68YpId3ros9wWC2a2ej2tiZVYKB/062teCjnCYD1qjj5VGEGINp97x9KCDXpu36F
	 bJ9PSdDncQZGK3PlzOf6BSys1wfnDO8JTn6feySgSeqTecEdFAyzX0fhRrHZlLFSvXW3Q
	 giGZXBihvOI9q+w4keA8MJsrqn6/INOX/0lvAr3LgFs5VE9dyxB4xvdvu1N16lQIgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
	b=yrlab2fdB1qf9S6+Pac+DW74Eft/ZdgTn2sLpYHj8bT/YwG2z/p6c3ZiM5uA16u+Bq/2
	 +mVyrd+t6GoFEVw+ADyneAryi/5oGcCmZzuI2GGAo38k6ebuj2SOpYSeGsWnqO3p5OXXr
	 q+Scra/rGC5ExpTCLLdd4Mq5Z9tKkabHKg1dtjjBmgxQWMqmL3x74qRwNobKvmGu1a1yT
	 ZntzvyX0cPyMF+4/VJoikdA77Eov2MUFk27o8RZ3aW61hYPpR8QbxraAJrb132LIc4WNd
	 eewVWrAKksgcgdRKa/uvT3cE03nJy6eIdIa3JYsRUPbTGRVyMr+eXRb0NGClZzHoucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2jLSq1T;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FC606A326
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 01:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD4FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2jLSq1T
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f05b465cd1so41152945ad.3
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795741295; x=1796346095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=L2jLSq1TsxTtGGugUno1bN6CZSx/7lGwp9t4+byNhC2tfSo4NBQStXHUoDWQrgSsXK
         uLfAS+ATmhVr0h7eyhj7uyTsQ7zGPYRb376ggq0TtInys+4qVsX+GcePm+k8SyHQLF24
         4bhHyNZ07NV2QW45M6Q44P8PMxK15U6PHr8Rd+pEhbvezL+D13VNezc/2443eNafyO0g
         3On26BchelSQ0o5UjZDHRkuJOYdao0r81FQr7ivRu/uEni1Ku2f+SLZczCRc58Xm8kyd
         cCzszz38A1ROnM76ziRueYmGuOpCEJnazMRTDEdXp6TA/gxWdnGbcjO2SRB/CZPQZxSA
         PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795741295; x=1796346095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=Es6wHf0Sv+9edppsbdwXOoN7uPxuShDmjABu8utEsC0OF+XeNBRFxRG8Ny+NmU6zqk
         bJ5yruh1cQQLE95cYmkp7/8ennSx1+HAjJ2NLxXj9DzZJrZJIfdnfR7ax4qnQ/Hcw7bL
         rQFUQFWEMB4K2JuaxT3vWOcQkkTFXdVGr3kXPG1fdMZ+61pJWTWJ8p5w05ZRObfVgxnk
         yaDiYJfIIITPIVVNW/nkq+8Ra50/bKV6wStqEUmiLJ97DTUOQqsKOaquZizzB+awB3be
         i3laMx37G+M9SD6X5drXV9qKAvGYl6kS29JC8TwVY1UP854m4LZZBCxx23kEc14Qk67t
         EeIw==
X-Forwarded-Encrypted: i=1; AL+hErHi8JK9etevvAYdB3XbapUM7m9aAgJuF9pomN3yMVNhGc3gRJc6oLmVmDqDTuAxUur25aCkirt01qHz/mDSIPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lMg5doIf8cTkWyAoArm727tM/BUfM6JN8u+KeXKYSzEG87mkh
	Ib3p90Rxx5SVpRPE9ha8Hf277yvx58lSS+dFjwauhKX3cv+vFD1pARqW
X-Gm-Gg: AZFdTZeYuQNpUIs1vk1E2Etpv1Y4SlB2Pi+nq2EkTeu4soKcs75E6vEpCWrl3XKGV23
	4cslMj1f1I2XtUwfuqQu36ufqSHOaXuwiCgn6F45O5dKAIv1dpZ2qVEI8eSIgEbyGQBogYcePrT
	7B27LmcpdA4rkrtJx8DRCCjdEHLtRWHUNIEJjofCbB6obwCjQe/vD3S6uOa3KE0thC4R24bWXNc
	sv1Bay3C2YSIFLGD8kV1UfsOD4wWrpJIJLuaVUPj1IlcJnn6S/sums7/xqUh+2l6Un3j38UsbJ1
	+JwL1zKbGnDm+oZTBD+B8o8vLNVSmONaKD96gcpA4KX5PpMQCVKAdQH0WonAwJAApslkOLgXnmq
	4/D89Nd43JFZ5cYmsSVMLSZEXLFPTCoBIxomPJ68fJCSM+SZa9rk3+rkcv2eqRtSUDh1GMzefdK
	xBCQpyzLmwESuoPer2f286fjQsL62H7Z4gwcvAtk88YU5/QLnC3kZHIhcUV3XdLSgjjy8lVP7oF
	P0HL9crIuvARKT1TgXxodTUOfq1CdJnfMUrhJcGmwAZTFI6KNzellg+YLKk+S4TxqciWvQ/zcpZ
	h9BQEpf9cX2AUYrF9Gw8R+6ZdRb9JTViMQBEAm4QeXUM290d4hHpIsthxrxYxkRZYbxYCtPK1UV
	C
X-Received: by 2002:a17:903:230d:b0:2ef:f432:3fab with SMTP id d9443c01a7336-2f03f169933mr212665565ad.43.1795741294670;
        Thu, 26 Nov 2026 17:01:34 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm99260055ad.41.2026.11.26.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:01:33 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: lance@osuosl.org,
	rcu@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 01:01:24 +0000
Message-Id: <20261127010124.848125-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Discovered in the Open Source Lab of Oregon State University when running
RCU torture.sh on a ppc64le VM.

With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
omits the references to the system sleep callbacks. This leaves
tpm_ibmvtpm_suspend() unused and produces the following warning:

  warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
sees the callback references and can discard the unused PM code when
system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
called directly from tpm_ibmvtpm_send().

Tested on PPC VM of the Open Source Lab
of Oregon State University.

Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..9840d0ebe6a3 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
+				tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
