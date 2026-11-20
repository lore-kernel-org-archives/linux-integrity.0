Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176989;
	b=MRAkrCsbjWW6SNm8Rh75y8q6odrAXVXWV+/sCA2CZwmGN4ufhwysZ50d/zrKN6UMl1hL
	 61b3Lm4/xlvwBMp7sGLhoZ4yaD1XA+sViXJXNceRsqKr9AfYyYL+v9fCX/q8t+HTQC8hS
	 Ghn6e5q6A0YWNONiiqU1TQJdIBCN8ckKJuqZ09h+MAuNVMMdOYIcz2Yn7HrICmkU9Hasy
	 u9YZ8uH558paGvOwkO40WMs0/8qUPp11YgpCaKZok+r+g5hld2Ee2eNcJoB6UnL49oTRY
	 Dg6ZAnK3q1Nj0/3my2jleRUi+Ft+6d6OZNbiuihjnNNn2NwuAcFra/2nIEmc2JQguzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mlU16s7/03iuntqpjZE6TiJEWGLy8t92iax2eFIVvl0=;
	b=RVxunuKwwCREVTQUIZVLNHYDx9z01Ayx0zSt/0vb8d3nMHsgDF970L7R9ybOTBjnQVwx
	 1Mls9s7OWArjNjUeV8+noeDchpZca7z4bJZNz1UgLOwelGP3fzwMlgS7tPMObz96x7pt6
	 yEy/pfFIyhhnryZSlrsgDzKBVBWRbyU1XJo8r+Vz449CUMh5dfQXv/UJLZ3/4Zg2oc7u+
	 hF4KaEwizwaEaLuSgPdRO/BoeSFOkMQVtJgrmhp0YEpQ0KSfX1ryYCwwiRk2k0Qd30bSy
	 nXu6on6zgFm4yEPaDLvjTWp1ADs6sARH2GHyERAxA16M4Y1Ljt3EdV4O0eVYF2cCcCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=kfoOGbry;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737B606A32A
	for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3737B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=kfoOGbry
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f04e3bf46dso2817305ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Nov 2026 04:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795176988; x=1795781788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlU16s7/03iuntqpjZE6TiJEWGLy8t92iax2eFIVvl0=;
        b=kfoOGbrycMj8gAlPRrvZhLEE5plzWJ0rrbPCTwN+YUDLqGJQdo1WQ17IOvMdC15jdU
         mr3j4t5KGIf8SFTp5sO/TNcd6BSQn2Kkca/VHP0ApcOOmg7osWK3xsmQ23+jvFXFyngM
         m8VrmCyduGhEwissLMQLwfiFq8D6qRz3k1yOB1bcw+Mn4AzKP9du+CTeAnUTkbqBAJIe
         QgGQYfRfrlteoMTJIT+MmcwZMlPk42hxXkZCqc/u0dxfyHucGPLHuYo0weA6fcAYMQpy
         qE+FLWfN+k/iHHxiBCN87IX85FN4shl0lDL44aU68093YWxA1DVYYXRNh52C3oXkBmW4
         Or1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176988; x=1795781788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlU16s7/03iuntqpjZE6TiJEWGLy8t92iax2eFIVvl0=;
        b=BOEzbCRgE7DqY5ziq+nA5iO6vyV1+zpOIuItQIyTBzz1eYk3vIHsMv0inz5hZcgV4R
         QDwBy4fPgaIlT4wysXoQ/fepNjciMiC1DKo7Iv4jgl5cP922Arnk2JF4AWleJ7nyZ3ph
         AF0Et0vSLIE0NeKmbxoS9Q/RvJQ2Xjya8Dc3652FW+PSY9zDP3yBSvEAM45M7M+ysg5R
         5Ff2vtYgsSDVJCq/g6+D3kNKIVLEVlgWg7H27S9tS16b6elmGMpbOiz0guUtoEKidZBg
         NxIaUe8crWBIEUBR7cRNTAZWrK77JY+zCyL1fuByER7msv8wNmLdEWIRLrIrxo+Td6MC
         JQuQ==
X-Forwarded-Encrypted: i=1; AL+hErE3eGyzSqAcFHtpmGxKuFMpdNtXIsWWQTIPmz0iMdk/VLvxa+O8gf01ZMn6dlXru8EcEinMLVXVX0SwXBmRYQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZLZ4zx5/2qzSlv/8VgxFJ0fk9DYfQpJ7ROYcpDu4FOQsuewsq
	srCH/tOaE9z+FiTx0iK7RXgK2rFFVUa7OLEvAr30u9G0nSTjm3kHfz6HjlhErTUJXJc=
