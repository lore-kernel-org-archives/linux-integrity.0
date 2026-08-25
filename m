Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83505329C48
	for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682003; cv=none; b=pfvZZAIp+iMCcOPd+GlBgxdTKmDyIx2STQQ4bweBvKiDMpOSrdp+TSgkAPjVG2GcwqbZQ8LHHSG3x0tlciYArv0vbBgvuVzCufyuQDlYdm6DWsnSlOXycwLmJb6Gon40fiqW+AnaMbplXexIKplnk38HZCNRE5mSC7m3Sanalbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682003; c=relaxed/simple;
	bh=2LHAtjESN6S66Bv21aGOPHTI3dmXGbwU9JZCPapdB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1zDgLG+Tfx7iAYEkHE+u5DD9/M+4NtG3rLj8DaZmNlQHWPCwIRKz+86rx4ihdswIZRj6gbT6McAOaWUDmDNcvkxKgSZ/fDsSDHpo96BgD3E0DrCmZLziKTilnM7wgIteTXxkOWtDOWYsq/wm8AIXZQfhdVR5LeNQ0noMeGJI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMpgI9sG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMpgI9sG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5655cc850so1803215ad.3
        for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682002; x=1788286802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=DMpgI9sGJclX1xxeKPjHbtMyCOmhACBIszC94dwo5H1v+4wBqn8ST2m+ULyt2zGtC5
         BRtdlXBTEaOrVnwDZlPQT7smUYgjQYawCRY8wXzpC7aGkxwZLcjpkWLu2wrHHNEnNcYV
         OkmTGymwruXEbdOc6fDliAogswzipPLNuaJXeAXfYW4IPMsEYStBxI44q7s3vkuC8ph9
         Ia95U9lYsXjm3buFcznQLc0lSsadhnvSEoc+t/k78tWmrgcJVHkc6tG3U+YtC8YHNlbu
         DJjlDqweDSp1yNXLJaSGojHaNW1WdYnJ2vjjeV+ThKBsnJuBho8k8l5/A2iH0CTjGVdv
         O/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682002; x=1788286802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=e46LE45OkotWZ+8iXYZrGnWlen/g77gFGxOQ9ageiNaD+54xCS9ptzF7apAF98EfSF
         kdtkhNHFzstlc7LLiDnr1rCgZqskoXOyZlciYz/KA/qJs5bwzcBYxYwuLib4rS26tChn
         bfixuyuY/qbtsKPyNzvX2BRIrTWgzwGiyoNnR60LsUJz0AffINDuFrFLpYrCqxkaGgc4
         z64zAsHM7xRx1h7HBKh13F3KQfWgU8Ycg0TVyNtCAhFg4geQkla0aEYkJVeIJClT9Ecr
         7VR85gu747YWT7iTJi4hrYVjKj6XTObskkM//8OLwdyS0dzgtSa4AnwAqDzymGh7zwpV
         1Eyw==
X-Forwarded-Encrypted: i=1; AHgh+RrpVmYBXNqJd7a1pAJ37nf0PzpoLSLyhqovl4LsvNMZKMznIKl8vvgmqHL9+PrbJ0+V5g//wAoDpQ43cMjvOtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ly2RHy+UzAg0nqb3roehioV4TVTgrPVBovwxQ0yWQ+LwJQaWoU
	F+8mjZlb0mDP9qIugm8pKZOb6RfXiajJGgar5qvAyJCNICH9TGKnzIzJ/eNWVuC3
X-Gm-Gg: AR+sD11oOSmHILLB+dUz1LAvM+aalWn4AlOhgvTxsVTJkOPIetFOfdsTcxldPXzk6ls
	dS8tPhEbW8JQ/a4MRz473EullVUJfZYly/3RqYSo4UCTBERWt4b+2FiUGEdOOiF3EPaMloCuSFo
	dxK0nIfn0Wa3frKgg4TMYMgbQWyZAqroHE1w+UKBC2htfLeh2CaCVGbeBlwJ56XLF93K7hZnJ2K
	RyGjw3LGyF2fNKE7piaRkzYC/71SmNnqHpidatDzFCdRQOa+VbfuD/dFT+ibp5xpScjWlvTHd6D
	2PLillt9ozho6q6fhBr5bpW8FuqHlknc7hi5op8vzeiEZY3iJK7oXYfGXwEbi2k8gemv+wT8jsF
	a/+B1X7Blt3oWSMRebJA7AFlO8jqpakphpWpgKx1jS5YTN/waWJhHTHpTD66v92BX+zbnCxrMBt
	HZQ32DOr7TWn4YjEJN3628G7z1fw/BMAiMBvYo6ng6vjegblTmmBY6ZpoyIe6JGAOiYPPemEqjJ
	Y9JLWsyfF158fvJUMw0747gLEbRke9MDqTWODw1hmTFIjTrgOAQ5YnZP9EjawGEGg+jeg==
X-Received: by 2002:a17:902:cf0e:b0:2d6:fea6:fe28 with SMTP id d9443c01a7336-2d707a8eb67mr2980285ad.4.1787682001776;
        Tue, 25 Aug 2026 11:20:01 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm1480549eec.6.2026.08.25.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:20:01 -0700 (PDT)
From: sn0x-sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	sn0x-sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Tue, 25 Aug 2026 18:19:53 +0000
Message-ID: <20260825181953.15566-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_seal() computes storedsize from TPM response fields and passes
it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
validation. A forged TPM response can set storedsize to 4086,
overflowing the 512-byte blob by 3574 bytes into adjacent slab
objects.

Add a check that storedsize does not exceed MAX_BLOB_SIZE before
the memcpy, returning -EINVAL on oversized responses.

Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
Link: https://lore.kernel.org/linux-integrity/
Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 8f57c6111..d47cb7108 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	/* copy the returned blob to caller */
 	if (!ret) {
+		if (storedsize > MAX_BLOB_SIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
 		*bloblen = storedsize;
 	}
-- 
2.53.0

