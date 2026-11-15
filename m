Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706502;
	b=G7+RKmZ8stNEvbd/afPI95U0iclE6vkVLX73sb8dXaVNxHjJjktJAyXHyVkA7ZJsWLiS
	 jTIE9flxHGgN7ejeZ9uNfE4G9zGkG4KSQLd/5vKq3/43kxJRekA23qSsdMzC+gsg67d6L
	 KsCTZ4pDUbLsQNSpojUVfit+Rnng4hYE/n3YFNmKfwxhsbI1I1BiyxEvI2fgT4w0F1Zyo
	 +39EP8G1LOlTC14CtRTJhDlaKNbkQgQVvnJ7akK/VN3bZDkzdquzvf5fuDRd3um7KgTxz
	 2z6eWGKU4mAzgZec3Q4sLSuZdWb7nReclZ6Xp4CyLNDHf1bi4rDIcpl9dNAhUnxJQ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
	b=Wbaik/OY+QMnYuXPy430RjCOsonUURlwPUoJk1TGaEl6dLeenNrZg3lKZa02A01GzdnJ
	 p3MLpLLX6utbCMB99TvumTk3IYlGU8eMdc8WCPlZmJdTMs10LmDyHklQkRbfG72S4KbGr
	 lIS7gl/n2IuVR8zAdoVlxFxe4ohqj8Oiwe5YfhdSENtdhtw7qLqzrdY3/EzaXG0t8ax+s
	 MNLXgfVf2VcOslCQpKjcMlrQwlgVI6eKzRRaG5+r8dWzJv6kPU+ZaJW32cUivLI8vmk10
	 PijTr6KsFJWIj267ZhTicmJ6qcak+F/tJIen7lBJUskUlDlJm7/GXG9Bj3L9IVGoXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nDBdINC/";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E37606A893
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 01:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E37606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nDBdINC/
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eb18f4da15so10810755ad.1
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706502; x=1795311302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
        b=nDBdINC/NsxSZSM6PLA2D/CKz0RnGopbUkW/xBfoJ5CakPtA6l5JXiJLCBbeHqQ9oZ
         cPOT4KtfQoYBaZWn4N8MYYyPHlx2gxMDOPQqQe+zb5VuB/aM/S0DEUh9ZkhVC6hOOBU4
         pZkSs+AhXmsjt95zXhaWjs0Pdszwfmo0hquzbBvS7Nj18dj6rfqOY9QVEKuKQUTM0xGK
         7kNiYWxQK1UxnD5ZnNZnETKRG5CGOsoGTHvF+lBzxFoeFLlwn7S+Adl++uZPXADtuuWF
         VGEa3L0leSUnhUe3xit/dNaruJc8zEkM1aqg0ZnJYqsOVwM1UQEUraE7v/IJnc2EHztx
         NJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706502; x=1795311302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XRaUjntmnwgXMBa6bG6H6t68ZP5x01BzH1Lhm94CSs=;
        b=qUmTtwz4YiXD5++5IgFhZcufDxIXj0oAnJE85EO863BYmzr5I4VMQ0yMflcIdmrPxq
         0semxfY1JCPvbn/Q6/OApniFdAK1gp3NBY5git46SIpPUnlWV91bqC/zVLdoobSlC0zl
         irv3+lsnPbvVXGfNv+0ZZ4HODD0HyUt+Ee37X1pv3EVgAtpksPe84qxVPCApN+n03rDS
         32dVTZt8ThLG64QnB6tJRlM66sny0rt/OJ8yYKk79IeVFu/l7NsN7P6s6tUHY77pbcJL
         AIDjgtJ9qfTJLUqxZlh+NJvplKgPU090WWpxZ2ru38oe7vQAwFraQEsL98eASUCfdGRb
         n1dw==
X-Forwarded-Encrypted: i=1; AL+hErFfQEP5Qnpoy4eDeyHg7HD+O49jbX+C21/w7HtRSJuQcey6sk55LbbUKfyVjiz0uYZYKFRPIxVRNts954C2MKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EORF0MA4wcp4hYCvpNWaH7yU90ZhwBPzTVGa5I2ukwGdQ4lR1
	UNTwPfZtwCQ7tiI7g1BF4HL3BEymFTmGUZcXvLW/UCF4CaPKaxI2R/uI
X-Gm-Gg: AYBFou0pb8A7keRWN0pVzqr6WBymPlCoAXLKVTGecxd5vmzMqDev+KdlmLb/US6CY4G
	2Ip1M3K5zpZovzJtr/f3egu+BWO5x4eZdyesl7/VX4iOi+QZgY9Z0G2v5pfGbiB12hcUJeS0OwG
	IebaSEmhJqqYKWWYUm3KHoaakCdbpt01klJNH9iAqG8aRFiLtXC+ce6dF25POnH2D1TdjYp7H8h
	Ay8sC4yEbujFex7gNIoyZ6rbzI3T8MdYDoeDyCzw2ODjj3wrz4B5f36kxuD2WqACxCR+78/QKfz
	tV0XMQFcJELdb9IMtTxLsqlUYIrX2rMqhlOv7qkxrZJgusKAmL+ct0znpgo6G9Sta5kmQQndj7u
	11iZmFqu9IyUQXExKmrV6pxPpjLKPPENKPZisnebQQTy5d6bFLSBepqzYx9dIUva+PjtO/i505+
	lqPKYbo8NqXmaOoTsjicn6N9j4Y+S1Ysu+xnv4GUyDOhSovA0J72XBX9M7l/mnUn4zSLC9BGDef
	+Dg7haUJOzxOMBKpSAV6QuuI5stnhHVREeLqBLHqB3yQ8MAndBan3qxlwmyufjOQlemycXENm9r
	/yop/qSKmeIxutZjXKmBfLFfkTgklmvvdVOmnswA/vnIYgfcIspvgeRq1shQ0xSfaI3Q5Es49Ta
	GaB174ALlIBzAxMOfk0hbG+T1BtKG1UgyPbEGVNw/2QBm680PUaOH/bObLJx5fYBkvfKWNU9PNX
	2O/MMMF29glrPwm/3FGactEyXHn2kZe9hY6gR3r6Q9eA==
X-Received: by 2002:a17:902:e84a:b0:2df:9556:6848 with SMTP id d9443c01a7336-2ee0d66ebd8mr59520075ad.4.1794706501770;
        Sat, 14 Nov 2026 17:35:01 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75dde9sm23671935ad.22.2026.11.14.17.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:35:01 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rachelmenge@linux.microsoft.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v3 2/4] tpm: tpm_crb_ffa: Only probe when ACPI TPM2 uses FF-A
Date: Sun, 15 Nov 2026 01:34:54 +0000
Message-ID: <20261115013456.212141-3-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115013456.212141-1-sidchintamaneni@gmail.com>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
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

