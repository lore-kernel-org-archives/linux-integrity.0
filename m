Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141175;
	b=Oh+PtVjfeKY46BLNUSEw7yyCHF5R5xAQRDkmZXVEBSg2QF31k+VyDqUGWBIQTZjL3E7s
	 VGp/0kNAM6Qa4eQ4LX9FyU9+5EZjCTG91ur2MpZ0RMFH0FenfBE7JtClQzA68lWl2i4vP
	 4YXq65DLpWz0Ew1XdmCjrdaK/Hk46PMkm+GqrYc4mllpDdFjx+Ta3p9s+EhLd6TZBpmi/
	 LJsZTJvOnjrrP8vbky03be0efrbDpTMTVIUse/fTGgGCT0D+MotQZuJYvCXjOyx5miHFX
	 fL1+ir88Hs/RsXzLXuJzCcdWHADyRT/qBlz/lIHzr0xstxJ3SsBSSRGqrYv2YeWKwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
	b=ej35l8ujShkbIv0UgQQ42AvXFtfnJ0UkS15eXf/nulkKY7CVpSLRj/R+bEy1vhoXDD+J
	 PETziD848244+OjbzAgKuE5EkemPmrf2OOw1TrLmYkQq9VMQeF7e9wGL6o41MuR226BE8
	 /kTOxbuXxOROG9+0gRO1Bvv2CwnR3LnZv5W8rEbe6DkacjfZdaSu5WzJP7cAaQTnOo6hH
	 4iwB2iU81IF24YqNkigmxHKkGljAzymVqOGrVdK+a5Vei6h/2IgRbeOufIeK1OymkgbG0
	 yoUqeoCLWfYMGuHM/tL1R+Yj8KX9xFDPYuR2WXy+7YflqSL+dyUOCwjA6vpxpSbyIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNSg2lvA;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D0606D82F
	for <linux-integrity@vger.kernel.org>; Sun,  8 Nov 2026 12:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531D0606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNSg2lvA
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso105130eec.0
        for <linux-integrity@vger.kernel.org>; Sun, 08 Nov 2026 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141174; x=1794745974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
        b=DNSg2lvA/YwwEds4kUckpEBeQb9JSJZaMJ+7AhOnpdKDZwhkQECjt1S97dHZb0brLO
         JIVeXHMX1RTIk088T0AKg+urcSev4bzUCIKaPTszlcQ+ROeNi83b56okerZdJP0ttVc3
         pB//u4vRcwchCOxuIVqKiREHBMjGFydYlEg8kXVKqqgK4q9S481H5jfNW/DzIrZkXCT7
         hJc9JwaGw0Z3aK2e4MXMvOjgEy8sPZnrs9FvG4ko5KdvLZgIegRFo5+i94aR5OOM144G
         ZIW94yWRYeHTbHfrE8LGqJaeVOfWn4rLlxENx/vKswW0LXJ74C/1HEti5QtMq3H3sED5
         S64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141174; x=1794745974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKKrVaDw8VhN0ThEY1srVBzSbNH24223CDIfI/w1Bw0=;
        b=dHabmaotyTECQQ1lwKD6hXeOk/is3h2uBNvuJrh067vCfL38CqMFz1RjuO26+BLShh
         EeN5NXGR5FQApUIw/LJ12qZNipnmN3dfZNt5HCCbCsLC3/TE05ST+idi2HkOYTwnKWIG
         Vy/vGYD3Zv2qawx3oe9f8mA9LF0vuZjZf1DtuAuwpKEc6dWIie/BdqPAW3iOkAJXpg2V
         uucTPuU7+DVzYznv4ZcQT35horra8ECF7j2xBUdI+J5Eln+94DsWAVot5tZCpPLFNsYL
         lpu4NvFboLNO7z/3izjVPhmfWiOgiYSy8DegEiV6GLDb2aR/crRw+CYQTo7USFYiYt2/
         p2xA==
X-Forwarded-Encrypted: i=1; AL+hErEHFhWksfafafcAop+wdcC3S/S6E4HIl9RDtAOaXZUxI+VPctOXHxWuu8k8dP11Iz4O/uAwbnQNRii4iQz6zfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Unkv785R8Ig1PHsnF2f7OH+VMVdOBNQbnygaFWEgDZQQikHS7
	hP6+4Y3CqdBRvq2DVyeChHpZNtV4qKpFaSI5lFDsUMoY08zbvdQANomS
X-Gm-Gg: AYBFou36lQhechS3XVHPUKpkm8hnc7bIPQzzFTLdlcoNoluLYkUTISD+NnIOZ+VARxJ
	FyzeYPESb+TvshXgHz3m2I5OAseS21U2iRvkuC/SM7NBGJRkRomvNe6vpe0880tosWYleCci07u
	f9uGVmzfS+PIR7IleEf7M1ITnSv9p6JtfiUiEVsnatpLgQmwXy9e3t1WyMzxwbaTmDBxSNO9LAa
	VtTjBwByqtC5ifQ2gJfN6C8tRESTB1363rp4tQymPl5OuUgnpvxbrpAXpI1eukIgYaHzPa50Eu0
	bj0x5tfogbB0St/5PN10qp0y198uIY1YsmfTnvbaDHtZoTpOTLcMsfVk72oN/GEbnN9VdC61o8N
	VMmEAo7VK6sIUsCzhp/2N9OjD71br4nq++0862kDFAISGnOP0CSg6sH4VQsF8t5uCgOYh5JsPlW
	lnokCLY93nhOFazJe5LJvEgZ/oaXEMr2E+3hEZPRp44tDrsextiwT7fxmYnng7Ho/1n640tsYB2
	tsPcgZJ38bn68VgiwXbC9dguarcHWSwFGd8lFqT8T9o8Uz+fa29oQpzUUHONOMeYZGH6LIPG527
	19pmCiL82XiwyzKNx25GZA7iB01GcRnuZ4DZUgUANsye6R6N
X-Received: by 2002:a05:693c:69d9:b0:36a:270:ce76 with SMTP id 5a478bee46e88-3725603960bmr2921302eec.33.1794141174312;
        Sun, 08 Nov 2026 04:32:54 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm4767363eec.23.2026.11.08.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:32:53 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Sun,  8 Nov 2026 21:32:46 +0900
Message-ID: <20261108123247.426040-1-hj351016@gmail.com>
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
v2: Rename the local bool flush_timeout -> flush, per Jarkko's review.
    No functional change.
 drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212..97c1b7c 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,19 @@ out:
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
+	 * mutex is held deadlocks if the timeout work is already running and
+	 * waiting for the lock. Flush after dropping the mutex; the timer is
+	 * deleted above under the lock, so no new timeout work can be queued.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 
-- 
2.43.0

