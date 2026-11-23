Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453031;
	b=lANtT5F0qZIF8LKQEiBuO5Z0s6ykKbsUCuChEwNZKM19ijQfLbMWNbtUR3uomvKjZK5v
	 oiKWUnxGjFuVA2yDFmal5bUVhSrIIskzIoV9kHCgFmcTmDIoOfcN2VFpqUYT/smGlufKI
	 CjS+ltSprPXgD8Oj9ovR7abFYWsOpc94nSCfn6Zhpp1mwpKCSK5oQ1QpbzfH0UnmE5MQ/
	 7xMPWV5FQ6oSOoMKyMbtZRcaCWYi07cDGU/dSJL+6sQgWjuXauGbkLPi34CVFdstIk0J9
	 BVuNHl+NHnr3Rp7hXCBCSyGT0sD2NG5eX1H2DOIvdGNoRnTYPzVBDnG/c3zVa885F1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P3fBfqcM/kPnuGqsw8lNwmYfAv37CdYTr0usYr/iDGc=;
	b=pYoZg6nfs0whKpDcC2uaaIRGVNWyxVdyefCgu4BZD5/gapxAOzrOONYVpmWMBUdq50hY
	 4wTD7WB5bj5u0wMMUAcyCOcC4Dk1Iso3JEaavpnPyRivlkStRTfl6chKqRt+pnaTeuX9J
	 bd7t+jKS/2Duu9ySSUUWOMp541YAhorLe6ulpaeuewy6fk1mxFrGpTNHNZZ7J27Dzlx10
	 bAFvv9LM42fn1IEPYbXw4MIFNF0ngj1Ot8dTg3y0IyQO5fHaeT1SWBUJVSQ+jlsnKeKJM
	 BsJKNl4IV6zUrM9yNo4OkX42G0vRGJ1FuNu5FHHGf12/HdAUgBf3EyoGKdIv87vMAvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="DUN3iN/H";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650C606A31A
	for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 16:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B650C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=DUN3iN/H
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1731657b3a.2
        for <linux-integrity@vger.kernel.org>; Mon, 23 Nov 2026 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795453030; x=1796057830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3fBfqcM/kPnuGqsw8lNwmYfAv37CdYTr0usYr/iDGc=;
        b=DUN3iN/HfssMy9FBnHOp0jw8X/UvorwDf/wnBMkzu2sCTcfHwcO9tM4pSVDz/09zEC
         JSw3qnUDgSIwaYAcGhou5ipjYT9hT+InvMpWId95Xmmi4nRtRTBicIHh6iFZoCkuPyp5
         Y1P/GYUKfqni3d1j8lW8uj13iNVdiRLLecxWhg1gaUoJ6B4pX1tCQUlvokO8GkAsX9TM
         ru6W41nsVPGwZQf4eZOXJTx6KqSc7AYoUMNdxyTfTml3R1Gb+9c81Qf2Q9jTQlJOzo0g
         JE67H28luNkgmf4+1geMQYcK1NRfFNGmCl6imh/fcOcj56uW2RXSvEVRiGxO0Z2d6L3x
         u9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453030; x=1796057830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P3fBfqcM/kPnuGqsw8lNwmYfAv37CdYTr0usYr/iDGc=;
        b=ML3B+5py6tlTzNUSIJBEfTRJdEAR/0Ab6m3cwn2RR2GNy5obNSkXZideOy+aZpT0HN
         3E/5ea2ixzSHwHEyxuICPenRXWM1PhSH/HG0Lwxlkh/eAnRmz1BIpv6tgCtVg8S7Y7T4
         lWVICiy3AOit7p6ozB42BB7xq58U3LiQquaVgWB1qEoLCqeaI7fgHukPQcQNG5ARIzvF
         jy5CaTCBxHdkppWnZLLBovxh6CqAKigGMMG8C1hSRTIBZ9fmd8E2RY6vitRc/tGaI66a
         6TIVAXOu0c0WhacNlYDE8qilag/fpzIc727wYa1SomzHmWb4PtSQdJ6Y9a/+f78RENoh
         pbgQ==
