Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766261;
	b=whdg56GWS4a0IlBSw907iJXZaKXsVCgVDImcdWIUqeTneNrurtLKh9/RCiGrTuaQ5VEv
	 HgEv7zsouZ6JzTzH8/bhsRI9Y1qa1T9ojVjUJBFB+DP7SR47pCozRHyrtLsn5lc3CSMuB
	 nzo8G9bG5pukN0Jutvp7PXMBxJtfNdKfSGw8jU87/vZFjf8TJebwGRp+kHaPwPTn2Axb0
	 xuox/UsWD5GFR2LwwCu2c/c0re6UggAMThg8XZcRpTjfVom5Par4NOA4tLFKmwytJqumU
	 8xXfTG/arOWUO3pbt8UCWqGr2YPpCXYiMBIQOPHY0sLmXtr1O/5ezB8Og1nONdu0l1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
	b=opLfwJ7g8YKppN/AmWKhaHz4smeF/rNJ7xpfXoZK+gjbw5dFZDel9ikHkckXoZLEIQ8V
	 YY5sPOpEZaEOmLJ9Tc8/vT+V3yFS8ts7Jo0p/CcpmseNqmCNwhyXp9b+r9W/pKxkAaRAT
	 L/uQAwOpWy/H4rzXyTYxmi9j25sK/HHopKtmqCqdP1q3FePmMEHvsQFhbOoHP8J+ahNO3
	 wTnyxDvDobkVIdrE7JemuF8oCB8cl6CSQVXacLeWX2/GQf41PLFe4nkqYiO8DGN6hm2VU
	 x5M6Woj1EkvwlDKbg0FZUjiB4HvZAUrUX2iWJzUerbWhsCahQ7IJkkItcIvmiIqpXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VljMGSJL;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663B606A31E
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 07:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0663B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VljMGSJL
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386b8f2f671so4512333eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 26 Nov 2026 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795766259; x=1796371059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
        b=VljMGSJLexutiimCumKOoGUm6WsO6r/0+Z+nXt61SWCA+zdAzM06ZztMCKGHP5EFiY
         2miqjQh01oYY6Vkt1FCTBvV1m9iWlhmsjdsU/ne6eqvLoVCQqhEGzpMbd0dDaTjcnHkL
         ofx5oF9kCDnCON3nxwDvOdv06bVfa2YMcco5eDy7dvlJQbnDiol+7uZqUuiAs4CaNQyq
         O8DQWDvUbJ6rm0vWQ3iBKxBq5PyTbMubnM7o7d63l8JsHx5yUs7nPpLjd8SWF54fE+fF
         ej9rj2DVrUcKf6Wc7eFW92ewj4XjHVg6tZhlVYbG5GYz0vk3W4k7yEfR8iYtt0ns7AOT
         rh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795766259; x=1796371059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
        b=OiKSoVcOpvp/3Qg4+NRVgf4CHO2wkwPdSfwzlsp0S2B4y0HYsNT65kLRSPcKydq6TS
         iMts+TC+3NQd8433oFFfWc8dDqWpH2ouBV/nEcpOEXd+SIysdP7wBjZHLNsA9Z/7FYi0
         oey7f3j0KScNH0PEdi7OWrhsTXCLJs954dWfu2FqnkU8B1CcSn2HJMdHaslpuWnj9SVB
         cN/9JzUGvJlcrfuTV7EskIAsiNsqKY/rbVu5OK/Ilynb/nHQdUH0drGVhSvFK3vMRk3w
         GIconnqFeu6AHPBydwe48igj4Xq8Lslg4WE7JoOvhm0am4LWV1pgGVxRJQgP2/8p1VLz
         BbUg==
X-Forwarded-Encrypted: i=1; AL+hErEbES4ngySl87qs3UXxWLU/QVlIC9w2MGqUZNt4lIZ/VbR6fhMt1Vo/ZNhzlx2MWaEPqw1Uz2pxmcYFPS0VsPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fe0BoqOAq+jmpvjh/MCILbzQ8loZtMiXGh6dhoVsYQ3Ludct3
	pmPY0CORBRw8DrfezI+8bf5ExeTmetrJyXRs3fKNhlMRSasjsrs16j6A
