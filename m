Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912531;
	b=gUanZhu1HZmAegNjcQYxBY3ymIIccpCeWs3jQ47pcnSO/7j/05AlUOKwDeNkX03B4gHh
	 1WD4lS6vBXMBWvL+MOFcONcfd6fPr12VdH+ZhjigAY4wnGZyWw4xXnirs+I28Al3/prqu
	 C3ukt2YT1r4HVd2GLrj0cz3D7cG2O1eZ4EdJtbZ0le7TYpXM8O75UPNdcNFscftOquAaZ
	 bVkYSPOQcbQXB7ufBs67YbkkPgs0fH3oSeez7HmGv7RmUTKATCU8jFGWOU9Nau3DZZmmy
	 YnW7ySRrJ5H0UjtppD4XBnjC1pBAV1adCre5xwJP1KuMvZtWSlJm/8e/lQrUa2faRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jow4/NJXPlMxTDwWdHpqgFrgbPhIO+nXQtLiDfMR1tU=;
	b=HsMFN8eqxkP1kyUYfb7WlLg56Q5BZysxTLQwN6q7qLASb0A/yfh3zpNPAS2Lf0Jmc9Ff
	 rNLU1m7MIkoXF5Zpr9p3AhE6AWNZkPB6fmwXmbV4P/dBHRyv+kdgMaunWA4gs/FTSKYc4
	 lnCvFfoN4iGLE/rvvo30c1+4OGGPoeWKNWJ5AaOzJ8mGvF0VXgWkOrj0O81CXocYNpGWN
	 v/Mvq4xS7cNFoMWNXkrVwqlcwx6WO/r7O1M33nnOrbNUjKNqPGxsp6/qd1sY/bEnaGxX8
	 jnYwLF20CyVEi9yP574fq1j1zqYZ6tg05zQrE5jKOQgZG4LoDsC7iADwpEfNMu+6IAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=jbp6nkMn;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5910606A329
	for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2026 10:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5910606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=jbp6nkMn
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1970334a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2026 02:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794912530; x=1795517330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jow4/NJXPlMxTDwWdHpqgFrgbPhIO+nXQtLiDfMR1tU=;
        b=jbp6nkMn3Sl5/l4KnQ/hOPVilhm8/tredrSh9cE+mITEKvqCj+pGhcWraU2Z4Lymme
         XQJAGKiA3y3AYvT8LHXNFQYivJOstSYxhbDzuU1ygyKLXHLiQAeD9Gm6DtobXSVc0XZu
         4wb7OwiZjU+DgDp3YDXg6ob0FYtrwKCFVjjAs/lKLrte88fmY1pgBuFsWSSpqTWb0ddp
         3L4yRu+5nXRg38a28tUpgANDKOQXQcvwvdp53RuGTcFmY9TqmHcJ1KBShagqBIOuvS45
         GdEV27Kq78inM40Q4HNz8CdbscUBvgRlinI2cnehJn2fpTymEymSVqLm+FZlzZ++qPms
         Oo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912530; x=1795517330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jow4/NJXPlMxTDwWdHpqgFrgbPhIO+nXQtLiDfMR1tU=;
        b=eOVcgeY7rr0n7Qt5DDJFg0YaiNcEN6G+frkpjXn9vmF3+NAOlklYlxGMRyfQQ8qrmQ
         4PZ247xTyoypbDdjbl/RGi8vVN+TI2hqZAteRM+HSn8OQwEdx0Cp4zA1yclJo5B5ehM9
         K/O4yMrdrKbBLSHDZ5rtXuoNn4NN7p5G1jPiL6dumybD4b6H6Ox1dOvnj3I14nIWtkLz
         5fOFV7lbiezUnzM4pww+PEcXWM65wpdpd1WdtsA5eKX2uGLuyixfRCGP3P839LBRxBFL
         vIifPWf0cl7es503zgFz0vchAQP0M32g1Dpv61UFT0TiJDxM3ik/QO0oxFl9arnlgPZ4
         pTvA==
