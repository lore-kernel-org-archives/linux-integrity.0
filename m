Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308083B7744
	for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731510; cv=none; b=uUAXvfk2nF8Leksj5zNAw6x6Es7GtXKxco1jiPziMx9IKwKc09i+YIsx9jGeBYYyDfj9/+TV3L8d3KxzricBUoOujVm+OnBxhqxcbGkLfs4dXX2ic2sLERyEhOQE/PI/ZahYDKOC8RuIrV0blALyizwQcfhdIr2bdk335JINHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731510; c=relaxed/simple;
	bh=adQmRDDMdEGHtE5WpnEdo09OXdFUdHwAT/L+LntBHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVm9hm2D2ZxPlusgGRIPa5Q079o1qink/dPf0WdPkrHFrAu9Y+HNnOvZfkwEB55T8G0faErpnlFALM0k/Df9JjSTMlHH6n6HyFz+oMVOBZWgMLv+w7GiPr78akQzAVzuqDt61h0WL9b9WylwvYHUzDOTbwCw9F9sCe5fpEiHRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl4tMIFT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl4tMIFT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so9538945ad.2
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731508; x=1788336308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=fl4tMIFTFn8KT1OAjfI+5im6kY2ISfRFvcWma/srmjWcsYWUgeSxRMO3tbpwySB02T
         rYfkSUM53AorEpSwTipYRVQLP9v1DM+w/Ku5xdLaRYAkVTlbaqlBsuC0jMS1XPlgPSa9
         kaXPvC6JMCi56YITMduWAzDQxq9Ccpi21w7REhhGZ7d0Cbxohnopu+1/vQRu80rEAElL
         sh/CZOGC+tHku8h5O0LiK+n7mta1bJFSZuQY+SuVxVx+zgujZjnbIAepT3bGRVoNihi9
         TyNABhzxi7F+AoBT+nGQDIUVbFj+N4hqrYZSARHVq7FU/y/ScAiFtOsPoSDURc3RP8/5
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731508; x=1788336308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=M9lrG23NDSNjuC529FkRcnAlIb76mobpIm2Z1cvOWwHkgED0XVGGu0KeXwSSRJmA0+
         SsguYqjCRv3i2F4yhpGosmeblH2aH0a+8VQKc3BnvVSK7eQoSjFr2Q3L1XPfO4zwzRoT
         20rE4hf9xAC7O9lCQG64TGrMUKbxHznSDlNHE+StXMLVlZw1ULJclWcFgbG7quAk/VMb
         7K8bcqg+UjuuH9Hjwa2mFKjfveRWTY7PWsKY6z8Fga107w1aSmoelCfcGW/EZS6AsVnR
         YYjWqVGvtWH9ql0If74Pnro3mrKf8oOZjqDxT9xN0D/g4BL2cbhZrtgWVWo4fGmpB1D5
         HKZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHklU1EkCPYdJzeg+Ccvuhij1AJrjRuAWWP8WKOflA3O3FlgFxrd3tz5iQSpLU7bJ15nB2ZEppn8Tq17JYYqc=@vger.kernel.org
X-Gm-Message-State: AFuF++lIK8HKQiG4W3BiaewOXe8lqDFmH++rloJIO7S908muyFQvTvyE
	CQVknzImiOLYwvnUYJ4FD017uGZephbeF0pIw0B+N/NSncOGPnr/gjhn
X-Gm-Gg: AR+sD131lelikRwgD/JvMiUmfhRDNNqfEWUxbszK6+DdwBZjJE9wGWC01HHRKuvP+E5
	JTmZhBiijMDHJxK+Rm85ZU6s4X/dGILfF0HR3+xeGeIsIL+K+FRxS/cS3rxUem5NXA9TxFIht1Q
	uX9s/L9nkX9E5kduovE3PWMWY8TU0kz/fjAJxS3kiXMF/nSz6HFQ2jFKmWq0rqPmUrb/x3sXmiG
	DK3LiB01VsF6dNWT9rGQWUOKGFRL/kVmE1JemtkOJUeC/btVGKiyaO3HinPegL2rl1QmlC8TcHt
	BVFh9Id8LWXeMdTbzqdjKF5xPHxZm8OR7NK/JSnsUZUkchqg5rwsW+w3XjTWhymNq2JlXpeqpXF
	F1fh415V5Tcb8Zyq7aRmtXd/pX6nVVHAIJFyQv74iYFzJKK1IaFwHZV8Z51Rnjmwy+wm+NXryKE
	06JLThndI/0ufhNeKQLUQjH+Yn2iH4akn4jRRe2w4I8iZMSjYQ1gX/FZrWaVamKzV1HhXl0YU50
	5bK8TkxkUKrJ+RVsmshoEZ8gGNLAmgNtkxLZPt5rAuh7uZU67qAcki7Nos=
X-Received: by 2002:a17:903:1b08:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d707b7f5bemr88598635ad.9.1787731508372;
        Wed, 26 Aug 2026 01:05:08 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm9566068eec.5.2026.08.26.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:05:07 -0700 (PDT)
From: Sanket Sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: gregkh@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	Sanket Sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH v2 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Wed, 26 Aug 2026 08:04:04 +0000
Message-ID: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
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