X-Gm-Gg: AZFdTZcsErCfDVwhctIv1JuP4m72pvtYum5RXLYuSQy3UX8ZgjV2Z7wHa3tGvYO8eJq
	JUCfIijxnS0PIATtMb32W7YZLfS5vkFGCMTxsr3nPTSy2KftvPdjPvIU2mzILHKTDVl9SYv2sCr
	nzR7Vp8ddHDqW2CxGh3ml5T913RDx4YeBRu24PFcyQwSz1x4BlRk8KHYDtvVBFYjeZHvVLmdAxs
	QdnTpSrCIWiF+1PqIl0HUw7vb22JdtbhNNFTAvChmDrn7LVKMci+Jx7uDWJsPT8LbLo1M9ZQQ0S
	MymMJeyTKj9CnMygYbJ9UCvbXdxB8Werf7u6G3+YdIZTp1dicLQMTd6OkBlLInA5cM1JWVGfvLG
	7OlEQ+YTRJIiwzwiXXHM6YDp0Vcil8sTQJfUalWG0KK0IUV2iqmqnY8zyFuwnU6zFwD9eRF8LbH
	G+IacekbDdb6ssBYB0i2fC1M2xZn9Z9wLmTdcMH/VXXqDRZOmroyQT3YlR6VOoaTAjftXHX/nHs
	PJwVHHzdjYbY8ug/Cr4py7BoHuIeFJ9965C6wmfQZejikhJYzUMHZ5dbIb1uEpB2/+TLMngEg3P
	j4rwmxtFkslHqhbWKx66o4xUEtOtSI51RXqs
X-Received: by 2002:a17:90b:5289:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3b41c8fe855mr3017017a91.15.1795176988548;
        Fri, 20 Nov 2026 04:16:28 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm4463146a91.1.2026.11.20.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:16:28 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>,
	Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tpm: Track the response read position internally
Date: Fri, 20 Nov 2026 19:16:13 +0700
Message-ID: <20261120121614.978396-2-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120121614.978396-1-rmustafin@cloudlinux.com>
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
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

tpm_common_read() indexes data_buffer with the caller supplied *off.
A read issued through io_uring reaches the driver with that offset:
loop_rw_iter() passes &ki_pos to ->read(). This allows out-of-bounds
reads and zeroing of kernel memory:

  BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
  Read of size 16 by task iou-wrk-148/149
  Call Trace:
   _copy_to_user+0x4b/0x70
   tpm_common_read+0x16e/0x2c0
   loop_rw_iter+0x235/0x5a0
   __io_read+0xc6e/0x11a0
   io_read+0x8a/0x180

A plain read() racing a write() reaches the same access: read()
samples f_pos before taking buffer_mutex, so it can consume a new
response from the offset left by the previous one:

  BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
  Read of size 75 by task trigger/151
  Call Trace:
   _copy_to_user+0x4b/0x70
   tpm_common_read+0x16e/0x2c0
   vfs_read+0x189/0xc00
   ksys_read+0xf9/0x1d0

Replace *off with a read_pos member of struct file_priv. It is only
accessed under buffer_mutex, so the offset passed by the caller no
longer matters.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---
 drivers/char/tpm/tpm-dev-common.c | 11 ++++++-----
 drivers/char/tpm/tpm-dev.h        |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index ee91f456f975..553fc6aca94d 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -107,6 +107,7 @@ static void tpm_timeout_work(struct work_struct *work)
 	mutex_lock(&priv->buffer_mutex);
 	priv->response_read = true;
 	priv->response_length = 0;
+	priv->read_pos = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
@@ -149,21 +150,21 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			goto out;
 		}
 
-		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
+		rc = copy_to_user(buf, priv->data_buffer + priv->read_pos, ret_size);
 		if (rc) {
 			memset(priv->data_buffer, 0, TPM_BUFSIZE);
 			priv->response_length = 0;
 			ret_size = -EFAULT;
 		} else {
-			memset(priv->data_buffer + *off, 0, ret_size);
+			memset(priv->data_buffer + priv->read_pos, 0, ret_size);
 			priv->response_length -= ret_size;
-			*off += ret_size;
+			priv->read_pos += ret_size;
 		}
 	}
 
 out:
 	if (!priv->response_length) {
-		*off = 0;
+		priv->read_pos = 0;
 		timer_delete_sync(&priv->user_read_timer);
 		flush = true;
 	}
@@ -214,7 +215,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 
 	priv->response_length = 0;
 	priv->response_read = false;
-	*off = 0;
+	priv->read_pos = 0;
 
 	/*
 	 * If in nonblocking mode schedule an async job to send
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index f3742bcc73e3..34efb1ffa491 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -15,6 +15,7 @@ struct file_priv {
 	struct work_struct async_work;
 	wait_queue_head_t async_wait;
 	ssize_t response_length;
+	size_t read_pos;
 	bool response_read;
 	bool command_enqueued;
 
-- 
2.52.0

