Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530284;
	b=LKVG5j8SKWed6OhKnee94mgirFhjNDDaF9ftJ5w1zktB6v40wEhpy1YH0e1z+XNJayvM
	 5rJwqpm7QCY8gRxHaWtraRl7R8XoQ5yL5BH8F4VNWSmMhJwqU1HE+9YEU1dTAVFbKefsv
	 0+LzvbeH0WrFTNpz1mO/fwcCatSNu0+4xLjTupqtuSsZk11rUeDPfTa6vWyYTSfozVh2H
	 86wGfXr7fnWlkQlcRS/3GidWqzQcJiPz2ugJikHWQ4PFHW6gRB+A9B6ZtVqux+oA1sXJ4
	 QWzgNetqerPl5fV2zxOfy7Gju6Nsf3qZAMNIAEuYmRJZn8O2KGUNlf5SU0WfU0r9kqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nTAzMCxB2/gXwbZNiftqQIJAtiuMPi3mZnrzNiLaZ9A=;
	b=iId9J5lnQhXiNVVPIiIPMVAwoC9PlZMiYTdsB/UOFlz8k4bFPIk73gx2r0JmsclehFtZ
	 OWY+IIPnlKw9t79CQPubGgOV8o+WP6M84eBojGFiehAe83D0pflo13uZym1O3XJPWVQFe
	 q9rpX7zUZ4vjFGWSqi3Tuv/VTFaWMN+N50dORXAz6dbHWX7owEXydVRXWDln5f6ZjhzZV
	 saO/OGOyF0oAJ8WnCIOmkJwL/HokS4Lv6j6FxAuXQHmuWvNjynnSBTQRR5xKT2q/vdZ6f
	 Sd5scbSyo2SOoAYpbIv0a3gRK3alTMGcO4tFMvPiZ6UJ+WRM0ilEtV9QgD3QID0XMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="Du9/A+eB";
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3F606A326
	for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 14:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F3F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Du9/A+eB
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4d5e645d1so29042717b3.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795530283; x=1796135083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTAzMCxB2/gXwbZNiftqQIJAtiuMPi3mZnrzNiLaZ9A=;
        b=Du9/A+eBSdjR98FK336m4XD8kKC+rseVT1Gkr2MY8C4M4hjTGah9xbkn0enbvwoVmW
         3dhFAAA44kZ0996gxRwq15zspnvaei/ZQA9dbIcHK4OQIW/MOAiQ3Vn56oZ8Wsyg9MHR
         m5UXkgejOfPnSRRfFms+bK2pSps1zFsMje0lqG0C66F7ZdUCIes4BZ/53qUAC0n8lukx
         hueJZJBShUVpgD1R5898BXpaLvNNX8i126xB9VYKwKeWJaSr5E3ArHnVvv3e+h4IadYk
         9hvDU53n+tstAp3ePI+8C8alM4qn8lFQWTnPU+EvgsGjC1QNLxgqjMsiuLVjCsfeYTgF
         IsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530283; x=1796135083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTAzMCxB2/gXwbZNiftqQIJAtiuMPi3mZnrzNiLaZ9A=;
        b=uzZjG/P6AL0Tik5ftCoCwdVbgfQcKk9uzid4jpdATLPy5uye9KRpEaMtS18J7iOTzU
         yHZ17wTIPNeZ/SnIrnqDzUiIz08O4QHojhyxyq6xGVV9WrLQQtNv+C8oF/Hzd+OFHUeo
         YTc0wG1+KLjCvWbCE0Y0kv9kyhh5y5YvX59X3NEw/ffZEXRF2H6FVK7MZ5k44uP3zf/j
         OS0NjIDeHUjghHTYdI+Oxom+8PId8ki0/5lo9YC7nJK8CWTbVssXgkxOd9Drk+i0vMKd
         h5TVmS8adp5/DL+CLan4RwXyna7uZfyW8rv1OtyZB4iJZAhm0unKGlGMU/2uFg9FNLB3
         Kq3A==
X-Forwarded-Encrypted: i=1; AL+hErH/ZTOj6UiB3zP7NSLY865B1yN+wQvYdyC1Z78thHfRRogCxCQCn40H5Z1ES2czWzo8q7HrxSb72fUGa8z3nDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MdpVhAbxUudT0NrjZ4tBmLTBzi6Lsl9UWK0aRNbrG/Dwz/dio
	OkSu6TvykfPgGMsOj4pWVU7taCW7CXHq7c+pViQsWoccQ1PshkpszAdzMOlzNXcDGCY=
