Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513206;
	b=gpo9xryXpdYtChGAmXKvRiz8ozFJxmPJZ3d043b+g2w00MRcv9xTcUQ1fUnNbf/k0DtO
	 XnwOQw/BhnLk9Bii8V4984uOrceFrqltVNUgP3jiacZYCe8fCbsxtRQORc6WJ7iGF8QFa
	 xWAXbeSb2lRRxikO7flHmFtYrmOM1IuAGILeStn8e1KU/D0S1xP7uJGpi2Tmz0JCyoqHk
	 v4hZGm72cOCANGxqvZrQ9fc+wGxA0kjaPMqiqCbYEBAjRO2gDPg6im2u/Z4Md5pQWSWbw
	 nB7HaqIV5bg6DH4iOJdeR/k1LY/vDpZqwg8Hl9djuDueNt0KzvhC3L5uyGpJ84WgHJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3RZb0SnMAOA57yM4atchQ4kYcf66cAOKXvBUnsreAV8=;
	b=ZE27J+H+h039+q8UfhV9tkhqA85FxDZ6oXM88j+Tm2RzpoztY5NDbeEFutzuo1hiKeyW
	 hm0xLLUBW/uP/Buuhcl/7lAluGuHrmhGRC2aDMBnuua68BPHOayh+6yo5RwLBZHvs6E+l
	 U0YvaevW4uUYdoaBZ8nyjk6N3lh6mMmuDX/ecw1+Q2cjjN+AtDbl2riyqd7BMwCXBy0Kr
	 SmH761DY3DIvs20fPPkBfSB9Ys5YIgsJ4orxompwQ0g7Y3xdcFy8ibxCpoNxkkOVvc3PO
	 W9mD5pjVyOiAiNihAw1m1T7+yAd7RwVunfORWBsW/qZGVqehMurfpTx+7nYU8NEHztQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="H2uro9e/";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E759606A333
	for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2026 16:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E759606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2uro9e/
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2927762a91.2
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2026 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513206; x=1793118006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RZb0SnMAOA57yM4atchQ4kYcf66cAOKXvBUnsreAV8=;
        b=H2uro9e/GSZtQibqfeaZa1pdR6pxTxhB/R+lGQeD+iBMbNrUsjlUe6FdxQ3FOwKKk3
         KlGE92cFlzzwiqXPu250W/9XD2x5ROogQdIcU7Uxs1K5G/A1DxTUdiccO9cdPgqETy3j
         OOfHJ3FZwjd7QyqVpR/PjuoYBhV8kqKVoKJ/9ijjvvOaZRbcvQ4apAfZhGZkAV3eI8L8
         TZIyp0fdxlT027WiIFIhHLTJRbWE9lBcltHCJMQ2m/AlDpX8z8+/mnheTqmMas5athpu
         zMBcWMgZ7valtlVcnZQ9xUI/DLcIbNf+KkbwHM0608cJZHbHIJvlPdXM0BFJ1XzZz/Tj
         /09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513206; x=1793118006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RZb0SnMAOA57yM4atchQ4kYcf66cAOKXvBUnsreAV8=;
        b=fIc26u3rStzW4pKNjAW8HXzwAL/dogOOUFEpmzr2Ji/FWz7+4UAgckMm3tcw7OZENV
         vtBVTZ0/Ku8KbgheMur0cS7fffxJyFOZzfmP1KK0dK1Zw/iJosNSTN+dEMJzuOQEfnjj
         +6TcGIwpSlkuQdeE7TChlr6myTSiyzVQ1N2HZUMp9EgGZt43B/025Jt10QP8l+O2fysH
         +NdE0+8kvD0FRa62ou0aKBEWvmZFxiUZS+YE2Ngg2H+JIar4RjaZUg4kODG5wvc6Vll6
         NphGhKa7FEiNdAs3LIxIyvR4uKcH75EfPvxUhpTo8tnFR5EP2shQX+wTNGxmCusI5XTY
         sr4Q==
X-Gm-Message-State: AFq9FYLUeCtmFwjb3eMuLHkU5EqmwAm7BXq9dYRQw91IrPFdrY4nlp5e
	jHxB2rBMSp0jZEdHaTd8HgalZNrlMxmV4796uAANWVfdFNGLOnhlb9bi
