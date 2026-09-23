Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53E40B6E9
	for <linux-integrity@vger.kernel.org>; Wed, 23 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184916; cv=none; b=ebDe+hsyAFR/bTuZgElvxd6x80F3Hxl6H7qqfU22lavDdZqrk71OnDwJjOTywLYI4rT7pN7qmrFIqd/szyrrIv9BoLvRegG/BsdHjIr8oNFB0OvDIIG1Kpvk5ciX8X7F4AMthlQVjaP6tHyiwPdmv6nDkSDLbvhkIZ/i3GXNNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184916; c=relaxed/simple;
	bh=EMiwijCSi9gVRyUeRj2kGmZadFEy+BUHc+JcXjP3tuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eu+4OqEbEpiZB79vIcYx77n1r044as7AAP34W/5CvAM2HvDYZ2hDrYGbF/33RiLXxOiGhZCnADdYdXHZFfYydci2APT6oLZw5qY2QO71l5yBB3IiirfvAfv93cixpe9kGVLbJNzmZAz+/GhaI8B48pDhsYBRLgJeN/9TuBjEprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uw5RN6x4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkpsI+tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw5RN6x4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkpsI+tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790184911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
	b=Uw5RN6x48dkym/2RTmWnrXQgmWiqYO9ywMjhszl336P79penvWb38YrofBDSY0B0x1YHSi
	oQISSIWsh0jmB7pLc/gVeDOCEBc1+LDS6gxMCRCSeKoRrKtXG1PT6LLYgUdVdImJARgnX6
	EgJcce2fcd00HN5MBqef+QYmDXGQ6qw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-xia4RDLaN4yuffygXjldzw-1; Wed, 23 Sep 2026 13:35:10 -0400
X-MC-Unique: xia4RDLaN4yuffygXjldzw-1
X-Mimecast-MFC-AGG-ID: xia4RDLaN4yuffygXjldzw_1790184909
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so10198685e9.0
        for <linux-integrity@vger.kernel.org>; Wed, 23 Sep 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790184909; x=1790789709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
        b=AkpsI+tnAbCar33EsO9QJ5QWszH96Oje2QnIarK3fKSN0j7y2gnkrnDO4X4wrwrNTE
         UlcFPzyCy3xnoMOgYeCf4RYYJ9BleSbkrl5CyHSo8ItcrQA0GLXRgmztvmyIAspwrGDo
         W48a6i2CcG7lHwRK8XeFiO5/7WKa1GoBXNV9AwMcwTy7r2TbHvNlBp/SfLwG7tprlczS
         GIuZKwzRj1mVFW9Zhz4TrYAv9wd/Q9gt19TsPUaDrsZugM2ovIEPJlJ1qDHF/l5h2btK
         Y9iGKPrzI4iNxHA3HyNo4i7+aX6A2RP8VsWJDamMV4uuezZxuMkcpCNKZGoHzLc/lkET
         90/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184909; x=1790789709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
        b=gYoCGyk6yG3fr1E49FL1DV29lyN9Xke11ekq127P/pL9LyaoDJew2Cu4wuaCgI5/Oo
         WuB79XyxTFRbYnvQ0a0tkAE6T+p+H4SrU3oaOBHqYf+AyWH/tun5KwpLMt1cbwN0Zohf
         CtUgM/MKUntjR0Us3tpxTiwAQGd93mLvjMqIVIv5H/9ep1zd/XNfsHupBvfTmvoWKngu
         vNauRrEwwkYo1BMDjt0agajaLDc3l0ipbIsBOHITdMYGQmiRWQJA63Lclc+QgCh8JFxf
         krqmhbWODoq/xOi9X5yXLUNj6IhMEH3n/07JoQrSZOwGUUhDRz4YYnIrkM9E9kNL9lqt
         DdMw==
X-Gm-Message-State: AFuF++mlM8/A4mLgxsZ3pb6ArIGmDEgQmHYzhEVCOI9sDpQNbT/ni+Q3
	tFh9mZ35SwoG9VYWIvzEV+9TpMOO/1BAvWD00+vJ72OuAOdWZOfeSSiX3+QQHFbr9u5g1P543wE
	ukjMvXoz/8CDcRXOp40+6Ic/mY4UaALC7ZMazYpEyw7TYWZFd7laEAQw7km7ZZGUhNPVeBvVhkL
	VXX/YK0C5RwwLwBgrRPZPpCGJ5sHPsLxOEUtDJ+a9G//FvLKkFwa4CJQ==
X-Gm-Gg: AYBFou2KG6QvMLdQ4TRQGcxIdk3rde0cSEQYU2RwOEYA1gXGUJA2pi92QbCgOYZhlY0
	lOHlkmZbkoye861D7LL56X56bfkJlhfwayi1humf6DapYFe3qPcxIPsqs8QTHOATliLKEC8CfiF
	kVS9J234RHvGyNI8kTM7fUX8jfHh58ewgBJwi1aq2afxd0PSJoj9Qtqx+yO2jctRkpqnqA5APkD
	FXpR38Q8PfK3IdL2BkWBJ0YoFGZv5N0p3hseAEWECPYklHJrDqa+kQI7BGjrOxwBg5abroxY6tj
	+4ATYV788PdmQu92uGY9g6gB+UgiQbaMJdts6wIXQBBMsRhlZY0KKkTd4RKq45RpkYdFPFqqsw2
	WRWCsecPx7ZYikvxKAl7fB7fsQPYlDtoYiJsTEcqlWVrz4eyr7cUsrQ==
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54024035e9.29.1790184909136;
        Wed, 23 Sep 2026 10:35:09 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54023415e9.29.1790184908631;
        Wed, 23 Sep 2026 10:35:08 -0700 (PDT)
Received: from stex1.redhat.corp (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfbc0csm1404045e9.13.2026.09.23.10.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:35:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Paul Moore <paul@paul-moore.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] KEYS: trusted: Fix blob allocation size in tpm2_key_decode()
Date: Wed, 23 Sep 2026 19:35:06 +0200
Message-ID: <20260923173506.41519-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

tpm2_key_decode() allocates 4 bytes more than needed. The ASN.1
callbacks tpm2_key_priv() and tpm2_key_pub() provide the lengths
of TPM2B_PRIVATE and TPM2B_PUBLIC, so ctx.priv_len and ctx.pub_len
already account for the 2-byte `size` field each of those structures
starts with.

I noticed this while reviewing commit 114f00d738f1 ("KEYS: trusted:
Fix tpm2_load_cmd() boundary check"), which correctly reports
ctx.priv_len + ctx.pub_len as the decoded blob size [1].

Let's allocate exactly that amount, matching the data copied into
the blob.

[1] https://lore.kernel.org/linux-integrity/apfoKo-BdwaLXtkT@sgarzare-redhat/

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 01f18bb37047..a9b8a31a637c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -115,7 +115,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
-- 
2.55.0

