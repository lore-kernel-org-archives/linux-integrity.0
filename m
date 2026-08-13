Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BF463B88
	for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620342; cv=none; b=A9F6osEEkeTFQ+AIzW4Qtbl23qa8S3WmU/Yx5U04pZ8eNc9FidDAMykZN7JBLzVy+Yhci31AudN2SUsO1lqEeyYAMTtSsaJHnT7ZxB9x+GWjo4J4JRUp02BX5mFztfVc4l+SVrysZAo4wAZINb7U8QQ4m+MGyoMyXTDF/OfzFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620342; c=relaxed/simple;
	bh=1o4aQnRbQYeCc3QqTVTta3nccl7Kt9E9wH4I3i82vjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxSBdAt7FBIFDkJAy/+jWvF5rVrgMTHzYvmSK+vV5LKK8tdHsdPxnrcDc8ElqNgdQfxKPostNAr9JJjIBnedr28UyPgfnNHwSkElCZLS5/zbUyURUde3Gjm/p3W+6FxVJRtHVLB5y3Jm+LumzZTZ/u9Wm5JSrTvpZUPOLYD7LkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sHR5VNoS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9k7XgYA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d1FRXoXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExTYyRKV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sHR5VNoS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9k7XgYA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d1FRXoXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExTYyRKV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CD623E90;
	Thu, 13 Aug 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786620332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e4VPySsf928NBWmWSotHkyIfCU22pGRzk9lcLTmNQ10=;
	b=sHR5VNoSQodNV9gVQmjG8diJdFZa4s1chSz0DPgVeUYBkxnNGdjsSQ/rZyqfY2cdkMyaJe
	pnjnfBX4RxYxgcMEhfGaOsK7H6cm71KfqSfzBtE6c4t/2+XeLmb/kZwYDEZFe0g/HquQ4/
	M2eGD9PslORGZeQifIQZb37khhtLqhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786620332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e4VPySsf928NBWmWSotHkyIfCU22pGRzk9lcLTmNQ10=;
	b=F9k7XgYAwRkyixamfGi/fIATRoRumGoOBqp/6VV9KRibFl5xDX4fzdiDOzhajNExyrZZv8
	H1vZJ+ca4GYupADg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d1FRXoXB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ExTYyRKV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786620328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e4VPySsf928NBWmWSotHkyIfCU22pGRzk9lcLTmNQ10=;
	b=d1FRXoXBwMJRl41wqCTYGKPgWcx09XVkdPW2ysUaV09sALTSwCDz0wx7FzMdFHAyouW7Gh
	bygffhevjvXUpP5WTFsXSiaspMc1uxSQDxRybnh/glloARnH2IkeD5KoC2e9pELBBsENjA
	Kkeeq4yElJEIroiIO7gGyc15hrlef/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786620328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e4VPySsf928NBWmWSotHkyIfCU22pGRzk9lcLTmNQ10=;
	b=ExTYyRKVbyhsIiqcYDxcvyTydH/6/lZ3nIKHFHQxNphA4AQ3m7QcZF1N6EdGjBlqidYVUj
	GroLKBB3FCs9l6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C33077DBF;
	Thu, 13 Aug 2026 11:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lMRYHaipfWqEFQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 13 Aug 2026 11:25:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/1] ima_setup.sh: Use tst_umount()
Date: Thu, 13 Aug 2026 13:25:24 +0200
Message-ID: <20260813112524.1849695-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9CD623E90
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Use standard test mechanism to detect problems during umount() caused by
GNOME's gvfsd-trash daemon. Although it will not solve the problem it at
least warn tester.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 19f00532b1..054ab28611 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -313,7 +313,7 @@ ima_cleanup()
 	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
 
 	for dir in $UMOUNT; do
-		umount $dir
+		tst_umount $dir
 	done
 
 	if [ "$IMA_POLICY_LOADED" = 1 ]; then
-- 
2.55.0