X-Forwarded-Encrypted: i=1; AL+hErGDy840g1JTGWJtneUjm0s8xGlM8IKfruTIeTGhlO6JuJzQuN8MNo7W1OzNxH7Pfe1CTaOlSAcbCOanBhTllko=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EfMQA6XSq60Cd2OdZjTQ4I+6G4MTPxsq1U30nJivWfgmplF5v
	PpHAV9YEsTsudKfWfRvY3Zqe/20rYZLK7EJzfFTFOk8v4F5xx84HLeLhJpnpPCkldvM=
X-Gm-Gg: AZFdTZdiEbhcvc2i2A2lowQOqS/SC/TJYibR0YNUN9RcvIaOCYp43rvzR4z7Z+RMmIU
	qJCkvY8NLLVIOeDwbAJe1adSPqQmVBsfutZx1PIExm7/qYVq868Jce4bXvRaWWQooKlQMVBnWqk
	g8J0b565n0GwkLv8+QOgcbGz45bEoSIJFQ+mDshYFDOefSZtbgcd3xzm46MpE45B3EkfOd8dxYP
	aPaefSobI5MaDoaD/hXwL00JmmmpX36pKEkVkptx860tZfrpi7BAcO/2EuZ73zSyYXN6jUBaJVK
	vccOytungyfUeJ0O0PjTGMiTn0qqgt8n+U9Yn1hrfIwYhR1ExmGUN/OHBagoIZmR1YYkJZKvGvC
	QoyFhY124Y2wk0I88OYY1b8djRokOIyHxNGjAqBmmnNda8EGTB9D45jlkyE0/sKPA4oK0w7qgO/
	k4M5bRn14NVNXDzDw4+hGyIjuSUe/ThwYI7CVyfpo+GuuLFMd2MZt9PtP2sr0mmQ1hxTsRAvLv4
	y6wvGOrDORmmfn5J2nfJr1zrpYrDYsLpT2WVPFvlxJVp+S8znM54RMcKPISUIACc8Kxl0n+tW36
	U7YlU/p/9JtBO2czSJLzLons62yXLGab4DbQ
X-Received: by 2002:a17:90b:1d03:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3b1b0b47a08mr12777836a91.42.1794912530250;
        Tue, 17 Nov 2026 02:48:50 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc13275cfsm5904135a12.0.2026.11.17.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:48:49 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>,
	stable@vger.kernel.org
Subject: [PATCH] tpm: track the response read position internally, not via the file offset
Date: Tue, 17 Nov 2026 17:48:38 +0700
Message-ID: <20261117104838.2650999-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <alvD5nOP15O5B8Ai@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
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

Commit f20d61c22bca ("tpm: Make the TPM character devices non-seekable")
made pread() fail with -ESPIPE, but tpm_common_read() still indexes
data_buffer with *off, and io_uring can still set it: IORING_OP_READ
copies sqe->off into ki_pos without checking FMODE_PREAD, and
loop_rw_iter() passes it to ->read(). With sqe->off = 0x1400 the read
copies heap memory past data_buffer to user space and then zeroes it:

  BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
  Read of size 16 by task iou-wrk-148/149
  Call Trace:
   _copy_to_user+0x4b/0x70
   tpm_common_read+0x16e/0x2c0
   loop_rw_iter+0x235/0x5a0
   __io_read+0xc6e/0x11a0
   io_read+0x8a/0x180

Keep the read position in file_priv, protected by buffer_mutex, and
ignore *off. This also closes a race where read() samples f_pos before
taking buffer_mutex and a concurrent write() replaces the response in
between.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com/
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---
- A C reproducer for the io_uring path is available on request.
- nonseekable_open() only closes the VFS doors (lseek(), pread()); io_uring
  bypasses both, so with this patch an IORING_OP_READ that passes an
  explicit sqe->off ignores the offset and reads sequentially.

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

