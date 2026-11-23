Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461359;
	b=y4wY0Oeutm8tKv6aq1JjNGSo14kHJfoE+Kun/K8P2/qkD99Z3J378oTFdaY4lq+KUmmG
	 PFYmaoTbvTuTmMHSoXKm56sksDIivGOwuPhfqyg672PeUzb3WMXAjH6ZUuqOwOyVEc39e
	 hyMpeL/dj7YCC0oifJfr+TOaz9T8wUj+noDMDkV4dYFuQYXruOwUHNMjVEJMGoKLu3TZ7
	 fBiJR3FXfRF/j0YkVfkJFTm7jqC6j/0UNyaUMgpIEpkF3cxyKAIWvfjT5FFIEr4vIV/Jv
	 WPGyv/OD7yppzHWPbtrfCXFZYFou99p9G1RDTcptq/6Ot/LkzV7Jm0Da5VDDIWgPEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PvW4g6854DmgXR4PJGdaXsGlS+qMtRehARbQ3GAMNvs=;
	b=kdIIXJdSL3k7gxmJDpuK3INihzn5BWltIGMPHtjHuDkzZ6Tc7EZKZDynZNlycWZBS0fl
	 bEmSiX09tArfM81ugp8LWFb9OY0c6WzqQS7233cuOnksucw7DzM7XCyQ7pmzmeLzEIOeH
	 s2GX8EhYkah9CULd3UxssGgtnyikjQBcFW5pAXaLR8FpCbcwTt+CoeyonfwxdB6YuqzaQ
	 O/EMcJ/k1+Slv67hL1F4BKwvyrX2M64SUjN9g0Sxsllg2LWBZYeb7BEGkSGhb6Ly+Ovy7
	 EFkGVowKYPbFYAgoeZV7z27zl659g0UeCGFupaVIOIyvHe1cM49l/mqpqUO8a6fRqOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUeJKkoO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6DE0A606A32D;
	Mon, 23 Nov 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUeJKkoO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 963B01F00A01;
	Mon, 23 Nov 2026 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461359;
	bh=PvW4g6854DmgXR4PJGdaXsGlS+qMtRehARbQ3GAMNvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZUeJKkoO+n5PbaowjiMJA2PUR8NZVJDGadCFC5uRagLWmV4RSWr/Hr2Kqw9jtpq1F
	 pEgAYgYfudCkygpgwktdVfM7458ZPWwk6v8t3ctxO9ZOCk8ShiueDy+dCwbzGsjLhC
	 ekUQ9O9N/QmlNKsNolEgw5qE1IaQRCrgp+wbBu9IuVEFUo4F5XXfv0YApBu3V+2N/V
	 IIQtLgjCJS8BF0PqZuwwNGy/8GuwAmGmGi3hQ1ViS0FekpAX/IyPvfnAjliEPzc+r9
	 nYAzT+BbyXnd1hn00K8tzO52fIwL1KbobUoGGCVy5z69J+p6ZSgofAWVW15gErqCDC
	 T0M9mM8BrQ63Q==
Date: Mon, 23 Nov 2026 21:15:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awSQ61-xFIsMY6N4@kernel.org>
References: <awBff_fSk9HDh896@kernel.org>
 <20261123173321.2363162-1-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261123173321.2363162-1-rmustafin@cloudlinux.com>

