Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A241A553
	for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764095; cv=none; b=cENXMhOnU/XNx3kT2puggqRkE4cZTgdYnj93jGephefkFAY/ZCS3kOokfDfK5mAy6YEPaSeTgieQPVcFhW4e1PKVqeCaTLjvJzJM5Cp/Aad958llqokiuX/1FS80blTCiGoneZu/JVETrgWtqJd/4oAFD5IxaMirxEYJAY76TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764095; c=relaxed/simple;
	bh=adQmRDDMdEGHtE5WpnEdo09OXdFUdHwAT/L+LntBHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyQ+lBjueh9eVnS6e+cnoOflJiXArXzzEC12PtyGpAeYMXONV9A2v//btz/sXgkgXtXQK1sAYm4HEtZ6tIVGKjRDGRt8xcD7xUL17c54CdRJXOxoqYLD2gW1qUVFSJaLba7qX6sOJM4jIN+nJ94uIyrSCelyHmh1ms195q8w03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpZyyOmn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpZyyOmn"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso1638634a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764074; x=1788368874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=bpZyyOmnCJmgCgVZBMX3CNnP3aVVc+YYT70KgS+9inyaKNblvSQ6Gwgh128S6y+7Np
         JLs41SiVtaQNTKtoJtAL5yFpbmTNik0O4AAXlkDWhv+1a3agO7uWcws2hVcMlcWBk3un
         syqDlS9QjkMtrdjng6cmqDMGCt2kvOeiKybHw3OqIUVReoiTfDwSKcgZGhkamipE3362
         BoS2A/tEvtaxlhJd55OVg92PEu5gfvuEWdcPiIPimfSZhyaFh0Wk9rCK6KZ34ygcGIzb
         9Sye3Z1CSHriRZkZbk1VNTmihXVwf63vCJt3pw0+d1JkG5NGffvaP1nBPa34JiL5v1sQ
         LSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764074; x=1788368874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=aEvJN/sP8eEFIuB1u0/FUzLgw7endm+Y7oAIeBZ7hjmxrMfPGbzyQKv6gWh/17hGbA
         Qdejwbn1hQvY1h59ApbftyfJlcXRRntjlUvBb3r/T3h39WiSyWdQ/jXkbiuU3GemagfJ
         WJYgC8+wecgCxyzGMKChJIdeopqpNFSnk6Zi7vVPolasmXQpfyRaoPzZNGsnoa/th7uF
         NyAlZak3IEhaVGINiUBBQkk27dmK3rCjW9QrY/iAsLY3ZtkaDakT7PQ34pLZT4tO2rC1
         dsw4j/u8Pva2C47y/wEsjUgdxeMFoDUunPMowZqq8xetFswHtyYRj+WMBXREYVTKmf4W
         Swvg==
X-Forwarded-Encrypted: i=1; AHgh+RpL+iu/ftRdaOj4yZHtLUBFBYCljWkr+5NKyYElFhNiu0NdqlKHufYsHmyk9VrzwOPS+wClOkUXOThf3tJpaX0=@vger.kernel.org
X-Gm-Message-State: AFuF++nmdPmzfiSO0jNziB/O5H7GB/z4/7+2iMhHhwa8kkJFyMSi7zUf
	DnOIm6fC7ROD1Isp80HL//GheiDyvkOewTgUk4rC+Cn80MfHp8stxQYfsN854A5r
X-Gm-Gg: AR+sD10PzdV/AuGYLWktQJp5U4HaueSBlI5l5tTG6RciNc60DPgIYh5ysgpmEtnRVcK
	mB7q86NdWqE4H4zAzD9h6/eIRLZ2ezw+tRmnkj47EtcXUplEQtC9BZIbyz60KcbUYO1xNp84Lkw
	7m/g9ZhuJkuCD6CdmARcm5NGwwbdBv4mw3ksCZEqejBLNg+wqAnKH1uC5ztqEXewQgRJC05UD/1
	ENoOwZIrEjqLHuX8XOoF490TsfzNKYaD9p9moQVDcrAI2eUS4nr4LUOlR/nodmBIiNmy7a8RhwY
	LCir8lFnYO1axw/wyH1B/nKcVPKnW/7Z1TTigw8iqA4IvmlmeOnOFJBkN1mrpnmm2RQ8T3dtFYd
	KdvsCjOe1Qws3BVTo5mzNMGIMbIx+RCTOG7rArsm7wXyxX3yhzYBDvWrU1UJqF4w0MyYm6mH9QY
	TK97FVulWlCws0/cUjbjYy23rJQrD24TO1UmpJS9Mhp/d7YjSVkAdOgYiOwcfuBjyg6UHfnLH4g
	1wmCeVSfBZoBNeAcrPGBThCuQ1AlV4KwtlaS854z7ZV4++EfMcHROD3uNM=
X-Received: by 2002:a17:90b:3c12:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-3966d484268mr19640797a91.15.1787764074277;
        Wed, 26 Aug 2026 10:07:54 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd82sm8945491c88.2.2026.08.26.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:07:53 -0700 (PDT)
From: Sanket Sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: sudhakar@linux.ibm.com,
	gregkh@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	Sanket Sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH v3 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Wed, 26 Aug 2026 17:06:59 +0000
Message-ID: <20260826170700.616-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
References: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
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

Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
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

