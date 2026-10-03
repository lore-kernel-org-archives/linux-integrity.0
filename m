Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67775395D8B;
	Sat,  3 Oct 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016091; cv=none; b=YMUB/MT4hOSPG0WR5aqYSZ/uTizleWQT1laA9q4xHO4gD8+SXc2z2rHmN+zRvz20TGJ6zT8FKemxXuCfUjRzHMNrbtg1uaUM4/93Oc61/9fkRIBP/KDSOPaEagncRLX3GPj0g6NyTJ7MpbingdWh3966QgeYbs216JqO87xtInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016091; c=relaxed/simple;
	bh=QS11a2B0L4n0a1Ev0T2vALRWX8NsWhfo7xsXl4uJdlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+ChdVRpBf/P3+tp7zQoFoPxzB/Me/8ilHtQ1sFUyokvXvYgHFv9S0GUAXnmx3dKAfsYoEMk9z5zfQhKHJCmfHRmULKIbfaNQ0Q0V8nxcBMxKko7i0n11dEDddpZTLtX9uHw8Xf1PFtZHyLLSe5WjmfEp1623eQEJUmISKJ5ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5747d89abf0411f19a56ed5b684f684d-20261003
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ec8d5247-5cab-4ea4-a11f-8ac96a05eba8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:bc4cb5861de2a43487160a7ec88965ab,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5747d89abf0411f19a56ed5b684f684d-20261003
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 5160961; Sat, 03 Oct 2026 16:27:59 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 0/5] tpm: assorted fixes and cleanups
Date: Sat,  3 Oct 2026 16:27:50 +0800
Message-Id: <cover.1791015549.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several issues found during a code review of
drivers/char/tpm:

  1. tpm_ppi: tpm_show_ppi_response() stores its return value in an
     acpi_status (a u32 typedef), so error codes such as -EINVAL reach
     user space as huge positive values.  Declare the variable as
     ssize_t to match the show callback's return type.

  2. tpm_nsc: tpm_nsc_remove() doubles as the release callback of the
     hand-created platform device and dereferences the chip drvdata
     unconditionally; init failures before tpmm_chip_alloc() crash
     module load.  Return early when the chip has not been created.

  3. tpm_nsc: the cleanup runs twice on module exit because
     tpm_nsc_remove() is both the explicit cleanup and the device
     release callback; the second run operates on an already freed
     chip.  Stop overriding the release callback, which also stops the
     platform object allocation from leaking.

  4. tpm_dev: a zero-length read() discards a pending response,
     breaking the command/response pairing of the TPM character
     devices, although POSIX requires zero-count reads to have no side
     effects.  Return early on a zero count.

  5. tpm-interface: make the tpm_init() error messages consistently
     prefixed with "tpm: " and report the actual failure of
     tpm_dev_common_init().

The series was prepared with AI assistance (GLM-5.3); every change was
reviewed against the code by hand.

Pei Xiao (5):
  tpm: tpm_ppi: fix wrong error code returned to user space
  tpm: tpm_nsc: fix NULL pointer dereference on init failure
  tpm: tpm_nsc: stop using the cleanup callback as dev.release
  tpm: fix zero-length read discarding the pending response
  tpm: fix log messages in tpm_init()

 drivers/char/tpm/tpm-dev-common.c | 3 +++
 drivers/char/tpm/tpm-interface.c  | 6 +++---
 drivers/char/tpm/tpm_nsc.c        | 8 ++++++--
 drivers/char/tpm/tpm_ppi.c        | 2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.25.1