X-Gm-Gg: AYBFou2MGjN6iyjv4RMSXg8qaHvM24nlbjwd8c90+6qw67pDotVjjBxqeTHIHcpqZyz
	D4vVwIXZY41Hout7a4Cgp+kB0AeC46M1plkpCOhIUIBuFIe0BuAd3fFeGyixhVn9DP/LHH2uTuv
	pJHkPbrpYOaRedXpvEaTgv308a9zR+V1+gQ9x+LucBmD7zvRRpXQPQQ9tpcOAdiRYuhua7hW/ID
	y8mBhfyDZ0ecG7moFGIniTQylZdmdXr8WQ2A7Voyab4Uw7GNO3Lrm2MS9UNCZnjVHCciQQpnA8Y
	6vqaztrOFicu09fEZn/wPGd4AzQrGWHvgVTqP/SApyN46q5E/j1+y+MnM2xjduguINbjClTxwhE
	09SzMzSaWFP6ZllzlqIIbKfoBAnVnb4v9niy2WzEP56vzYpVtY6vujqM/s+q+ipipaUm/cRVwYj
	hLOZWaoYBaqiMH39swV+OKBWPFE563E0rp/ZdL/5m3X6oTJ+KPKdAItuVEwxC6KBtXk2XyalSIG
	zbsBKRkoo0=
X-Received: by 2002:a17:90b:1d4d:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3acef538914mr9358618a91.57.1792513205657;
        Tue, 20 Oct 2026 09:20:05 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549db75asm5009301a12.18.2026.10.20.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:20:04 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KEYS: trusted: Reject short TPM2 public areas
Date: Wed, 21 Oct 2026 01:19:54 +0900
Message-ID: <20261020161954.3956212-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ateELTsfmHsdCEGL@kernel.org>
References: <ateELTsfmHsdCEGL@kernel.org>
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

tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
does not require public_len to cover that field.

A TPM 2.0 ASN.1 key blob with public_len zero makes the read begin at the
end of the B + 4-byte decoded allocation, causing a four-byte heap
out-of-bounds read before the TPM command is transmitted. This is reachable
from an unprivileged add_key() call when TPM trusted keys and a TPM2 device
are available.

This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=y
and CONFIG_TRUSTED_KEYS_TPM=y when a TPM2 device is present. A KASAN run
as UID 1000 with no effective capabilities reported:

BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
Read of size 4 at addr ffff888106273b48 by task exploit/160
CPU: 1 UID: 1000 PID: 160 Comm: exploit
The buggy address belongs to the object at ffff888106273b40
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888106273b40, ffff888106273b48)

TPMT_PUBLIC starts with the two-byte type, two-byte nameAlg and four-byte
objectAttributes fields. Require public_len to cover all eight bytes before
reading the attributes.

The exact input produced the KASAN read in 3/3 fresh boots. The fixed build
rejected it with -EINVAL and no KASAN report in 3/3 boots; valid TPM 2.0
ASN.1 and legacy trusted-key loads continued to succeed.

The issue was found with an LLM-assisted source audit and validated with an
end-to-end QEMU and swtpm reproducer.

Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Describe the wrapper as the TPM 2.0 ASN.1 key format.
- Explain the eight-byte minimum next to the check.
- Return -EINVAL for a malformed TPMT_PUBLIC instead of -E2BIG.
- Replace the obsolete Assisted-by trailer with changelog disclosure.

v1: https://lore.kernel.org/r/20260925095308.3248297-1-4ncienth@gmail.com

 security/keys/trusted-keys/trusted_tpm2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 30188a0ec6766..fb45795b53327 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -425,6 +425,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (private_len + 2 + public_len + 2 > blob_len)
 		return -E2BIG;
 
+	/*
+	 * TPMT_PUBLIC starts with type (2), nameAlg (2), and
+	 * objectAttributes (4), which is read below.
+	 */
+	if (public_len < 8)
+		return -EINVAL;
+
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */
 	attrs = get_unaligned_be32(pub + 4);

base-commit: 722658cac48a6ba49f5506fd74d010ad9dbb2f05
-- 
2.55.0

