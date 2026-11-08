Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124741;
	b=pHBYJXfPTl5nQDm0CdFQn8jqR1RiIJBtiGf/h6d27gXOKmVrlsYI5cN883OyK/ZgP+RK
	 LocZXU6HuLbgl5rTcL7h8OerIjRKHwjtGk+lLSkh52swk70Xe/1KEAMurApvXaiHs4hq2
	 ZaZJQ1y6RBRrO8/nOBMHBP8XxF/eo0bLojXB9UYcuuW/YbQE8zqo42BxsLaNI1/R8IpRB
	 Zx6W7y6H3jQ2ymqa2axnS4RWsFjGPeN+8EpTB1vrl6jTxTsySskRPbwonaGYDdVEV+C76
	 Vy5vYBEfMxmTekgNYrfugT/3vXDd1HL5JThSyugfmJbj0Dhw8hA00Q6u+vEPrgj3Qvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
	b=1ZRNTQSYUvGnepRLFDm+9svca7KrJ9zMVNr1WKXRzrZ4PuLIbIYCB/QdQ7eEzwfyzM/8
	 hZYwGk4wCfK94VL5XX7s8bTtliSe7mE2z2eDch08mStqAkjj/FdoQN51rvRNp3bTANA9a
	 OV5RHGqSPtYP53ti9i5ohRIhZTf2PXdg6bKH0A5BjlHS90fJIrEFHjSAGRFI0xjUvWWng
	 uz3vPxZf2NJqfWwQJvFgoWKc5Yaqi2Gqae2QwcJtf5CfeCfL16al6tU59RkeyCqrqzQJi
	 9f4HSWkwiDEQDBEQ5c6em8Qsp4sq64dxKXBxnXRTNN5ofmKUrQt7+K6R5USe/nWFf8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weR81Ncw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720F606A320
	for <linux-integrity@vger.kernel.org>; Sun,  8 Nov 2026 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D720F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weR81Ncw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so650838eec.1
        for <linux-integrity@vger.kernel.org>; Sat, 07 Nov 2026 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124740; x=1794729540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
        b=weR81NcweyuBhQaWTFWZGi0vcRkp5kMYOWKhOi4uNjRNhOxGNm4GnkUKoMkOmfC9U7
         VVizkZCDuufxRNyda4QuRywNb2G1xpxgezv+rn5cr3/6hv0IWTEiF7ihY9m8kp9GDam1
         9yH6619OKEKqVpKmvBWEIBG3JMt0ZbvRpeKm8BcIB1o4+4GGPgcESFv01/xEbcxdrRc9
         hCiUJfSeWkxI5kxPY260FaxU+Px/24c9/Upo2CciHRAmXjQwRmBSu/Tk9Zpq6x+rOI+x
         q0Ygf2Soy41A6/ifyYohAxMd0DVynJZukvVIoXHOWWiny+wv7xqx9tsHiX2nlSGSxAjy
         NXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124740; x=1794729540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwIhs2lYepVcUm7QFvUJxPA/hvff1VaV/dOu2IxaRvM=;
        b=pHMT6C8hMx9RKZnBhJlY82raUPT4YALjknkMzd7HSs0sOQhYBLTDSfDi8ulSRytw+m
         lMyH0WTGrTHes0vGneNVWUzKFO5TPmr+CV4Sw3B/S5sTI3Ciy+k043doantD2toCUYVE
         nsZPtc/+yIVM4mP9AGvg9n+1cbi6s/oWl630iehOogRY6M0JMALzxWnupy7rPEIPw9jh
         VWnZN7zQfwRD6ZwN/ZdV7OBPJ1eIp2xvrDPcIugmOk+YfmWifNC9dGkjAuqGc5RroIck
         SQ5fkBtSxKeQq44V+cbwsS326sNNaYyN7rfvPemGgYWCDyOOpYffvxCnJ/TYZkwxlPUi
         h49A==
X-Forwarded-Encrypted: i=1; AL+hErEsKaAwjQlAOr/uu3uskgGwGe0Khg5SSzANeqy996RiX4En7OSiS2Y9Mo2ML4/X/SvHXi2MSyJ4xm3B4LhdXEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ogg8xh3NU1/Fi0/B4d7l0RqlWBYAiFineTMmNGc03cy0BSOUY
	wf09VMYSNv92ERAljkZLmCTI9VzYc1D95VR3/OV+pvZVzqvPGeO9dQO/
