Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68852499F12
	for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594625; cv=none; b=WKWUhxO6eO10n3twMNTxun2yN7FltiRJmd7lOM/wOWJ1ZpMv5p16dBuMgPt2C2vz3tPS40IfemBdfitW/VII1s62p2odidwbFsg3YkSKaBM5C1FRZN93cat6gCML/TFXkr4cI6ndCtaAYO0rzaWtYup2lrGqW7pzbCrcEwboRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594625; c=relaxed/simple;
	bh=z2tQHhAwEFt+agCaRWeVzBR9XVTRt1GIp8bQCvmiYuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trnd5XdM4IFEnlgee7HG9edyB+021te3PdqCzwO8bNFjqBWmxOdyqka14SAjM/PENn57RN8zqmlEkXIEGzAlj2ApA9hxad74PK0B1mWiyWa8jzmHS73q/YxTHn8i7dSv9T1U+DMt9ZT9u1uaRHeRj96gxPLAyG2vWkOEfe9BgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EA81dlCD; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EA81dlCD"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so55641fac.2
        for <linux-integrity@vger.kernel.org>; Wed, 16 Sep 2026 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789594613; x=1790199413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhuOR/yTpkseeAWrvSpKFTY7Og9vlkZJ0CujlTEe3/8=;
        b=EA81dlCDWK8Brg7yFLt12E8nZlqjwrkN0YEPpAojkNirkQk13Y9EBI8WkR5wMuziOn
         J8PpG7hJn/L8j6WmijRAO6sk+rbNKqmXZtKJBS6VhM4TP9N5WXGrHvRaTGmydE2VgwDS
         OaeLEKKULlqA19YKFhlEEUdIx2+cUr3TUXyGivcSng8lCnUT6cXJtyg6goStQi8X2chj
         CzSy953u9/uyHqrpMumPFqGLQgdwU+LxIIiyRVB2WSkT1OwddN//BnZ4o802EtXzjv/S
         Q3veP9F/7urB38Ozg8Yb6Lhy+2YVoH8NVVytMxhAafS/6CMYAnUBxrnaNaNEXuOrf4Bo
         mHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594613; x=1790199413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhuOR/yTpkseeAWrvSpKFTY7Og9vlkZJ0CujlTEe3/8=;
        b=bqGiQcViAXbZRHTy3uv8vTuk7toQLhNvZKyDZ9bUacb6clZ2zc9W0uB3y1QKs7dsqC
         2qZVHHQW604EGVYFYhg/op7LDISSnuu9cob6kmVWIkYUlWS4oprq/QUhnaPTe7gu/IhQ
         x+gcSIxA2w/SdPP9FEBL0V7OCvr2X4XLgOFz29c7155ZmExm8QLLEpjlU/ucrjiU5flP
         utwyGfQeFssDEgEMTTPReKCSuIwVI1Vam5krgGdTtGW8wVKumq+oQcWXegmVE68lKrim
         1sSdQ/zyoBpXsF3C+Bei19QPY6aoUzrfVC/5NqAYk5NkoQ7ZAKPt4YyCSFzPSd5KdMQ7
         w6gw==
X-Gm-Message-State: AFuF++k0Zh7hkHikVseGl21MxFCcWzHxhhYgS424lw6vBkF5dn/ocehf
	wO3lVCWcpgm5B6iTIy3kgKR5amxLrybfUwaN6yqXqCKUGkZstvjTsYcVMvDOwCcU0yI=
X-Gm-Gg: AYBFou3B+NFvp+0b9SChsiGyn27n6u/EvgpuDYdIIQB4z/d5vJUQIfI548Iy4b5WFiy
	A2LrO0L4POmFsnLABusMZDhCadef1UT6dfX/Tqjb6AxIJhbeJ7Gkz1ZTmZxXdJRJmWvmgS4SnXg
	ko0tFfYx4HWTnLwk2iCLLqFx3jwl5vNWXuOEcTYSipzpbBdZrgqNHt0B/VYv3QKLt3sn0KFm++J
	4VMAiplFtBpnOqhvnJ+HniZEw04wjWuA2XsOwQVHPiLPBOjKEIq5y9GIR0nTZleg5Jl5np5XMlL
	yzfCLcNW4GOHQWFaDMwWWMVbStLN0BbIq7j4yOCNgVcQgNvcHrs3RtzJEZ2Coiwi5E6Q/5rPPD9
	jPG7d39bluhObagqbXmICtrA6+e6FXy193z8vi4S7YbnM0y/hhPAxQbqM7wYZlO9G5uzSxI4M4y
	pFHA25m2MZcCwlUgZuKLc4HqIsXHnfcFOQWxPbt5T6QSLcIlim9IUAH2tnYwFcOFBjWtVC
X-Received: by 2002:a05:6870:b3d4:b0:475:a1ec:9621 with SMTP id 586e51a60fabf-484778f2bd2mr4152184fac.35.1789594613524;
        Wed, 16 Sep 2026 14:36:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:31f5::4fa:4b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a23e310sm3387557fac.12.2026.09.16.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:36:52 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 16 Sep 2026 16:36:38 -0500
