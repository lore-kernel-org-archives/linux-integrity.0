Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271681;
	b=Gxql8QISNulGVdRBXnvR+5sYFDpKpRTTjwMwzHQWlQMTRmzUQEjSt31/z48PQNiVWygV
	 nnaeK/YRXevIMCsNwRgSMON7aHajpF10MwCCQjK8M+sqLwOwFuR/OnUcv8bbgl4CH7hJd
	 8CmVBW6pzJsP+NxE+e/WnbVBdaL0tPRzqxkgiG+Uy+aSJUfEO8fBN0cQx3/Kx3+ovOrbB
	 OCUw1Nn/HBKLAUGMwnY2s6eswWIlAl8l8jbqY2/UFqDsHaf/vzyLmPCfxE/RZ3Jdxcmk1
	 xYdJ5cwqVW5RN8iYV/2POguSqh2iwtaOw6VyEdgCMo6YQBV74mza4fymUKac5xtGXpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271681;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gk4bcxgmxdSY9ejOoEcFMk08C5Rxt5ij1zkHy2OJ554=;
	b=ROApoz4Mpc5USipwTfC7UKt8FUoZitY1MLR/+iqu70jjuazZkvEBtlpVlUB1rrNwIX6S
	 orbZDrAVxgBA/K+WrMrWp/OYwOxIY0dnK4plQ8LTRiwfsoS971mSFv1AcM+g6f/Tq9L93
	 uNEtf0ndEFM+2vV1Gk150Hy7OsVVqzDCvYHN5E6dxs2sFkkrWRz5GArp4D/StGryI093z
	 /ZinzCNGuh2AeCmIaTvfksSY+r4eHl60U1FGRnOlGhpHkImdYsL1rtCSCN1fN7La8KgKM
	 aAeWiN1Gq8FiBjqPhzGubxFAw3LyaPgK9gOShilNwSVpJz52X5T+2A9jWmqMislJpOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch8U8Ex8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AEED2606A33A;
	Sat, 21 Nov 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch8U8Ex8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E7ACD1F000C0;
	Sat, 21 Nov 2026 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795271681;
	bh=gk4bcxgmxdSY9ejOoEcFMk08C5Rxt5ij1zkHy2OJ554=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ch8U8Ex8Z3d7tTAsAv0hNDRYwYR3Wgsk34slfCp7n6Q4N3RVOCsPrEwUd2KnDZ5c9
	 KIcP9l4L6X5arUKEOpmoidwWDkAwVZvgbLgqc9KfNn5N5LL8LreL8MONZPnQ9t1mFG
	 QUQhFF9l48V6Nf47cI+wydTvoH6yGcmScrBwQoe7RhZfsSva5QkIHJmrnWxwJY+kC+
	 zF0GAOxr6SJVdUKLqBausPFj8g+JkB5hER1TrqY0G1h7Vb/wO0nC0iYc8Vxs49aleR
	 FEyeZVhXxKedfgaWQYMZLNA8kn87jNvEwjLQfT4iPUxz/X1eaJ1/BA5+vUhUY1hnRn
	 QVc/K5iUvI2Bw==
Date: Sat, 21 Nov 2026 16:34:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: tpm2: test that io_uring reads ignore
 the file offset
Message-ID: <awGr_tB3QXwnW1G2@kernel.org>
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
 <20261120121614.978396-3-rmustafin@cloudlinux.com>
 <awGq_L-ZjRhM0rMK@kernel.org>
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
In-Reply-To: <awGq_L-ZjRhM0rMK@kernel.org>

