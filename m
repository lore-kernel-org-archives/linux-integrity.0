Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684882;
	b=tZLVqjH5Kpw/MHGxyBaffMu3xvYeNqgRxbxP0R+R759YsFaq/t+M57BNKN0Gak8e5YoX
	 7lOkQezV15zGKx5IwnNt+QyTK6othA7QrJWiDblkBP8wHii/KQyfb+/eUCRMje0dIjTRZ
	 jLQ9IMidXylP1CUbwGWQzqjdQBd42BQ9Gm0scK3PxYCStMUC6S3GEXgGms4/nqpYt7ZHg
	 QluNnn/onivXu01//fTd44Aeet2pDx+L3yv80TogGt+Zag8O9loBS7ECXqVopkvJ7MLlh
	 Ks1tGV+Q7FQrPv+my86HcqyIdFMjZU+touY7/NKvvq0Eft05ZMhcII9nh0g0x4B6KYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
	b=aUZlo8Zo1DabzCP1TEIWp+I1Pt8DCTPtXe4TNq1SaCCgiFB0//6805ohTGH+lentSxrQ
	 MZpjgzoUMcz2+n81bm0hc85oLsXSAivgHSynFRwS4O7yoBRiwb+aJ6265WkQ4JGV1xsZA
	 YvgtjP2d0N/sGpiJMlwn4PfCy9pNdpLa+h6uNjkp35T3PY72ScFPevOvG+cdDd6XUHLid
	 1wkeid/bJPxRY9WUVn79yrvRlcFmzn1yfGCM4XfcoSBgWnxnII87L5j8SE9+KT7DDLixS
	 9BSSSXTdjAG1qsyIDhVVvqbROEhOSB34I3IlkUl+00X7hcCreayUXeFKy153RWPLYVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nMkesfph;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FF606A330
	for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 19:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80FF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nMkesfph
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so2935045a91.0
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684881; x=1795289681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
        b=nMkesfpha3IiAu8eFTJotinhZcu2J28OQMJipRI6kXIr8GsJYdbTCe1FwN6G3tz4CU
         8lYRS/q/LMN94I1Qmk7Y80BMjTG/WmRZtrj9qtlNXXcCZVtOqEe4oljdF1DnnRCThoYs
         lcDSo/JDgmpmi6fvDRGh8NRfOBfO//vt9VTlkrp9SAIdPEX5UrLNmaWxAblfM5oXdtE/
         aylciJhX8Y9ifhod7bittejOWiMFZpeOPvaZKsBxlMMJyz31LyEssDRIRy8sKHp+3bfC
         fSqgoIamXjgl+0liu5GkPsMxaPtRRkye/lFB8P1lREjPBjVLEtVi8gE8su4bz+3uyQLO
         P7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684881; x=1795289681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
        b=GN0Mk4dSBgD3IvPY5LiaGFmRuu2BNsqzNJNmkInJ/4LzlB7QqKdfxW/hTCfR9pOEKx
         TKdn7sUXi8cMOlCkVHqz/Bgx3SaZZZbAdvxsfTYZ2YbuekBbZ1rbCE3gabGpAAoXlYcT
         pIfKtokDZrTOIQ0lGjr+3FwyaLrEe+jtwWBxK2CArQ5qj8UtnD9CdL+i8HuO/5na8+dG
         ybg08BzGkv9CllwODtTxNuf5U++HvUH9W90JDTs9PqGpi6qyEoLy8HiDkG58tLYEvSQA
         boiKFB/c6xdQAgvLwz017c2eZYSqq/Edpy3qNl7tt6o3lsqz7ikIMFpk0nwWj+xangc7
         0zCw==
X-Forwarded-Encrypted: i=1; AL+hErEudPcWtHTQyzBQ3d0MUy0/1IFRCfVIQLkYOOgdK45zGlof+svfw/t6ZWtRAPHDmjxR6YOD7M9QtHMqRnso2mE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pU+/PPojaykVIH36LJIkDzUkYtuqodsBjyqhhZdh3yV/gFOM6
	aCOZggA4G3ZXP3uHMuV/21Gnf10cv08Zc/V1IIzRDD+JsdjiltIt+95L
