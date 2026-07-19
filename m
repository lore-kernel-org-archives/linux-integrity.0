Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3631FC110
	for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479316; cv=none; b=WGWht9RF9dwSbUGiMAui41ER6zvdCwcqRUne1Sxv91GE31oakSKTbd5mtyf/jJ2bgLvezOBhflKc16SVrwTdchl6f90wxRtL6T6P4fieN8JJVr2xuW0bM7LyGxPZiVevxnkX1idlDswgE0LabhOmLC1EIYPN55uuwp2OHw5sFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479316; c=relaxed/simple;
	bh=kM9lXnzDuQLhmYTlwT6DIah52BHbORMFMEfPJmUpbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmkOERUMWWNI92Azgud0z3UdtT4uSN7fds/3lRFeLpXaGhnj4VcLepRvLNyfQ6yD1oi48t8dsXmJ68DepwpIxzGgwNA/qYMKCbZOo+/bF8KROMe6j/eaTMw8Nbx0gB3nA4U5Ptbxca6pWnx5ZjunPD10Emwhm6T3QDr2ag7MUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=deKZ3Aly; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="deKZ3Aly"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A6A33FBDD
	for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784479310;
	bh=k8tWkKjs5KjNi+HuqkD4ay7QtP1AHEL1UJFoTXYC6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=deKZ3AlytP/kcBPqy5ioK/HJ/XBtJRiOo7U76vruHbgk+olFsN8rpkXvVfvMmroQe
	 1qfiSXIY4KfqEFL1wQx2QrmV9EuPQz/xZjuQjYnG9xycrP2yA3u3o8jyPoeN/AbXC/
	 MifxhD+sDHCnyoByH0KU0IlgSLNifR/r9bi9Ps6VrLZknblDD4awHLA2iUDn6+Ju9+
	 LLm+L2AZouRybgHFYOaZxuZja11T1qkk+bF8XB89KQnhueMb8PA8bMkBU5jHH+LBt+
	 WxoOqMnmRubYlU0I+BUdNTBxxAfEea1jSq2VBlLgMg6KWUcsM9FDoP2cjyWZD/SeGK
	 n+XJ+CIQ0tM0nUmM5SA1Y5fzPh0ada+e1tIo/GTXnGRPkj7RwWJoBHdedKQ9AbWo83
	 ZbtiGQOCYFinbDg9ulemPMFyKnBrEEZ7g2ZkZAGOxfO5bNqOLjU+nv1P1Q9znIDFdD
	 iZaNPNABT9oUTmpOTtG2wUGe+2XdDgZCubp2iP5FmCwYHCJYwR5QLqqUH/ShEAefOD
	 iRTXk8tQ9uuXbNwkQVAOCNwDtQQr9tHDUTKQw9GgOTEvcKKgmLucr0eze2andQ40b9
	 UZba0s8MiL9hxefhGiUcrjWDQeq3IJsC+eQ8oViTsL0SxRqST2sDyc9CgaNJdP9U24
	 j2E5IWt/twjJB46qlSPlzsOg=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f7700ffdeso65090f8f.2
        for <linux-integrity@vger.kernel.org>; Sun, 19 Jul 2026 09:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784479310; x=1785084110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8tWkKjs5KjNi+HuqkD4ay7QtP1AHEL1UJFoTXYC6Ys=;
        b=JTy+pTe4BnoEajCnwT+kR5LF2wcHHDp0R+K0/4RpGy46h7Ez8BMrlJmODvVWaH+KXX
         a7NnWtcrNe0WmxPxJCWuh6omR8WnE3Sx9UAKnT0fFtd6/mm03oLhI8jOOnIcmF21LCtd
         l/gtkQ4EzYTABvXDVMMJaSlKbbmHIOgcOQz3f/qRnBB35SieUC6P37gN57u+wr/gUEZ0
         xPQ5PsbROoPrlBwm6fZFnLO1U1T55+bHZqLNXI+YxAFoVR4j1Cw7irSlTBxdt0+oW12R
         Hw3lBmO9doJLGIGoDkUKWyi2oeW25F9vxbqADmCMQdIxth/BwRMeHKn/d2A0A/DBcJyP
         kWJA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1PENsPDpSxurebTLVaIXfSWJUfJRPl7hYc47RdkG8Ns/dGJ2c2pC1rc+857WdZLlBMozQ/551FZPj4q5lFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKK9aIrXvdRzM1MlOnQ7GozJnrpuEgNitwfEuc/yljQkBF1mo
	01NAqi0JwMBOpesWbA6UvSNIazIDobPfgJQ6Z7JmQHe9v6vfdtyVmIWo65/H+AFDxLg8SY3LlOd
	0L+GvGFWNnKfkbpZPrB0NOIqJX4UJLH4Unp21QQq0+j98+29sMQU10caanT0zZkfWKCx09zR1cR
	snHv+s3rOMGA==
