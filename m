Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625862;
	b=MIDi3NDvuZI8xFGBD/gB54xgJvcuRadyve2jV711hX+Nr4kFkmh32NvgVwP4DtxPDw9t
	 jUVOtLbrjSDhJ4NFTUlqIvVMVfTDj0PYOmqpmcGFyKjVE7hRdA/O//FKIgwWu5z+OJkP9
	 fZBj6R8uhVK5WMK4zY3gMiZkqmxDGYbXPu8myFS27DcMaKKlEHbmM6l79Ga5u7aC3nPiC
	 TR2zoD08IkpjdUiJzmt6SMfat5WU0RkTo5HRWMB/VAk539vqt4iO5D4Jy9vWNus4ppcED
	 yNJdwlKN6BGVWNaveHrB1wMGbOtN4nsPUbfj3UzE2ZJbgoPnBxBJ+Q4mnQVTLZXLK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sbmVapqlaLf7FPEIOBjD6utjm5DhLXMyca/stvkWTEE=;
	b=3mFPuO+YqxTGTvveEi+M6yQd2XeBnfevKH1zHxwA1iBn6UfxZucH6QuVtentc1ZaigZj
	 wti9lnQggGCxkKm3uBnZkWed+VRCAq5RyE5A0PUSeaFJGT+w4xwoN8iQ/5ccta7kh4K8x
	 rOGNnXUzDHgU8+uzYlhdCU1rmvStP52uW4YoaGdTI65pDYkjc+DPsxnXZHXqlI1g/uFLK
	 hmR2yEXXIS8W69S29CjSDFT8XBQZrTGhOIvH4fTxSN8PhJOmFVUHPTKXLV1VSfbWoPlvR
	 ONjTB/uWoaEASaIzR+CMOYbTYw6DtKklyu7CdCvConWLPVHx0E+fp68HWOI6FO55aJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdD+toJr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1F9BA606A332;
	Wed, 25 Nov 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdD+toJr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4AF711F000C0;
	Wed, 25 Nov 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625861;
	bh=sbmVapqlaLf7FPEIOBjD6utjm5DhLXMyca/stvkWTEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WdD+toJrw307eZBwzVlajrIbH75AkOsaifWjxjM+seN2ZuHZp3gUrTKHEknu4R5jI
	 /u5bUgMxPKh6y7O4JQDvQ+kFNCuyE3Fsae6ZH6BLj0QsIncbhAqTnVd762hq13xHU4
	 thz8FsNG9m3bcqFzPEGdpPqrqerKaCe88DYABCewilB1bfhyBIwSBX7Onxx66UM5To
	 PIr2Bxk12KOz0+cZ3hOyp4rJOIFLoUHa2M5zx4Qy496ZFr0m03L6BXqKLKK8EWbdsR
	 PCqNTqyUfEPxWqUP/wi0gC7NM/EHArjMIFtfBiFdERNk60Fe81qb9t1L5BhsRwg8Jc
	 NM5KpooKiQRSg==
Date: Wed, 25 Nov 2026 18:57:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: tpm2: test that io_uring reads are
 rejected
Message-ID: <awcTe-W5J-Q-oK9m@kernel.org>
References: <awXHzblUfp05jZSQ@kernel.org>
 <20261125065429.1483868-1-rmustafin@cloudlinux.com>
 <20261125065429.1483868-2-rmustafin@cloudlinux.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125065429.1483868-2-rmustafin@cloudlinux.com>

