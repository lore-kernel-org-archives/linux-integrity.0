Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210259;
	b=MkmsVKFQqzSyNPCWTQhMsmgo9LswEg2mmPlzdxbYUItqfwnRA1q98jgvRA/mIFu/QImD
	 xvXnCX1ERQyRt/uu8sn+Ior+z04H4WVJLYx8GjWx4+4A9Xfu3ICedrh+688jhmLAVn//Y
	 pvTOMAyOnRZmpzsu1LlQFC4jZM+pvtJpRkj1OhKz+91ypUsn5BrvUFWLmNo4DuKDRzSop
	 20E8EPf5M8neGGUpNP2hxBvr8WH62ecql9KCDL9JHJx1e1rhmnC0usmB6Xa4pUcekovzL
	 sUDT/L8HzTZsdKXhyG3o/9Nj4C57D/FNil+ekiT7fVG1lJHV5+mNJl0FUcbpDUGlHBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xEZ6Vr/i8fYUxPX4yWZQadVpW4+uFsP7w6mvAv5fdzs=;
	b=1aLsRdscW4HzOtAg40NCJ+eLjWtunvBMFKbhPchlfdnWf093Ly+hpKObjwR6vj9lafIN
	 h52BgxfP7UD41sxFP5ch/nFFkcrpZrjSMjJi1ZJCi+ibuBaho8FvXJCtxQQmUuUMvYCAw
	 e8sZV30oTyQcGm8/PUsDsjiB2+igE2mqTY3aHPJtnXDEBpt0azUTOdD8D/QXIoDBb1qww
	 j2C2d5He2aUFXR1zrPSNA7NaPnG9Wj2unSet/8SLpcdXsCWD80+sBvAH/jT3q+8oH/Uoo
	 0C/wnkdPDJZ07jIWdT1wmLzpgtiGrM8mIEGs1OpmTnMURyiWMYFIg6g4qDUhf4zPxag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWnWkNBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AF1D8606A6B5;
	Fri, 20 Nov 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWnWkNBE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B8A021F000C6;
	Fri, 20 Nov 2026 21:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210259;
	bh=xEZ6Vr/i8fYUxPX4yWZQadVpW4+uFsP7w6mvAv5fdzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWnWkNBEXYqUCr3N2VyzKy+b+dPXlWJWXcIbRYSFcbRsa1f9nOY9ho5L90G3EjPr/
	 H/A+gJ+9eDlmqWqGMFnwi07Lhu8bkh+Uv4vUP0dBGOGwUKLuUHQU8k3ZLFr1VBYB++
	 PbC1zoa30W/MNlTnBWL8/Q4Ra512DbH6sj1iUG0oNSyeKEGZEN5/mOGFnLT6S8X2a3
	 0kIs0LOUsgyTx5/gj+JYUIGjhGZrLkbAXipt1nhUkcvIZ3CBcL8MoHYIkoU0uWW6SF
	 vGdxqMzdnvXEbDrebYIB/qU9ihkW8BPP/UkfjVprAocCtdGiROIriAkWaebpk0JTWj
	 f4obhMSzyDcEg==
Date: Fri, 20 Nov 2026 23:30:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <awC8D-17ShOMXkp2@kernel.org>
References: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>
 <awC70MnZ4eXVQrdS@kernel.org>
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
In-Reply-To: <awC70MnZ4eXVQrdS@kernel.org>

On Fri, Nov 20, 2026 at 11:29:56PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 20, 2026 at 12:47:06PM -0800, Breno Leitao wrote:
> > On Meta's datacenter, given the size, TPMs that stop working write about
> > 54 million lines a day to the kernel log, because nothing in the kernel
> > gives up on them.
> > 
> > Two cases make up nearly all of it.
> > 
> > Some TPMs stop responding. Every command then fails only after the
> > transport timeout, while the hwrng thread and userspace keep sending
> > more.
> > 
> > Other TPMs get reset under the running OS, and answer every command with
> > TPM_RC_INITIALIZE (256) from then on, while the hwrng thread retries
> > every 10 seconds:
> > 
> >   tpm tpm0: A TPM error (256) occurred attempting get random
> > 
> > The goal is to retire TPMs that are not properly working, similarly to
> > what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
> > retire the worker if a wedged call ever returns")
> > 
> > Patch 1 disables the chip once two commands in a row have timed out,
> > instead of keeping it in this desolate state. Patch 2, from Jarkko,
> > disables it once it answers TPM_RC_INITIALIZE to anything but
> > TPM2_Startup.
> > 
> > Disabling the chip makes the failure explicit: every later command
> > fails at once instead of timing out.
> > 
> > A health-check daemon, such as machine checker, can then detect
> > the broken hardware and send the machine to repair.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changes in v4:
> > - Replace the count of timeouts and the tpm.max_missed_responses
> >   parameter with TPM_CHIP_FLAG_MISSED_RESPONSE: one timeout is
> >   tolerated, and a second one in a row disables the TPM (Jarkko)
> > - Say in patch 1 when TPMs stop responding (Jarkko), and drop the
> >   claim that some of them recover
> > - Fix sashiko findings:
> >   - A timeout while a signal is pending no longer counts, since some
> >     drivers return -ETIME when a signal interrupts the wait
> >   - tpm1_do_selftest() clears the flag on the timeouts it expects from
> >     TPM 1.2 chips that block during the self test
> > - Link to v3: https://patch.msgid.link/20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org
> > 
> > Changes in v3:
> > - Rename tpm.max_unanswered to tpm.max_missed_responses and
> >   nr_unanswered to nr_missed_responses, and drop a redundant comment
> >   (Jarkko)
> > - Document tpm.max_missed_responses in kernel-parameters.txt (Jarkko)
> > - Check the limit with a modulo (Jarkko), guarded so that 0 still
> >   means never
> > - Link to v2: https://patch.msgid.link/20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org
> > 
> > Changes in v2:
> > - Disable the TPM after 60 commands in a row time out, instead of after
> >   ten minutes of timeouts, and make the limit the tpm.max_unanswered
> >   boot parameter (Jarkko)
> > - Open-code the check in tpm_transmit() and drop the "timeout" field
> >   names (Jarkko)
> > - Replace the hwrng failure counter with Jarkko's patch, which disables
> >   the TPM on TPM_RC_INITIALIZE
> > - In that patch, move the check ahead of the RETRY/TESTING break, where
> >   it never ran, and skip TPM2_Startup, which a TPM that is already
> >   started fails with TPM_RC_INITIALIZE
> > - Fix sashiko findings:
> >   - Two timeouts ten minutes apart no longer disable an idle TPM
> > - Link to v1: https://patch.msgid.link/20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org
> > 
> > ---
> > Breno Leitao (1):
> >       tpm: Disable a TPM that stops responding
> > 
> > Jarkko Sakkinen (1):
> >       tpm: Disable TPM on TPM_RC_INITIALIZE
> > 
> >  drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++++++++
> >  drivers/char/tpm/tpm1-cmd.c      |  1 +
> >  drivers/char/tpm/tpm2-cmd.c      |  2 ++
> >  include/linux/tpm.h              |  1 +
> >  4 files changed, 24 insertions(+)
> > ---
> > base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> > change-id: 20261110-tpm_unresponsive-a5f71c1db026
> > 
> > Best regards,
> > --  
> > Breno Leitao <leitao@debian.org>
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

It's considered enough. If a tree falls somewhere because of this, we
deal with that separately (and it's just life).

Br, Jarkko
