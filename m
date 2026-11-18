Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015868;
	b=Z8sqR1H085NvDh4OA+76moa4i7lLf2a6QrrLmJOQ4y2N8oBg3vcqESYB+lzCe/766T13
	 JczOlXRoNX6NsXnBi/lmbfVGR8Jr3hkXZmAtTYcz0FADYUKkeaafuohVvyprYpZzEGGvJ
	 miiqpM52G4aEPrLADHkferGaewKWygsSXZKS5L0PkZPi/iNEgsZjZ7ovetB3uF0n8xhX/
	 R6BdHO0gnmfdc6ftn+4ZCpKgSTepXgjI6CgaP607UzxYGvFuNIKwffk85pdTO3JW3OJOA
	 S70HYd7NGwRqI/dya/3mWr75G4qj/QWEyEv8gkBtI7EsxWHjYq1HMIHH6cJexy29HOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hxgpa/leqx8PCF9q3j+va2efHdOZAI7uRVqirCJqCzI=;
	b=ZUK+b3GX8ZmWu1UsWAyMJ/w/cdJolrNhsg7zULJPNoFVTbrft8h05QsVglNRAO37Gakg
	 fHch7LyRj6SLy301OcJx7Qws2AjMESA+l/P3PIWzD1YDW8A29DfMWwdrrWVsO55tJh8wp
	 3Mdlrpmgg6QNf8aSEAwws9BIAHCGlPtLNMykVV4f0QtHkklwc5ImM+yMMXjut/4FLmh8s
	 v9uXkeFfSOHX3Q4LhF5KdyUozmv383kOPCqkXOSktVOOrQ+c1Qpc3HEKYeIZ+gzzL+Iwo
	 VjLGO+dX3jSW5ttgFXJNTnARcFv1BcEe3/kfI/UeAFKx/x0fVwmGPvGlYedzXdQ/lWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ow2JFFnF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0F292606A333;
	Wed, 18 Nov 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ow2JFFnF
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 489051F000C6;
	Wed, 18 Nov 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015867;
	bh=hxgpa/leqx8PCF9q3j+va2efHdOZAI7uRVqirCJqCzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ow2JFFnFjrZbpBylLwXiUkX7OIM5KWImrx020bDV1sQiBP75UpZwnaBqhiGHWLw6C
	 Q3AdN2xvhsQX4PbUlv0zGz0BK/MQsGwZ+KInEz4ejv7RVzVgbmj4j/jM7zpKNd2P9f
	 kk5s6Xp4l8kkz0o1z3ET+rjTW1WMaBDB16LzwO9hPOxPnggxGkK62xDLL1Oz+7PZRQ
	 O0uc9Cks9raMH8xmzDm9g8+IXYUPrPx1h7h2kI0yy3R6z/yWf/H7PvLsBHVgxE+mPc
	 JdyfqrJmM8sM7zOsOfP1oSfpqDm/V+9ZYiVuHCA+3ydOGWun7wxgoLBfpYr5ecEtaw
	 NDXRTHFm3gpHA==
Date: Wed, 18 Nov 2026 17:31:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Henri Roosen <henri.roosen@ginzinger.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin.Kepplinger-Novakovic@ginzinger.com
Subject: Re: [PATCH 1/1] tpm_tis_spi: add reset handling for SLM/SLB9670
Message-ID: <av3EuJE7vaj6NzkG@kernel.org>
References: <20261118151029.1259673-1-henri.roosen@ginzinger.com>
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
In-Reply-To: <20261118151029.1259673-1-henri.roosen@ginzinger.com>

On Wed, Nov 18, 2026 at 04:10:29PM +0100, Henri Roosen wrote:
> On an i.MX8MP board, the SLM9670 could not always be successfully
> probed at boot time. The first call to tpm_tis_read32() returned with
> timeout.
> 
> This turned out to be related to no reset-line handling of the chip.
> Although a reset-gpio was provided in the dts, the tpm_tis_spi driver
> didn't use it.
> 
> This patch implements reset-line handling for SLM/SLB9670 when a
> reset-line is provided and uses the timings from the datasheet [1].
> 
> Tested with SLM9670.
> 
> [1] https://www.infineon.com/assets/row/public/documents/30/49/infineon-slb-9670vq2.0-datasheet-en.pdf
> 
> Signed-off-by: Henri Roosen <henri.roosen@ginzinger.com>

Looks good to me! Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
