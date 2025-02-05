Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498A215168
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792641; cv=none; b=ZzNN/AuEr3JAha8tiMCQyu+es4RvKdelbCIYGW8bnflq8UqLPngjhZrPXwWWLXTMy9dwsZolVH0EWz4CR9S6iCZfMaCX/iIg14TPd3Px9+BqLrJ313qYeL1yQyipMhjKmJman351GCBod9M67pFe2uFs/+/Uo9V+y+ZkivnEZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792641; c=relaxed/simple;
	bh=fbQww/PNycPzOcVUVrI1Qm1wYeBngC1saZDtSC+0tIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoIMN+0oBK4jh/iGVj1biPvTBYrmEOU6yoyH6r2a6IJ6VE6s/sgU6zNv4IFE21+maxJ23K7yhYrJjxykRPfr3S50bwVgDajIz7+XOATUq98BinW20vTeuDIA+xC/U7Qz4VUQs2MBVhCLL5yrLQCbad3hQd11p4IrVyRw9XQ4toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B90421161;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B05D13A96;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QP6tGLzeo2eYEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 21:57:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH COMMITTED 1/2] ima_measurements.sh: Fix exit code condition
Date: Wed,  5 Feb 2025 22:57:07 +0100
Message-ID: <20250205215709.1526151-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205215709.1526151-1-pvorel@suse.cz>
References: <20250205215709.1526151-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 9B90421161
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Condition is "$? -ne 0", therefore negative if command passed to if.
This was hidden until fix in the next commit.

Fixes: 4c74c7dc69 ("IMA: Read required policy from file")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_measurements.sh     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 35acc6ea78..d1e41b789a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -94,7 +94,7 @@ test3()
 	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
-	if tst_rod "$cmd" 2> /dev/null; then
+	if ! tst_rod "$cmd" 2> /dev/null; then
 		tst_res TPASS "$cmd failed as expected"
 	else
 		tst_res $IMA_FAIL "$cmd passed unexpectedly"
-- 
2.47.2