X-Gm-Gg: AYBFou2o0vRf4sob7RqszeXMqMBITQWGzQufpl1r8MJQAw37DmFhMpKjlSUua7n211y
	+U6TldmVyY7Goho3KN6FDSCVVVpl5rHJ8VsbFGtdMU+X0ljKkmEWgwsmFAfgwmj8WZ47y02aFtA
	Vyln0F6U/05BnP38uzLfxwLewT79XPLkWzrczt3XmL86L46KXmUIP+/DK5rUVpFJaLZTgfGqpaQ
	rc1OPW1tYz9yMpT2htbeqGBXDE1FOuN20kze6PLJU9scmlXgdU+l5KRybbLjORO7ya5seaBzma8
	sJ5/rBlX0PUrdUNxbWA8Z7pMlWnyVPsiXkS7PexzNRmnpekzt7D8kODosu9+AAakrSDj+XJ1bqw
	q0Jg15/DPS2o16PJeWHQX69xifbqTIXSbmCZenGfW+PJ9YQMmzETf4tDAh4AIW3r97GSUwTJvPs
	kyVUAH3x7jw07SOLBjO+339le7E1mqaarXQSnTJHdSwOANvgwj0973nAWlzonUW5g51eXGfiJxm
	YD1MGmH+xkpMFOPi8S8IXkDuK2ny2c+HPO5NCiTx/GH8AzEnW26W/xXP+JjdblZ1SirmEq7KO6f
	Xh5u1w1FFPrLrk3FVkyQH8vLdnPr3RxlQDLkawtpeYvuepjLiJ+u+SX2txP+MWspNgbZaGptINi
	xnY4dbKnx6p/RSwPWh6FvZqbGax+EIXRhQ0agYHIaSfYCdVf5Q2ffPeoEcKwgCOo9kVSgC7BI5M
	DMPOXXD/cyn6Bba4XT3l0fmrx0QiAQiFLn86/J6jS9
X-Received: by 2002:a17:90b:1f8d:b0:3a8:6045:5a19 with SMTP id 98e67ed59e1d1-3b1b0a20e04mr6004859a91.37.1794684881101;
        Sat, 14 Nov 2026 11:34:41 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5093969a91.1.2026.11.14.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:34:40 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v2 2/4] tpm: tpm_crb_ffa: Only probe when ACPI TPM2 uses FF-A
Date: Sat, 14 Nov 2026 19:34:32 +0000
Message-ID: <20261114193434.117714-3-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114193434.117714-1-sidchintamaneni@gmail.com>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
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

Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
device_initcall time (and when loaded as a module) without checking
the platform's ACPI TPM2 start method.

A platform's firmware may expose a TPM CRB over FF-A Secure Partition
for UEFI boot services while advertising a non-FF-A start method to
the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
should not probe the FF-A TPM service.

On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
partition and tpm_crb_ffa_probe() unconditionally sends
CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
That request wedges the calling CPU in Secure World (with Non-Secure
interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
stall:

  [    5.507519] ARM FF-A: Driver version 1.2
  [    5.507519] ARM FF-A: Firmware version 1.2 found
  [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
  [    7.150580] Freeing initrd memory: 293640K
  [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
  [   65.530031] rcu:              hardirqs   softirqs   csw/system
  [   65.535589] rcu:      number:        0          0            0
  [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
  [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
  [   65.555228] Sending NMI from CPU 66 to CPUs 10:
  [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10

Check tpm2_acpi_start_method in tpm_crb_ffa_probe() and return -ENODEV
unless it equals ACPI_TPM2_CRB_WITH_ARM_FFA. Checking in probe() rather
than module_init allows tpm_crb_ffa.ko to load as a symbol dependency
of tpm_crb.ko on non-FF-A platforms when built as modules, while
skipping FF-A TPM requests unless ACPI advertises the FF-A start
method.

Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 025c4d4b17ca..da676da6f3f0 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -9,9 +9,11 @@
 
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm_ffa.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include "tpm.h"
 #include "tpm_crb_ffa.h"
 
 static unsigned int busy_timeout_ms = 2000;
@@ -324,6 +326,9 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
 	struct tpm_crb_ffa *p;
 	int rc;
 
+	if (tpm2_acpi_start_method != ACPI_TPM2_CRB_WITH_ARM_FFA)
+		return -ENODEV;
+
 	/* only one instance of a TPM partition is supported */
 	if (tpm_crb_ffa && !IS_ERR_VALUE(tpm_crb_ffa))
 		return -EEXIST;
-- 
2.45.4