On Tue, Nov 24, 2026 at 12:33:21AM +0700, Rustam Mustafin wrote:
> io_uring passes its own file offset to the TPM character devices, although
> they are opened with nonseekable_open(): IORING_OP_READ copies sqe->off
> into ki_pos without checking FMODE_PREAD, and loop_rw_iter() hands it to
> ->read(). This offset used to index data_buffer and allowed out-of-bounds
> reads. The devices keep a single command and response per open file, which
> does not fit asynchronous requests.
> 
> Add tpm_common_read_iter() and tpm_common_write_iter(), which fail io_uring
> requests with -EIO, and AIO requests, which the new callbacks would
> otherwise enable. A multishot read uses a synchronous kiocb, so also reject
> IOCB_NOWAIT attempts and requests from io-wq workers. read() and write()
> are not affected, as the VFS still calls ->read() and ->write() for them.
> 
> readv() and writev() now reach the new callbacks instead of the VFS loop
> over ->read() and ->write(). A readv() can split a response, for example
> the 10-byte header into one buffer and the body into another, so the
> callbacks keep that loop and call tpm_common_read() and tpm_common_write()
> once per iovec.
> 
> Update the tpm2 io_uring selftest to expect -EIO, and check that the
> rejected request leaves the whole response for the following read().
> 
> Assisted-by: Claude:claude-opus-5-5
> ---
> This applies on top of [PATCH v3] selftests: tpm2: test that io_uring
> reads ignore the file offset:
> https://lore.kernel.org/all/20261123165638.2161305-1-rmustafin@cloudlinux.com/
> 
> Changes in v2:
> - message starts with the use case, rewrapped (Jarkko)
> - drop the CONFIG_IO_URING guards (Jarkko)
> - drop Suggested-by and the Link to the review
> - selftest part on the Python UringTest of the v3 selftest
> 
> preadv2() and pwritev2() at offset -1 now reach the new callbacks, so
> RWF_SYNC, RWF_DSYNC, RWF_APPEND and RWF_NOAPPEND are accepted and ignored
> instead of failing with -EOPNOTSUPP in the VFS loop.
> 
> v1 (RFC): https://lore.kernel.org/all/20261120142116.1630010-1-rmustafin@cloudlinux.com/
> 
>  drivers/char/tpm/tpm-dev-common.c          | 70 ++++++++++++++++++++++
>  drivers/char/tpm/tpm-dev.c                 |  2 +
>  drivers/char/tpm/tpm-dev.h                 |  2 +
>  drivers/char/tpm/tpmrm-dev.c               |  2 +
>  tools/testing/selftests/tpm2/tpm2_tests.py | 11 ++--
>  5 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 553fc6aca94d..5189c1d72058 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -13,8 +13,10 @@
>   * Device file system interface to the TPM
>   */
>  #include <linux/poll.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/uio.h>
>  #include <linux/workqueue.h>
>  #include "tpm.h"
>  #include "tpm-dev.h"
> @@ -253,6 +255,74 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	return ret;
>  }
>  
> +/*
> + * Reject io_uring and AIO. IORING_OP_READ_MULTISHOT requests use a
> + * synchronous kiocb, so also check for NOWAIT attempts and io-wq workers.
> + */
> +static bool tpm_iter_is_async(struct kiocb *iocb)
> +{
> +	return !is_sync_kiocb(iocb) ||
> +	       (iocb->ki_flags & IOCB_NOWAIT) ||
> +	       (current->flags & PF_IO_WORKER);
> +}
> +
> +/* Preserve the VFS fallback's per-iovec read/write semantics. */
> +ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct file *file = iocb->ki_filp;
> +	ssize_t ret = 0;
> +
> +	if (tpm_iter_is_async(iocb) || !user_backed_iter(to))
> +		return -EIO;
> +
> +	while (iov_iter_count(to)) {
> +		size_t len = iter_iov_len(to);
> +		ssize_t nr;
> +
> +		nr = tpm_common_read(file, iter_iov_addr(to),
> +				     len, &iocb->ki_pos);
> +		if (nr < 0) {
> +			if (!ret)
> +				ret = nr;
> +			break;
> +		}
> +		ret += nr;
> +		iov_iter_advance(to, nr);
> +		if (nr != len)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from)

These should be static.

> +{
> +	struct file *file = iocb->ki_filp;
> +	ssize_t ret = 0;
> +
> +	if (tpm_iter_is_async(iocb) || !user_backed_iter(from))
> +		return -EIO;
> +
> +	while (iov_iter_count(from)) {
> +		size_t len = iter_iov_len(from);
> +		ssize_t nr;
> +
> +		nr = tpm_common_write(file, iter_iov_addr(from),
> +				      len, &iocb->ki_pos);
> +		if (nr < 0) {
> +			if (!ret)
> +				ret = nr;
> +			break;
> +		}
> +		ret += nr;
> +		iov_iter_advance(from, nr);
> +		if (nr != len)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  __poll_t tpm_common_poll(struct file *file, poll_table *wait)
>  {
>  	struct file_priv *priv = file->private_data;
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index 74488f0a7b78..9c2f0ad826be 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -62,6 +62,8 @@ const struct file_operations tpm_fops = {
>  	.open = tpm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +	.read_iter = tpm_common_read_iter,
> +	.write_iter = tpm_common_write_iter,
>  	.poll = tpm_common_poll,
>  	.release = tpm_release,
>  };
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index 34efb1ffa491..2f2186e6f094 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -28,6 +28,8 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			size_t size, loff_t *off);
>  ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off);
> +ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to);
> +ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from);
>  __poll_t tpm_common_poll(struct file *file, poll_table *wait);
>  
>  void tpm_common_release(struct file *file, struct file_priv *priv);
> diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
> index 19e8f2779265..0c8c1a1b0b3b 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -49,6 +49,8 @@ const struct file_operations tpmrm_fops = {
>  	.open = tpmrm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +	.read_iter = tpm_common_read_iter,
> +	.write_iter = tpm_common_write_iter,
>  	.poll = tpm_common_poll,
>  	.release = tpmrm_release,
>  };
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index dc4e642450d6..dc1814e0c701 100644
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
> @@ -386,15 +387,15 @@ class UringTest(unittest.TestCase):
>                            tpm2.TPM2_PT_FIXED, 1)
>          try:
>              client.tpm.write(cmd)
> -            # Offset 10 stays inside the response, so an unpatched kernel
> -            # skips the header instead of reading out of bounds
> -            res, rsp = uring_read(client.tpm.fileno(), 4096, 10)
> +            res, _ = uring_read(client.tpm.fileno(), 4096, 10)
> +            # The rejected read must leave the whole response in place
> +            rsp = client.tpm.read(4096)
>          finally:
>              client.close()
>  
> -        self.assertGreaterEqual(res, 10)
> +        self.assertEqual(res, -errno.EIO)
>          sz, rc = struct.unpack('>II', rsp[2:10])
> -        self.assertEqual(sz, res)
> +        self.assertEqual(sz, len(rsp))
>          self.assertEqual(rc, 0)
>  
>      def test_read_tpm(self):
> -- 
> 2.52.0
> 

I think it would be best if you would squash the test part to your
other patch that adds python test. You can then change the license
too while at it.

I.e. add the whole test as part of this patch set.

Br, Jarkko
