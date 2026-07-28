Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1844248B1
	for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238966; cv=none; b=sqU3osSwOQJflr2ElcxmxFhyRJrEwKEAEwLjFbEHF2J+wrUQIz2MhSvU9gwR92OE41ig1Rtn30vJg9rZnktft3m46ORrczn2MNXc6m6TCLbeUWkZKVSwaWTmKAbMOdN1Ha0CN/gDlylrRIsdF+h+dBUXK8802YRpEJJj7xt+pBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238966; c=relaxed/simple;
	bh=pTTrGiaorflrbO/nF9aH+Fu5UhHjcYi3tO+Ss4oF5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO25QiffUz5lY+IWf0bGWyxMFvERryvMi6PrdN6lOnjxRFkBdBWqToLg1RGp8cV12Cmsyorjr3l8cTG9n3jjWFP/P6SgvJ5HIzbKaVoRwlYFEyO9Kn6521+23OudrTF2oQeF78p91pM4K8eqflZ3HTyr8kk7cgZ6R+afRkVJc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uixruSgv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Hj6qy+5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jm+fr/CU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gzr6dCGF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uixruSgv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Hj6qy+5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm+fr/CU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gzr6dCGF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05C4B3E9B;
	Tue, 28 Jul 2026 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785238959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wtLfJKXXVMDGcSFMQX037I7bImdcOzaYwxZZwUA9jLQ=;
	b=uixruSgv8DVeUudO1wIyrFlFOU6Vn6r2FbznxNfCtuslKE+VpdjSa4t9m2ur90VigAd2a4
	Fh8XRWduP7FuqjXaTX/sA4UzTWEBlmiFC+h3THWzDrWZS/QzONf+JEfNoKZM+85Tz7VkmA
	p5h61VPAwBMgXBZGY4aAv1XKRDP18GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785238959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wtLfJKXXVMDGcSFMQX037I7bImdcOzaYwxZZwUA9jLQ=;
	b=5Hj6qy+5LhpsZ3pdwGc36Rd7Q6xQ79NQJQ98jrUH4JwBfAaN1SvSPFGC7+JYIQhD35wIHz
	d0PFwl/JAKxMQyCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785238955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wtLfJKXXVMDGcSFMQX037I7bImdcOzaYwxZZwUA9jLQ=;
	b=Jm+fr/CUvLgHIXXUSIOOwbLS//lwxwq6BF3qwBmeDU5MdklF/kw83ITE8tZqa77+vXtW1z
	HFgrtf7hJsCnWwoXr35jKVuE0lyTlOoLVlLHh/tQSHxkJ4/SSalTZ8e8lRC0VFxOQA/lYQ
	9T2q8+lA60PMAgA6CqCA3N3SAm9mU5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785238955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wtLfJKXXVMDGcSFMQX037I7bImdcOzaYwxZZwUA9jLQ=;
	b=Gzr6dCGFoIShWQOJjrpkjBAWRtCG3eUyf2gLJy/sB8qqvhkeek4PBv3chJIpC/4NhZFJAC
	dZNeMLUWJuf3DmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7D16779B1;
	Tue, 28 Jul 2026 11:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AA7NMqqVaGoCcAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 11:42:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/1] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
Date: Tue, 28 Jul 2026 13:42:24 +0200
Message-ID: <20260728114224.1055009-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(1.11)[0.369];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,ima_conditionals.sh:url,ima_policy.sh:url];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.49
X-Spam-Level: 

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

