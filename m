Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03DF386541;
	Sat,  3 Oct 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016089; cv=none; b=Df5n2LSWqKFPJtctRBZ82gIkx7/aTt9dexJjPVT7QnB4nb1isJ5+i6wUhy7BeZNXwCl/iwQNeCcscEUDGZN+Dkn3Rnc+YWzu+bmR86/SugIJ+CxJeExe5jgvhJFyaKsS4auhbx3INVOoI5hpQmwYGqxd2k2r5YNd6zkgX7RiZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016089; c=relaxed/simple;
	bh=ukHHZbDxTWWm1OpPKIWYhzDknctImGv0EPYdJm5XGvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epr0/C/o3YLjr+a0yRdtLFDr2rHBvZ2baT6RJVPEHrbyCeoqkrKzz0TNhzPVp4NhQ5Fp8L6m2jtTUYOpqADt/7hCFljCBZ5gBkmDEEkx6HTeusOoUax23Zcp6kBIZBT2hHz1T/mclkDMmWbUX+ciaIiGpJJ6u7m8T2M7QDiFa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 57ea9b98bf0411f19a56ed5b684f684d-20261003
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7cf3b2e0-a8cb-46eb-aa58-50bce44b0367,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:a0667b7647df651a9cd8110e28aaf2c1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 57ea9b98bf0411f19a56ed5b684f684d-20261003
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1744330986; Sat, 03 Oct 2026 16:28:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 4/5] tpm: fix zero-length read discarding the pending response
Date: Sat,  3 Oct 2026 16:27:54 +0800
Message-Id: <3f15140ab3c26e98b49d6aceaaa826585d56960b.1791015549.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791015549.git.xiaopei01@kylinos.cn>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POSIX requires that a read() with a count of zero returns zero and
has no other effects.  tpm_common_read() treats such a call as a
consumed response: it marks the pending response as read and drops
it, so the response can never be retrieved; subsequent reads return
zero and the next write() is allowed to overwrite the response
buffer, silently breaking the command/response pairing of the TPM
character devices.

Return early when the caller passes a zero count, leaving any
pending response untouched for the next read.  A zero-length read
will not report a deferred asynchronous error; POSIX permits read()
to skip error detection for a zero count.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Assisted-by: GLM-5.3
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/char/tpm/tpm-dev-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f942c0c8e402..6569212dc6b8 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -134,6 +134,9 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	ssize_t ret_size = 0;
 	int rc;
 
+	if (!size)
+		return 0;
+
 	mutex_lock(&priv->buffer_mutex);
 
 	if (priv->response_length) {
-- 
2.25.1

