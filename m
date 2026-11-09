Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212734;
	b=dZXfIHvITrQIvLAGI/AWZfT7VPhyMGlRJ4FhlbxNVPQIdkY1YdOUso4vbfGEnahbIFhV
	 9c/6HM5GOMTD00IQr4pc57xk+b/STlPQsquOEhiBp2e5qkOzsvM0xstJg9QIOAP6mE04+
	 2F9/1b10DXnx5qak1/rJf7v6RBOin2elWJ3imoDynfohLC/8uVHpb2o05gBMmBr+DnDpW
	 59lz2uR43n4lo07pwCbBz6mfDPRYWRqk4fpXL8M6eUdVDBuGVwRFRvaltejqSZ8Yy7weY
	 R3uPDbHyBZIIrtVhe/zoqzpkxst4VVMfiqa8JW6DV7UF3aYK7zudXPg+T0Sx9/nMDyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212734;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=A4oUi5vp/2emtE9Fr/c3cwsOuJmCimuvjbyahDedgBM=;
	b=XU7JEzrQpP8ophZQouugTxQ71IVBsE3zmYt+9XtVQNt0H4yeC2ITNvVOzMfzZITYvnyG
	 Tdipj82YBV1HgVs0uaAvB5qXIW/qOapmOf7J4x7PYra3UItaYnYGGijc23KOp5h2n7i3U
	 tUvymTXDFSAn3xWIasRxRZDuzBNeCrwleXIhU16u1g+AIwaY6x3ckdDlAhIh4aNud6XRM
	 2N4uCSAwxA6cZIAyMQXSVK1O7GgRDSVeHvQah7C7ftM86kvhQJWI/phKmI1UBa5nUnyh7
	 81xRjbuqwhze41SEJpk/y+1UHw5DdqRbwrYLnpGhE8cn2CnC8G5z2O1wjKfumpWHrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=faZahCnb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PQ4F9vJe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qAFMvgdc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vxHSxg6+;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E2606A31C;
	Mon,  9 Nov 2026 08:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=faZahCnb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PQ4F9vJe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qAFMvgdc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vxHSxg6+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D458F2217D;
	Mon,  9 Nov 2026 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794212732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A4oUi5vp/2emtE9Fr/c3cwsOuJmCimuvjbyahDedgBM=;
	b=faZahCnbv+T2hWi3ztV9rljCL41+ZO9ySPETSV3cqB/IZwXJ0nyNr/GZ23YYXSCpe/jmGd
	jTiQEnk9A4X5/7NzbJ1/wcSVbe/JlBA8/LFSOwxlLVR+yJP4lojdchqlddUYOgY/AM2Y/o
	QawCtBhnEhj0eQT/uzU+aYb28mt3P7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794212732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A4oUi5vp/2emtE9Fr/c3cwsOuJmCimuvjbyahDedgBM=;
	b=PQ4F9vJe9cSNP9BjDWlUA53CM7wCM1ZJzVDGp+TA3G1DhSrGlMRgZAQSoi5hdFwnDxINBH
	VsffLtIaMvVta9Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794212730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A4oUi5vp/2emtE9Fr/c3cwsOuJmCimuvjbyahDedgBM=;
	b=qAFMvgdc/kSzIvkUXKr5AIws2s9zRqx60KZ6y9asdE9TE5iHc7ZR61Xh517p5F333QNgWp
	45PPJURT1MD9iV9xFZZDAhboIWcFxOT8d1QUqKpa1lft9pBIwYt7aHvLYt4xgVyyPDPi2Q
	ZLuIbXii2VgsoGcBDN4E4Wfat2VqBqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794212730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A4oUi5vp/2emtE9Fr/c3cwsOuJmCimuvjbyahDedgBM=;
	b=vxHSxg6+xLdPLIcD0v8xKJVkEp9VGGIqhbdSEUoYDExfGH+MUXKt83NPyov1tnyLsgcc3q
	9JC3IiGhqRzTrODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 847E013302;
	Mon,  9 Nov 2026 08:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMjXFnqD8WqEaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Nov 2026 08:25:30 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error path
Date: Mon,  9 Nov 2026 09:25:24 +0100
Message-ID: <20261109082527.541901-1-tiwai@suse.de>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -11.80

When devm_add_action() returns an error, we do NULL-clear
log->bios_event_log unnecessarily before calling tpm_bios_log_free(),
and it would lead to a memory leak of the allocated log buffer.

Fix it by simply jumping to the err.

Fixes: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/char/tpm/eventlog/acpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index cf02ec646f46..50770cafa835 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -167,10 +167,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
-	if (ret) {
-		log->bios_event_log = NULL;
+	if (ret)
 		goto err;
-	}
 
 	return format;
 
-- 
2.53.0

