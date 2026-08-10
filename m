Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2130567F
	for <linux-integrity@vger.kernel.org>; Mon, 10 Aug 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372440; cv=none; b=ijGECND81ApNx820W0/kWYhCk2bzr3/uETyDj74g0DYhH9iDFkECT1Jm9uchUSRYOGEaZwzdATm4xWMoDFG1mfX/o+NR6j4zR9wPA5nvvgrYS4xEDeatgyYApMkqSZ/kbVDd1QvWW4zM3WG2FjzDoMxCNNKD3Ova+54wI0YTL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372440; c=relaxed/simple;
	bh=Z0BAhXILyTZlqOoopLn/IYkd1hg5fTKGu/UbHI3OYOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGHYlRe+ar6RMMA++STzqZgv/iBbwbxH8hlSk+FnEygZH60viBVw/ZtblQ5j5xL6QrC33XPf02J31IJ5L4nca3aJNhLLTk3mkT3x+3swCWlsIIl8Gi7UKQK8u2eEXX2SZDz1KFeDHQdAC7LwefJXCOk8Krvz71guOfYMMErqEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UrdKeAU/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KSZBqjxo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LzSR/SL9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSNuhjco; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrdKeAU/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KSZBqjxo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LzSR/SL9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSNuhjco"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28D0180CB8;
	Mon, 10 Aug 2026 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786372432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bUxwmuDKq5MfYJfBihGf3D/qfIAzRg9avhR/Jo+STU=;
	b=UrdKeAU/HAsD9V7RT+Qr5L35tv3enKaK3XS7EkmYG56sr+5fDXtNuMGN8vywtjKZU1J9ax
	G0lRHCESk597PLrxglBSf/OAIY2UGyOdWjitD0QvJrQRf45Euy/s2uU4imqI3p2IIlBQc3
	yGWb6C9utLSo518Y24SSF8jXQ0il2Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786372432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bUxwmuDKq5MfYJfBihGf3D/qfIAzRg9avhR/Jo+STU=;
	b=KSZBqjxolR0H0qVHHyDetdQH7vteqjgitJTzcwQEmgyEMmxHGs08JevZvC41HCX9oC/7Vv
	A+2Q50p1MnHNr1Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786372428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bUxwmuDKq5MfYJfBihGf3D/qfIAzRg9avhR/Jo+STU=;
	b=LzSR/SL9UIczHqqQdIqyiOd8QKlav/lW7xDm7I0/CpUJzChJWmHBBQfkYJQnh0IUf+uQ8n
	RDnInmeirrBLbCSXtrC4wiLUDpTcTrOUziwlElW/LSdDlN1CdrvgWEhatRi2fYiJzKJYDL
	gu5UfNSI05vqOl/44RcG+FazrilfzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786372428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bUxwmuDKq5MfYJfBihGf3D/qfIAzRg9avhR/Jo+STU=;
	b=hSNuhjcoS0cyf0X4PU9R7GiRNzDRnejr0A9jpC8atzZ4VOcwy0cakefyTfXoi8XSHv+v/v
	QWrEeM+lAF17JwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2357779BC;
	Mon, 10 Aug 2026 14:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KKZOUvheWrNVwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 14:33:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/2] ima_policy.sh: Require kernel 4.5+ for test02
Date: Mon, 10 Aug 2026 16:33:44 +0200
Message-ID: <20260810143344.1029588-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810143344.1029588-1-pvorel@suse.cz>
References: <20260810143344.1029588-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

@Mimi I appreciate your RBT or ABT.

 testcases/kernel/security/integrity/ima/tests/ima_policy.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index d66f261a81..e6f4ff133a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -60,6 +60,11 @@ test2()
 {
 	tst_res TINFO "verify that policy file is not opened concurrently and able to loaded multiple times"
 
+	if tst_kvcmp -lt 4.5; then
+		tst_res TCONF "test requires kernel 4.5+"
+		return
+	fi
+
 	local p1 p2 rc1 rc2
 
 	require_policy_writable
-- 
2.55.0

