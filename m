Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9852C235E
	for <linux-integrity@vger.kernel.org>; Sat, 11 Apr 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867666; cv=none; b=hiTN0xCSGc+ana8upRNhBTCYRH4Y7vgePy8qzF/+E9OvjGXjrnq/IOGWaf376SQd9FOGHu9yegOqWxrV+RF2X2qvt+0CqOyiUBszvWGFazEBZswNjfvmwsQhrrD1f+uRZJgBUBa27eKbf3pdsotXwy9PY/rZYUewa9vIrcq9iOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867666; c=relaxed/simple;
	bh=qvfdBV4Tk7XfRPhUqhdcvivPlFLQrrCu0l0LIGKTToo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSQET8BRPuqv4PKsEJNozajv5op+nMjSyGf3qP/cXCDqLgPizN6fJVJkXfqg+Tu7jPiynzrWZ1+dOTIPTsgcrWTsf3Ml4O5lfZYO8Nyuc74vQ2JZAZ65WrGfRfMQTCLzIk6dKpHxxXtJVhtg194PL6eBZa1dzb9ZYJrq5EgibbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhGBojFk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhGBojFk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cec239147so1614389b3a.1
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775867664; x=1776472464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq7Kah9jpkT1YgC07HMZJ4YDhiS4H2l4B2K1DCxhJp4=;
        b=dhGBojFk3U48udPtDJ8vA2okFsf1xHyLvkVSM8oWx9/KjolOiLU8JSIijCFcbY9Wb8
         bNwRmH8iTyfYys//yaabm58JzHanVlZk6fxGxoVt8ZLmmL0v2Cx/lAY6WrYsjpyw0ehu
         501BfHrxb2AQ5UgKpkdonf6zIbbgRs7BdJF9nBD5v2OyLsxZhARnZySWUqKDgPiB8f2Z
         OUkKyLdDa29PwVvr628CgTwq6htUDk5kp6X1tVomQV1lHd59BZALtrAhPZFWNMw1dMLB
         15ZKbn1vwBAwp6WHT2IHMTupE1/hRaOJipSjEtVZveTPxXuh7Uc0iVqF6ThP3Y6qKdcr
         22Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775867664; x=1776472464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq7Kah9jpkT1YgC07HMZJ4YDhiS4H2l4B2K1DCxhJp4=;
        b=dgh7w59PonXKqRBiELjmeJZncZSs6NTEVU5p0Xg1h4OLoWWJi2WcF8WLuls4+Bo99A
         OMBGHEaPlYO+ZQKq0xWkAm0pu+yF3F+TdTD3dbTuLrrZNZCDiz4n/aC4KI72TNV5oRPc
         SbBfU114LjxyH9/LXfH86BB7kp3Stv1d1x5L2ZYvahHNS+BuVJU1Ba9KGwinurZGiOlr
         GKA3QTRGXZrZ4Xpr2wFRcGqdMSaa8nBKdWi8dAnKyDdZO7IPOklE0loxAf9QlCVAP7te
         dzjXnJd7hiFOHYU8CEvBxvtKpUgBNxbwQ8FndpBSrTyhaS2dSe7miGUt/iuMJfgDj7su
         X17w==
X-Gm-Message-State: AOJu0YwA0rSedjTBKloa46EqdKwMCp5A1bh02MXOYzFc8OLzst0PAb0y
	2nO/nrBzwFviHouDCaZY/BgKBMxPgZNhlEfgVJ7Zp3FRDe2tP3plviKAXYtxZcX9jKzZDi0Wdfl
	7U+3o6B4bLEq9TOh0ZsG3deSwJSVmScoGe7ho7NyK01a6MC4naxOQR4B0gMhJBGsaeMG3iP9Icy
	L8kiqUywJbzhxjAiV//kiO6SWM4omx4cy204JYPEp8VKZnyjz2Xi6beb00ZWc=
X-Received: from pfbg11.prod.google.com ([2002:a05:6a00:ae0b:b0:82b:928a:17cd])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:847:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82f0d1ec618mr4647184b3a.16.1775867663684;
 Fri, 10 Apr 2026 17:34:23 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:32:59 +0000
In-Reply-To: <20260411003300.1823020-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411003300.1823020-1-jacqwong@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411003300.1823020-2-jacqwong@google.com>
Subject: [PATCH v2 1/2] tpm: tpm_tis: add error logging for data transfer
From: Jacqueline Wong <jacqwong@google.com>
To: linux-integrity@vger.kernel.org
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	axelrasmussen@google.com, Jacqueline Wong <jacqwong@google.com>, 
	Jordan Hand <jhand@google.com>
Content-Type: text/plain; charset="UTF-8"

Add logging to more easily determine reason for transmit failure

Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jacqueline Wong <jacqwong@google.com>
Signed-off-by: Jordan Hand <jhand@google.com>
---
 drivers/char/tpm/tpm_tis_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..c79b696086fe 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		status = tpm_tis_status(chip);
 		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
 			rc = -EIO;
+			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
+					status);
 			goto out_err;
 		}
 	}
@@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	status = tpm_tis_status(chip);
 	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
 		rc = -EIO;
+		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
+				status);
 		goto out_err;
 	}
 
-- 
2.53.0.1213.gd9a14994de-goog