On Wed, Nov 25, 2026 at 01:54:29PM +0700, Rustam Mustafin wrote:
> Test that IORING_OP_READ on /dev/tpm0 and /dev/tpmrm0 fails with -EIO and
> that the following read() returns the whole response. The test needs
> liburing-ffi (liburing 2.4+) and is skipped without it.
> 
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> ---
> 
>  tools/testing/selftests/tpm2/Makefile      |  2 +-
>  tools/testing/selftests/tpm2/test_uring.sh | 15 +++++
>  tools/testing/selftests/tpm2/tpm2_tests.py | 72 ++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/tpm2/test_uring.sh
> 
> diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
> index a9bf9459fb25..44630fb980fa 100644
> --- a/tools/testing/selftests/tpm2/Makefile
> +++ b/tools/testing/selftests/tpm2/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  include ../lib.mk
>  
> -TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
> +TEST_PROGS := test_smoke.sh test_space.sh test_async.sh test_uring.sh
>  TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
> diff --git a/tools/testing/selftests/tpm2/test_uring.sh b/tools/testing/selftests/tpm2/test_uring.sh
> new file mode 100755
> index 000000000000..516985ef20af
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/test_uring.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +[ -e /dev/tpm0 ] || exit $ksft_skip
> +[ -e /dev/tpmrm0 ] || exit $ksft_skip
> +read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
> +[ "$tpm_version" = 2 ] || exit $ksft_skip
> +
> +python3 -c 'import sys, tpm2_tests
> +sys.exit(not tpm2_tests.uring_available())' || exit $ksft_skip
> +
> +python3 -m unittest -v tpm2_tests.UringTest 2>&1
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index ffe98b5c8d22..6fe60e00ff06 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -9,6 +9,7 @@ from tpm2 import ProtocolError
>  import unittest
>  import logging
>  import struct
> +import errno
>  
>  class SmokeTest(unittest.TestCase):
>      def setUp(self):
> @@ -331,3 +332,74 @@ class AsyncTest(unittest.TestCase):
>  
>          self.assertEqual(rc, 22)
>          async_client.close()
> +
> +def uring_available():
> +    import ctypes.util
> +
> +    name = ctypes.util.find_library('uring-ffi')
> +    if not name:
> +        return False
> +    lib = ctypes.CDLL(name)
> +    ring = ctypes.create_string_buffer(1024)
> +    if lib.io_uring_queue_init(1, ring, 0) < 0:
> +        return False
> +    lib.io_uring_queue_exit(ring)
> +    return True
> +
> +def uring_read(fd, size):
> +    import ctypes.util
> +
> +    lib = ctypes.CDLL(ctypes.util.find_library('uring-ffi'))
> +    lib.io_uring_get_sqe.restype = ctypes.c_void_p
> +    lib.io_uring_prep_read.argtypes = [ctypes.c_void_p, ctypes.c_int,
> +                                       ctypes.c_void_p, ctypes.c_uint,
> +                                       ctypes.c_uint64]
> +    ring = ctypes.create_string_buffer(1024)
> +    ret = lib.io_uring_queue_init(1, ring, 0)
> +    if ret < 0:
> +        raise OSError(-ret, 'io_uring_queue_init')
> +    try:
> +        buf = ctypes.create_string_buffer(size)
> +        lib.io_uring_prep_read(lib.io_uring_get_sqe(ring), fd, buf, size, 0)
> +        ret = lib.io_uring_submit(ring)
> +        if ret < 0:
> +            raise OSError(-ret, 'io_uring_submit')
> +        cqe = ctypes.c_void_p()
> +        ret = lib.io_uring_wait_cqe(ring, ctypes.byref(cqe))
> +        if ret < 0:
> +            raise OSError(-ret, 'io_uring_wait_cqe')
> +        # cqe->res follows the 64-bit user_data
> +        res = ctypes.c_int.from_address(cqe.value + 8).value
> +    finally:
> +        lib.io_uring_queue_exit(ring)
> +
> +    return res
> +
> +class UringTest(unittest.TestCase):
> +    def read_response(self, flags):
> +        client = tpm2.Client(flags)
> +        fmt = '>HII III'
> +        cmd = struct.pack(fmt,
> +                          tpm2.TPM2_ST_NO_SESSIONS,
> +                          struct.calcsize(fmt),
> +                          tpm2.TPM2_CC_GET_CAPABILITY,
> +                          tpm2.TPM2_CAP_TPM_PROPERTIES,
> +                          tpm2.TPM2_PT_FIXED, 1)
> +        try:
> +            client.tpm.write(cmd)
> +            res = uring_read(client.tpm.fileno(), 4096)
> +            # The rejected read must leave the whole response in place
> +            rsp = client.tpm.read(4096)
> +        finally:
> +            client.close()
> +
> +        self.assertEqual(res, -errno.EIO)
> +        sz, rc = struct.unpack('>II', rsp[2:10])
> +        self.assertEqual(sz, len(rsp))
> +        self.assertEqual(rc, 0)
> +
> +    def test_read_tpm(self):
> +        self.read_response(0)
> +
> +    def test_read_tpmrm(self):
> +        self.read_response(tpm2.Client.FLAG_SPACE)
> -- 
> 2.52.0
> 

Thanks this much better.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