X-Gm-Gg: AZFdTZfAHNfhWSuLqr7BSZKgU1rheQdkLKGEzV4A6Ua6EGBqJ5aj4kBxxm8IZ2J3Dor
	VW5igfIj+/mpLEF0zW427zQAW3zolDDCiLJFnFIhxKTbMOKUldhz5hlt1UtkfHDowPkk9Aq6XxJ
	FJLsS8YcspnTkCSrEqsPYc5WFde0nxWNa4dtj9O0aYyaZo9k1gfqPnHReBpRufEZkwM0iH6og13
	xIC8XdkwtU41kNIxLUerYSm+el0f136FGSlh4F05QP8k2V+OI1ARtSBgRuW46iYBKe7SFBINShW
	rTK8ILw2k0GnfE00oyVCthVF9otnTEpMfmq7oy6lGU6mBOTBIQob5r8WkZDjVMlpDqpDYkbrwPb
	aqIshebHWX5VGthCEXli39o69Ae3WnCDH8d+D1rCSerlXwus+b7jsNIdf3Rrp2eRqd/MzXOIdM/
	r0fMwdDQhOZv3wvc3pS0FrLCW9jr5saQAMH4i71kbyUaZ8ZUdwTjQBAyyZTYG4PHL8yh1f5jFVD
	4OxIr+nSzurxDUfptZ2cpC5zvCyaKASECnSsdIrgw6beRdXJwL7Ti7HAPZ1Jq5IqK2BLc3w5pce
	N5BM+ODbEeWXwIujUzNZvQmofVa1ehGY00iFbg==
X-Received: by 2002:a05:690c:9b06:b0:8b4:e258:3dc with SMTP id 00721157ae682-8b5204eb0cfmr56859957b3.49.1795530283166;
        Tue, 24 Nov 2026 06:24:43 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033c2d4sm58062957b3.36.2026.11.24.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:24:42 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>,
	Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>
Subject: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
Date: Tue, 24 Nov 2026 21:24:31 +0700
Message-ID: <20261124142432.368943-2-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261124142432.368943-1-rmustafin@cloudlinux.com>
References: <20261124142432.368943-1-rmustafin@cloudlinux.com>
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

io_uring passes its own file offset to the TPM character devices, although
they are opened with nonseekable_open(): IORING_OP_READ copies sqe->off
into ki_pos without checking FMODE_PREAD. The devices also keep a single
command and response per open file, which does not fit asynchronous
requests.

Add tpm_common_read_iter() and tpm_common_write_iter(), which fail io_uring
and AIO requests with -EIO. A multishot read uses a synchronous kiocb, so
also reject IOCB_NOWAIT and io-wq workers. The callbacks call
tpm_common_read() and tpm_common_write() once per iovec, so readv() can
still split a response into the header and the body.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---
 drivers/char/tpm/tpm-dev-common.c | 70 +++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm-dev.c        |  2 +
 drivers/char/tpm/tpm-dev.h        |  2 +
 drivers/char/tpm/tpmrm-dev.c      |  2 +
 4 files changed, 76 insertions(+)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 553fc6aca94d..5189c1d72058 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -13,8 +13,10 @@
  * Device file system interface to the TPM
  */
 #include <linux/poll.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/workqueue.h>
 #include "tpm.h"
 #include "tpm-dev.h"
@@ -253,6 +255,74 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	return ret;
 }
 
+/*
+ * Reject io_uring and AIO. IORING_OP_READ_MULTISHOT requests use a
+ * synchronous kiocb, so also check for NOWAIT attempts and io-wq workers.
+ */
+static bool tpm_iter_is_async(struct kiocb *iocb)
+{
+	return !is_sync_kiocb(iocb) ||
+	       (iocb->ki_flags & IOCB_NOWAIT) ||
+	       (current->flags & PF_IO_WORKER);
+}
+
+/* Preserve the VFS fallback's per-iovec read/write semantics. */
+ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+
+	if (tpm_iter_is_async(iocb) || !user_backed_iter(to))
+		return -EIO;
+
+	while (iov_iter_count(to)) {
+		size_t len = iter_iov_len(to);
+		ssize_t nr;
+
+		nr = tpm_common_read(file, iter_iov_addr(to),
+				     len, &iocb->ki_pos);
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
+		}
+		ret += nr;
+		iov_iter_advance(to, nr);
+		if (nr != len)
+			break;
+	}
+
+	return ret;
+}
+
+ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t ret = 0;
+
+	if (tpm_iter_is_async(iocb) || !user_backed_iter(from))
+		return -EIO;
+
+	while (iov_iter_count(from)) {
+		size_t len = iter_iov_len(from);
+		ssize_t nr;
+
+		nr = tpm_common_write(file, iter_iov_addr(from),
+				      len, &iocb->ki_pos);
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
+		}
+		ret += nr;
+		iov_iter_advance(from, nr);
+		if (nr != len)
+			break;
+	}
+
+	return ret;
+}
+
 __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 {
 	struct file_priv *priv = file->private_data;
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 74488f0a7b78..9c2f0ad826be 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -62,6 +62,8 @@ const struct file_operations tpm_fops = {
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
+	.read_iter = tpm_common_read_iter,
+	.write_iter = tpm_common_write_iter,
 	.poll = tpm_common_poll,
 	.release = tpm_release,
 };
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index 34efb1ffa491..2f2186e6f094 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -28,6 +28,8 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			size_t size, loff_t *off);
 ssize_t tpm_common_write(struct file *file, const char __user *buf,
 			 size_t size, loff_t *off);
+ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from);
 __poll_t tpm_common_poll(struct file *file, poll_table *wait);
 
 void tpm_common_release(struct file *file, struct file_priv *priv);
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index 19e8f2779265..0c8c1a1b0b3b 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -49,6 +49,8 @@ const struct file_operations tpmrm_fops = {
 	.open = tpmrm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
+	.read_iter = tpm_common_read_iter,
+	.write_iter = tpm_common_write_iter,
 	.poll = tpm_common_poll,
 	.release = tpmrm_release,
 };
-- 
2.52.0

