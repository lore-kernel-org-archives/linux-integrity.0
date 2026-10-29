Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316625;
	b=BfnyY/diBgU2a2SpMq4rkFoNVL0zwumKORYyrSBIDE+/m43K1zEr6jULkbYWup1ic2+s
	 iVrj+7EmrzozwcTyOIf9YEHCw8sZ323TBLINhvlwxogA6tfnrTnJ0I62xTjaHCYzABP+k
	 1hdtquN8ReYQkxLEMg+Jcyzg7d3OSmCziwP2MNK90VOyHKs6Zqn30/qYgEKXGSflLKR2s
	 pMChuS7oT6559pYSL1KlbgyKfIcrWiyFaZ+V0x01RY5usZYO4m9KX7I2397jEP569S+a9
	 RqXa0WkirD6shG1Vse08pNKL2+gsMsOxOdRnvWWuLgvbgFcsdzOPiYz3C+l+nqADmwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aVdetZY9Do9isKUPb6qz8CWfVwLqoRc2UCiZFRh14fY=;
	b=5qYauMMfuCkbEZDeefhJJo44U7iH2gdaUhQ9VPtrIKP40WKz5blxOzWUbMZNDxRzJvRU
	 Jm9wYCYl9EttdT/BqSUIJky3PG4sWPvqbJIQ3RLHJyLIuQhT5U3gjA2TepswmaYy2bWfy
	 c9f+aJSLhKOHa6A9UqhA+gmwQvpri3vpSsTTNclNEcTYRchGCo9dCqWwcOKAseBZThk1H
	 WgKJoH/h1gnv8A0EwjOHLKRS3dq2EvUe+GXo42kzwyye7IGeuBMVhiZrkjdtgMoqrHlOM
	 XYfbSSu3GIqB6qRWfkYnPvyvcRDu+xSzcB8K25cFiy0mHiHBXAGfGM/ICOcVq36egHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjB+DBzz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C014F60A2610;
	Thu, 29 Oct 2026 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjB+DBzz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DD9101F000C1;
	Thu, 29 Oct 2026 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316624;
	bh=aVdetZY9Do9isKUPb6qz8CWfVwLqoRc2UCiZFRh14fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DjB+DBzz3w8/CzjvBWnS1I46ATi/RbuQRPJU3RrRrx5/uHro5rHl8Ej9oL/ZcyosV
	 9+rt4p9LbXTuAMGF6vGsFUGYlEqdsSnPHLspJf22yDR1zjH5YPo74jqnSMXFR2e02U
	 5ZZ7z0foCNHY+myCoLEeiO/49LWsScEtO4lpO/Om5tESO4kYhMrMr9khL8rPC4P1/F
	 MjT0uJDSQaieeyni95jp8WGlohonLvPoMTOycF2vaUsOVeza8AgXRR010gr96+e5rI
	 lfZYa/7bwzBLwV9UlviGUAnk1vrNUktMO8AiSDCPlVwkbs9SLP/YXSUjOjQ/ot6Ku6
	 rkvf1gNvUttTA==
Date: Fri, 30 Oct 2026 01:30:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/7] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <auPXDdXZ8L8KOwUW@kernel.org>
References: <20261029181541.99505-1-armenon@redhat.com>
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
In-Reply-To: <20261029181541.99505-1-armenon@redhat.com>

On Thu, Oct 29, 2026 at 11:45:34PM +0530, Arun Menon wrote:
> The new version of TCG TPM v185 [1] supports sending data/commands in
> chunks for the CRB (Command Response Buffer) interface. This is in line
> with the initiative to support PQC algorithms.
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
> in chunks back to the linux guest. This is implemented in [2] and
> already merged into the mainline.
> 
> The whole series applied on top of for-next-tpm (including prerequisite)
> can be found here:
> https://github.com/armenon-rh/linux/tree/tpm-crb-linux
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
> [2] https://lore.kernel.org/qemu-devel/20260601215410.517009-1-stefanb@linux.ibm.com/
> 
> v5
> --
> - Split [PATCH v4 06/06] into 2. The preparation patch separates the
>   no-chunking send() and recv() from chunking.
> - Fixed block comments to respect kernel's preferred multi-line style.
> - Added citations to the TCG TPM and NIST FIPS documentations. Explained
>   the logic and newly introduced registers in brief in the git commit
>   message.
> 
> v4
> --
> - Rebased on master (or for-next-tpm, both point to the same commit).
> - Resolved one conflict in PATCH v3 05/06, as TPM_BUFSIZE is declared in
>   include/linux/tpm_command.h.
> 
> v3
> --
> - Split patch 2, so that the code is cleaner.
> - Re-order the buffer size adjustment patch.
> - Rename crb_trigger_tpm to tpm_crb_start.
> - Add dispatching logic in send and recv functions. Chunking is
>   separated from no-chunking for clarity.
> - Increase TPM_BUFSIZE in the common file include/linux/tpm.h following,
>   [PATCH v9 11/11] tpm-buf: Implement managed allocations
>   https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> 
> v2
> --
> - Add size checks before copying memory.
> - Update TPM_BUFSIZE to 8KB.
> - Commit messages updated to indicate motivation and logic of the change.
> 
> Arun Menon (7):
>   tpm_crb: Add register definitions of TPM CRB chunking fields
>   tpm_crb: Split start method into a separate header
>   tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
>   tpm: tis_i2c: Use local 4KB buffer to limit memory usage
>   tpm: Increase TPM_BUFSIZE to 8KB for chunking support
>   tpm_crb: Factor crb_send()/crb_recv() bodies into helpers
>   tpm_crb: Implement command and response chunking logic
> 
>  drivers/char/tpm/tpm_crb.c     | 226 +++++++++++++++++++++++++++------
>  drivers/char/tpm/tpm_tis_i2c.c |   6 +-
>  include/linux/tpm_command.h    |   2 +-
>  3 files changed, 189 insertions(+), 45 deletions(-)
> 
> -- 
> 2.56.0
> 

Applied, thank you.

Br, Jarkko