On Sat, Nov 21, 2026 at 04:30:25PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 20, 2026 at 07:16:14PM +0700, Rustam Mustafin wrote:
> > Test that an IORING_OP_READ request on /dev/tpm0 and /dev/tpmrm0
> > returns the whole pending response from its start, although sqe->off
> > points past the response header. The offset stays inside
> > priv->data_buffer, so an unpatched kernel fails the test on the
> > returned header without an out-of-bounds access.
> > 
> > Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> > ---
> >  tools/testing/selftests/tpm2/.gitignore  |   1 +
> >  tools/testing/selftests/tpm2/Makefile    |   4 +
> >  tools/testing/selftests/tpm2/tpm_uring.c | 131 +++++++++++++++++++++++
> >  3 files changed, 136 insertions(+)
> >  create mode 100644 tools/testing/selftests/tpm2/tpm_uring.c
> > 
> > diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/selftests/tpm2/.gitignore
> > index 6d6165c5e35d..d2324bd0eca2 100644
> > --- a/tools/testing/selftests/tpm2/.gitignore
> > +++ b/tools/testing/selftests/tpm2/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  AsyncTest.log
> >  SpaceTest.log
> > +tpm_uring
> > diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
> > index a9bf9459fb25..67f346f4cdef 100644
> > --- a/tools/testing/selftests/tpm2/Makefile
> > +++ b/tools/testing/selftests/tpm2/Makefile
> > @@ -1,4 +1,8 @@
> >  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +CFLAGS += $(KHDR_INCLUDES) -idirafter ../../../include -Wall
> > +
> > +TEST_GEN_PROGS := tpm_uring
> > +
> >  include ../lib.mk
> >  
> >  TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
> > diff --git a/tools/testing/selftests/tpm2/tpm_uring.c b/tools/testing/selftests/tpm2/tpm_uring.c
> > new file mode 100644
> > index 000000000000..9caa3cba5bf0
> > --- /dev/null
> > +++ b/tools/testing/selftests/tpm2/tpm_uring.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +/*
> > + * An io_uring read chooses its own file offset. The TPM character devices
> > + * must ignore it and return the response from its start.
> > + */
> > +
> > +#include <endian.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <poll.h>
> > +#include <signal.h>
> > +#include <io_uring/mini_liburing.h>
> > +#include "../kselftest.h"
> > +
> > +#define RING_ENTRIES	4
> > +#define BUF_LEN		4096
> > +#define POLL_TIMEOUT_MS	10000
> > +#define TPM_VERSION_FILE	"/sys/class/tpm/tpm0/tpm_version_major"
> > +struct tpm_header {
> > +	uint16_t tag;
> > +	uint32_t size;
> > +	uint32_t return_code;
> > +} __attribute__((packed));
> > +
> > +/* TPM2_GetCapability(TPM_CAP_TPM_PROPERTIES, TPM_PT_FIXED, 1) */
> > +static const unsigned char cmd[] = {
> > +	0x80, 0x01,		/* TPM_ST_NO_SESSIONS */
> > +	0x00, 0x00, 0x00, 0x16,	/* command size */
> > +	0x00, 0x00, 0x01, 0x7a,	/* TPM_CC_GetCapability */
> > +	0x00, 0x00, 0x00, 0x06,	/* TPM_CAP_TPM_PROPERTIES */
> > +	0x00, 0x00, 0x01, 0x00,	/* TPM_PT_FIXED */
> > +	0x00, 0x00, 0x00, 0x01,	/* property count */
> > +};
> > +
> > +static void test_read(struct io_uring *ring, const char *path)
> > +{
> > +	static char buf[BUF_LEN];
> > +	const struct tpm_header *hdr = (const void *)buf;
> > +	struct pollfd pfd = { .events = POLLIN };
> > +	struct io_uring_sqe *sqe;
> > +	struct io_uring_cqe *cqe;
> > +	int fd, ret, res;
> > +
> > +	fd = open(path, O_RDWR);
> > +	if (fd < 0) {
> > +		if (errno == ENOENT)
> > +			ksft_test_result_skip("%s: not present\n", path);
> > +		else
> > +			ksft_test_result_fail("%s: open: %s\n", path,
> > +					      strerror(errno));
> > +		return;
> > +	}
> > +
> > +	if (write(fd, cmd, sizeof(cmd)) != sizeof(cmd)) {
> > +		ksft_test_result_fail("%s: write: %s\n", path, strerror(errno));
> > +		goto out;
> > +	}
> > +
> > +	pfd.fd = fd;
> > +	if (poll(&pfd, 1, POLL_TIMEOUT_MS) != 1) {
> > +		ksft_test_result_fail("%s: no response to the command\n", path);
> > +		goto out;
> > +	}
> > +
> > +	sqe = io_uring_get_sqe(ring);
> > +	memset(sqe, 0, sizeof(*sqe));
> > +	sqe->opcode = IORING_OP_READ;
> > +	sqe->fd = fd;
> > +	/*
> > +	 * Inside the response buffer: an unpatched kernel returns the response
> > +	 * without its header instead of reading out of bounds
> > +	 */
> > +	sqe->off = sizeof(*hdr);
> > +	sqe->addr = (unsigned long)buf;
> > +	sqe->len = BUF_LEN;
> > +	ret = io_uring_submit(ring);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("%s: io_uring_submit: %d\n", path, ret);
> > +		goto out;
> > +	}
> > +	ret = io_uring_wait_cqe(ring, &cqe);
> > +	if (ret) {
> > +		ksft_test_result_fail("%s: io_uring_wait_cqe: %d\n", path, ret);
> > +		goto out;
> > +	}
> > +	res = cqe->res;
> > +	io_uring_cqe_seen(ring);
> > +
> > +	/* the offset is ignored: the whole response, from its start */
> > +	ksft_test_result(res >= (int)sizeof(*hdr) &&
> > +			 be32toh(hdr->size) == res && !hdr->return_code,
> > +			 "%s: io_uring read %d\n", path, res);
> > +out:
> > +	close(fd);
> > +}
> > +
> > +/* the command is TPM2 only; test_smoke.sh skips the same way */
> > +static int tpm_version_major(void)
> > +{
> > +	FILE *f = fopen(TPM_VERSION_FILE, "r");
> > +	int major = 0;
> > +
> > +	if (f) {
> > +		if (fscanf(f, "%d", &major) != 1)
> > +			major = 0;
> > +		fclose(f);
> > +	}
> > +	return major;
> > +}
> > +
> > +int main(void)
> > +{
> > +	struct io_uring ring;
> > +
> > +	ksft_print_header();
> > +	if (tpm_version_major() != 2)
> > +		ksft_exit_skip("no TPM 2.0 device\n");
> > +	if (io_uring_queue_init(RING_ENTRIES, &ring, 0)) {
> > +		/* not built in, or disabled by kernel.io_uring_disabled */
> > +		if (errno == ENOSYS || errno == EPERM)
> > +			ksft_exit_skip("io_uring_setup: %s\n", strerror(errno));
> > +		ksft_exit_fail_msg("io_uring_queue_init: %s\n", strerror(errno));
> > +	}
> > +	ksft_set_plan(2);
> > +
> > +	test_read(&ring, "/dev/tpm0");
> > +	test_read(&ring, "/dev/tpmrm0");
> > +
> > +	io_uring_queue_exit(&ring);
> > +	ksft_finished();
> > +}
> > -- 
> > 2.52.0
> > 
> 
> Thanks. I applied them.
> 
> Sorry for few igorant responses I was doing too many things.
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Br, Jarkko

Second thoughts on 2/2 but I'll apply 1/2.

checkpatch.pl --strict:

WARNING: Prefer __packed over __attribute__((packed))
#74: FILE: tools/testing/selftests/tpm2/tpm_uring.c:23:
+} __attribute__((packed));

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#171: FILE: tools/testing/selftests/tpm2/tpm_uring.c:120:
+               if (errno == ENOSYS || errno == EPERM)

Also, this cannot be in C.

Br, Jarkko
