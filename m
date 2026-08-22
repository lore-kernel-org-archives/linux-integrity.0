Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FC23395F
	for <linux-integrity@vger.kernel.org>; Sat, 22 Aug 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357752; cv=none; b=fUyJgLl1Rvb4hpfbfpBaqJqmitXT3ULovw65wFKmfZbKCURhA/EIf1f2KGqVEgwNlitq0KvpD7SDM+Piceo4tnPTMQeoYZFc1DLzjWYMhGgWu0nmpnK243iL3GxYiurV5edHxsremAIviWeNQxibRZR7RiNpVDcH634vuLkE7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357752; c=relaxed/simple;
	bh=1TA2bio4/II8+zwpwrc2qqpC4JhhhuR3h2RWPm5OjLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcojHLs2WValEe4mmO9ZvT3Qy4jVBH+dsdFrQm5MeS0lE+T6fMLlvfyvxD/031vANUXjqB46E+h3bBTmLYTQPbBU/wNrvIhnTacKqKk6miJwX+G65HMCCEH1y7i16+r8tLo54Xi88ib6fQndiuL7IFayZrNunH1SGUSQUbGxGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4sQVwgp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4sQVwgp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fecbb7000so703913f8f.2
        for <linux-integrity@vger.kernel.org>; Fri, 21 Aug 2026 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787357749; x=1787962549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4nn8Adu34scllPu0PVpeNyTmxzz7pa6nBrXKjE6XjA=;
        b=M4sQVwgpKSzyHi/WYFF2MDekN/8zvNv5wwAxNLtWOI6LIFbaw7THm1hJOFouboWre/
         tiLQuoLJgtEvi/XWE32fWxHvcjNrN6JXSgOA08HUIMD3gVf1XjDF+kr8UkquC6QBW5/N
         FJ9Frc9ng5bRDOzeTDlmEvWUZ5GFbmsfGtL8z30X8D3Wg+apdUrgFxT34mSfr9LSVAkv
         TIHIhieBF9LubggBAi4f96ksUBF0kfh3aNPFbdknS43w2x21XVYvVN2G4P3OjrrV/QdQ
         W3zUpH1GKk6oJVQbu1l8wYEfDo/mqAANcMmOqRNVzd24gsMN0o707hPlWIYspyalYfrK
         jEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357749; x=1787962549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4nn8Adu34scllPu0PVpeNyTmxzz7pa6nBrXKjE6XjA=;
        b=VvJUdfEH0zJ9Ob0+q1e612yQhSaFlW3LQEgtOdwEDqTWwwn8Nn8F6GMxDbGcBzrEeH
         iF61sY3jHuN+QN2Q51Mrx8uh7WJqoNMAxESSNqk6VXSDUxkV5mprd/GOrYJpwnjpSB0U
         pGaBnk4RmLNjZHZGVFJfRAbMbSJ083XHWxA98SgpH4rM83sWqASj0tovr2Me+Fiqrq7X
         afl9IaUlrj3DGbmv595/+mx4L28LutgAoeCzVeqFz5Ixl1EsxaaQ8WFOyshVQZy1Ym9k
         rRBqGksV0suI1ud99bUEoRZWNuFuUNxlGpTZYCX0ZVSAt902DhoBYl8e8rtod1rOvsoy
         v5eg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4dO5P/nfQWl4PmmiB6n+D/YrvvGiozxUIg45Bc/7Jv0WrpWMvmwCD+j3t7gS0rA50bRLphHsfmU4CYKk80/g=@vger.kernel.org
X-Gm-Message-State: AFuF++kONQH8Th1cwf2kO2zJHpfrlMgpz+ZcG+EQ+CoUTD1ZQUQSnG3b
	Z/EcfurB2qYYu8GFlI6jy3lxfcjly9zepl3DKTYwwi7RGIln8r0lY8iB
X-Gm-Gg: AR+sD11fs7/t86nND9PsL1xp/yfpEQ5wQ4Oezyu+jCS41aL5KNAH8GMxwBT1Xw6SYnK
	7SDUMLQ+AWslPrLjVZXCUxPMUhkzw9WuZ4sarrD71zOOui6x9w8wvEILV11X8H8cLnYFyUWoweH
	smefs9Lqa6+asy3OxcH+iP3GMZ5AkyoLuNHSTS55PtAUUVY025qsnFe+JXjN6gCXpaJetY0Hb+X
	xUU1iYfFoU3bp+aHO3RLOYQp4RbQL0q58QsodjC4B4DFMGyt25fprRb7u3cGJBqgltocpULTQIF
	5hOF3VZNd2CXQeugPEtWvRCCzI2ssr8mbRw5oxT+KJkfGHTrcjdBQeVNn+K4Lt5O+FldZ3Ib7D8
	ZhgO3aJCe5BjF0AgFi7iivj4jVoH+da3TfSm3qpmlSECOTBrTnd5b3fBTXSY8JcBIkikyn/rcHK
	/WzVF4TEemsu5RR+hwHEBprpoQyyEM2x5R0zyMzKQx82DKbz7OQt2q66i7eRE+9uhK81pPzFGgy
	ORxoJVxVvxaSJPpZ10IsFGo4MmbaH3sWj4JbB5h3M9GBXbpV+n4
X-Received: by 2002:a05:6000:601:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-482c81bd354mr1785152f8f.10.1787357748724;
        Fri, 21 Aug 2026 17:15:48 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b855cdsm445514f8f.16.2026.08.21.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:15:48 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] ima: clean up IMA_MEASURE_PCR_IDX in Kconfig
Date: Sat, 22 Aug 2026 01:15:45 +0100
Message-ID: <20260822001545.354195-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA_MEASURE_PCR_IDX option is not visible for users to set, so it
always uses its default, 10. This means that the 'range 8 14' is dead
code, and the "If unsure, use the default 10" in the help text is
misleading because the user *has no other choice*.

During the first patch submission to add this option in 2008 [1],
the submitter originally gave this option a prompt:

"PCR for Aggregate (8 <= Index <= 14)"

then later removed it in the revision, without adjusting the rest of the
option accordingly [2].

Let's clean up this of this IMA_MEASURE_PCR_IDX config option to be
consistent with its current, non-visible state.

This dead range was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 security/integrity/ima/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a9f86809b0..8a67bc1faa4c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -46,12 +46,11 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	range 8 14
 	default 10
 	help
 	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
 	  that IMA uses to maintain the integrity aggregate of the
-	  measurement list.  If unsure, use the default 10.
+	  measurement list.
 
 config IMA_LSM_RULES
 	bool
-- 
2.55.0

