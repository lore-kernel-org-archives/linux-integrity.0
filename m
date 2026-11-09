Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189007;
	b=3n+wNVHGOjHAA3sCt+qa0T7xKfOkdySwWXF0iGMe5NXeTdsOMQ8vq/og6r3s974yPmCb
	 gCZVAiM929Iaz5zTtkqM21gvbZUTE0FtvX/Li/eyrChcILPBAPdxJOcJLBB6yBp7eDpKc
	 pM9gVxeYY1E5FLBpLHhP1k7PeNLoKh8dNZaopzXvFzrljXtCcK2USdDVZ7avv/hmr4fev
	 PQBDCdDISFYX6M4oCEu5wviI/jHJBpPNYBKldxR/ENzTQSPTQ8apCIe6WwQd3Z8kYbwK9
	 W1j6+Tg8cFgqWdsbS/fSUXmPJPAM8P7bEhGBvCcuHGQ8KaXjE/aX9r+OhTmOE2/wNjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189007;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3fGTU6aueqvbRZKCGqUZQ0PvrtJ8i6SbkcYbayIwgs=;
	b=Q2CrVctLzELvdfzkmVaKGsxVHZcPYiOL1bQGY5VpJf79tewszOWKUPJ329Z32P1dXxii
	 ZdPpkPS5qFr9UpPoKj2v+CDrLoRCoa6ZSKvD6P3rstS3a6xMddi42MRijtMeHAopzdJ+Z
	 a8EwIsgaINmoQpUCcYJaJP2Ai1aWaYh+mDNpz/nmgZqN92qUXWUs9nk50qeTLf4LIa/Nv
	 L3NSWVNoJBH4cR4yX0RkX93YKfqE+I1PWj3kljZz8mwA449lN8pt/llwitHLsoKU7214F
	 RjShbZx7tMqRHTj0m1eLeiwKEos1ZztVdHrm9ZAgK8pZADhy+8hK9bIhSl1eNCfvSdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=TJ7RavfG;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAD606A320;
	Mon,  9 Nov 2026 01:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30DAD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=TJ7RavfG
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794188996; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u3fGTU6aueqvbRZKCGqUZQ0PvrtJ8i6SbkcYbayIwgs=;
	b=TJ7RavfGY0VhZHEAuRqZuzbmgyl9PxWi0yXZXAm+N8z3r0DbDwa0xafRDjV76mFISEvNqwzRNfRishirVhreWyH6fNj36aynMu8Zz6OUvo70xIiioPHc+Fxu6Zz46c9yaPKIIveLwyKhf0g1ZhXvbm4Oo6cHoTz5qhYO/sv8yEw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2031034|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00122131-0.000399247-0.998379;FP=16093665035493975195|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jziGj7E_1794188995;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jziGj7E_1794188995 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 09:49:56 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tpm: sessions: bound the primary public area by the response size
Date: Mon,  9 Nov 2026 09:49:54 +0800
Message-ID: <20261109014955.2777635-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <au3waVnY6QA8TpPl@kernel.org>
References: <au3waVnY6QA8TpPl@kernel.org>
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

tpm2_parse_create_primary() reads the size of the TPM2B_PUBLIC area
from the response and hashes it to compute the object name:

	len = tpm_buf_read_u16(buf, &offset_r);
	offset_t = offset_r;
	if (name) {
		/*
		 * now we have the public area, compute the name of
		 * the object
		 */
		put_unaligned_be16(TPM_ALG_SHA256, name);
		sha256(&buf->data[offset_r], len, name + 2);
	}

The length is only checked against the response later, after the
hash has been taken. A TPM that reports a public area longer than
what it actually sent makes the sha256() run past the end of the
received data and hash whatever follows the response in the buffer.

Check that the public area fits in the response before hashing it.

Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
Sakkinen: a TPM reporting an oversized public area is not known
to violate the TCG specification, so this is hardening rather
than a bug fix. No code changes.

 drivers/char/tpm/tpm2-sessions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index cf8f1fd6790b..e140079dbc13 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1125,6 +1125,8 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 		return -EINVAL;
 	len = tpm_buf_read_u16(buf, &offset_r);
 	offset_t = offset_r;
+	if (offset_r + len > tpm_buf_length(buf))
+		return -EINVAL;
 	if (name) {
 		/*
 		 * now we have the public area, compute the name of
-- 
2.50.1

