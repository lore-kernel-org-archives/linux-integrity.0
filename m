Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86F361958
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008279; cv=none; b=DftD/FEiydNgTcW2SpJFPMUOkI2XBQbh8TLoiTe0QbQxBy9omSjb9H5pzEMZLGwh3InOHsT41j2jlmQMpicXEmJzInLJJ3QSvAo1oKGXfDabeUdIAo5ZriSKHo+8KNEY/xAw/BS/tH8Ohe568cwCSXe/3oiFtkWEvYf9+3h4BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008279; c=relaxed/simple;
	bh=5plLy/akUgnW+2omHUcDOEnJjRaaas6WdXfuN0Z4nP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l76j40hMnKtv4l4LV2Y7st7WNg8WM3Y3vzQqYqWhPVapuczWJ9qME8wuDwAwF9bt1vX16Eg4+LGtvwJGu+KcxUDNAxjA7fnIyuJl7uawVdmzvgfLNRUCWscm88rpcuBdAWdn63JwMIS90fEdjcila5ICNQUcJuXaJvYa6TrZ2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OzZNYWed; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OzZNYWed"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c294bdd76cdso35930466b.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Sep 2026 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789008276; x=1789613076; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RGo0BucmWwjHY/M/mqoExTi1Uj0ClHrt9derWN+gAl8=;
        b=OzZNYWedrQt0Kuhm8WYrVmlKdhayoZA+lFUp81rebzT9YcHezOjql2DcdqNX+BgEuV
         6YgYA+YI6GwG/pLQFrt7ev4+hK/LUxPpuw4cuOSXCGbzzDmXPWKYxEhVngW4nRB2LrXo
         rf/iLZn8e4WcUweth4/7XknF1XOjLXrXy6xqObUFRb88fFl1PVsKEI1fqdLHKnqlg5Pe
         UcJV/7pQmiH1AHgymlBAyAHJ97q9gPzOS7JTV6+obVR/lAgAH+DaGUZOJTlRU65Vq9vx
         +A8u0GCsdjddJK5rTma9N5rCJLfV58spmvd9TGCKxOTIAzxZXiVB0iRY62N2Q0HyHy0I
         Fyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789008276; x=1789613076;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGo0BucmWwjHY/M/mqoExTi1Uj0ClHrt9derWN+gAl8=;
        b=GH/Yr3TGbA70XLoeUVwk1dXNOWlqbyF+zCDyY5B4RnmzdVM98UzsbkvHvCZ+V1lahA
         UQ59uaUN2dBwxFYIaj+gi5Onj2Q4cwlwmmaTfRKrA6xIyJUu1ZpZn1r1KyAS2f1tmrvv
         SOIgX+x9kNG1JCEn4+m2r0CJ3StwuAQNTtiHwWZvrWp6jwnPNfbD1m1rEQhSJaudQD7T
         sSaomBFdfjKW4RKD+rsxXaGhKIbqx7Oa/4R/QDqEc/aYGzJsdiNM/7tCtJzPUaMSau+4
         s+xKs4iYaO/AlQUoPFzZcyvQBu2itKjKwjYPJ6nr5pVD9xk92f1ZCUeoct/enZnS9CDe
         79sA==
X-Forwarded-Encrypted: i=1; AKwUvBzjp10nPvj+JQlkVOzH7gvHlF7c5Dw0JDC+XqIMBOmUYPiTxCH4A1J70XLM2R1jWc0T9mQA74EIFkQeFarYekU=@vger.kernel.org
X-Gm-Message-State: AFuF++nAvxD+7H5IAjxbmfOiNWa9BKMHycDFFNst7ZdWNldkyVNBzPbN
	JxD9j4OwxUZ3vrUvCM0vjfmKuyQOu/UuGk2KVUNNpnY7ynq3zqua7YqMFitNTG0LRTs=
X-Gm-Gg: AYBFou1veOAIclcZPL5iE3knni3XcisTrPWvO//Ow++AT46Hg31R5l8OiDQNTdiu7BE
	NVq/AX8KLAbZsvG9XKzVjHedy9YNifsTnLIflS5Zl+YYXIbhZJH9GCLB3NX1R2Bvy6wYBuzMPD7
	qVQb3fBrg/7cKRUnffZ+Kpc+7UdiMynhC+mqDO1UDPmqt8DeQY/xmU6ceDcOCwH1kGUQMPEH7jD
	a93jTal0ZOJi83l/Swva4vGPcAQog+/gOb0afQ5O0/Su7TxiWvHQMOG8ja64QNghy/d+LFVlFhr
	8AesAAV8cBXSB4rmEtRCtjRUTBKryI5QyHBMB6vxYyahLzpHarcsHYE9neTAubbLsRM5OrII4zF
	e/AGSE8w3lsFYuGmWzFbRQHpL0Q8L/i9qu5+GKYND8tEQfBUDlB3UdCoVtE5mPPCfeLrhHj6bqD
	/w1WP7c4clyKtPZHe2DpWG+MfAoKAM6VqEewA54s97ksBXIbdUcnKxZLy2XP2EXdGufCr5PQGpK
	hvaNL4PpgctxLJTs0JtjiAIggCm
X-Received: by 2002:a17:907:9494:b0:c26:1691:b362 with SMTP id a640c23a62f3a-c261691b930mr1596840166b.27.1789008276432;
        Wed, 09 Sep 2026 19:44:36 -0700 (PDT)
Received: from r1chard ([2401:e180:8d23:5f05:2c5b:a1bb:33f1:a712])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841054sm81992665ad.3.2026.09.09.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:44:35 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:44:31 +0800
From: Richard Lyu <richard.lyu@suse.com>
To: jarkko@kernel.org
Cc: fourier.thomas@gmail.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
	richard.lyu@suse.com
Subject: [PATCH v2] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <20260910024430.40418-1-richard.lyu@suse.com>
References: <aqIVn0cDBvIYKggE@r1chard>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqIVn0cDBvIYKggE@r1chard>
X-Mailer: git-send-email 2.51.0
User-Agent: Mutt/2.2.16 (2025-11-22)

The comment above the wmb() in tpm_pm_resume() states that the barrier
guarantees TPM_CHIP_FLAG_SUSPENDED is written last, so that hwrng does
not activate before the chip has been fully resumed.  It cannot do so:
it is placed after the store that clears the flag, and therefore does
not order the preceding resume work before that store.  It also has
nothing to pair with, as tpm_try_get_ops() contains no matching read
barrier.

Drop the barrier along with the comment rather than leave a no-op
behind.  Should such ordering turn out to be needed, it would require
paired barriers or locking.

Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
Signed-off-by: Richard Lyu <richard.lyu@suse.com>

---
v2:
- Drop the Fixes tag: this is a cleanup, not a bug fix.
- Link to v1: https://lore.kernel.org/all/aqIVn0cDBvIYKggE@r1chard/
---
 drivers/char/tpm/tpm-interface.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b4e749e70b02..0bab78c8767c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -497,12 +497,6 @@ int tpm_pm_resume(struct device *dev)
 
 	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
-	/*
-	 * Guarantee that SUSPENDED is written last, so that hwrng does not
-	 * activate before the chip has been fully resumed.
-	 */
-	wmb();
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
-- 
2.51.0

