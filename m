Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323645;
	b=BUqNdF88DCESxq5woAbzmwTqJFWxRa8EQmQqbI5YVc7LXxDLfDFGWSjXZ2nVqUuhez38
	 BpxFpHTETyIGrlf0xpkIoMt6hcNczgcJkWlmGlH8UWyVMuf4nn3Kkss7I2O6DftKj1scg
	 rp0rFz8eHyLGvStVZ/sGoBpMFYcWqVvuAUS/yk+KsF5TneoDnReth/Io822oafZoGhY85
	 d7uRWJ2TukUUwrCfQj9woZzMIQR0ImcL0kRbdTQFJuk9v1iSdRg+p/rlwUllD+/6M4w1F
	 vOUJtvoNmmO4+c5ApHmmCeqI2ptXmXLv8acoPIP8LkNgo5vp87pcs8wT4o6ks6yp+xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323645;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nZtTE9paxgqbhh5kaB/rcE90qtPhb/tsUpxc9TASPi8=;
	b=UgWDEqv62fAGdohcPU1Y8pFRc+Z7X8y4B3r+f9BDyzNNcgY4zV0DWIslcTy5X5xMTUOT
	 oi4CoisXwbYLuOhkkRSkkmo83cBdBKG5h33GdiOd+y9A2PAweyFzOEinRE1yBw10Cx5oO
	 Ipz+3rY5Ivw4xGXu07LYXonEX4SoTatYOPddInVtyUmAFMCYOuhHkHNEHsgcOdPY+vuQV
	 n+KWpuEjkDcSseLoKcuyZP0l0YPRHjM8ZgJ7A69pkeqAgx/orjZq36QsSM1x/+ikgf5Kd
	 wWHQvr5iKuG+ljZ1dIhtTYKQygEZrQfFuuFR/vevxfMo5A9D2dkuvnwEIU4HnfL2PPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IS6Z/kA0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E9B50606A33B;
	Tue, 10 Nov 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IS6Z/kA0
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 467171F008A4;
	Tue, 10 Nov 2026 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323644;
	bh=nZtTE9paxgqbhh5kaB/rcE90qtPhb/tsUpxc9TASPi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IS6Z/kA0idabiGJvH6bkB1y+TyKRGjJTUkNRKx4WHWiABqQHySl93a6jwIyBiFXRl
	 Bhq7Je3CW+t/yjYbnkIDhZpxJaQT/TfUqSBmtXSOT1DXDHjHHgNIEchjeUXhQ0gbqf
	 Ls9vkeHlgbuPrvmTqKUrXU7458UL+rdqMa4IlLUUkaUb1CUpc9vDC0Q2apKV5SIWYB
	 tRoBEAFAupyfYkL5/EIhI/NNxBHFV0vAjzi6Pr7OJPhFVwl9tAcOq32G7cJWG0HLMK
	 oxd01iy5g28/YPrDmNySki9uG1OgiQaT5iwYpPrHqghJ3NIqXxMDUnK2WQ8uuSvBJL
	 oPWluHk8JZdjQ==
Date: Tue, 10 Nov 2026 17:14:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: add OP-TEE transport core and a discrete TPM
 driver
Message-ID: <avM0uIlZxZIga4dY@kernel.org>
References: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
 <20261110141923.3100770-2-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20261110141923.3100770-2-jorge.ramirez@oss.qualcomm.com>

On Tue, Nov 10, 2026 at 03:19:08PM +0100, Jorge Ramirez-Ortiz wrote:
> Some platforms place a real (discrete) TPM on a bus that only the secure
> world can drive. OP-TEE owns that bus, so the normal world cannot reach
> the chip directly; it instead exposes a mediator trusted application
> that relays TPM2 commands. Add a driver that talks to that application
> and presents the chip as a standard TPM2 character device, so the
> normal-world TPM stack works unchanged.
> 
> This is a separate driver from the firmware-TPM one rather than a reuse
> of it. The TEE transport is the same and is shared through a common
> core, but the device identity differs: the firmware TPM uses its own
> application and a public-login session, whereas a discrete chip needs
> its own application and is restricted to kernel access so that user
> space and other applications cannot submit raw commands to it. Folding
> both into one driver would also break on a platform that has both.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Looks pretty good. Did you check the Sashiko remark?

https://sashiko.dev/#/patchset/20261110141923.3100770-1-jorge.ramirez%40oss.qualcomm.com

Br, Jarkko
