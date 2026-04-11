Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E40155C87
	for <linux-integrity@vger.kernel.org>; Sat, 11 Apr 2026 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867674; cv=none; b=LbCU3eH1Sb9R2BTApirw1wOfVUfuGO3mvtKn1cZG3owGtLif16T4vGNMooPWlw2TpkxDTopOGm9j42L41W5gkGkavf/Oa8OiR/zViNAw3ZaQavlCWBRB2UxVKqxTXB+q71vHONV30TUkYw2xSaeL3js1qFB/8L1mcJBXRbM2f5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867674; c=relaxed/simple;
	bh=FgaOEOTpZ4BpPK6y3PFnkFDoG8IOPPOqXgiJ+rxsuxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s+mj9VVSDwwCsuQsSlyW/0WhFgdqonMsyHFxd2Ana2gIZmrLCrG1qat3/QNo09GIchxGcnOWiwrFHInEbjqTyqiY80ou6MQQS7QUEM2cKdMpMKzl4rScfREkhtLiqlGJRanUGRoN2z/qUHgwlT3te21By1ffjKP7axoIdWDm1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4BtQpkz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4BtQpkz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso2918218a91.0
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775867672; x=1776472472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mnWkepiHxmItzRon8NZr1pojVHtp4vHABTKa2NSGls=;
        b=d4BtQpkzrjYJxf3hqo7EL88LnapVF9uj9YI+wwKHcOGGy9RsEvK9xBYGM2SLx2GEOj
         4LaKKdbPKLLxvvCKSy9N3O24JltURmiYBOiqsVNoGP0dpEueV0av4WUie+wmv20hGoDX
         sqMUaZE7I8McMMnlSe53llM71Nams3pQh3x+R0dYvzr4n10ZJZPnfpsGtVZShcrvDvir
         FPmxWI+yDuzpXHMqtIetfvNPCfZh9UOjyhSDafh9pyORGFBQ0U0W6XslXiTbRSgaEz/q
         QGlft8+QMMQfnWkQaLK3hbVz2A7Cre0yTQtEoKk1E74L1Hm0uNezx8te0yC4IjZvYmhi
         d59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775867672; x=1776472472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mnWkepiHxmItzRon8NZr1pojVHtp4vHABTKa2NSGls=;
        b=h/qJEEYt3OXqT40OpTnHw+pvEabDoD5zR5YP+q35D64QbifcMr6klWDxgu4icXjNOT
         dqc6omb3AvzA5t0PefAAKwc5mMTOxTXju4SizUh4x75LXK8fIXfMRcU2Ga+7btxy6Jde
         mYPbHG19WYreWkNdTLgBdzoumbaVuOz7LaN09eRVlihCGez+psdi57rZYRsJN3w8Z0OO
         i7XWmbA3hBqj7YXGu5ZCdwqTOWtD+fk7wZECQ/SwNeIN/AJAmyKt7klpKN8XPg+7QXM4
         vcIeiTvQyPlT4rG7BJrVd/RIbx6/GMIQnpetQ3FHQt5vNv/6rIuTBhaoks0/0k3TyQcE
         XTJA==
X-Gm-Message-State: AOJu0YwEEz+QvNAxb9F6lbywd1VZ1+dxcMNwxxlsD0BFFqLV6/ebQBB6
	N9KdlTA3IPvLMTKQGkkv8/V1cxRlynzyvK9ea1WzMUUjCWItfctiHp/Q7kTtEtGacJbRCzlIXmW
	MQW8BmEL2cix4odjnYg1n45BhAFaFdZ/q7f1MiGHLhMbhOKVAGCiuArLTN6lt22qlG5SPsTm0Zr
	E7LzVpCdqBxBIhI/KKJN/ETYnCT7u0Um8jqLbOB8CV9vJLIkNfyoJ+FzRSbN4=
X-Received: from pjbgx3.prod.google.com ([2002:a17:90b:1243:b0:35c:20f3:4ec])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b47:b0:35c:d37:6024 with SMTP id 98e67ed59e1d1-35e4274318amr5922274a91.11.1775867671952;
 Fri, 10 Apr 2026 17:34:31 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:33:00 +0000
In-Reply-To: <20260411003300.1823020-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411003300.1823020-1-jacqwong@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411003300.1823020-3-jacqwong@google.com>
Subject: [PATCH v2 2/2] tpm: tpm_tis: stop transmit if retries are exhausted
From: Jacqueline Wong <jacqwong@google.com>
To: linux-integrity@vger.kernel.org
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	axelrasmussen@google.com, Jacqueline Wong <jacqwong@google.com>, 
	Jordan Hand <jhand@google.com>
Content-Type: text/plain; charset="UTF-8"

tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
Currently, if those retries are exhausted, the driver will attempt to
call execute. The TPM will be in the wrong state, leading to the
operation simply timing out.

Instead, if there is still an error after retries are exhausted, return
that error immediately.

Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jacqueline Wong <jacqwong@google.com>
Signed-off-by: Jordan Hand <jhand@google.com>
---
 drivers/char/tpm/tpm_tis_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c79b696086fe..ecda3c1085c7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -556,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 			break;
 		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
-			return rc;
+			goto out_err;
 
 		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
+	if (rc == -EAGAIN || rc == -EIO) {
+		dev_err(&chip->dev, "Exhausted %d tpm_tis_send_data retries\n", TPM_RETRY);
+		goto out_err;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.53.0.1213.gd9a14994de-goog

