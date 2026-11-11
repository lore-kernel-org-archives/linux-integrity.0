Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437662;
	b=q/10Ersugzn0uKDjWyD8EcseGpSroZkEBKI/zZvZbkw3tBFSmLJUZmyAYt8IttWrH3vp
	 1kZ3RnqHsHH/BsBrcx/IID2tp8FK3UNlZrOPvuCkuKgKw0ax8dpe6idMol20yYhelQ5Xq
	 8QZK3mRclGDxPPHsFpeZUMItaHzSKFakxnMrvFOUK1/34BmqM9tVbZ92B3sXhvAt4mZ2X
	 Az5gAJ/fhgkvhxrH04tqgg3XUKHuN6vYNpQ79Qh4mjfYXVPmsft2cG8mz+1ChNkrWYq7S
	 lhGnxby8qznR7Scx8WtzJfngVXLeg/+fvxafkN4Lx0hPeOOfRE5RdyG3o8cD2vXNNrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WtHMg/x0CcOfSTtKPR5su74Wna+qWRxbs0EhmQH9YFE=;
	b=weLv4wl8BOcU/y5nHrnE7XxoJFOP2G3VeLk0iCiNZ7RB1p3J8sk/AQevUASferDXEqY7
	 OK2uHAZKRCjgjcaQ1XAmiYARheJXEEzg2z4mRZTIYFDbBJQ2bjZa4e68CPyv4K41EY3Oe
	 Vu9n9w3EsJmQYCP2dkid2C76cyL6VJGl9RuI1g1HxxRY5lL3I1Ig0HeDGl9VaWL+2jYye
	 e8J822XOLedFEtElihMzaUAew5pvGAFPzVu3hvy5bjZ2knU1rbJDrsxw+7UXRMFagB44E
	 RgLFlSuOJU8xISpiZ2j9Ac5m158zvgCnGySLOi4HY+xl8SagVQMkRiqLineX3J7j++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBBlcA3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A8B2F606A31C;
	Wed, 11 Nov 2026 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBBlcA3Q
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7A241F00A05;
	Wed, 11 Nov 2026 22:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437662;
	bh=WtHMg/x0CcOfSTtKPR5su74Wna+qWRxbs0EhmQH9YFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cBBlcA3QlvLwWm4ODL0GZf+incvoz6y8Yg9p1X8xowI5kxRw9iEldTDaaqOJeTYSF
	 Z9+77vujKMJSc1HPQH8kFNiM5rp2BWucHd0xMoR+VM+EuZPWhDQ/5SjAc3ZWMFaV5A
	 v9+pDcGK3PGhwYS5OxV6Fbm7TQaVwkssg1+3osEciGBkInF3mrpyCdITt2mD0Y9+8e
	 4/w0g7dOBabP6PmGxrwi+cmMyeCwId2ARYzTSEhTiKRGh2hGApfzdlAZrbjPdsd0fH
	 Ttf073Zbb0KgIVFqkIEX/D+yApFr58NZ2Jyc/94RRZTRqfeiAZhILaROPTnMdOek3P
	 XCRjuix3TG9Mg==
Date: Thu, 12 Nov 2026 00:54:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
	Eric Biggers <ebiggers@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: add OP-TEE transport core and a discrete TPM
 driver
Message-ID: <avTyGsINq0mO0rr9@kernel.org>
References: <20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com>
 <20261110141923.3100770-2-jorge.ramirez@oss.qualcomm.com>
 <avM0uIlZxZIga4dY@kernel.org>
 <avRyYBpQcYx-xo9o@trex>
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
In-Reply-To: <avRyYBpQcYx-xo9o@trex>

On Wed, Nov 11, 2026 at 02:49:20PM +0100, Jorge Ramirez wrote:
> um, right, that is a bug correctly addressed by the ftpm implementation
> (the shutdown callback needs to go in the core as well)
> 
> will post a v3. thanks!

No worries, we don't have it yet enabled for linux-integrity.

Eric, forwarded just as a supportive argument for the discussion :-)

Br, Jarkko
