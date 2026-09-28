Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA40472551
	for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584045; cv=none; b=fR76WDTZ4F7nyLVAmhu9hdQQL4+AmLqaNi2IAge5dm0io3ZgdJGsuP+TAKnp5ZMHHOGN1R5yHk9tKS7De7haY/RvNNCp24FosgJVZpLp+8id6UU/cupIK/fzlxCzjxRmRCFY6ULng3OpInuqxqtDibZjEbZAAg+krbq5Ow7NvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584045; c=relaxed/simple;
	bh=abf0CWKhpj6pL3vQ087zXOZUjUm1ZLL1hnZCQzMvphw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeXIewra3+bWzSeVnfsaQckuqOnvnM3Og99EB+MOBqUVWl6mA9Tgv4FyISLeWyfUc/kV9Jm9Xy9TPBLSSG/4XBGKldjLdFo4/1vqzS7P1RBukom6yC9HvsniGDQbXenRvDIb0WKTL7wrN8wxSq7XrK571UKEBEhQtuXzOipietg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/ZBHRDe; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/ZBHRDe"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1551880a91.0
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2026 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584044; x=1791188844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vX0JjjA39zKKltn0X7k+S3g1AJ/3Xp/uB/9KtblEZgY=;
        b=r/ZBHRDed0MgJCk0LrZCVnXn8x/WiOJyVNXZvGqXCXxOcH+LQkIOILdOsWe7QO+dAp
         Jcr4cK8iLALtqOLMkegHqdxCmB/mP5j5rXYEjU9mMDJzVDvhIpcybaOnW3NUfOEt29gt
         soynLOt3jo8sd1yUmvHQis9F1JYkRCJtIMOD2vtN0Mg0/jBghgx0JIUxTKdB13NAUGUT
         //F5i2eibM1BVgcYmiyUaDepFyZ+yBusPZUqz0G52KXb+XSlJjvT7zKt3+Y9lpLL4CRY
         H7KO61AZpN//bZGH9/vONe6/r+vb8aX5IRKPI5fjYtbjrrEuOhqohIDalNhbtlzoZzQq
         vt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584044; x=1791188844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vX0JjjA39zKKltn0X7k+S3g1AJ/3Xp/uB/9KtblEZgY=;
        b=lBxTKu7a2BpirJ3oRbIusfdkBN/95Ia4WszWyjcpEjuHBRn6MdCPD1GMjWJWk5f25X
         mch/z5ADNENisWGqxsQZ9V45a3sxi8CYNgV0Jfp1oxMKLxEU7xAhgqcX3ndz5Htq0uXw
         R6byL/5roPS0ZlR6an1+wEMO22Nn0OyMpxeL7C4Mra4RpKHSmHA/dgQjMr6q9FMPxbvZ
         0u+xeTB6B83f77fD9hPvyWGYglSbJvB5IS00JjU9OOTSsT7eFTKhNSKb576Hi//GW9sT
         ktneVWywHAl4zc9ZAUTfFGEwY7OKfZGAkB4km1F12WX9kW5UVCH5RgE9YAdXSBdp9A1L
         j+DQ==
X-Gm-Message-State: AFq9FYKG+oLrqtTbKz7B6uSmb3WxP4axFS2khIEyGHxp34rSaQmu5Mmd
	3oUCMTzf6JdpK4cXbE4Jj1bUPVtPxZQ87z0FQ0b3J+B9dYHULY9dstYZw7v/fBeKgax5ug==
X-Gm-Gg: AYBFou2fiyoQChU5AaAdwnJ2BcA8ERvYQw9fo0prBpoqbu+P8UGNKIQuRUabRhSRTRL
	0uZLbNxhr0544g/DqAMdPznpDMpXRvIkgzRhAfqeikMbNmD5sCI88nza63NaOQqQIM5CMyhnILO
	r3J+ZsWaG9O45L5x34l46DgeHJkn/iGghTFuwMARK9U5pIUxyJYSiFBgJsZrDCIwGJq84uDfIrF
	JBuJjv2tm9anBQJmveOf7wQVKMRPN+1YTlSPikdOqMVJL32/txZNOE4Uwow/cuDxzsW1WPkt/F+
	/LVe4syHh5FDTo+IT3qcPjxYylpfuNejnIDPjNXiDSw1YZ/kWdHNsrrilRKr6iFxMSnLQBa0p9W
	FihEQnOZvo88a6bJr74Re6JEpNtiSxxD4VYDuxsGcqSksccwfMe2Ll3xI2hEScGqYBC5YSmaVhQ
	kNwSX94n1Ry8durb+WPudYZPxs6QArChYHMaYrXdsPedJtOA1+ydAgHT8BvhlCYcsDHiInI76cZ
	zviXNaoxOVnsBKR8Usg2QG2cU4mJhy/V4RASpnBtOaTiVUmLF3Bnh4XvrsW9C7uAzT66allNK1b
	EQ/tb0jW/Q==
X-Received: by 2002:a17:90b:4b12:b0:3a0:8050:2ed1 with SMTP id 98e67ed59e1d1-3a0bb6596e8mr7982777a91.63.1790584043566;
        Mon, 28 Sep 2026 01:27:23 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm19265257a91.10.2026.09.28.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:27:23 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Mon, 28 Sep 2026 16:27:00 +0800
Message-ID: <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790568982.git.xuyuqiabc@gmail.com>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2_CAP_PCRS response is external input. tpm2_get_pcr_allocation()
adds every active selection to allocated_banks, while
tpm_sysfs_add_device() has one group slot per distinct hash algorithm.
Eight duplicate selections can therefore write past chip->groups[].

The TPM protocol does not allow a hash algorithm to appear twice in
this capability response. Treat a duplicate as a broken TPM and return
-EIO so the chip is not enabled, instead of silently dropping the
extra selection.

Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Return -EIO on a duplicate PCR bank instead of silently ignoring
   it, as requested by Jarkko Sakkinen. A duplicate violates the TPM
   protocol, so the chip is not enabled.
 - v1 Link: https://lore.kernel.org/all/cover.1789800840.git.xuyuqiabc@gmail.com/
 drivers/char/tpm/tpm2-cmd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df798..a94f4395c198 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	u32 rsp_len;
 	int rc;
 	int i = 0;
+	int j;
 
 	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
 	if (!buf)
@@ -569,6 +570,23 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
 					       pcr_selection.size_of_select);
 		if (pcr_select_offset) {
+			for (j = 0; j < nr_alloc_banks; j++) {
+				if (chip->allocated_banks[j].alg_id == hash_alg)
+					break;
+			}
+
+			/*
+			 * The TPM protocol does not allow the same hash
+			 * algorithm twice.  A duplicate means this device
+			 * is not behaving; do not enable it.
+			 */
+			if (j != nr_alloc_banks) {
+				pr_err("tpm: duplicate PCR bank for algorithm 0x%04x\n",
+				       hash_alg);
+				rc = -EIO;
+				break;
+			}
+
 			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
 
 			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
-- 
2.55.0

