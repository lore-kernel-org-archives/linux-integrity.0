Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186563;
	b=TwOxAcPGrh1DFzITIm2IQiPlzEs2Fzia8ekqbaj10Pm6miNhIJzIiaUQaDZA04saGuMq
	 2MfSuSpQ8uYk6+L9uPggnZE1xpipXcJUnkeMthxa59S72XndhZoFx6k2eNC5f3R77mLCY
	 VvlflddUkr7XQIts7F7me+jBeLEVI7I1YP/WVI14pnx6Oktx9mWXuhW/69Y+6pZoJv/uk
	 TKWM4FtXvmqsPHEFT+tyCIAn9Bnw0+gum/6a0/ScjjIT7lsszZylTAfUH+JXcOg6C/pHj
	 Hl9aOg5CokBjnJc0FgadKG6QjnoVqG4FbXfOzHOHw9h41vnq6moqksZPJTef6XgI7mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y1WFt4mc0pkIwAYAAV4z+HOcPwFajyIGSfcvXE3IL5g=;
	b=rsLHkhLCZG96whLWpIwq5QlQSlhnEIYcnA67Y9Vr8O84bjKwu6qwIkDNJFJzfUqM+254
	 qLpu0k0xHd+8TQ++ELeFH7n0Xkfn3vARDu3jF93L4yaQS53De76qxuPj30tN4SaRN01Cx
	 uyF6GU5j76VbDFQEuQjrkPN606HS80kXQJzscDDT6j6dmgS4hwOxZI+Y16Kq8l4ZwmpMI
	 Tz5ERrkDmlJ+BncxHjN7stzH+Df0INjoSmUH2Y+lhZYobGBFdgV58HaN76vgQbCm6cnww
	 4c1u7iksuXn3O5hLVzpHbOxcuxZnUn48H895hPmhs9YNuLBBAdDAi/Kx3s6LharQJzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmlOHE3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 19A49606A325;
	Fri, 20 Nov 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmlOHE3M
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 347721F000C6;
	Fri, 20 Nov 2026 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186562;
	bh=Y1WFt4mc0pkIwAYAAV4z+HOcPwFajyIGSfcvXE3IL5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmlOHE3M18kjqxxy4WeeFLbttHAPPdDo0dV69i4givT0uUpj/ylhZD7OPQFeGkPHZ
	 nxlketRBB45uONx1fRrDnV31m7pB7ydmkBjy9OvBypZpPK2ZpAQqhbzsO0qZ51VGb1
	 2rKqj6NfeluW5IaAir2DZzS5FP3PN28FuKCBCr3rYu8/KVqIK5EOeU370f1fPhxAOO
	 ds/WQTxfOhQSU1jUWU4E7xAYBexqrOwxjdsAKZh0LECz2QPyJlaMpcyaAR7nZtU4xw
	 ZhGeA1uuSPAQ/WZrA4nIMIjRHetacMpGIFoQk2LTKcr4P0JLEo30olIVJsx7q9zjWe
	 G4HKYMTEZUelA==
Date: Fri, 20 Nov 2026 16:55:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awBff_fSk9HDh896@kernel.org>
References: <20261120142116.1630010-1-rmustafin@cloudlinux.com>
 <20261120142116.1630010-2-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261120142116.1630010-2-rmustafin@cloudlinux.com>

On Fri, Nov 20, 2026 at 09:21:16PM +0700, Rustam Mustafin wrote:
> Add tpm_common_read_iter() and tpm_common_write_iter(), which fail
> io_uring and AIO requests with -EIO. read() and write() are not
> affected, as the VFS still calls ->read() and ->write() for them.
> readv() and writev() now reach the new callbacks instead of the VFS
> loop over ->read() and ->write(), so the callbacks keep that loop and
> call tpm_common_read() and tpm_common_write() once per iovec.
> 
> Update the tpm_uring kselftest to expect -EIO, and check that the
> rejected request leaves the whole response for the following read().

Align these 75 chars. You had use case for this so prepend it before
any of this. So that we just know along the lines where this is
needed.

> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>

I think you did most of the hard work so I don't think this is needed.