X-Forwarded-Encrypted: i=1; AL+hErFchmnl2NRA4oPvOGGLMbt1ui3xsQWTEo2kC2S4EDz9aawcsU+2OS0AP4AZkgof1WeOrWWq/FWZMK0h/uP6h/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ShIdkx551HNpJ3ne2NUqtLQXZb7lrwZt2cX/7tOEnkt1GKcm8
	qEeF2GGJOgXLtKzV9DtBr82z4Lzg1YLD3TywvwiMEhzF3A1rz37a7FFY06FvF7R393I=
X-Gm-Gg: AZFdTZdDceJm4q5dY9w+XhaqFr1yK8I5oAsflLttTAosJlhwUklFViEkHUMgNg25X1d
	bvn7a7Z8Dq4o4Ko45oQ1saHynomeVeyxDc7PRm+gihCel++NiqNubvtbyYQFqXBPGhlZXVMgeb2
	jDS+U1RdJGcdMnKYDkcLJVQRdwgJagSQNUiZ6Tm+LjNc6N0k1EhmQ2hrG/2SzSnPoM8N3IglLVZ
	ofa0wXMKn+TWtZP/bAhbUToIZlNiWbERlg5i2vl5n5iiPun0ZHaf7kTvIvLRI2np21KUgzI4L6A
	IqeV8YuWwLR+qHrplPCdIboZMagspDuAZnTa9txlMyN6L47ZxEODKfoQ6lUOU9wQAKB7OZYAD3N
	8nUTfVsOuvaPgj9wrTgXNdmo9C7zYz8213yNemdcCei1ll0nTy9UqYqSUHxsvsjiVs0+o8YN+cG
	beBQGRyLUyvleFY+HdVAhBG0fJ59mYQLZ7Q/7nBRAyduym+C1dKNNDYRTDZ75QVSFAYfBRG2Anw
	gaXOutKUC36uf3yQPV+Sa6zWSOpRMdQYqsW60Rv03QY8UVeWgClaa8uJ8SjO9HHHaHsWiKFr356
	yCtckjk+oaobanRcRdJU4S//fWOPLOiru4GI
X-Received: by 2002:a05:6a20:7d8b:b0:3eb:a7ca:4d71 with SMTP id adf61e73a8af0-4014e0636damr15757562637.43.1795453030085;
        Mon, 23 Nov 2026 08:57:10 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cb6640429fsm2943198b3a.38.2026.11.23.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:57:09 -0800 (PST)
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
Subject: [PATCH v3] selftests: tpm2: test that io_uring reads ignore the file offset
Date: Mon, 23 Nov 2026 23:56:38 +0700
Message-ID: <20261123165638.2161305-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <awGr_tB3QXwnW1G2@kernel.org>
References: <awGr_tB3QXwnW1G2@kernel.org>
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

Test that an IORING_OP_READ request on /dev/tpm0 and /dev/tpmrm0
returns the whole pending response from its start, although sqe->off
points past the response header. The offset stays inside
priv->data_buffer, so an unpatched kernel fails the test on the
returned header without an out-of-bounds access.

Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---
Changes in v3:
- rewrite in Python as tpm2_tests.UringTest, run by test_uring.sh
  (Jarkko)
- io_uring through liburing-ffi (liburing 2.4+)
- test_uring.sh skips when liburing-ffi is missing or
  io_uring_queue_init() fails

 tools/testing/selftests/tpm2/Makefile      |  2 +-
 tools/testing/selftests/tpm2/test_uring.sh | 15 +++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 71 ++++++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/tpm2/test_uring.sh

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index a9bf9459fb25..44630fb980fa 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 include ../lib.mk
 
-TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
+TEST_PROGS := test_smoke.sh test_space.sh test_async.sh test_uring.sh
 TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
