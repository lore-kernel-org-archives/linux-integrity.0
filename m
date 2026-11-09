Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238020;
	b=4R0zPjQXBavlGgwPo/uUKi2P9C/Uc7hsaAmIS33Vm26IvzaGVL7xUmafVmPBEJqfYXLo
	 JrTM3X6y4fhzo5+RYA3SgPxNWsooNfjhZQ5SREmYU8RMiH3PRVLeGGMAOa9aFvHJcqWPU
	 JypAjahLiJdkqaFsZo51YOdON7ViC9xB5UMHFN6GpsYmHWTFv4g/dVpBDs4lVP+hKKdYE
	 iK21Wk40WlPi7BCVaqfjo7jrE4UdUECXhKg8ZzbXKt8uKWnT3z3TrKyXkKplXGsBAndXw
	 w1o1MfT70J9JSqKLSVJMtzKZdar+i8rFFglQstCWM/UR5CkbqJpxd8KM5Ttuns66aGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IuGpn/yGGLcRy6ENjs8QYP41tBA/XYEencBbZOq9J4Y=;
	b=l3up3FGi4BVND04yQ2KYCJeH6614K147xT7+7CT4sI9OfOVC0K2lcd8hQ4MpCxM+0L+U
	 p1OdV4TwyxcF65+uc78FLMvpzNo6vcigLH6aZGV8ALa2UU1ohufzwu8vC48soy/tx+qdZ
	 4aLn1HSNjMHmgVZqOVXUgF7EE1cxLNfZyUPp1eVD03vtVSmT+XCug3z4wwHvVO+CpdYdW
	 KFzlQwdAGz8KS3r+UFOiDL+sUEfd9npKAH8EgLD+WvSDKSWZSpYj++XR8rAp9WrrCqnvQ
	 2KTARIunFNUwkEmZw18U5pRvBWBbAHJ71qkaYUARWJMpCCqU0SJ8dFLQKWfDMSdwawQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3K8gFjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 753F4606EE81;
	Mon,  9 Nov 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3K8gFjI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8451F1F008A5;
	Mon,  9 Nov 2026 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238020;
	bh=IuGpn/yGGLcRy6ENjs8QYP41tBA/XYEencBbZOq9J4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3K8gFjIlLN3l3daxDNJnYmgBq7zWZGvXsMBb1sXaq2/uYKYrvxRw8MOpDwaIYAj8
	 RHckbfcgCyi3ErqzPfHO4onD8Ocpe1iOad+fpypMYSkGJMc7E3t96nprKgZpkDKS3/
	 txqfdz255p6FGI3ehLZvyImTpi4cjsUbDM+M4jEFbi5/CzUEilBx0fELrzGqutUUIJ
	 5yalnkp2qnAa8O+R2UMaMA5qIeETc2ot0wrDL1qp3g+OEGnjRljHQVPA3ZJEWq0IM7
	 9uLGxFizjafVN2BMgFpxsWxY/pYV7NtOrzG/hrO81EIBfjL6gydjtMDSWFz55csu5B
	 eN2BEaeMyBUOg==
Date: Mon, 9 Nov 2026 17:26:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: acpi: Fix memory leak at tpm_read_log_acpi() error
 path
Message-ID: <avHmQBA4s7yVwVl7@kernel.org>
References: <20261109082527.541901-1-tiwai@suse.de>
 <avHl-WoBP73QjInD@kernel.org>
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
In-Reply-To: <avHl-WoBP73QjInD@kernel.org>

On Mon, Nov 09, 2026 at 05:25:49PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 09, 2026 at 09:25:24AM +0100, Takashi Iwai wrote:
> > When devm_add_action() returns an error, we do NULL-clear
> > log->bios_event_log unnecessarily before calling tpm_bios_log_free(),
> > and it would lead to a memory leak of the allocated log buffer.
> 
> I don't understand this. "NULL-clear" is gibberish when the actual
> bug is just spurious clear of log->bios_event_log. Also we are not
> doing anything we are not computers.

I.e. in place of "we", use the name of the function and this should
be good. The fix itself is legit.

Br, Jarkko