X-Gm-Gg: AZFdTZfaDfFUp0NBUkAfsTBP0AUT/QRup/tgimq8vh4Umbns9xyc5ewQ83MGqLuMoHe
	tUw7EfJMI5Hvjv3xhVQqKFYsXxBH/SsZenMeHi5B6K18aVCf5Wj3rawLOmthLdN9XUWJWbS4AyG
	Sfam770SEDKXmaoj4oRXJqibE8zPzeUPTWTvxrergS75jLe71HRFFvXq4sYf9frLpbFHsIK2o0a
	sICRf5njLB5ryYrJ4KtNq5wSxgOqJP/aTF5qMBQKQzrSa+VJh9PyCSwFxh2ZLq39Hf/4zEhw7aP
	rkzKbWOcALiq0Pd2/KrGwATX9QR2Xwa6Z3mc2Lodgob0/gxuoOCLHczVgMFb0bDPkXCsX5RTlD6
	d0ET93pe6q22+3tizhYoHgwN/DOaPAFfNA0K+sI636CgOQifFUclWDiKEgQkqwWc1dZHhAQr0cf
	e1jBjN3oRqReZ1tc0s3UZPL9o6AvHNEv8wNW62J0QeW+8t6yL8folVW7Wyw2GvE4p/TSZPomzbI
	VXoqAO7JfBsIJfiaBFrD4vngwIQfMZs45aqa99MZNMzITBbkXEbkLDK+V2pxT6mlFhIp17K+rhq
	KwjCiguQU4D1eUZwuDR0CLuH0GTyuSE9es08Um+yLJrOVK0=
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr12774546eec.34.1795766258950;
        Thu, 26 Nov 2026 23:57:38 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm65363944eec.13.2026.11.26.23.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:57:38 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: allocate the new hash table before detaching staged measurements
Date: Fri, 27 Nov 2026 14:57:32 +0700
Message-Id: <20261127075732.252471-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

ima_queue_staged_delete_all() moves the staged measurements to a local
list and clears the staged counters before it allocates the replacement
hash table with ima_alloc_replace_htable(). If that allocation fails, the
function returns -ENOMEM with the entries already detached from
ima_measurements_staged and never freed, because ima_queue_delete() is
only reached on success. The entries are then on no list, and a retry
finds nothing to delete.

Allocate the hash table first, so that the -ENOMEM return leaves the
staged state unchanged. Both steps run under ima_extend_list_mutex.

Fixes: c26d9d9246cc ("ima: Add support for flushing the hash table when staging measurements")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_queue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 67782c004cdf..d58b33950bcc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -377,14 +377,6 @@ int ima_queue_staged_delete_all(void)
 		return -ESTALE;
 	}
 
-	list_replace(&ima_measurements_staged, &ima_measurements_trim);
-	INIT_LIST_HEAD(&ima_measurements_staged);
-
-	atomic_long_set(&ima_num_records[BINARY_STAGED], 0);
-
-	if (IS_ENABLED(CONFIG_IMA_KEXEC))
-		binary_runtime_size[BINARY_STAGED] = 0;
-
 	if (ima_flush_htable) {
 		old_queue = ima_alloc_replace_htable();
 		if (IS_ERR(old_queue)) {
@@ -393,6 +385,14 @@ int ima_queue_staged_delete_all(void)
 		}
 	}
 
+	list_replace(&ima_measurements_staged, &ima_measurements_trim);
+	INIT_LIST_HEAD(&ima_measurements_staged);
+
+	atomic_long_set(&ima_num_records[BINARY_STAGED], 0);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		binary_runtime_size[BINARY_STAGED] = 0;
+
 	mutex_unlock(&ima_extend_list_mutex);
 
 	if (ima_flush_htable) {
-- 
2.25.1

