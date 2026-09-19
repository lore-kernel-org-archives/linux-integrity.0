Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322903C0607
	for <linux-integrity@vger.kernel.org>; Sat, 19 Sep 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807642; cv=none; b=E6WVX9gGIP69Dxgv0q2Up3qMNyOfjEJZ19TySlmzYG8E/+jDZWiGGeBqTLehSvSksx95XZRxAovVj54TKgCyDlppzf1xzubxE6/y6FJs5aKnp0oiBqrg4QvpK+7AYfQyz2YU2rdpyfbeL5rFwi+1dL2HNPptZqJ+cBJwE/MAJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807642; c=relaxed/simple;
	bh=j80gGp1mQQqYOGLc25zXbELHZ56zd+Nm2USR78qFXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqGW5qxEJGwdwBkSBByu6vtplJt5V6yfGCGzntQV45860WnH4oeZONH9H1CY0XIm2vJ4MidGMllnbYy7Lf74yMSBry7bcexa9Q5dA9IdHWUVoGm17uf9e/zZTw3RfglfLMG5m1o+kzShcLfNpxlNfxmfe3bpey+kwxTqkR4YB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5UGpiLg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5UGpiLg"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso580653a91.0
        for <linux-integrity@vger.kernel.org>; Sat, 19 Sep 2026 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807639; x=1790412439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKrINCbjz06iI3XHAyCAb5A7LBzsyEXpm4t3U5fKalE=;
        b=P5UGpiLgCKwdiIFY48xloNe+TX+JpH8KVHS0sicyoA6mw5cHeULZzvf4AB+3Vrtxqg
         WB6jQcllgZi4l5VcHKYLC7zy5tVlN4EVqbwBjnEWez66u0qrnKKBOMzGh/zOFzCQ6x+U
         7O/FSsQYI3sANdAn84dFhCuxnYVeZjOqffeGdS99FArK2k/dpqrHEIhjQVwxZS46iaFn
         +6olXjCjAZc3XWx1SVb1D0VAlt22iJzfsCuXa6jyiMqhPZDy/f5Np75ErqoxSxAPZD64
         bk2/SHvq7pxDJRSCfomOyAklH0hMpStEQDb/4G3z8+iLlL+lXcBFxfFdjpTvXcy4Er2u
         HbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807639; x=1790412439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKrINCbjz06iI3XHAyCAb5A7LBzsyEXpm4t3U5fKalE=;
        b=lSog+0BqRUhLOzjL8+7ifsCMtRwGEFAq0ZbppL5MUJVEL65o1DKkp6EqbxXvAp/6fo
         m4SH34MUv5yYMvqt/R+t/bv3NdgcCD0GMgyGhleTu3tRn1C6V26USkYAvrGZspbMBoHx
         8JGYGD4QH3UHlHkRVzNc8ndDCbQkXG/sOg0aaBi4jFIfB89GzTHGp6dT7ueiOUaY6r1m
         H7v7H7LSSaeOOCB5tKlNvpC4m+D2gBvH2aMFQ6jn2RbBgwLpRYdMrxSzTT+UVQ+3InNE
         vRJ8muROxkLMZ7nOAUyot1s8/+/H/tQ7HiKjebYR9u/pN81yDIKqLHAfJ+VUkNxTfqyl
         W7mQ==
X-Gm-Message-State: AFuF++msdpPRoSkoSJf6sIl2hSzlbEOeJPlJwk9zmrgF01bXbIek86Gc
	KfnSyGCBo24H3sbXIU21Cwq5SaCdSVI6zpruyFeShl8FvLmkeQar4l/cHvGkww==
X-Gm-Gg: AYBFou1QUkmZSwoStUlSGECimPcclEOaF4/IUZIwkjNrN14BKcAjO/YppHGxQZwZ6BY
	disb4qg4IWHrJHsrbbfWGWTgnO3NEz8l84VAakJMfnD9ZmxdcPhY1brBE1TDhWvAhdG28ktggq7
	JpN+falosNQ7/R/voK5hXiC7Hv7P2c2YG8Zyr3PgqRa2gJ5+Auc4l/u4/FXX6ChM+lliUWanOPZ
	NCyLhXnPvkI7PY86WCtOPof5U9RqX9bNk36nWLQPoPPdcIa9bNlOY91NJ+lYRORFGI7sV8i0ETy
	V13clQrgF+MIqnYbJD+vXpcAfZHdJcX7EONZNZlnKuIh2z2dkqmE2vVzx9dyaOJhLsPooEM15Jf
	o8Tu9wh6FvCu4l2emiv5R4BVJSg/gwF3obeMai0tQGNYg/YEOKhaK5pOZeI9M3WBN4Fb1f+AJvN
	/Y0tR2/3ei/2eqBjHqdReBjua+TyOcyw+fLH4CTF7sP/XOVNAqIbxGEG/vgYFrhyImV6GgG5Ajf
	yZ77RF/s9qVIvEKKvbbGJZIkA+m+coJIjnY+y/V0psHsR6MwW+MmS28sBQm8l0pKIRwlg==
X-Received: by 2002:a17:90b:3908:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-39e5565236dmr5237971a91.10.1789807638878;
        Sat, 19 Sep 2026 01:47:18 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca871edsm3492881a91.5.2026.09.19.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:47:18 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 1/1] tpm: ignore duplicate PCR banks in tpm2_get_pcr_allocation
Date: Sat, 19 Sep 2026 16:47:00 +0800
Message-ID: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789800840.git.xuyuqiabc@gmail.com>
References: <cover.1789800840.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2_CAP_PCRS response is external input and may contain duplicate
hash algorithms.  tpm2_get_pcr_allocation() adds every active selection
to allocated_banks, while tpm_sysfs_add_device() has one group slot per
distinct hash algorithm.  Eight duplicate selections can therefore make
it write past chip->groups[].

Keep allocated_banks unique by ignoring duplicate hash algorithms while
parsing the response.

Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 drivers/char/tpm/tpm2-cmd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df798..99e9d89b18e1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	u32 rsp_len;
 	int rc;
 	int i = 0;
+	int j;
 
 	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
 	if (!buf)
@@ -569,13 +570,20 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
 					       pcr_selection.size_of_select);
 		if (pcr_select_offset) {
-			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
+			for (j = 0; j < nr_alloc_banks; j++) {
+				if (chip->allocated_banks[j].alg_id == hash_alg)
+					break;
+			}
 
-			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
-			if (rc < 0)
-				break;
+			if (j == nr_alloc_banks) {
+				chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
 
-			nr_alloc_banks++;
+				rc = tpm2_init_bank_info(chip, nr_alloc_banks);
+				if (rc < 0)
+					break;
+
+				nr_alloc_banks++;
+			}
 		}
 
 		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
-- 
2.55.0

