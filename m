Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E64353A99
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008395; cv=none; b=XfNrwkGWMySPJF4rAn3JWgFxRYfpGk5gygsBgsn6NkbGQAkN+RtO+HDudwUAVF6OVkWf11Jf54K9uA1iAw1t+thbooQcGYLsGInxMnTifE3ocL6lVS0xBkb75z0ui8joI/EQuHI1wO7+sgTq1jMTzwIJdOs3Jm+BBJ/JxUMJCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008395; c=relaxed/simple;
	bh=5plLy/akUgnW+2omHUcDOEnJjRaaas6WdXfuN0Z4nP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=soUZWqHBZfjjfWJGdONuOa9E33ZcIJOMJs3HnbWsWgo0JtAxmKgFmHQ03+o3dDXpmSXPV5QPllhl2KY9YrURQ+DN30gdt7i+MDLUEeafeacHHG3qvIU28zw8XWdlHTh94z1JxSe47PMXIxCq+HaPs9LMnAP5BC3PV97VMOLTWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AP0t3lNC; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AP0t3lNC"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so2839038a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Sep 2026 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789008392; x=1789613192; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGo0BucmWwjHY/M/mqoExTi1Uj0ClHrt9derWN+gAl8=;
        b=AP0t3lNChJ+/TnMVFnpsWHoh37Pd8wHsacbBixmxZ+hcHJlwibN9+gtxWfDhAVHJcy
         dC+B9H8iuts2NYiy1/50EAjFtEbzjJhmS7mxDWpCiyEMqQ8c68jFmlS/8Rdz6J9S4gcZ
         L5BLXy6aRXEKoZDHwI7bT1zTXJXlUTYguRwoCaiyvK8TtW67AEVEg++T5oQ865Q/w9mG
         44zM3oWjIomisQylcXZs42H2iXQyX2XLvxTWdYYmsT3L+qI2ON3rgERWr9TAAfzgi9Yl
         92pfQOYxE0ceaujFzOR7+UEVRcpMtkEFKanZIuPFFMIGv54Hf0zq+9WEiqTVnGiWFMq5
         4l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789008392; x=1789613192;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RGo0BucmWwjHY/M/mqoExTi1Uj0ClHrt9derWN+gAl8=;
        b=qSYl/BGCa56JDzU/xN5HFc07edmLob/KtGDTodnLpstaHygdXdEBZQNYwqekQqVI1N
         CiqsU8UNbh0RwP6B3gyTd9CeEOMykwqEjhBKxFBm6+qByYY5jhxFxRY+iVO8SdX8J0SN
         ZOY/J2vALzbYmFAyNhP1NZM2ui5CA+erEt2+It0GmN25tL633NO+ZdurhNs4o3mQ9QBJ
         uca01YLdjMJp4Z/BcGwo00xOnrQPcVSOWX5LBTrFLuSG8wVRWjcAenvMR22EHk/to57v
         D8mrdtcIlcN6sPDTenCS1gK4GXwrKyv77OJlKpUFeGzlY/gXCgUoE0tnMYKPADC0o52d
         uURQ==
X-Forwarded-Encrypted: i=1; AKwUvBytYOfQsMklkAob1rAIgqtHZI4NdKoQysrvdGDia5RwzyY2QCTToxnUbzddxRud+30rIigAuVbkuA1fweD9PHI=@vger.kernel.org
X-Gm-Message-State: AFuF++mBhKIujylr60UrQCyS2BzLKBqXKq0HIdifGSNOuK49Q+MMWoK/
	YvWPbmbpKpK71mPJ8/qxyNjQsxemmHPy1wXUJc8q6y0BW0jbi4gX4jpDBHVzi56HOy8=
X-Gm-Gg: AYBFou2dRn8Ko5jKsCh2yj330sHuqrZj0C5Cx2Fn4uNEe9F6KrLiCib1jAbjinBzPMs
	vT5dYlP2/h05AKPr8aru6fJpRMC+atlr+8Vf1ko9ry3UA9jTsfSzfaADGUlz8V9cRJO1uKoVHUp
	Dj84JX4LYhFFZf60aCkQ9IFaHRIz10vi0R1+m+DrxO3U9tnqewqOIONOW6fQ/lFLUiWDQEO27A+
	d8vkK7BwCriZ6W+Saj4IKDkY6O084vvhTkZA7IG+L057Xg+4xxnNdjnaHQ+DQVQv21bQocg3jeP
	NEW7BYK7tVcGzTjhZHuZhxR/RZs7WuKalpSXpKfWdiNUmHKZSjsgcduD0mfV1rcySttYXHmFPqe
	TGg4+YQOru24wSYQqhWaPScRPxa8070BmcgzU6UvI0nBuDgS1pbnm1ithiNRo6iDseHlaehKulk
	qX6T2+8A9UKhWVBN/kdnC8q5JHnqqPWsEu06DyQqopTMzvM1VBIVZj+ZU4kH/aD2e/jI6/Tmwj7
	02MiOY3WiW54YAORl8mJNczV0mM
X-Received: by 2002:a05:6402:c44:b0:6a8:3962:2b85 with SMTP id 4fb4d7f45d1cf-6a98df800c7mr7115034a12.3.1789008391853;
        Wed, 09 Sep 2026 19:46:31 -0700 (PDT)
Received: from r1chard ([2401:e180:8d23:5f05:2c5b:a1bb:33f1:a712])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770bc2e1sm2641321a91.1.2026.09.09.19.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:46:30 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:46:26 +0800
From: Richard Lyu <richard.lyu@suse.com>
To: jarkko@kernel.org
Cc: fourier.thomas@gmail.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
	richard.lyu@suse.com
Subject: [PATCH v2] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <20260910024624.41195-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0
User-Agent: Mutt/2.2.16 (2025-11-22)

The comment above the wmb() in tpm_pm_resume() states that the barrier
guarantees TPM_CHIP_FLAG_SUSPENDED is written last, so that hwrng does
not activate before the chip has been fully resumed.  It cannot do so:
it is placed after the store that clears the flag, and therefore does
not order the preceding resume work before that store.  It also has
nothing to pair with, as tpm_try_get_ops() contains no matching read
barrier.

Drop the barrier along with the comment rather than leave a no-op
behind.  Should such ordering turn out to be needed, it would require
paired barriers or locking.

Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
Signed-off-by: Richard Lyu <richard.lyu@suse.com>

---
v2:
- Drop the Fixes tag: this is a cleanup, not a bug fix.
- Link to v1: https://lore.kernel.org/all/aqIVn0cDBvIYKggE@r1chard/
---
 drivers/char/tpm/tpm-interface.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b4e749e70b02..0bab78c8767c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -497,12 +497,6 @@ int tpm_pm_resume(struct device *dev)
 
 	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
-	/*
-	 * Guarantee that SUSPENDED is written last, so that hwrng does not
-	 * activate before the chip has been fully resumed.
-	 */
-	wmb();
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
-- 
2.51.0