X-Gm-Gg: AYBFou0hmgJoRVMka8BxYQnMTL6EtBNKzplgbkQjfBC2ghScqwce1LhSpVpy4EBdMuV
	yieE8m/giCpXbO6hN4Ym1uzshDjXXOWy0hcqVGNmOZvPH6DmyadXBPDHjuT7/xqpPcu8JjAe8iu
	NVmJT39L5RldLt/+eb75G/vkYfGwCRlobkweykV4Ku0vXJGQscErM98B7tL+j7ctc+H/cbm39lL
	Qu/B7fjrLur120RS4hlYl/fk0f4OIDJRRbiGDH0uVc/Aj4GXIlboxVYDinlm1MDZSZ1MkN/ZWnw
	mYxu3QmyuAbw7Hq/1d9tqQcEqzoxqGoaE7nw8BJ8qwFvsLyTP7TFWxL4qUyzG4yvCQi5gdj2m3e
	0MvfqfHFKyWKNJTA5/VZYwzwTIdMepgS3THTn6vzv+lrruMfEaUn5sYnlZGM3p1qnkGotdjLjHp
	ymoQ3qeH5jVYsLp8vkCbgmfTJqrgLdc9vMcRJWl7+DLAULFw/c15ef/yCSx5VII7QqNYZCFhW35
	nxtZvBfPZ2Qj4CUSqxauwtjpXGXnxwfNiO5eGgA2dg8C60Cq9YM8A+hz2JClInd/SSomKPiYIlj
	HbS5xGOArYxBlNOBBcqxIyIyvzRukQqaMmVtbo8jZswqdi30
X-Received: by 2002:a05:7300:d211:b0:36a:1709:458 with SMTP id 5a478bee46e88-37256df1551mr2243835eec.27.1794124739956;
        Sat, 07 Nov 2026 23:58:59 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm5966379eec.28.2026.11.07.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:58:58 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Sun,  8 Nov 2026 16:58:48 +0900
Message-ID: <20261108075848.257145-1-hj351016@gmail.com>
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

tpm_common_read() flushes priv->timeout_work while holding
priv->buffer_mutex:

	mutex_lock(&priv->buffer_mutex);
	...
	if (!priv->response_length) {
		*off = 0;
		timer_delete_sync(&priv->user_read_timer);
		flush_work(&priv->timeout_work);
	}
	mutex_unlock(&priv->buffer_mutex);

The flushed handler, tpm_timeout_work(), takes the same buffer_mutex at
its start. user_reader_timeout() schedules timeout_work from the
user_read_timer, which is armed while a response is pending. If that
timer fires and timeout_work starts running while a reader holds
buffer_mutex, flush_work() waits for timeout_work to finish while the
reader holds the mutex, and timeout_work blocks acquiring that same
mutex -> deadlock. lockdep would report this as a circular locking
dependency between buffer_mutex and the work.

Before commit 9488585b21be ("tpm: add support for partial reads") the
timer deletion and the work flush ran before buffer_mutex was taken;
that commit moved them into the mutex-held section, introducing the
flush-under-lock cycle.

Flush timeout_work after dropping buffer_mutex. The timer is still
deleted under the lock, so no new timeout work can be queued once the
mutex is released, and the flush no longer runs under the lock the work
needs.

Found by static analysis (a checker for cancel/flush-sync of a work
performed under a lock that the work's handler also takes) and confirmed
by code inspection. Not reproduced at runtime: it requires the
deprecated user-space read timeout to fire while a read holds
buffer_mutex, so the deadlock is established by inspection rather than an
observed lockdep splat.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..f9b18ef 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush_timeout = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,19 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush_timeout = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
+	 * mutex is held deadlocks if the timeout work is already running and
+	 * waiting for the lock. Flush after dropping the mutex; the timer is
+	 * deleted above under the lock, so no new timeout work can be queued.
+	 */
+	if (flush_timeout)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

