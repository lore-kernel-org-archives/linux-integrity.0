Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F58478E3F
	for <linux-integrity@vger.kernel.org>; Wed, 21 Jan 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984431; cv=none; b=tYVWrcHvMwz/yywZqaudfFcB9H7rwRTNa5EckzDVHkX/AEQC+WabBn7IJXhnmHgY3gUSvEe/ojwh4+IFrl4R41fJW9u8WSdxy3OfOVREHVlK7GluWyY0wCeO/uMvH0ytMJR73/qTKywWjFW+MCvk+FcwGc2ZQd4Rcr5kli5swWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984431; c=relaxed/simple;
	bh=LussiEkeXhPSCMfQqQ+SuNJLPKKIpb+wNBqBw8PDMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBWLMoqyyMbaP7A58xWzVFwblQHh0s2gv8mPmXA7MJDHlX21n5Esq6lvoANC2BJce8sZx9ox9yaIWNYdkiI3VQAVTYgCWS0ZOL0s+iQBSsTuSF28s6zIXpg8lPzZvJddKoyjG3n6FpLj4PICL7bSo6yk018EKRhKJAsFm0N4wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0S6hmIt+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2rzGd4gw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=23fXL1ZS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmLuIxeK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0S6hmIt+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2rzGd4gw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="23fXL1ZS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmLuIxeK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1625BCCA;
	Wed, 21 Jan 2026 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768984427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQj0f+/QN03dC/eYu6Fg/ITkQHWLd4xoBtkVWH4L9Lw=;
	b=0S6hmIt+GnQHvRdwaZf0glG0ISNIyycRXB9ZFweeAK4RNVUTYASgUlP8RFg/dCTLNx9/FW
	q72adeQaKmoIr+KTL0hEfz56vumwZCUAiP0/Y+0jNxJ+7+J0oFgGqulBoMTQtIXdaB2MJl
	Z559rzVUfNTigsLzypUoZ4t90j3DssU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768984427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQj0f+/QN03dC/eYu6Fg/ITkQHWLd4xoBtkVWH4L9Lw=;
	b=2rzGd4gwZBY2zwFXW+DYPIqTf95Yve2gKs3ndP48CIz4OLoWK9rl3OpCXnsZyAdGtId8lh
	FukNsM1KEZ8b7WBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768984426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQj0f+/QN03dC/eYu6Fg/ITkQHWLd4xoBtkVWH4L9Lw=;
	b=23fXL1ZSErSUtPCztOTn/PgPGUwDKMrGdLAXrkhsiniPzs9urEB3ANPAqpgrlnleQ13yyi
	4jTKCKKLlTYPI9kuuqW9a6CdaukCVKTXhfeUrGDK+BoR0vpTsc2AlSH6VAl5xZIR3cZBD8
	fDEePmi4fz668aTmqZmBQHVxxvrgook=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768984426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uQj0f+/QN03dC/eYu6Fg/ITkQHWLd4xoBtkVWH4L9Lw=;
	b=ZmLuIxeKl3E3IoN5HUePvCGpEI3cUyQAuaqR8BcEfx6hgRXwHJq5uqLXQ+oAvUdK4R+j89
	dFv2pDE6aBjSUfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CB253EA63;
	Wed, 21 Jan 2026 08:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZQteEWqPcGlWBAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 21 Jan 2026 08:33:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] ima_setup.sh: Fix check of signed policy requirement
Date: Wed, 21 Jan 2026 09:33:43 +0100
Message-ID: <20260121083343.127613-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Kernel code in arch_get_ima_policy() depends also on
CONFIG_IMA_ARCH_POLICY added in v5.0:
d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")

Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi, all,

FYI I'd like to merge it this week to get it into LTP release.

Kind regards,
Petr

 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1bce78d425..df0b8d1532 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -466,10 +466,11 @@ require_evmctl()
 }
 
 # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
+# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
 check_need_signed_policy()
 {
 	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
-		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
+		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
 }
 
 # loop device is needed to use only for tmpfs
-- 
2.51.0

