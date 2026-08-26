Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B3372075
	for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731520; cv=none; b=dE9Hib3ruIRYnerO/QamvSFfCHW1QJrPsaHiGYRr5zvqEl63IZfZbORj/SHFjmq/Bq4h1ioMiPLoHxDZ0FPB2jYHNZpTI3PrkJyBby+34HlS0BkRWke8hAQp/CRySjZ/ukmP8DU3i41XTHMMwTROKo7Hr6sydFxUpdY+XNsHDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731520; c=relaxed/simple;
	bh=K8sgNMD+lhoLDVxxJtRUbAtwJnEs5Vs65ayfE57jHlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfoXMcSlQqeI58meFpFG5LNa21LIYihMja81vSQICWZuhm+hjWND7FVcZzdVZLYdWNq9chOHCdxpKMNBRHeBXA3OvfAszvOY2LGxclmBARPV9WtObuei8ugJbYY1wVa9rwORCnDDQcBJlZidbf+uU+XSYG8GqD0L727CMPtGeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmNiyGGD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmNiyGGD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d530328efbso7078365ad.0
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731519; x=1788336319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4mwt0a14dx+ccRRrwmOcVtB1mc3b0oWKjoF8Tw/vUw=;
        b=MmNiyGGDN3ee5NgGOlXc8wDc1o857kHDzKa6bdHJ0Jykt4m7TsnA/vnBMWGJRR62UV
         lDpupAJcWLsfZ1pEFTqlBIWDJMuJEumyjlnsChaUkWvohiaxlTdEc6VvQoB5y6ANQuT1
         AgwX2ky85SVRd66Xxt2OdhGiPdcP17CRYrIPmxI8hDiEyOTKuc9KphzwD+zpntmgItM/
         CpXOdGf4MSQsP+GzkHShm6SWT7pgfaVo6mwNwWoycJH6GMdrUDMt/h+pHBQe2gt1UjhE
         xaG/WQVZEExkhzHKWY66HNkmeB9RJXt4KK2YR4Bc57VQ5YXzb+UQM/46oonSfov8YW5B
         Ml+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731519; x=1788336319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4mwt0a14dx+ccRRrwmOcVtB1mc3b0oWKjoF8Tw/vUw=;
        b=UsRj05Oj31AIoFzsf4H+Y7X5hwkELM0YzjCzkpxFg9zR31HO3LUkXkn4hgO4wM37JC
         5gSj8unsYonUKELp6HtiiGewuZD1KWjlULaYa/Nwx+FFLJJcnkvkDhzk5imc8uaM5YR5
         VrxVkx+Ilc8NNDh3a1XSTpM7gFu2KTXKr1nDHJuADUjCHlJZUus4bzvUnCqDBwqrReh9
         XpBmXQHNm2EtZlVZ/95qqLDQNsHxWy0hoFA30dXEu353HkZfc8Qsfrtq4R16D62YvuAy
         eY1zyiDg+imQC9wr9OyH1gfV0pKtk1QEjxQch/KWhHOrP7Ius0FSQLspdWP0ACmRYlK7
         pS8g==
X-Forwarded-Encrypted: i=1; AHgh+RrhAYM9zKH7PmE39nNZjOCQ5dOqkVxj7OEZ9Cu1ouzDEwoODR9qUHbE27OFjL62x9Ot02f21WXL4fdkokjDwzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mxMrrAvgIZB18cz7ii8GOWSKUKZZAZnaoMPRxwMLOvPC7zJOHW
	CJdEOpuVM0wTzaRzvzyWcIzixkkZcvXuEypkJfa0roURbL3QdRquZjUK
X-Gm-Gg: AR+sD13bA14J1xDXkFZceEbLtVk4B3I1Sev1a+AT6fzfSezAqj1vqLn7DtYp1Pwb+HK
	rajFFAR301OTaq+QKrPwoluqrDEkuLWyCBRZv+Dfzkarb5+/gORxncYED6qRD6r1udousrzddIj
	t9lZh0p0dvaWnYubdupTjsikj7RDfSq2CDUvNDAQPHJkfi7DXqQcJkcw/NJYAEiia333sk2vofr
	c9u50kTXxtzxgZWtCatukXg6mUDSxgXg0VT5+88y40ql8SYljfvn3TPM0fA1k2j1u10lkmuuyu5
	39aI6zKyCgkJoeWtA9wrAyR7lpWL2Bc6dkVsDipDobGxUnjAX5wJXO/PKpYPDlj/zrqdukgG8QQ
	BcPaULX8wZSEkX++KQD1b8+QB7WH9nAaGNAlmapkHPMjvvgZ6tKfGsbjVkFmwH0YD7UqAN1gKLn
	yBuSfnQWCGBWVOukCavgEdxHRD1S4uLmTP00mSv/xHsmJX8uhTmgfDS67EE4qIS/Pe8V/FeMAUw
	e3hyIlszXKAccMscXfYA7TPAHxQ+7a7YSwO8SfH2mLyheKKRLSGa9x3rEY=
X-Received: by 2002:a17:903:1104:b0:2d6:e401:9676 with SMTP id d9443c01a7336-2d707955aa3mr79322015ad.1.1787731518542;
        Wed, 26 Aug 2026 01:05:18 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm9566068eec.5.2026.08.26.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:05:18 -0700 (PDT)
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
Subject: [PATCH v2 2/2] keys: trusted: tpm1: reject unauthenticated response tag in TSS_checkhmac1/2
Date: Wed, 26 Aug 2026 08:04:05 +0000
Message-ID: <20260826080405.255083-2-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <20260826080405.255083-1-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSS_checkhmac1() and TSS_checkhmac2() silently return success when the
response tag is TPM_TAG_RSP_COMMAND (0x00c4), bypassing HMAC
verification entirely. A forged TPM response with this unauthenticated
tag allows an attacker to skip integrity checks on TPM responses.

Reject TPM_TAG_RSP_COMMAND with -EINVAL in both functions, requiring
all responses to carry a proper authenticated tag.

Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index d47cb7108..c89fc6cfe 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -202,7 +202,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	ordinal = command;
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
 	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
+		return -EINVAL;
 	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
 		return -EINVAL;
 	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
@@ -270,7 +270,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
 
 	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
+		return -EINVAL;
 	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
 		return -EINVAL;
 	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
-- 
2.53.0