Subject: [PATCH v3 2/2] integrity: Replace integrity_audit_message() with
 integrity_audit_msg()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-report-hash-error-v3-2-73e5d95e9efe@cloudflare.com>
References: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
In-Reply-To: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3985; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=z2tQHhAwEFt+agCaRWeVzBR9XVTRt1GIp8bQCvmiYuk=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqqwvrmVrK7ESQgDOkwOK2VK1kK4+HrtNpxxvea
 iBnILRGMd6JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaqsL6wAKCRCrJbR2A5LT
 bV/uD/9wvueyIbMy+vcKKZMyE4dXComXFcTtuZRJhDcc5DnG+h+yNYsKK4JLnE1BKm5i3Vog4uP
 DZXGjaJVBZ6dYP6FG5oIKKyE6xe5PQzylgbOhDCQQH1Ogj+kO9bwdc3aliPDrL2nCk8Iq4S/bVF
 EtlxhXPDl9jQjhZUJIa5oaY03bXz05eZehXZhHxG6Pas6SLhZBbgSdmMrtcUDaFagzJT80OL3gq
 jFmJngTlmZJUHZyfwazPDDTx/ltZTzrt/cCxjE98xkFEA04Gq5QkHfgb3dazPMuffaHI9sTGLzr
 JqFqMHc+v1C0FZeYxI8SYGZM5/wwzyYwLsqhg/JadVucvL/64vh/s46S68VpsRUAXFD9jnPCXeD
 8pvpAQOVW+adIVTCdKVggnu85//0B1fgKXffGaznAde2/zAXwmTEZxb6f/03ygRr0HRrvsrRPEE
 z1pF4piiWMlwVqorNuMn0hPNNHzdjvYyJNAIpRn/1VA/LpBHpw2Q7pyAUgjF0KPQgi+kda7hfaw
 spcyEl7Xl6f4xGZPR8N8yQaFDNFUlPr8mMK5fha85Zutm9aikQE2nx/iwY/JpUEtldK3e/SCI1m
 jxM6ZIvzlDVYF/nvfe37LanXSxyJIq2sloWsd7PGzWyz00BXBjgS2T+CiYMb5DcxBDPtdocdi2H
 7nBu+Ssj5st78Rw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

integrity_audit_msg() wraps integrity_audit_message(). Replace remaining
call sites with the truncated function name. Then remove it since there
are no more callers.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/ima/ima_main.c       |  6 +++---
 security/integrity/ima/ima_queue_keys.c |  8 ++++----
 security/integrity/integrity.h          | 13 -------------
 security/integrity/integrity_audit.c    |  9 ---------
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9e80f40680d7be08d14d26ba48ed334d4e4ab10c..bd9997b01633d6235fc2fcaa9bef1931d6ba7247 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1196,9 +1196,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 
 out:
 	if (ret < 0)
-		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, eventname,
-					func_measure_str(func),
-					audit_cause, ret, 0, ret);
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
+				    func_measure_str(func),
+				    audit_cause, ret, 0, ret);
 
 	return ret;
 }
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index b5ed33cbb272fdfaf7f5e945137c56e46e0d7db1..8adc8863ad5a540bf0c047ba47cc4817fcb46e9a 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -90,10 +90,10 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
-		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
-					keyring->description,
-					func_measure_str(KEY_CHECK),
-					audit_cause, rc, 0, rc);
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+				    keyring->description,
+				    func_measure_str(KEY_CHECK),
+				    audit_cause, rc, 0, rc);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2ab6b7e34e7ee2dd29ae03ae1fb45fa26d9c032a..52c5ec881cca468bde72c885cffa1c564877735e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -221,11 +221,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const char *cause, int result, int info,
 			 int errno);
 
-void integrity_audit_message(int audit_msgno, struct inode *inode,
-			     const unsigned char *fname, const char *op,
-			     const char *cause, int result, int info,
-			     int errno);
-
 static inline struct audit_buffer *
 integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 {
@@ -240,14 +235,6 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 {
 }
 
-static inline void integrity_audit_message(int audit_msgno,
-					   struct inode *inode,
-					   const unsigned char *fname,
-					   const char *op, const char *cause,
-					   int result, int info, int errno)
-{
-}
-
 static inline struct audit_buffer *
 integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 {
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 2dd2d7e3916e7bf35c753450315ff22e2d0292b7..22106aaeb0df21fef0990b80611dcd13cba112be 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -29,15 +29,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int audit_info,
 			 int errno)
-{
-	integrity_audit_message(audit_msgno, inode, fname, op, cause,
-				result, audit_info, errno);
-}
-
-void integrity_audit_message(int audit_msgno, struct inode *inode,
-			     const unsigned char *fname, const char *op,
-			     const char *cause, int result, int audit_info,
-			     int errno)
 {
 	struct audit_buffer *ab;
 	char name[TASK_COMM_LEN];

-- 
2.43.0

