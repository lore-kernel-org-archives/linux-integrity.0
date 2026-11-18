Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001076;
	b=0E8URAgbjNt3bjMUKp6YtQ7jwhBiIyLF0Wwe8l4kQFbFXm9uNtdtg9bpoTWtIO3LS3sh
	 WdEUF9SDvRD/j+hRwxsaQTkhZpA/pqSu4jdcQdJ9S4KiEAk67wtE9ywL+eq7xsUtMCjcB
	 gw99imc8CWazHoIZ4SWGAQ5g07IS6N94hfd1ugi8arGlAbnDAvW2MWEC75WDyUIA006C5
	 qZXEB8/BfRhkRdqKfSL7jvAmbQoMCUaD5O8H4VnHgOW7S4HuP5/lMJnXFUqjZ3XCcRjwV
	 XQXh0C0h/mHktdDw8sLQaV581ummS44Uu1FNDO8TosN8Aku63cBpNt8hwL/ZORRhQwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
	b=TJYGH5hyOlxb5o4RDzu8z11AHwXWxL1XYzjkxhkQymCj8m57ajUQBJS1dkOML68HGF80
	 BTIzLwmda+4GGUGQ3IbQ7ExV1fk54VZaAUI4Hy0EtXkC/R0W972AOmJLt5+j3mNRjoFkX
	 WnN1m0TBi5wwOIWWeHzhbtHt8Otkip/YbPaO2g+hNlyKz+CWcMc6a7DhdKp3y5IxYY01e
	 U/0QwSYWfD0/TiT9BvAB68D/pk6mKZc5AcANyw5hStt485uwbekaquggUAPoUvMOV8nSC
	 dbJ48yAVaOdU6sh7UUu8me3vQoG7X7YV0osEW/hctsgMzuMsXJLEgsw3l/CxAC1VthA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twWyIZ55;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9A606A338
	for <linux-integrity@vger.kernel.org>; Wed, 18 Nov 2026 11:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F9A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twWyIZ55
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so489449a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 18 Nov 2026 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001076; x=1795605876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=twWyIZ559njProg2yWQj/3Vnd7aqnM2sEXWgZyP1xXIqbTU31t8H7KzEvl28llhVKc
         ZFa7PVyLz1MXv5/5aGiqXyGo4cRMUZWeNXl/0rbfp06StiW2GeeNOLz2visK6L3oFktZ
         y5nGEPhOWPDIosfB1XftFmA+9BGwMwQOxh9p9jUfb6D6esytjhvblQx1Z4Q4L2huomFn
         bf5kfH0bb8rwnnRn192bXYWHfwwoXX7OnlQkui+GxuThTd9Ph4NnmcUhjN5kIcWs3yKQ
         Q5BokV3DTjDsk1XVrA4LcbNI5jzmrAsgsaz06u0XONnfABazZhKRXRstyoGrJn58XhIp
         MsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001076; x=1795605876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=aqiSaLAZYeVpwYWPL/HdiZsGK9mrZcwk/lYNcvH+GCixC8jcpJc7I7smDRvU6nFVS7
         RQ9rXlSRFX+Edmbyr+G2q3pneHcqBUJCVC0QMImarDI91+l+CJTgd/MDwBDBCw98Nxk7
         YTJQ5yhQX0w1aq1wu0Ls1PH5B08TQ97xP+EACvW7Bc2JsvHoo2WwCaPK9i6fu/26Aozn
         ykLml5n+dZ3pHTg0kAx0ejqTQ2zUUhd3vNbwGcwblnHbMsxb3u32pMCeqbCNPk6Id3sZ
         GB2TW4OP/PrWjogBbeuASIq5eFQGwmytWCpLnXOj5bjiZvbGvHcvhAQ9dGJMreVcqTap
         T1QA==
X-Forwarded-Encrypted: i=1; AL+hErE5kUPU5eAZVz6smfGlzo7EqJbtK2TNTfGomBmCJ3G7xHwGFNDA96RB33jMkxrJNFFZr3vO+bYEfZZ2hORVLMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6pBWWAiIeG4oZUJrOk6iny8M40HEnX7nROY8nZglkA3gbycWN
	qrURZUn3Y9JE5OQmsQQ3G+I1cJ94+YE4hgFdXumGDgjMP7gQXSwM4NGl
X-Gm-Gg: AZFdTZd/dt22l3peRQjcDKe5uJtERRgV5FFL3eUISrC6tHkBiG7AchtZlY6yURmy+RJ
	XL6+rGExZ4ERAv79Os6P3KBmOmIlD5ZPJHQZT0snzF62/k6cvtAzVaYwchOkWba+CJNr+KqCPNU
	33drr6ajMRSZ6+T9QhGo5HPzrkSmOSoZ0BmLgJSeOqUadVJT+MMVmvEjZSKUeUoGLv7XuPMheFF
	q8draFbmJLEoiJ2eo9ZF8hOba3uTGm3vK820F0tehVcVZoqIYHOsFc/jdfEGRs2Xd+YpTQXOgT1
	6uucuxfs51C9g/F8bUWH6+k5X2sEQECKh1NhlbYPSqhvdNalIKsVlvYWYnuSdVHGR98bUxoe5iO
	iLgRAGsxoeQ5t136fQS9/w2oLlNX9Nelnk+HXthuxOOMiRGzEhSoxa4JJYXwlc8pFxvEVXXlHEQ
	uQdj929jEt3kyvbeRFdycTGz3fMnMa3i2vmijvi1V2aopjpnhQHVWHV2ex3aci9s62uFp5Nwla+
	sKM+cB/kizbx3JRe5G6Vz6bBvwyB3/ASsfHDMLKo9NoGVsChffEt7OkHXF3NtP5NUQoX2/aiDz3
	fgMYaKNN3RlokT1gIqUPzdsT6j09NTPKjmO8aGyxqGLgPN4Xeg==
X-Received: by 2002:a17:90b:4d04:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b3d07597a9mr1914378a91.10.1795001075580;
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62842b6sm11510395ad.60.2026.11.18.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] tpm: ibmvtpm: don't call tpm_ibmvtpm_resume() under rtce_lock
Date: Wed, 18 Nov 2026 20:24:18 +0900
Message-ID: <20261118112418.1009785-1-hj351016@gmail.com>
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

tpm_ibmvtpm_send() holds rtce_lock (a spinlock) and, when the hypervisor
call returns H_CLOSED after a Live Partition Migration, calls
tpm_ibmvtpm_resume() to re-enable the CRQ before retrying.
tpm_ibmvtpm_resume() sleeps (msleep()), so calling it under the spinlock
sleeps in atomic context.

The in-flight command is already serialized by tpm_processing_cmd (other
senders wait on ibmvtpm->wq), so the rtce buffer stays valid without the
lock. Drop rtce_lock around the resume and retry.

Fixes: eba5cf3dcb84 ("tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..e06c4db2e138 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -247,7 +247,14 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		 * ibmvtpm_send_crq() once before failing.
 		 */
 		if (rc == H_CLOSED && retry) {
+			/*
+			 * tpm_ibmvtpm_resume() re-enables the CRQ and sleeps,
+			 * so it must not run under rtce_lock. The in-flight
+			 * command is already protected by tpm_processing_cmd.
+			 */
+			spin_unlock(&ibmvtpm->rtce_lock);
 			tpm_ibmvtpm_resume(ibmvtpm->dev);
+			spin_lock(&ibmvtpm->rtce_lock);
 			retry = false;
 			goto again;
 		}
-- 
2.43.0