> Link: https://lore.kernel.org/r/av23L5HBpy2gbm3m@kernel.org
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c        | 72 ++++++++++++++++++++++++
>  drivers/char/tpm/tpm-dev.c               |  4 ++
>  drivers/char/tpm/tpm-dev.h               |  4 ++
>  drivers/char/tpm/tpmrm-dev.c             |  4 ++
>  tools/testing/selftests/tpm2/tpm_uring.c | 14 ++---
>  5 files changed, 91 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 553fc6aca94d..e40a251315f3 100644
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
> @@ -253,6 +255,76 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_IO_URING
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
> +#endif /* CONFIG_IO_URING */

Does this compile if you leave out these flags?

Probably would not add them unless it breaks compilation.

> +
>  __poll_t tpm_common_poll(struct file *file, poll_table *wait)
>  {
>  	struct file_priv *priv = file->private_data;
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index 74488f0a7b78..56751be46d90 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -62,6 +62,10 @@ const struct file_operations tpm_fops = {
>  	.open = tpm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +#ifdef CONFIG_IO_URING
> +	.read_iter = tpm_common_read_iter,
> +	.write_iter = tpm_common_write_iter,
> +#endif
>  	.poll = tpm_common_poll,
>  	.release = tpm_release,
>  };
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index 34efb1ffa491..22ea88156833 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -28,6 +28,10 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			size_t size, loff_t *off);
>  ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off);
> +#ifdef CONFIG_IO_URING
> +ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to);
> +ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from);
> +#endif
>  __poll_t tpm_common_poll(struct file *file, poll_table *wait);
>  
>  void tpm_common_release(struct file *file, struct file_priv *priv);
> diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
> index 19e8f2779265..95788c6bdd4c 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -49,6 +49,10 @@ const struct file_operations tpmrm_fops = {
>  	.open = tpmrm_open,
>  	.read = tpm_common_read,
>  	.write = tpm_common_write,
> +#ifdef CONFIG_IO_URING
> +	.read_iter = tpm_common_read_iter,
> +	.write_iter = tpm_common_write_iter,
> +#endif
>  	.poll = tpm_common_poll,
>  	.release = tpmrm_release,
>  };
> diff --git a/tools/testing/selftests/tpm2/tpm_uring.c b/tools/testing/selftests/tpm2/tpm_uring.c
> index 9caa3cba5bf0..37b41c7d295b 100644
> --- a/tools/testing/selftests/tpm2/tpm_uring.c
> +++ b/tools/testing/selftests/tpm2/tpm_uring.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

GPL-2.0-only

I cannot recall why other files are not (not critical tho).

>  /*
> - * An io_uring read chooses its own file offset. The TPM character devices
> - * must ignore it and return the response from its start.
> + * The TPM character devices must reject io_uring reads.
>   */
>  
>  #include <endian.h>
> @@ -39,7 +38,7 @@ static void test_read(struct io_uring *ring, const char *path)
>  	struct pollfd pfd = { .events = POLLIN };
>  	struct io_uring_sqe *sqe;
>  	struct io_uring_cqe *cqe;
> -	int fd, ret, res;
> +	int fd, ret, res, n;
>  
>  	fd = open(path, O_RDWR);
>  	if (fd < 0) {
> @@ -86,10 +85,11 @@ static void test_read(struct io_uring *ring, const char *path)
>  	res = cqe->res;
>  	io_uring_cqe_seen(ring);
>  
> -	/* the offset is ignored: the whole response, from its start */
> -	ksft_test_result(res >= (int)sizeof(*hdr) &&
> -			 be32toh(hdr->size) == res && !hdr->return_code,
> -			 "%s: io_uring read %d\n", path, res);
> +	/* the rejected read must leave the whole response in place */
> +	n = read(fd, buf, BUF_LEN);
> +	ksft_test_result(res == -EIO && n >= (int)sizeof(*hdr) &&
> +			 be32toh(hdr->size) == n && !hdr->return_code,
> +			 "%s: io_uring read %d, read() %d\n", path, res, n);
>  out:
>  	close(fd);
>  }
> -- 
> 2.52.0
> 

Br, Jarkko
