Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589680;
	b=iene0zhrgViCIGTkE4H5nVNR5zvTy1SeA+ePLyUo8oyal7a+jIRayfr9jjz2+2icBnz5
	 jx6LiRcHsskNdFpPMuSN+TLyBzxMx1YKx2uZal50jkPUKQviOScpyNgHQoAQgvHstPeBS
	 OWM08mwXYfoFy4wBXHSV9CEkIwyKIZhHFTCrhNwmXrvvYvhr4eEljdNpvfzmoHPz6WqLL
	 D5atXKRlNkoVi4YkCDrKLbsIlJqJIczBKxtg+dkXngXKGSEPiLZ0/D5dWm+5P6awhMlTF
	 TkWsqOyNoFqZVS3mnen1ug2Mqav6LOTNVC/vp0gFgxs22P9zUedUGqsYyiSYrQ6+Sxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6WKlTv2ikV+tMBOUuWFLT86t7HrmSdz2dy/v4nMSeg4=;
	b=2bzJOzdDSksVFuHeKJfhGu55P3xFCUedRQ6ac+70fRTkHOj28t41V5P6XHPlZbclCKzO
	 Lq+VwzEZAM30UtfZum+4b1oPnYf0r3+M3ae43FsdcBAVXH+cna1Zf3YvFVwyl1/D/Q7Gu
	 JIegwyKk/HEI/W36A/MsohyemlO60K5o9klEa78E/H/v31oiMCVWXkI3zFmJamR2eXa8M
	 2NAkX7tiHx8Mgzr5n27xvNfH8Vd2KHROx73dIIkT3X2FLyH0VutLA4QpOIKxUeGCd/XWO
	 7XNmrictUUk7qdnD5GKYsU/Xn+TJJuvm46p0vV7tzxSDMrgiDn/BNdLAP+PZHVU3AJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LtslzANr;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA919606A321
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 06:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA919606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LtslzANr
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b402824d07so3661078a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Nov 2026 22:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795589679; x=1796194479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WKlTv2ikV+tMBOUuWFLT86t7HrmSdz2dy/v4nMSeg4=;
        b=LtslzANrqDUVC6r2xqMAWZBJ7DJK4fPKRmJG+V4ApFtevl+agm1IC2jxj6tLW702N6
         hZl+5tjJ6AdLSCmorONIJXAzep5CrzQrJDZjvJFD8sX20v7/eqKQuUhDMXLL9fdIcmjT
         gxbMTOe8m92fmSru8vTiDYw+RMACfurJ1fxHqbSB1DnkKnk11srDCMGpbnDh3FKXVhcs
         eZhPwhzf9J+Je9wlyYskzdaKnGxd2vmvcdURSjcmfRPgCaW3KqTAaJAphetV2Z44ilhj
         +qx/x+ITeojXo6sA8JinDHUoVeifTKLvv2ukJ3BU5w4bND2/D+gNrTRxgBP1c9RnqREt
         E4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589679; x=1796194479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6WKlTv2ikV+tMBOUuWFLT86t7HrmSdz2dy/v4nMSeg4=;
        b=hAs5WWZTG3kBrzzGHSbRYmm3lUta1ued+KsQNR6PFtixhoKtCwoyXcf/srxnmdYL+x
         ms73DWGxxja2yw2sy2c1uMnlnYe/TVWjGta+dtRFW/wLzRnW10IMunDyIYsfqQwUfWFn
         N7GKanw+ECG2Xhn6Vj70K41N68XdJY3b/1SmQWhyBOIzilg+l+N2d5S1xKRWBYO1A8y5
         GrFSERVj7gExTZjRUK9oxZStIz57YlY++SbUpJrETeeBrlDzGPu91SzKLs8Nhcbh9KWX
         wIYNb/zRdUTes9MzHmLao8whcYtd2QQGc9R/G/690PYl3Ma80NPLN6gSu1aZw9+sGjBc
         8dow==
X-Forwarded-Encrypted: i=1; AL+hErFWMaLURwZ3grdXxN/S+C5At52d1LGL3tUE0SdR56iY6lGXtDV+d/wiW9b8o29nk+IUImXK3OysHwEMr1LU1EM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cA/YuWvsUNQtu0IT9sDi3U4pR86lA5ZQlTXn1RgWtRmUJqYlq
	W4OxHOIn/H1l0bLVLcxMrx3nngMF6MMxFRqF19rR941eSINYridC+h2U6P2rxIBfet0=
