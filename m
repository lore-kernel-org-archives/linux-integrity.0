Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8E1F4631;
	Thu,  8 Oct 2026 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422203; cv=none; b=QEXX81PkgRkt+Dbl8tgNgotMReKD2/UK91hg1Rg7K41RlH0F+tb+ifD3W3RX3xuBXWnhhBGJmw7XyAE7ALPJT1ueZ8s4CblK9mifilusRmLICQt/GCVTaIVQfS2SXv5jQqlfx24L61Ktr81d6r3flxFnjMoEXGt/lMLqLyl1bzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422203; c=relaxed/simple;
	bh=wvAlMxiZ/06tjdYrgDmf+w+bShlA5Uk9C6yBoV8ak0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXx0L/3jWRRalwQGkJ7ZUFULMzdNlTN1TuvPeJawkStJmAAHM09QcSJnOUZcJ+bmlFcFmUm92j0IshG7mFaS74O7shRYIGbbg2FRzi6voXiZ+db3LlYdgtGpo7KKKiVD4y60cEciVBLek7Rhb5F09I99QlqmIOGa3QhOuoSk9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e28c9ef4c2b511f19a56ed5b684f684d-20261008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:21e25339-3141-4dd4-987f-c0c302f41113,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:66f646d9331cb31dcb9c58c7d3c4b317,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e28c9ef4c2b511f19a56ed5b684f684d-20261008
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1893273027; Thu, 08 Oct 2026 09:16:27 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 0/4] tpm: some tpm small fixes.
Date: Thu,  8 Oct 2026 09:16:19 +0800
Message-Id: <cover.1791421672.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several small issues found during a code review of
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

chhanges in v2:
1.add reviewed-by tag
2.remove patch 5: 
make the tpm_init() error messages consistently prefixed with "tpm: " and
report the actual failure of tpm_dev_common_init().
3.modify patch 1 git commit information.

Pei Xiao (4):
  tpm: tpm_ppi: fix zero-extension of negative error codes
  tpm: tpm_nsc: fix NULL pointer dereference on init failure
  tpm: tpm_nsc: stop using the cleanup callback as dev.release
  tpm: fix zero-length read discarding the pending response

 drivers/char/tpm/tpm-dev-common.c | 3 +++
 drivers/char/tpm/tpm_nsc.c        | 8 ++++++--
 drivers/char/tpm/tpm_ppi.c        | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1

