Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78B446BF6
	for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764098; cv=none; b=A1TdcD8cEMgizMTBJ+4vTS7iUUGfgyG7tC+Qot/f0Un1sD8k6sz3GgokcooI9/zPVfWz0VxJjS57wbcFg7K30SIAogjOJhfZrO0QVQ7dP7QXFImZgVgdUcKQPif2xwIx5jdEbCxaJ+UStdF2jiJGDl8HQ7xnH2ueBxIGsJKTICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764098; c=relaxed/simple;
	bh=vdAY/faVLh29CfLHLgVsNnTrIBvl2WSvEe0RVJF/UQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGDmdDgWx8pQF6ZYsq6qxH3PbBFZIdDFuF81gLG93B+BIgb6oxHKBmE0GiGw+PZp1k5COcrHR0BFjus/yrGB8dGfCQ0ouKHYIKFCyfjzSXQpmB+6WcLydYNRjyJdvvzG6N33WOb/OuPvW5/clsf3B/v8OhoFcMGb/gCFDq4xZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h97C8WWv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h97C8WWv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1567822a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764081; x=1788368881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7Y3/aUaSMSqtnYOcW/WwHTgglCUuyrDSlF3Z2YzqPY=;
        b=h97C8WWvhPhI4zdzTjeXFsISyzxpH5ZmrXuuRLkyr/KGHENwOJoALsYoLdpzqr7Lv3
         nNZReTVaEJeF3koK850Mpf/t1haMZ5tqHU9auIwo48bU9DvNC8C+m2Cy4kk523tFK/iw
         G27fa+Awe1aEFepd554OOLqZ7KI2JaPb0NIgRq31Vk0oacmnGnx5c6l7N1f8uu6AEs0u
         VFTGEXIjvagyyXflUC+wdNhQIakFpfuEdRiUWNzOZyQ/8/qs2spv795pMTha0KbmX2Ar
         zDVe44XEWqJOEhkEy6F9aJbOQY0uO907+xiXmnqP9/GpNsij8BXuu0aWW0K+RMbsU5hy
         CvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764081; x=1788368881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7Y3/aUaSMSqtnYOcW/WwHTgglCUuyrDSlF3Z2YzqPY=;
        b=jcGjJAB3RAk4qiaqU2MpmPOAA/620TsrXtlSao/DINR58x7vZ2qqfaHRJ/VGdnQstv
         G1SLo4Q4bkYMvbGtWmvZMpn4xwleTlASDInneCXjgvmwZH4fVAuFhiB0T6oUXsY/enMj
         qOfZn3MuhjAIpqpfOpng2TA56ylScZpmzDBmFhaiFJzfQ3h4V7Tw+pAEDYT8e+xSE5IB
         /ELUYBQoDfDKle4rUnDR4fus2BIaatG81/Lp5tKTZMw8cvOTgyvdYH4h5RHj7mjPM34j
         FYrvu0dVv8tahRxINdBoFrdRb5Nqmz8cCrIfilFbft3InsAjj2x2FJ9uEbKTwFH2m3Ff
         +aSA==
X-Forwarded-Encrypted: i=1; AHgh+Rrc0L3OuWFnstVY5s3oxU3Sxu7JA6NKOdgiw5NHgOG3viCy+h91D6hinZvhPS3fzh8w15S86Mk8IKWtgsNNWvA=@vger.kernel.org
X-Gm-Message-State: AFuF++m++xKZs0gptUWgznq+R3I3f7bMbZ2W3izM/33fQ+hNkmp4bAlC
	85vjlTncl6neEKY9G0CWVZyld5meNMdK17xh69ZgA+A6wqdApRlXuVv0
X-Gm-Gg: AR+sD11jPrqbsdXntXk8Fg/n6RIsHBL9XQmYMhfCWqRe5j+nMUjqXeKLrmQaSXYhaGl
	CLse3FN6ImF9XTD19GCObHeI5K6ZJh5AZ6o6GtgWhfl3WC84SvLMgd8x5wAk//vaM17sOBHLDHj
	3XgxeSeLqmU3iVVg8LP5R1EFuZEKozVGTgooVMODhlLffa/KzxTVNlSjHAN4XZz068B8h5nu8dT
	Rbt9AeNbzcfkxRAZeavnOC56nXI4NZMhqQqcv4UPAnutf77yhj6j6BG3ehBI5B8gba9ZndsPJ7u
	ESEGvwwTKMljaD0BQD2n3jnxQWb05Xr8T+GEOxJLzjeAr6jnS8JK+aiZRaKmD2F/z+9pjXcdEpC
	c8E9LRCSu/GHHNWiCGHYl0qwL6nDcWnhl/a9qIus0AiOGQKWOaZPuZWzoEVphX5NT9Cq6fNttMG
	ArwZSsMvA6HOtISbMJmPsIpcXJa3UFvUJm/L79hTK7Z/PxJzivHt3wuWvmN4IRToobaYJ7450o4
	v2rIK5MZGSliGxUWe15P5lSo+MqWssVtwaFI5AAOnC7NS4FpJ3pgzXqnJ8=
X-Received: by 2002:a17:90a:e70f:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-3966d43471cmr18087587a91.8.1787764081008;
        Wed, 26 Aug 2026 10:08:01 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd82sm8945491c88.2.2026.08.26.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:08:00 -0700 (PDT)
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
Subject: [PATCH v3 2/2] keys: trusted: tpm1: reject unauthenticated response tag in TSS_checkhmac1/2
Date: Wed, 26 Aug 2026 17:07:00 +0000
Message-ID: <20260826170700.616-2-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826170700.616-1-sanketsharmacsec@gmail.com>
References: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
 <20260826170700.616-1-sanketsharmacsec@gmail.com>
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
 security/keys/trusted-keys/trusted_tpm1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index d47cb7108..6dbbf4546 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -201,8 +201,6 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	tag = LOAD16(buffer, 0);
 	ordinal = command;
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
-	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
 	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
 		return -EINVAL;
 	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
@@ -269,8 +267,6 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	ordinal = command;
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
 
-	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
 	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
 		return -EINVAL;
 	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
-- 
2.53.0