X-Gm-Gg: AZFdTZeg6A5ygFh+HoMTWHg31+EqkA0M6SlweoLa+cATQbvvOEu7plsqQDWh+r0UepA
	B/scvqqJNoZD5E+TaccAyIjt3LfnwOqa1knQhJLbkiryrbUjohD9O2t0333UeWfBYVBO9nQBjA5
	cVN8uClP2E5JjdcXtPc/h3D/ZbPey9duq9IGLQVisug6zzXYj/L1TyL22M2IV1gew68RSe4b6qb
	awnfUylDhuRS/lRbIhyH8Jjnm13O1RA3bbn+qZK8WWyrjtoE65MHZhEx5SfLzoOMAV04NVki4/m
	vaSC/1SzFiVjjIhrIHMmQxGCWd2d7SDTT8IDpgBeAFnyc6OkVP7I47/eFl0U34UTrm7QUHboBEw
	lnKpZEtqk/jGBU23fwggA+fPHwrKHRkUtrd1zOqWN45a26eXYjpBp8ilGh1K8OIj5S2SqyS9HYD
	WV/vLAUIyA0yywmSz/Ufez87mRxdQxuHAvss7aKjnEzo4JFxb2kG8Z1IwsmqfV0Sf1ysnqpYfT1
	LwfWuVH0htpFK81KejTIDuxiS7WX7saug+5rUegvFcqm7bontM5czCqY5hz0ceOFCr+JW6fIm6l
	6ooqGKa+ODJx/pMJCqsSJ6kwlD1YJnvqTYYg
X-Received: by 2002:a17:90b:2c87:b0:3ab:f2a9:cacd with SMTP id 98e67ed59e1d1-3b41c94df73mr16354240a91.49.1795589678991;
        Tue, 24 Nov 2026 22:54:38 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm26149320a91.8.2026.11.24.22.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:54:38 -0800 (PST)
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
Subject: [PATCH v3 2/2] selftests: tpm2: test that io_uring reads are rejected
Date: Wed, 25 Nov 2026 13:54:29 +0700
Message-ID: <20261125065429.1483868-2-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261125065429.1483868-1-rmustafin@cloudlinux.com>
References: <awXHzblUfp05jZSQ@kernel.org>
 <20261125065429.1483868-1-rmustafin@cloudlinux.com>
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

Test that IORING_OP_READ on /dev/tpm0 and /dev/tpmrm0 fails with -EIO and
that the following read() returns the whole response. The test needs
liburing-ffi (liburing 2.4+) and is skipped without it.

Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---

 tools/testing/selftests/tpm2/Makefile      |  2 +-
 tools/testing/selftests/tpm2/test_uring.sh | 15 +++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 72 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
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
index 000000000000..516985ef20af
--- /dev/null
+++ b/tools/testing/selftests/tpm2/test_uring.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
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
index ffe98b5c8d22..6fe60e00ff06 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -9,6 +9,7 @@ from tpm2 import ProtocolError
 import unittest
 import logging
 import struct
+import errno
 
 class SmokeTest(unittest.TestCase):
     def setUp(self):
@@ -331,3 +332,74 @@ class AsyncTest(unittest.TestCase):
 
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
+def uring_read(fd, size):
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
+        lib.io_uring_prep_read(lib.io_uring_get_sqe(ring), fd, buf, size, 0)
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
+    return res
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
+            res = uring_read(client.tpm.fileno(), 4096)
+            # The rejected read must leave the whole response in place
+            rsp = client.tpm.read(4096)
+        finally:
+            client.close()
+
+        self.assertEqual(res, -errno.EIO)
+        sz, rc = struct.unpack('>II', rsp[2:10])
+        self.assertEqual(sz, len(rsp))
+        self.assertEqual(rc, 0)
+
+    def test_read_tpm(self):
+        self.read_response(0)
+
+    def test_read_tpmrm(self):
+        self.read_response(tpm2.Client.FLAG_SPACE)
-- 
2.52.0

