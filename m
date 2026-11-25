Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589676;
	b=4udkp0jYl436sclRXS3Ey7iH7GDYBa7fS6zTRI99jOMaMH3lcTFOnWx8HK9BxkVJ1VJW
	 vLdt2tt3psGKrzckWu/vLmcrWwUIpIAEu3WWK9lxRki2G59T8A2JqcBdZ825qEw4Ok3u5
	 g+KtZlUPcypiz3NoXAqwZCZznEXpT/0WMpOeiMiylWzmvo12RkR2jh5I/ewl822U6Fej9
	 MGotTPYxYXoH4QPOKf4gZ4Fuvhr+AyI8JybSeNFcGTrKG1A+eXqkDabYkzhJAsECvy5zK
	 l10iGDWvUBU8/6jdBaAjHH2DmnHPew5xeVGjk3xnOx2wQVKJXlM5TTGTsSQU3Dct1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FA3OAU6eEjC7L1C6zX7t1wOu8qvpScaN/CAqUhfL2dY=;
	b=BGZM0uLIx0ekwHcWm2lWYGE14sXaaYbvaGEFHOz//lDqE3dgACV0uxXl4sFPoBDGVDn7
	 QtCy1Zl19eY/Dwk0ZCUrz3yzABRbDeNTxr2l5HV27z+x+SR2aBoWRQHj8nHe8nLYCdRrv
	 C3giqA70oka4kYd1ENurIagUYOKngwr+uiq9j6SE+adQDMSVg6LvbBYYKSzubKaoINSUK
	 pJVkyTGqgQVXObQ3IdNyan0Qglr5D0Y87zs5nIQsTjzE92XRwzpPg0TGNE6qW+VN4R4I9
	 O2owCL3Y/ZJeAefH1IKnAWXIGnbgfJ+Tn7BLYBkgJd3+HPXgDl/TdkxC3YmdpEOvZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="OeKocc/j";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB993606A31E
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 06:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB993606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=OeKocc/j
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso2089713a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795589675; x=1796194475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FA3OAU6eEjC7L1C6zX7t1wOu8qvpScaN/CAqUhfL2dY=;
        b=OeKocc/jgkyphXPYZoQ9dQj0qTRbGrxddODEBN6yK8n7q7LWAz4e0ov0eX5oAnfB3Z
         kxvN1cPZBlJRaDw8PUfQd0EisM4BBJkrc8eqKR7cZdynf3rZ6yjlLcHmEogaevayPMZx
         e2Hgqz+QlvJFXFBbVUUZN+EwLde0DyPyi78qQrBVlOTQLyB1A/Jy+iV8kUCUsBfD0Uj+
         6NbktBTepkHQ/V6dPMc7FyJ2tHMU4/4gZsxIoY2Y7fL1TnI/XUX1XLbPNZcQamudpu3M
         SCAdoXRxYKAe+2yRtd6v3m+SQrdi/Bl913ZoWo7YOL5KJq3SgZ9DQ0sbxyn3AVqgkGDc
         ybDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589675; x=1796194475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FA3OAU6eEjC7L1C6zX7t1wOu8qvpScaN/CAqUhfL2dY=;
        b=CkE0Md8ev+L6p75W01OcX6IsIoj4bIHSOeElbTzRgbxCTnDTnekwsqBfcARVRoQULW
         7dkCPCv6cjOd5/ocpzRGPXwp8qwAn73RBDiBpXJYuJrRxYHxSC6sr+1nekMG/4Zz2bIk
         PwpVJq37xciGJhh/exJLqzI+XLinG9alg/RFRKkVYm8RVhn8s9JWklothkiul8VDofCh
         yCrZoKD4E/UCig5zbpCNJaBG5TxHNxynt32au12WX7sVyQsYx2gq+4a1olYMnRrekZSh
         Ps7AjAdX7yzpktw5o6OnhhDRxbFiY7lpphZt1Uu+00/akgAy/JEXUkfffkspgdvPhB0b
         QJ7Q==
X-Forwarded-Encrypted: i=1; AL+hErGf1GliVU2iCiyAEco81GN5+vj7fzLyA7DJsmjoJZ5BNYeYokS78uZLXpqg1E78AD0v0ICJnLuzoN+ZL/6fLtQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z92iWwM7S+r5TfBFefW2SjwUas3Ek2tllGgx8yNyg8XTFCeA4nQ
	m1tIbhpONmUIx0+BE0F8zFGkif7atWOmCJxGzW7hgU4qofATOGr3GOef3DD5Ax8ovU8=
X-Gm-Gg: AZFdTZcRMOWZaopr6fRubvF4B14waHGI+KMQkEOWyd4f4doxTj4rancQdtPSpE/vgKB
	fdpNblTKGsW/IoWrZjkEkPj11gGDZOZejr6U08UgEUiW8SBy1PkOQiOomKvMSuSrgA2XeabAcbh
	z4qwpDiHXwO5v53bdkXIyDCSLtChjeg8Oz4S4FCDOSBZBNTg/OQ/p/wFDqYIFCmTM1moiEG6pz1
	cfELsUx0KPk5gULAk/q8qWyE/1/DHKcx3VLE+glBKFbfO8huSgET+1DICbbxb8BV6wYM+IeD9qa
	f9MNLEzZW5qHF2UZ8els2vTUEVL03qIs6tZu8fdgn1+b6V+7GExU6PXte2llVBUi627a8dMrDzk
	5YCk0gT3Hgs22PZFT7BX89f/BrdjyEfItxsR701E4EqtcAHOwgtVOF7cgxaN/NEogwFspJyQBMt
	nByW4f+vaHGtdgjiAeyFDbh/qqRnjNsXaQiUmHDFvTFRv6ChboVuebGOHCaboHpkxEJy3SRPsK/
	i2fwmKx2Ye/uV0w3htjUJfbme6sUtq52LrIvlr1/a8yI4qLI4xFB9dGVYHfGk2+MRIXNwSBeeMP
	YENQQ8Tl91hroEssGBW32EeGjpVhkAkhWIlG
X-Received: by 2002:a17:90b:5109:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b41c953f98mr17148999a91.49.1795589674969;
        Tue, 24 Nov 2026 22:54:34 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm26149320a91.8.2026.11.24.22.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:54:34 -0800 (PST)
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
Date: Wed, 25 Nov 2026 13:54:28 +0700
Message-ID: <20261125065429.1483868-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <awXHzblUfp05jZSQ@kernel.org>
References: <awXHzblUfp05jZSQ@kernel.org>
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

