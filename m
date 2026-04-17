Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3437F735;
	Fri, 17 Apr 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423374; cv=none; b=pXXdcNv9nxe6l9xdMAtoDAGSBUw7SrHotiIno0bxf24bKZ8ObCZi+Tp4LnGMv6HOVxuFSIad26Ut3wr5yfDyjzuwj1r/H8N4eWLxcIOvkHOUDQPJDgdzUB4f+3QHRh+Ri9cKUsj8iHFxhO8YBqBxCumcjjTTGt3QCEu/6DqHX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423374; c=relaxed/simple;
	bh=7nIwZJu0KWJx2c4GKsk/4PsqGln6X/8+2jKrFrwhE54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWhxV/wTnmNExEg+1ufuw0eBa339rDTrzssEq4KXdav+ohd9G9ZrYZlmmvaAqPPCS3UhIORMIrFYXfddyXPSI5EE8BZXAr8dc73GvdFSyjPHo9LKYt/7203BTd7nhpregmJ5ibIKUBaxlox85CV4io1UGGDhaV4xt6CmKtXK/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vHT4thAX; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vHT4thAX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776423371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/FWc3BcjPbbJqhHHVOwLcGT+XwhPk5923LWzYZYudl0=;
	b=vHT4thAXETffEMKsmTFH2lJPgrNru1zq5FX6fLpfcc7PI0bWwZTE3c4TeQRdU2cgS1ljw5
	ubXGulEfZ4uMP0wXWUI54hX0T6zTeyqPlQHwhhSu1slUUqFf+prMv3UJldpNyJd/LQV7ti
	Gqy/HjAeQTAfqwCPX2c8cfSXe9TnQdY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: eventlog: remove unused structs tcg_algorithm_{size,info}
Date: Fri, 17 Apr 2026 12:55:17 +0200
Message-ID: <20260417105516.552735-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=thorsten.blum@linux.dev; h=from:subject; bh=7nIwZJu0KWJx2c4GKsk/4PsqGln6X/8+2jKrFrwhE54=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmPBKfkMaycutx4+6cPM6fsuSo0d7WT6CJ2y4V5DBlqa Ub8DyxDO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiJjqMDA3P04L/yOzO+MlT GFG+6VpZqix/7NQW3fX/dHskz25iYWX4w/MiePcTrY1nq7suiZzuU2/+Fc0kXrR1/Y5rfGnMAg0 LWQE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unused structs tcg_algorithm_size and tcg_algorithm_info.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/tpm_eventlog.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index aff8ea2fa98e..615bd0af5173 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -114,22 +114,6 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
-struct tcg_algorithm_size {
-	u16 algorithm_id;
-	u16 algorithm_size;
-};
-
-struct tcg_algorithm_info {
-	u8 signature[16];
-	u32 platform_class;
-	u8 spec_version_minor;
-	u8 spec_version_major;
-	u8 spec_errata;
-	u8 uintn_size;
-	u32 number_of_algorithms;
-	struct tcg_algorithm_size digest_sizes[];
-};
-
 #ifndef TPM_MEMREMAP
 static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
 {
