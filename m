Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376136;
	b=CpM8vGQYBy7osTVcmUiKveAU1YYuhgFPC19M6ntjLaAt7IqpLyLm8CaVyjSfkb5IBfZX
	 UoIHWEtunDVXyoDGEhu1asq3owyFK0ivDI0xrcIV517DCFKIvXrRt6/cb7Dw0S43afKxI
	 I5Pbdd7sTz/5PU2owVR4lIAn293YjzvMf4bug9p/5KEOiwSoyb2DGy23LcyGzIFMgvxM6
	 pAlvaN+aFcXvSrTSBQumIbjtF1NN7CZMmnRruCUBF56YdMqkfJttjQLgTMx+10RQdBAtz
	 RBdI2seOda6FB/9+i9ibMI9AhHINSCCKot/qd5+Qkgrm65shvEfyF0qSJuYrKs0B4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376136;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IID0IQrwer6PQmdAFn1eniEo1UtSssILBqJFeXxXuX8=;
	b=DxzwzMwAQesAV6r1SdICVRgYFy+1w2Fo+nSkAgXKfZ1027hlZSMrAXwgPSCDA4uPWjxR
	 2oQtr/uHs8g5q33xIyAnKPdBgt+VxkM/GsguV1SPsy4ETv8y/qow60TgVifTS2czqHCqj
	 WhfSMbTzno/tZheebIazCuc80ue8nqseT52JFN3hhIXcOJHo7/926ZfD2n3Hfuci5w/MN
	 eOOOYUmQbliLB8mTBlQgoh3ej9Vg763/sqY2DzIvStKjGM2oPZAgtmcHQP/x1TcEaRY7H
	 QSlZ/L93bPLkbbuDyIoGwz7aNx3yaZkTms0cIvKfnrpgsSXoxGw9blHpI7AZQrcu//A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5XQ3b9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0059606A31A;
	Fri, 30 Oct 2026 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5XQ3b9Q
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E65E71F0093A;
	Fri, 30 Oct 2026 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376135;
	bh=IID0IQrwer6PQmdAFn1eniEo1UtSssILBqJFeXxXuX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5XQ3b9Qof6LCbx/LGxFlcpMZ9xsw9w03YWHAQr+RSTlGqIFJCz9Ds6u6VVCgEoyZ
	 8MO4wq50vIbdEFDQG5QqWGuxWTezNOQSs9uJGDLXUP/g3DWdG+NxF8lHhnnQka+R7w
	 W2TVUUEUo/yI9uXy2T1BuaK3SjJcgAOABg+C8bMlpqM0CfDz37MflaDf9QX1aWiAU3
	 n6Ksctl8CoFg2DU5dLoYNXB7VMR5tk/9Fhl2jb+8wWXNpB82Yn9wbTbkZqQ6Ai4sfA
	 SoYkxvVo81pyjr3yTaGQwUYSRUlHTLQFCxbmeRgItLKv97ddqe0ttBF9iUFmJ7Buxk
	 pd6mTS6/9jmcg==
Date: Fri, 30 Oct 2026 18:02:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/7] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <auS_g_hMiDZIjSb5@kernel.org>
References: <20261029181541.99505-1-armenon@redhat.com>
 <auPXDdXZ8L8KOwUW@kernel.org>
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
In-Reply-To: <auPXDdXZ8L8KOwUW@kernel.org>

On Fri, Oct 30, 2026 at 01:30:21AM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 29, 2026 at 11:45:34PM +0530, Arun Menon wrote:
> > The new version of TCG TPM v185 [1] supports sending data/commands in
> > chunks for the CRB (Command Response Buffer) interface. This is in line
> > with the initiative to support PQC algorithms.
> > 
> > This series implements the logic to send and receive larger TPM
> > cmd/rsp between the linux guest and the TPM backend in chunks.
> > Currently, the TPM CRB driver is limited by the physical size of the
> > MMIO window. When userspace attempts to send a payload that exceeds this
> > size, the driver rejects it.
> > 
> > This series introduces chunking support. The driver now checks the CRB
> > interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> > backend, the driver will slice oversized commands into MMIO-sized
> > chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> > with CRB_START_INVOKE. Responses are also read back in a similar chunked
> > manner.
> > 
> > If the backend does not support chunking, the driver retains its legacy
> > behaviour and enforces the standard size limits.
> > 
> > This feature also requires the QEMU to interpret the data in chunks and
> > forward it to the TPM backend and subsequently dispatch the TPM response
> > in chunks back to the linux guest. This is implemented in [2] and
> > already merged into the mainline.
> > 
> > The whole series applied on top of for-next-tpm (including prerequisite)
> > can be found here:
> > https://github.com/armenon-rh/linux/tree/tpm-crb-linux
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
> > [2] https://lore.kernel.org/qemu-devel/20260601215410.517009-1-stefanb@linux.ibm.com/
> > 
> > v5
> > --
> > - Split [PATCH v4 06/06] into 2. The preparation patch separates the
> >   no-chunking send() and recv() from chunking.
> > - Fixed block comments to respect kernel's preferred multi-line style.
> > - Added citations to the TCG TPM and NIST FIPS documentations. Explained
> >   the logic and newly introduced registers in brief in the git commit
> >   message.
> > 
> > v4
> > --
> > - Rebased on master (or for-next-tpm, both point to the same commit).
> > - Resolved one conflict in PATCH v3 05/06, as TPM_BUFSIZE is declared in
> >   include/linux/tpm_command.h.
> > 
> > v3
> > --
> > - Split patch 2, so that the code is cleaner.
> > - Re-order the buffer size adjustment patch.
> > - Rename crb_trigger_tpm to tpm_crb_start.
> > - Add dispatching logic in send and recv functions. Chunking is
> >   separated from no-chunking for clarity.
> > - Increase TPM_BUFSIZE in the common file include/linux/tpm.h following,
> >   [PATCH v9 11/11] tpm-buf: Implement managed allocations
> >   https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> > 
> > v2
> > --
> > - Add size checks before copying memory.
> > - Update TPM_BUFSIZE to 8KB.
> > - Commit messages updated to indicate motivation and logic of the change.
> > 
> > Arun Menon (7):
> >   tpm_crb: Add register definitions of TPM CRB chunking fields
> >   tpm_crb: Split start method into a separate header
> >   tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
> >   tpm: tis_i2c: Use local 4KB buffer to limit memory usage
> >   tpm: Increase TPM_BUFSIZE to 8KB for chunking support
> >   tpm_crb: Factor crb_send()/crb_recv() bodies into helpers
> >   tpm_crb: Implement command and response chunking logic
> > 
> >  drivers/char/tpm/tpm_crb.c     | 226 +++++++++++++++++++++++++++------
> >  drivers/char/tpm/tpm_tis_i2c.c |   6 +-
> >  include/linux/tpm_command.h    |   2 +-
> >  3 files changed, 189 insertions(+), 45 deletions(-)
> > 
> > -- 
> > 2.56.0
> > 
> 
> Applied, thank you.

Could you send +1 version that:

1. Applies to my master.
2. There was one issue that kernel test bot complained.

The issue:

>> drivers/char/tpm/tpm_crb.c:464:34: sparse: sparse: cast removes address space '__iomem' of expression

No worries, just every other day stuff  but would help me if you carry
out these, thanks. And yeah, the first one is not even a real issue,
just unfortuate coincident :-)

I'll apply it as soon as I get it.

Br, Jarkko
