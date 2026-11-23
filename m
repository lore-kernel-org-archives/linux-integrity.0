Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460752;
	b=TokO1glceRIDzqOKOK7A57YQs1FfobHcpNPP0NqIEBFYmR0EG13xvh6+tFh3XHjysI53
	 q+X/3aZKTTAQXZgM17r5CcuJkm4op+rZ+WzUZ/XK551pzg3D06p3zAs3St+6H0B3WK5NH
	 SydGTF996tBEcaDTQlK2DPRPE3VttVRkdvK3m/nV33me7v/z+K9sBo/DlixUCZgpEkiYV
	 7Xit/S9ePm4yiN7IxdJHnKhq/pB+tBUo3mU3A+HGSol8CgetFrh5VjqvzO6OJ9TIOBd8K
	 oOpV99ZSERgmltdU2Sk6T2OsSMzwHj4QIupLuTbEffu57tZPVcZDTCbgJ87gjFxvlfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460752;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TeHWyBrOcFP+atvl9yPuIzA/2fWSUI+VCyFKYuru20A=;
	b=Fv7w1sFUAUqr2asksnN690q4uFgi2R6F7xFNdXtVwNA9ESlik5q4GfHDbqY0hsgaiuW3
	 N8NnkZ32wwiop7oxSR852HoappaynmkeJKwmIg7WDfUe9GbwdfsRq29e2ieXZkV38WDtr
	 CN+ZBR/NL7Y0NX3IrRq2nVI/H1SVftrC+urfAk6YZbeoHsHvbUoMBAMtKP3aHEp5fYnBY
	 TRpre5TPVMRt2oWZxxfca5j+Z4swmRrd2EegEdwvRFg/imFm05Q1Tsw0uT/q37ph6u1yP
	 ZFBzzK+7SIIVxfYS+s6FT8ux21s51J1/bdOLrtqVKVwtCdWQfERtEyVydWvYz0n+bHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaRJ2OfV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 00D74606A68B;
	Mon, 23 Nov 2026 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaRJ2OfV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3BBE1F00AD3;
	Mon, 23 Nov 2026 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460751;
	bh=TeHWyBrOcFP+atvl9yPuIzA/2fWSUI+VCyFKYuru20A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jaRJ2OfVEuvqdG975r9fAobz+sNSNcjw7JAuozjNAQrqTsrEhzqP14WwyLd7J+Vfw
	 D7j5JTqVpBtoJuDJdHw1+qHXkuT5Bx3mKGHJisL5u0aXr8xsRAO+RqUbcfq2JvY2Eh
	 9pa3vszMU+UpZ3gjDE2jXwRC6R3l2nNjeegSfFG+AR2AHeC04BnsiGgo+ozeWIhlEj
	 qc9BEvH6WoY5pPxoxgpEvApr9DL9BOEEbG+eXGHGvdgPekhqjfX52I+LszVUiRyiD6
	 lRdlD+zRtqC1MPkd6cUz/TavqU4jE0xIvbIdw9hrG4xhFq24LvCYAfN8X/9tACtyNe
	 fy1veLnPZMC2A==
Date: Mon, 23 Nov 2026 21:05:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: tpm2: test that io_uring reads ignore the
 file offset
Message-ID: <awSOi_89tLwQhfk9@kernel.org>
References: <awGr_tB3QXwnW1G2@kernel.org>
 <20261123165638.2161305-1-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261123165638.2161305-1-rmustafin@cloudlinux.com>

On Mon, Nov 23, 2026 at 11:56:38PM +0700, Rustam Mustafin wrote:
> Test that an IORING_OP_READ request on /dev/tpm0 and /dev/tpmrm0
> returns the whole pending response from its start, although sqe->off
> points past the response header. The offset stays inside
> priv->data_buffer, so an unpatched kernel fails the test on the
> returned header without an out-of-bounds access.
> 
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> ---
> Changes in v3:
> - rewrite in Python as tpm2_tests.UringTest, run by test_uring.sh
>   (Jarkko)
> - io_uring through liburing-ffi (liburing 2.4+)
> - test_uring.sh skips when liburing-ffi is missing or
>   io_uring_queue_init() fails
> 
>  tools/testing/selftests/tpm2/Makefile      |  2 +-
>  tools/testing/selftests/tpm2/test_uring.sh | 15 +++++
>  tools/testing/selftests/tpm2/tpm2_tests.py | 71 ++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 1 deletion(-)
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
> index 000000000000..bb6e2e10162e
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/test_uring.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
> index ffe98b5c8d22..dc4e642450d6 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -331,3 +331,74 @@ class AsyncTest(unittest.TestCase):
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
> +def uring_read(fd, size, off):
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
> +        lib.io_uring_prep_read(lib.io_uring_get_sqe(ring), fd, buf, size, off)
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
> +    return res, buf.raw
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
> +            # Offset 10 stays inside the response, so an unpatched kernel
> +            # skips the header instead of reading out of bounds
> +            res, rsp = uring_read(client.tpm.fileno(), 4096, 10)
> +        finally:
> +            client.close()
> +
> +        self.assertGreaterEqual(res, 10)
> +        sz, rc = struct.unpack('>II', rsp[2:10])
> +        self.assertEqual(sz, res)
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

Thank you.

It's just best not to spread tests to multiple languages without
any special reasons, that's all.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