X-Gm-Gg: AfdE7cllWzbDnKqXSPAL02pbCq+9JogtpRZIh2REg8girCCe9qsu16w2WAIPPuE9irS
	oJgrQ3NDNT3GRwFBhMU6SiqOj6rbgIKjfDt5/Da1esJEV1HHQ8vDaPz4+XKNqNcuI4ZgPWRV0K7
	YeHBO/0OaJoKa9GU4g3BeKjHE4QK308DPRY0UDX31ISsaqq+YkjqoNi3bq6ilAA7P/4DthMjZUB
	Po3zmM/SXKU0wKm+qo2K6bBKYEexhDUI1ewIZXmeqFXZfkTqACpH1NoTNTnwhNVL2h/5wsRVqS7
	Pl2/fwMLrxjfiWJrzQKTyxJo3y0gLtrnwSGo0/4seBTP9mN9mM8ZpFpkhWVpR1gk5llSyHqwnMu
	1rXUY4JtdLM2YOqRfppdHZA6RtVItSY7e8qgG4EozCjg76ZOxFSBAEyYNs7E/ypjQnBb+4wyye7
	nQbcJxvbPO
X-Received: by 2002:a05:6000:40cf:b0:473:a376:815e with SMTP id ffacd0b85a97d-47f6232826fmr12998056f8f.33.1784479309842;
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
X-Received: by 2002:a05:6000:40cf:b0:473:a376:815e with SMTP id ffacd0b85a97d-47f6232826fmr12998029f8f.33.1784479309435;
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
Received: from t-14 (lfbn-idf1-1-452-109.w86-242.abo.wanadoo.fr. [86.242.159.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm25378442f8f.11.2026.07.19.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	david@sigma-star.at,
	upstream+dcp@sigma-star.at,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
Date: Sun, 19 Jul 2026 18:39:37 +0200
Message-ID: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alv7LVoTQJOMyk2J@kernel.org>
References: <alv7LVoTQJOMyk2J@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two correctness and type-hygiene issues exist in the DCP trusted keys
implementation.

First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
a payload_len larger than 128, the subsequent do_aead_crypto() call
writes past the end of the p->key array into the adjacent p->blob
buffer within the same struct trusted_key_payload -- the caller's own
input, not unrelated kernel memory.  While not exploitable, this
violates strict array bounds and triggers static analyzers.  Fix this by adding a validation check against
MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
matching the checks already done in trusted_core.c.

Second, calc_blob_len() calculates a sum in size_t that truncates to
unsigned int on 64-bit platforms.  Because the DCP hardware is only
present on 32-bit i.MX SoC platforms, size_t and unsigned int are
functionally equivalent in production, making this truncation harmless in
practice.  Nevertheless, updating the return type to size_t (and
subsequently updating 'blen' in the seal/unseal paths) resolves
type-narrowing warnings and improves overall code hygiene.

Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Changes in v2:
  - Reframed commit message as correctness/hardening fix (Richard, Jarkko)
  - Changed bare return -EINVAL to goto out for consistency
  - Added Fixes tag

Compile-tested with arm-linux-gnueabihf-gcc on imx_v6_v7_defconfig
with CONFIG_TRUSTED_KEYS_DCP=y (W=1, zero warnings). No DCP hardware
available for runtime testing.

 security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 7b6eb655d..c078adebe 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -69,7 +69,7 @@ static bool skip_zk_test;
 module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
 MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zero'ed");
 
-static unsigned int calc_blob_len(unsigned int payload_len)
+static size_t calc_blob_len(unsigned int payload_len)
 {
 	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
 }
@@ -200,7 +200,8 @@ static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
 static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key;
 
 	blen = calc_blob_len(p->key_len);
@@ -242,7 +243,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key = NULL;
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
@@ -253,9 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	p->key_len = le32_to_cpu(b->payload_len);
+	if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	blen = calc_blob_len(p->key_len);
 	if (blen != p->blob_len) {
-		pr_err("DCP blob has bad length: %i != %i\n", blen,
+		pr_err("DCP blob has bad length: %zu != %u\n", blen,
 		       p->blob_len);
 		ret = -EINVAL;
 		goto out;

base-commit: 6d41c11ef3044788902a05e292cd7f0a9c7a8157
-- 
2.53.0

