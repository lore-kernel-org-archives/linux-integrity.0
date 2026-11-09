Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245883;
	b=VhGQcRE7vsrUCvPg1bfOjJJ3/pe3dzBlBeaURtpK63hPvBFzja7kYX/+7h+as7LrPT6d
	 zAt7xmp0xh+EXU3YInin/Wf4sRNW+emF9nA8dQsePBsXNgyI1h+y04eK8aOHxY02rFrQP
	 o1wXMYB3Mx+aKemheUAQ5Bt/fucXFWbb3ZZUFW7ZaOmTgq+Z8T2lQKC9TdluOeB9sVwId
	 QMHufXvr2rGVcxOWnLnK7E2E21Abf18RHDZzPUpgn9eJLkAWotqDSNteJOveq+bl+U/m7
	 PqmBWRTcP9IEpLDXVmXpjde/aviEIH2pKhHX5SKka1Q6czB3jxgNyPBA//KlVwxb6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245883;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=NTjeRwi22EWjiF2CmL7r4VezS/WoFSjVqRJSPlKddy4=;
	b=cXsVoFwyRN5XUYSLXs572gxpG0H1+UT6KjbxIKV7qFMqw57FvRZd/6v1A2pqYxwLfCLy
	 orKBH4TxB5eEyQ9eg9eVd1dQtvNd3AkB1nLOoKtp+RaF7kWW4+aWSm7VcgBMaucE1MFNu
	 MQu/oHwiGaBhJbQiNFEbxsogWSy4fbcKII+9p5bdL6r01ubOF8OLMoqNgmEu9KvxVD765
	 1okch+rdMgBYrDdn64JV++NcTiewx8pI6N0NTy9oWKzJdeCYvzBFN7dFXdrD09ouF0dYq
	 InkG3SQknn3AvlkQP7Dmjuf2TUJ+9uWMs0XWe61VcJV6zT3Ra+SAsSt+g0iMb1UUjDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eR938zqa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sBg3PaR6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PfavQuOr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8LOFMHKw;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B99606A31C;
	Mon,  9 Nov 2026 17:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eR938zqa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sBg3PaR6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PfavQuOr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8LOFMHKw
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E770C1F833;
	Mon,  9 Nov 2026 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794245881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NTjeRwi22EWjiF2CmL7r4VezS/WoFSjVqRJSPlKddy4=;
	b=eR938zqaoH9Epk7KQw88fTozNR9lB1LoIFyNyj0yD0kkMIH5doAkBjo98VX2roIpX0aErO
	Ge9ALr49AoT7WjBcOmqbDGTyelwGUHOftLYdk9q4NJ6G4Vw1YCyUzdWqXRFSx8RsiLpf5n
	Lrho13y26ioVLbx3GbENHdpM3qyA3nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794245881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NTjeRwi22EWjiF2CmL7r4VezS/WoFSjVqRJSPlKddy4=;
	b=sBg3PaR6ZhHHx7/pO+7HKoHtmlllwOV1pe2d8S9iFa0PkIgBLy4FruFgIVreCdGbgyG0mr
	+HvmJZFen4SHDzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794245880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NTjeRwi22EWjiF2CmL7r4VezS/WoFSjVqRJSPlKddy4=;
	b=PfavQuOrPjY+M1dGsz96h2RcVyFrLn4E32jKAE78ClmdZ1vCd1/DRWeh98T5GnZJPNuhHc
	LFVDcGg6coo8Aqv2vZ9jAzYsDLOnsGOOj3miaTlEnB/z5sEdqCjlheq4STZ5xA2wZETkd/
	ppT++DNC6OEp/kfCSm8kp1iwjLc1FT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794245880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NTjeRwi22EWjiF2CmL7r4VezS/WoFSjVqRJSPlKddy4=;
	b=8LOFMHKweFORrkCUolH1VhrhYv36ghMZu0DD3YhyRgdepsl9dCV1db+0+D/3ONcGHr6DTg
	ya/Lhbd2qfMycZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 974E313319;
	Mon,  9 Nov 2026 17:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bLZNG/gE8mquMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Nov 2026 17:38:00 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error path
Date: Mon,  9 Nov 2026 18:37:52 +0100
Message-ID: <20261109173756.742248-1-tiwai@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
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

When devm_add_action() returns an error, tpm_read_log_acpi() clears
log->bios_event_log unnecessarily to NULL before calling
tpm_bios_log_free(), and it would lead to a memory leak of the
allocated log buffer.

Fix it by simply jumping to the err.

Cc: <stable@vger.kernel.org>
Fixes: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: minor update of patch description and tags order

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

