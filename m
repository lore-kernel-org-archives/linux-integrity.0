Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157108;
	b=kh7MjXW9WWx4EVfv++sVaGO6m476OIRbcCajB7sSmLzxCl57I1Iqx4liz8H0D2UgWbqE
	 +Ajv8PO//7ZFefH9FeHmQQJfeQMVJ7OCYS76oVTD9Jm/BCSgqbXCOlcnMlTkapA1BUhEQ
	 eD4nboxseMtorqYYwArj7R2PWyGxtBJttv2wLalJ+R8Is/zZQwUkHA4jfk4+u1X9HiEwX
	 hF9giP+OZmWkoFzvYnUF2XN9MHwZI6oBgyBq7WPg4vLyF99kseJ5JUObGt1WZSLCLmpF/
	 VeJhFu2HWBW4K2ozB8/QGTeHSxAtNa1AuB/z7rMtQV9MAfzc7nEKibqouVIWNM/Gg9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
	b=zdriT9Ag20eH1yjJXeG8prcQNX/0KZovUVueUMgW1mddskNCt48WV09Crog2uk4aGKcG
	 jNIb0Bs4dtgzqFS/Cej2iLMasDChH0767g4rYNFMcZh3c4ymhnPX4yW9k1Udr7NlWoIF1
	 tQjdDDFplhmPoWj8CeGDDc4APzSEcp7vXs1jTnEBXp5il2S8QIWXMtjDtreyo0yjq2DiA
	 GrO2sjqWL9ZYg9GzKCVe8bmmmiblxKz2Tq0ezP22XsCxw69Oo3DPLPtnPSYProFrh4PHM
	 BdLzWfbT5hA8c0KpFJrlfjMTzP3eSiGxd35TyxdqtQg8AZPfW0BxKyu2PirnXuVzAbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkdgHZGm;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B53606A321
	for <linux-integrity@vger.kernel.org>; Sun,  8 Nov 2026 16:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B53606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkdgHZGm
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1adbf62dd31so208015c88.0
        for <linux-integrity@vger.kernel.org>; Sun, 08 Nov 2026 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794157107; x=1794761907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
        b=QkdgHZGmSsLi5ADkdkJ9VZfphXO5ZbhqbbOTHZmnn3V16q59Sqq/9yeP08PK8xQBVu
         lqQ/rYuLmooHGpexNb/nDvltvkMhII+oy2PSdd+2Rf35Qa099JW3NWfAZ3M8qPBGguLQ
         HtfaOuG+z/u2JGJKHCeeehp/6M13qed77999QIXuA3kcgKgFGeoKLjdbGj9IsuOH8kad
         mWHU9Bz6IK9QzgC8Pyxj2XU64RJNjGfwq/HwhG40TX57zn1I3P70h/LNH3tCIuH3OJkL
         16IWUuUVvAFrR5sW4J5FHdUdBoxLW6zTIoo2f5poG6QAM4C2xdAj2aLq90mxd4R6VtrQ
         YbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157107; x=1794761907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5/FgJx6xQuodGivSipA+H8MZrv95a/oZ5kRZw8SEv0=;
        b=PTMNyR176C3p+ZOnCQmrTvPe4a66wCWR6GJN13TnmRS9UIhqZG3X5FLTb+q1HRRLO7
         q1UFYcecuX1W8o9Za/aC/p7Un4qVLLAHZOD6mXAfeuxDE6e/6O1rgPKsJSuu4G5E/A9n
         ip5brk0Cd2BgAkuytNSZ7DLRVgOzIhNxO8Kn8lCqUkKorypH2P0dn1pkAtcuwSkmjQlt
         Nkm6LT5znyWWxPdQiRx3Mc46Qpee7xs5+EuP8pAgc/en7gSyvC+/ctqQSOMd0Ugym6gE
         yPrM2QWMlsmSFnK5tldUX0nQSnob1kZTvZoVgUEnf4X/f14XQtC8WOKM220YZD9HfEnc
         d21Q==
X-Forwarded-Encrypted: i=1; AL+hErFV393DruNbkL1c4biCDgIvJ4uRpIxOYZi22afZ9E2TSXHZ4z1ecBKiD28rO3Nk51Sl/2T5FjYnfVPFMbl0oMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9opjxa+lpvodxQ1ajQdRowftBAwJ+X4wNyZ2+etML6VHok/3VI
	6RySKGlEbgoO+r8HC8Q7uovs8pmpRuI9X4lHVFbYDjIy4edy3PZUwbeRKNx1AYK/
X-Gm-Gg: AYBFou04OLJWkdI+z7ic3aDpkMbx0Or8PO59HXh+/BDz4Yw4VqF6ms8PFXN4lysJoWk
	CKPRLPkgoB+Ct62gaRQD5LbSuOf0rmEs4I7fp/lB+SlxOyg5PbkhVgP3TYRmejsyQjyRfb/1ES5
	hgyA3X1ggWVQ74t/YlMBGs+lAjQw+JaC5sItLugV9DJMZse/MQdw1V2X73BGHRe2hVBntD5Zg5V
	9f9lOfJDuuhroEXHvQJAoJo4wwVZiPMbVMsz7pHtEqqIrsrG6lTi4TD47CN6VboxWEDYklCt/az
	78MRroOa388XDaLmsHO9wjEoJOKDqxY4HdxCOmdjwNwnKhtbK0ty/bqoBiW92EMhlKZ1ehzpbUZ
	NrseuWs5d0N/vDDgwEeZH339bHTprfyIsJYpeOAOGVUlkwki2gCeLgbGt80NVaJgXN1wuTmxkBN
	Q3zFzlY3I3JqXotrGhnZPqGZWL8ZFm3Ebrr4xpyiB7C61D27EKScxcDf0qYrRraxowlnpLQpUOf
	kOkWSx9PnWY34bm30g+tllQhUZZatDXhSZW9SD3PKIViX0v3gjwa2ZllOP+LrmFWH49Mwf3bEBV
	ytL5wRc+6bRUw/GJA82dT9gtgVCBjJVbPms4hvcdruxY8ngp
X-Received: by 2002:a05:7022:1081:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1b39fe2dd5fmr2487572c88.1.1794157107231;
        Sun, 08 Nov 2026 08:58:27 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372631df629sm6539935eec.1.2026.11.08.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:58:26 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Mon,  9 Nov 2026 01:58:12 +0900
Message-ID: <20261108165812.676876-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

tpm_common_read() calls flush_work(&priv->timeout_work) under
priv->buffer_mutex, but tpm_timeout_work() also takes buffer_mutex, so a
running timeout work deadlocks the flush. Flush after unlocking; the timer
is deleted under the lock, so no new work can be queued.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v3: Trim the commit message to the essentials per Jarkko's review.
    No functional change (same as v2).
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..ee91f45 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,18 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() takes buffer_mutex, so flush it after dropping
+	 * the mutex to avoid a deadlock; the timer is deleted above, so no new
+	 * timeout work can be queued once the mutex is released.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

