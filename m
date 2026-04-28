Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A202FFF81
	for <linux-integrity@vger.kernel.org>; Tue, 28 Apr 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392652; cv=none; b=r8mkWL0tivM7AQoWJFHhrATyoRfkF6CRKIn91nI5ocZ5JFJyQNjqkNo3aN1drRnMo+KidQVBL3lWRSQgT0wZoxQ1fjSNRpabA2+ut2B0EVnnuX3HvBzNJj5Xv3fUIJhGTL2/irHYgZ0kiOc00c0eRjyEzWgWLB1U/D9x4kyEep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392652; c=relaxed/simple;
	bh=xrrmWBNx/Kjk8OGvCm6W/atMxEYXNdTs97s2x4H33TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTIPJ0RnEfHaIolv+P/khiiRQCLctHL1jLCutrA+NHkPAoSRqLMG8dplIwV9wXqto6oP4/+hYRgHJ/x5/RUuOWjWXjRiMF+bWNlx3MDhs1QE5792I6g6Hfn8b1ZqrGYqnjCH9AGtNE08LI8GhTHqh2U4CVgmpz/ojabzYMUikhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2W7pFKHb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ixFs+yiG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2W7pFKHb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ixFs+yiG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2W7pFKHb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixFs+yiG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2W7pFKHb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixFs+yiG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C037D6A838;
	Tue, 28 Apr 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/xY+JuT9SB922Vd8GksQP3O2M/EVrOW+CmvFUk5xtI=;
	b=2W7pFKHbILiW6ruDwR4Ai1yTBviQKUOBLOtirfzboLQMYpySsJQyJf7Lfs+rA3CBYtwxP4
	9zJiD0T2Lec9z0YgfXOlOosrcO9Y6ru7Yd4n+fEOmzWBXwS3JiJJTgxveK2cTz6keZu7Ka
	SA/iSEQwItShAV6OzbkGYUiiCXasmXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777392643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/xY+JuT9SB922Vd8GksQP3O2M/EVrOW+CmvFUk5xtI=;
	b=ixFs+yiGLLKRQVNWLgAIb5KKl04BaLDHfiA+nX3R28MEpNJYsUTHzwkyLhASqYJ/mPFy18
	xWdWPsehozYs6hCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2W7pFKHb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ixFs+yiG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/xY+JuT9SB922Vd8GksQP3O2M/EVrOW+CmvFUk5xtI=;
	b=2W7pFKHbILiW6ruDwR4Ai1yTBviQKUOBLOtirfzboLQMYpySsJQyJf7Lfs+rA3CBYtwxP4
	9zJiD0T2Lec9z0YgfXOlOosrcO9Y6ru7Yd4n+fEOmzWBXwS3JiJJTgxveK2cTz6keZu7Ka
	SA/iSEQwItShAV6OzbkGYUiiCXasmXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777392643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/xY+JuT9SB922Vd8GksQP3O2M/EVrOW+CmvFUk5xtI=;
	b=ixFs+yiGLLKRQVNWLgAIb5KKl04BaLDHfiA+nX3R28MEpNJYsUTHzwkyLhASqYJ/mPFy18
	xWdWPsehozYs6hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813A2593B1;
	Tue, 28 Apr 2026 16:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SBuEHQPc8Gm6EgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 16:10:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	Avinesh Kumar <avinesh.kumar@suse.com>,
	Wei Gao <wegao@suse.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima_violations.sh: ima_mmap.c: Replace sleep with checkpoints
Date: Tue, 28 Apr 2026 18:10:34 +0200
Message-ID: <20260428161034.947614-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428161034.947614-1-pvorel@suse.cz>
References: <20260428161034.947614-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Queue-Id: C037D6A838
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Using checkpoints is a proper way in LTP new API [1] to avoid races and
waste of time.  It reduces 3 sec sleep in ima_mmap.c and 1 sec sleep in
ima_violations.sh with just checkpoints.

NOTE: tst_reinit() is really needed instead of .needs_checkpoints = 1
as documented in Shell-Test-API.asciidoc.

[1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

Fixes: 0e4cbf753f ("security/ima: Rewrite tests into new API + fixes")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/ima_mmap.c     | 7 ++++---
 .../kernel/security/integrity/ima/tests/ima_violations.sh  | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 8596809ef4..09b22fd4f4 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -9,7 +9,6 @@
 
 #include "tst_test.h"
 
-#define SLEEP_AFTER_CLOSE 3
 #define MMAPSIZE 1024
 
 static char *filename;
@@ -35,8 +34,10 @@ static void run(void)
 	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	SAFE_CLOSE(fd);
 
-	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
-	sleep(SLEEP_AFTER_CLOSE);
+	tst_reinit();
+	TST_CHECKPOINT_WAIT(0);
+	/* keep running until ima_violations.sh open and close file */
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	tst_res(TPASS, "test completed");
 }
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0c03c30786..d7dcd077b4 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,6 +8,7 @@
 # test[4-6] test 6.15 commit 5b3cd801155f ("ima: limit the number of open-writers integrity violations")
 # test[7-8] test 6.15 commit a414016218ca ("ima: limit the number of ToMToU integrity violations")
 
+TST_NEEDS_CHECKPOINTS=1
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_CNT=8
@@ -171,12 +172,15 @@ test3()
 
 	ima_mmap -f $FILE &
 	pid=$!
+
 	# wait for violations appear in logs
-	tst_sleep 1s
+	TST_CHECKPOINT_WAKE_AND_WAIT 0
 
 	open_file_read
 	close_file_read
 
+	TST_CHECKPOINT_WAKE 0
+
 	validate $num_violations $count $search
 
 	# wait for ima_mmap to exit, so we can umount
-- 
2.54.0

