Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76D4CE66B
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282123; cv=none; b=QF+EvGaFQ2m2AKnxD9gQCfW/4WrGxyBQcSnXTRIlTpo5MATttPbxSPIw7UUpuktUW17vrt6jgF+E9Kca1Fecs6gyhgq6W73T78h3FwkcS5c+Oq/1atWg1ciM/FaAJ6GjnaylVPU0dj5/McgOIcXTCrQr7CIMPqUlipZvPKNQAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282123; c=relaxed/simple;
	bh=Ezdlx+UeRBSR/f6nrz4LesZPCELyFYKZoA7wcmaGEzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKarn9K3t8JS9kMNnTtzXYJHmx/sWE946syN+DDcQQyfhpo/9sdTBZ9S+L7ZNmJAT8FsYu9X1yWl+uzk9BKs9CZtNfx+VEqTzctTqNDodEDklvxHLNapa86qzifiybAfPnAqF+sXwmzPeL0ywgBBbsnLoOrTcxCMIWATsDM0pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OQLzgFZ7; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OQLzgFZ7"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-469fdb78b1cso203723fac.0
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790282117; x=1790886917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+deUfdU77FGkM4KhZU62y6wx4HZXqi9klM76GTBpRK0=;
        b=OQLzgFZ76R8SdvMgiG03fk4vLkTXvd6GRNqUUm3aoJbsQyfWXpteXNooZYwZ0VJPBL
         x9plmvkYPM99+p9iwRhLCF5Aba4Fj18/o3G5sRK5Sv6Pzgh0M5wqndzYVaJ0aoq7omFK
         dD+V3+i5K2KpY5FU//81KeGwS3aNRDmoe/wIjFNR8QmcEqMBfPTlwsdYaeqvmHbHqmA5
         /3npuEljJbhmOAj2aWfG5/4nhmEZHFyFOgztJOpvyJ4BFd3zmsdaZiYt88wOlVY/1fdr
         lYiiaTbPmxtlxiAp2rmC2mfPr6t/C0sgfpNqSMiBYPFAy3exfe5zryoEguPuHAHOIaFj
         CBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282117; x=1790886917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+deUfdU77FGkM4KhZU62y6wx4HZXqi9klM76GTBpRK0=;
        b=jB+XKxZy2jxGsR8+Pf0ouPM4BTHmTal4X2nVJNxYhvVX1cJb6TJhXTYwI75nBbpiP7
         i4/LJ0+3U0Rcu9ZLavWh47wqHVN3Yh7l/puTLDoEXrISUcEs+OBa7jgDkNCnB+pfNYxM
         28PX6Np5jqfoQ299Kx78KoGwiwQik7C7RoGoNfYwcaj2mPaANMcClx9iNX3JDKGnGDdR
         1NqIyFWObbKfoOEPkv0/R/tNooVzgbqPtngfe4tRwz+7MAC2CY7yGrzuSm6eVNspzxfP
         mVrgb6gVDX5/Z2S8rc67aCyIOtzB4UIdsf56YnpvVeEPAMdb8tck//d30o3Itfrx+xAl
         NJag==
X-Gm-Message-State: AFuF++lzz/6lwyMdGPfyLctxLHUel1dtORYQK57nJlwMdbK9d2FhCabP
	WQ0uXqA/Fx+gG88yl9LtX+zxcSwyJUxLZ9Veh1mCxktNY2Q4IgVJjgNcYdSxVsiRC5k=
X-Gm-Gg: AYBFou09na7FGH8gSjLphQ9ljAwPTkRsv3y1rt7oknoG4hNdVIR2r9vbxbPe9k4hbCQ
	hgXJPVm6ialH/nWMSFk6GqucSoB8/29H4OQDlhbv4ZZdjdd+vyA43nu0Gu2cBn55/xQn8x3t4eR
	1oPR9ys9dqQvilaO6jm85PdKlKAlkXH0W3rAdOzorzBWmM0qCE/JN9CNEi+cWgX9IvLl3vi2GP9
	uzHvoeKZ2uQGJvvlLb9XuA3VzzCg1dyNLXumxcKLAbH7HQAYkj4rNbHdU7JRfmtirWXDaBBm70Q
	bRozYPWEgNI03vViAZkkx36Ygj0iwie/QepRJmlQHDVf5v7yc0KHdCNYWR7b/nT+v87ayN9cESA
	xLhjAveJnlvLOkWAFjTVHJt4BmGfwbz8Wwp1SWq5OWVw8ySSQd2FD0yvyWUbmQPvn28efwr1jFU
	+VWCJoATpsn4WEHgIoWQDxDItW5eIQx9Qx7Esz9SvLhWpWXqhnrOkMdeBF
X-Received: by 2002:a05:6870:3263:b0:48f:e107:317b with SMTP id 586e51a60fabf-491e6efd09bmr4096695fac.46.1790282116700;
        Thu, 24 Sep 2026 13:35:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:1cd2::2df:f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335011458sm254515fac.4.2026.09.24.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:35:15 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Thu, 24 Sep 2026 15:34:59 -0500
Subject: [PATCH v4 2/2] integrity: Replace integrity_audit_message() with
 integrity_audit_msg()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-report-hash-error-v4-2-196ca6350619@cloudflare.com>
References: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
In-Reply-To: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Enrico Bravi <enrico.bravi@polito.it>, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4050; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=Ezdlx+UeRBSR/f6nrz4LesZPCELyFYKZoA7wcmaGEzc=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqtYl7XvGk1MJfTdKnrYbu8pV2c9CadsSpdb8fC
 uBHarKmHcWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCarWJewAKCRCrJbR2A5LT
 bXxXEACUA/aczjDQzxajR+a0kcLYZnuvxzY6UzOsfjftWnjRH4QhB3hH9PJRztqXTvt0a1cDSB8
 YhL0+4jayAQdqXLhla0SKqAmOM50iS1GW0UOxfegOtSg89vOVCpSOyUah1nTxbN4dNNQmn14hOu
 8Mo0Pd2lRRrjPJqxX0Lk4GlSpMt4BiN1VgXgJ/d0Lafh/VomRpFjBMWop5Dy8oNhtdO2vzny31r
 idzKhC+7IQSc0Y7wgQTUSM+aIzuS4vg4khe8aXr3RsLoIH2drakS7I/R3OzyPldD8E8dm9LY4FF
 FE/7FU2OqgdW5MYUHJvZYa7qT2ZeigppOKvqTkBQpvlPGR/5YaCKptxTi+4YEUwLeQ6mcycBf1W
 tYuojIFFU9zbrXrFNlitGgNflLq1z4yfuUwI87YgvIln7zai1zjiU/ujHeUkCdWvNehst91+XkQ
 PedRrV+fou0KzRV22626vJtQUREP6ByTytyzNItgC3p/EmRe6wJ24L4wBokjgaL41rB4GjOma64
 iYTMyjMXkcTPD9TC7T4z48x00bzz7koEX+BCWeJLdVMOVgUAcX121Z+0xlYIhw31zFk6mQbdsVn
 nVBpv2zUEX+5td3TV/h1gJ31JVJEQN+xWH0uX6kJyayislvRBGHX3vgjgIn1bfelB9DQqNS3+NF
 EwcJlLz8nN2phUw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Now that integrity_audit_msg() accepts an errno parameter, it is
equivalent to integrity_audit_message(). Replace the remaining
integrity_audit_message() call sites with integrity_audit_msg() and remove
integrity_audit_message().

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