diff --git a/tools/testing/selftests/tpm2/test_uring.sh b/tools/testing/selftests/tpm2/test_uring.sh
new file mode 100755
index 000000000000..bb6e2e10162e
--- /dev/null
+++ b/tools/testing/selftests/tpm2/test_uring.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -e /dev/tpm0 ] || exit $ksft_skip
+[ -e /dev/tpmrm0 ] || exit $ksft_skip
+read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
+[ "$tpm_version" = 2 ] || exit $ksft_skip
+
+python3 -c 'import sys, tpm2_tests
+sys.exit(not tpm2_tests.uring_available())' || exit $ksft_skip
+
+python3 -m unittest -v tpm2_tests.UringTest 2>&1
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index ffe98b5c8d22..dc4e642450d6 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -331,3 +331,74 @@ class AsyncTest(unittest.TestCase):
 
         self.assertEqual(rc, 22)
         async_client.close()
+
+def uring_available():
+    import ctypes.util
+
+    name = ctypes.util.find_library('uring-ffi')
+    if not name:
+        return False
+    lib = ctypes.CDLL(name)
+    ring = ctypes.create_string_buffer(1024)
+    if lib.io_uring_queue_init(1, ring, 0) < 0:
+        return False
+    lib.io_uring_queue_exit(ring)
+    return True
+
+def uring_read(fd, size, off):
+    import ctypes.util
+
+    lib = ctypes.CDLL(ctypes.util.find_library('uring-ffi'))
+    lib.io_uring_get_sqe.restype = ctypes.c_void_p
+    lib.io_uring_prep_read.argtypes = [ctypes.c_void_p, ctypes.c_int,
+                                       ctypes.c_void_p, ctypes.c_uint,
+                                       ctypes.c_uint64]
+    ring = ctypes.create_string_buffer(1024)
+    ret = lib.io_uring_queue_init(1, ring, 0)
+    if ret < 0:
+        raise OSError(-ret, 'io_uring_queue_init')
+    try:
+        buf = ctypes.create_string_buffer(size)
+        lib.io_uring_prep_read(lib.io_uring_get_sqe(ring), fd, buf, size, off)
+        ret = lib.io_uring_submit(ring)
+        if ret < 0:
+            raise OSError(-ret, 'io_uring_submit')
+        cqe = ctypes.c_void_p()
+        ret = lib.io_uring_wait_cqe(ring, ctypes.byref(cqe))
+        if ret < 0:
+            raise OSError(-ret, 'io_uring_wait_cqe')
+        # cqe->res follows the 64-bit user_data
+        res = ctypes.c_int.from_address(cqe.value + 8).value
+    finally:
+        lib.io_uring_queue_exit(ring)
+
+    return res, buf.raw
+
+class UringTest(unittest.TestCase):
+    def read_response(self, flags):
+        client = tpm2.Client(flags)
+        fmt = '>HII III'
+        cmd = struct.pack(fmt,
+                          tpm2.TPM2_ST_NO_SESSIONS,
+                          struct.calcsize(fmt),
+                          tpm2.TPM2_CC_GET_CAPABILITY,
+                          tpm2.TPM2_CAP_TPM_PROPERTIES,
+                          tpm2.TPM2_PT_FIXED, 1)
+        try:
+            client.tpm.write(cmd)
+            # Offset 10 stays inside the response, so an unpatched kernel
+            # skips the header instead of reading out of bounds
+            res, rsp = uring_read(client.tpm.fileno(), 4096, 10)
+        finally:
+            client.close()
+
+        self.assertGreaterEqual(res, 10)
+        sz, rc = struct.unpack('>II', rsp[2:10])
+        self.assertEqual(sz, res)
+        self.assertEqual(rc, 0)
+
+    def test_read_tpm(self):
+        self.read_response(0)
+
+    def test_read_tpmrm(self):
+        self.read_response(tpm2.Client.FLAG_SPACE)
-- 
2.52.0

