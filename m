Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A93E0C4C
	for <linux-integrity@vger.kernel.org>; Mon, 10 Aug 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372439; cv=none; b=O94vUi9QKtKBrszww60BHZi8uC7VTeamTvmSHAyE/xIG0XtOSKN5jqivnXfXY+79FwO7y9AxhzchewZRekJzWkrI8XTl5HFXcHfuvMOSoRtm0FUrZwKmqAvX4Rrw74YjT4oqsZI+aCrTh/w1KuLRIzowvO49PjSso3ts0OivGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372439; c=relaxed/simple;
	bh=183Yr3WcTzKkC3Gk9RH9oY1SK/Q5ZLVhUpSRWtOfNbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4DHPTV1Q+6mGwvpV26I9kPuv1Y87jdhatx8UKMENwiXEOYnzD46eVBfTNGL3COizeMF/oCsPztutaCM9CeZS0taLG7872STgkhxXbZ8HGN72C07BUdjfjIIItN8+Yi5zQ5ai68t02BMhmA/lBoBpZdab3lNI73LOAeqM0PeLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIiBpzBG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyXVRKb0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fYP9QiZ0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=16uqDyfs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIiBpzBG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyXVRKb0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYP9QiZ0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="16uqDyfs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB8403DFC;
	Mon, 10 Aug 2026 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786372432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BDoV+SMp3tKCclaxMYvq+RY1yRCHqIwpW0CrAVCRaCI=;
	b=FIiBpzBGRtFqufZK5RWmMBtQ+g+Bw5CtVEdnJmFog+Qh76mqEg23XRQTFStOKdezM7a1XC
	x0kKrXaDCshYq/tjUmtZ3WFhGqi4ZlDBG1k7+2pMOuttUfoQgW8sPFdg73fkWogY8qCG2D
	3y2q4QDnB7jOFYz1qs9gIYGp6+5gyo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786372432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BDoV+SMp3tKCclaxMYvq+RY1yRCHqIwpW0CrAVCRaCI=;
	b=vyXVRKb0agcnDrULSyUHBqry4ChDhN8GOZLniPVLublj7v8AMr70FTbcI3nqU2OjvUxkPx
	96N7J122Wc0qS2BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fYP9QiZ0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=16uqDyfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786372427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BDoV+SMp3tKCclaxMYvq+RY1yRCHqIwpW0CrAVCRaCI=;
	b=fYP9QiZ0F/tch+PyG5mIaFYpAtGUiLt8aFQOdFjgNmYU8ITWE7trD2Zu6EdjP8x5IeYhIF
	u0/R8OJkPJ1LLO5HLZ+BiSBCR8p+O449iUB33VQMhAxzyLOM1ZjxHBzmsRVlt92nmDhQQG
	NAa0axcRbjDla8sajIZs+x+umd++S8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786372427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BDoV+SMp3tKCclaxMYvq+RY1yRCHqIwpW0CrAVCRaCI=;
	b=16uqDyfshy1dIjR2SWJV0Rn9aEEcWNvDCDyj2tAOaWg2jz9Lnz3LV+VqsIdsgQjKULoqz+
	PFgn5WPbFMysWrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2494779B6;
	Mon, 10 Aug 2026 14:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UimSLUvheWrNVwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 14:33:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/2] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
Date: Mon, 10 Aug 2026 16:33:43 +0200
Message-ID: <20260810143344.1029588-1-pvorel@suse.cz>
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
X-Rspamd-Queue-Id: EB8403DFC
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Writing into policy via echo on kernel < 4.5 effectively makes policy
not writable (no point to check if the policy is writable). Therefore
skip this extra check in check_policy_writable() on these old kernels.

This change improves IMA testing on kernel < 4.5:

1) Allows to run ima_policy.sh which was previously skipped:

    ima_policy 1 TINFO: verify that invalid policy isn't loaded
    ima_policy 1 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)

2) Fixes failing ima_violations.sh, which was failing due policy was not
   writable:

    ima_violations 1 TINFO: Tested kernel: Linux susetest 4.4.140
    ima_violations 1 TINFO: booted with IMA policy: tcb
    ima_violations 1 TINFO: using log /var/log/audit/audit.log
    ima_violations 1 TINFO: verify open writers violation
    ima_violations 1 TFAIL: open_writers violation not added
    ima_violations 2 TINFO: verify ToMToU violation
    ima_violations 2 TFAIL: ToMToU violation not added
    ima_violations 3 TINFO: verify open_writers using mmapped files
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
    tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
    ima_mmap.c:33: TPASS: test completed
    ima_violations 3 TFAIL: open_writers violation not added

3) Fixes failing ima_conditionals.sh -r uid and ima_conditionals.sh -r fowner

    ima_conditionals 1 TINFO: request 'uid'
    tst_security.c:115: TINFO: SecureBoot sysfs file not available
    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    tst_rod: Failed to open '/sys/kernel/security/ima/policy' for writing: Permission denied
    ima_conditionals 1 TBROK: echo measure uid=65534 > /sys/kernel/security/ima/policy failed

    ima_conditionals 1 TINFO: request 'fowner'
    tst_security.c:115: TINFO: SecureBoot sysfs file not available
    ima_conditionals 1 TINFO: verify measuring user files when requested via fowner
    tst_rod: Failed to open '/sys/kernel/security/ima/policy' for writing: Permission denied
    ima_conditionals 1 TBROK: echo measure fowner=65534 > /sys/kernel/security/ima/policy failed

Fixes: cd96265e65 ("ima/ima_policy.sh: Improve check of policy writability")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same in v1.

@Mimi I appreciate your RBT or ABT.

Link to v1:
https://lore.kernel.org/ltp/20260728114224.1055009-1-pvorel@suse.cz/T/#t

 .../kernel/security/integrity/ima/tests/ima_setup.sh  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index b69d7c31d9..19f00532b1 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -95,10 +95,15 @@ require_policy_readable()
 check_policy_writable()
 {
 	[ -f $IMA_POLICY ] || return 1
-	# workaround for kernels < v4.18 without fix
+
+	# Workaround for kernels < v4.18 without fix
 	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
-	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && return 1
+	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
+	# 38d859f991f3 ("IMA: policy can now be updated multiple times")
+	if tst_kvcmp -ge 4.5; then
+		echo "" 2> log > $IMA_POLICY
+		grep -q "Device or resource busy" log && return 1
+	fi
 	return 0
 }
 
-- 
2.55.0

