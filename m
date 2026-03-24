Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29063B3890;
	Tue, 24 Mar 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348890; cv=none; b=qG9+avKsuuMeQbiB3SrydZPHJfXQrXT7DWc00dv4PUaihD8DAyM2Hubf0xvVcsGIG0Q/ZPX4r9DH9pjflVg9LmLwvqvWCRfjCw2SlNw+MwBvyFYUhasUOo8kBl+lUKCQZzxbKLuUfBYUnVswfHm9LZ2Zw/7tYU3Y4rBCGTBVuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348890; c=relaxed/simple;
	bh=Ojr0ORfYdgGMH6PCxt1nTwKh7eCw2IHBKotESx3WoNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spg+LwOzsHhqwBdKqz8K5VYrDNVaNNZ6GkXpVxIb/O54B8/luLA5LUK+oC+40WHVcU/p1EnsL02JLHCP4aLAzJdoPQk0hJvNdgf/FDayD7cEiRvQIP52aldZ1KFy+79t6xOGk3cdoFOSt/UrzfXyk9XMTxf8an3LM/879a2HVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVkjiGnK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVkjiGnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39D3C19424;
	Tue, 24 Mar 2026 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348890;
	bh=Ojr0ORfYdgGMH6PCxt1nTwKh7eCw2IHBKotESx3WoNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVkjiGnKAvbMvxx1KFZV4BvALgjVhEXdy+FvLzKIKz8PWn9n4dSngNNXKUMI+b8P7
	 h/7ltM/I+po0oGULKnNNiqqPHmeRJKW05Ge0+seUPcEdlqi+4CAIqqUr+xwCRHutto
	 uu+RUYQNmiNoEno2uxJcUbYsdTmzxlIoQOS0mu1UDQiOEuZUttseJQuAgNkiZ/wSwt
	 iu0phvuFFCUx2d86IKFS+mPMA34TwpcQUv4n8klKFl1R9oegLs6ZQpj6ZD6jWIwDPz
	 GYIoH7aFSCDBw6taf/uThsxhukEoBjI46ujSWc/s6KKLwQMW62GBFnGen6n1FQ4T+L
	 wSpLrQ4/YUhNg==
Date: Tue, 24 Mar 2026 12:41:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <acJqVjZ7eSxOpSL5@kernel.org>
References: <20260324071803.324774-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324071803.324774-1-armenon@redhat.com>

On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
> The new version of TCG TPM v185 (currently under review [1]) supports
> sending data/commands in chunks for the CRB (Command Response Buffer)
> interface. This is in line with the initiative to support PQC algorithms.
> 
> This series implements the logic to send and receive larger TPM
> cmd/rsp between the linux guest and the TPM backend in chunks.
> Currently, the TPM CRB driver is limited by the physical size of the
> MMIO window. When userspace attempts to send a payload that exceeds this
> size, the driver rejects it.
> 
> This series introduces chunking support. The driver now checks the CRB
> interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> backend, the driver will slice oversized commands into MMIO-sized
> chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> with CRB_START_INVOKE. Responses are also read back in a similar chunked
> manner.
> 
> If the backend does not support chunking, the driver retains its legacy
> behaviour and enforces the standard size limits.
> 
> This feature also requires the QEMU to interpret the data in chunks and
> forward it to the TPM backend and subsequently dispatch the TPM response
> in chunks back to the linux guest. This is implemented in [2]
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> 
> Arun Menon (4):
>   tpm_crb: Add definition of TPM CRB chunking fields
>   tpm_crb: Add new wrapper function to invoke start method
>   tpm_crb: Implement command and response chunking logic
>   tpm: Increase TPM_BUFSIZE to 64kB for chunking support
> 
>  drivers/char/tpm/tpm.h     |   2 +-
>  drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
>  2 files changed, 137 insertions(+), 59 deletions(-)
> 
> -- 
> 2.53.0
> 

When QEMU has the feature available?

BR, Jarkko
