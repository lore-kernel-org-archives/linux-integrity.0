Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6035B632;
	Tue, 27 Jan 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528735; cv=none; b=BVKtCl8U8wBlO4hDoVxpMXqVqOrva0lgIBS3NN3FAGEbV7p7yto87l/SmVFRa+zZv/hdOrNEX9o3t77SsroBFQDJ0I8GWQzejGAizjK/jDwnq//4s24aFtY6MfIQKvAYgLH6jpb946tqta8iCohelcwwM7ntojdPpPvNvo7/0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528735; c=relaxed/simple;
	bh=d4QCgirQGUGDrDP+ZhpmWrlquC87QZooZmKgKiRl3kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucnm/gnbfCZadwYLSEB/Kk1NL3Ron8wU6YaC7/yHZGXtJcAmJlYiEORIIE1nSzMmtE2X2Fz6d+mrJgEsJ8/lH0rjJLGrGfad5yuO2886N5h+/ZiFeueAKp2oK8VZCTuTSOWHm7QOzuWbsOtGPdQfC8JMDFhW4q5jxNPFC1DgAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2f/KysY4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVZV4nGi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2f/KysY4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVZV4nGi"
Date: Tue, 27 Jan 2026 16:45:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769528732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljnqvQ7FcejLyLmSh5biG+cZ0bvPvaTDT2MvmDyOGIo=;
	b=2f/KysY4r90o/Xhw0WiWrPN0ZgzBaZyvhgkQxAwd/CyOwc75U8BPVteyAaEhreTRoYmb2H
	CClMP/sh27hbLb7NKautw6V0TsjAEKm2qpCmP15/+nZjfJmcTCyhD9ne95giVS+g3o+IhO
	X+J0gKja5vDYCt1NbTNJAqyEsA+UoIuz9MW68BZtSs2T9M/GtTdFF2nfercUr/qXwkOrCA
	hxXezOJwhXdb+b9cxi/Czrvp24C5tKtOUqK/PWFNtD55zak1v6Dq1iUGD/ltmFs4ADkaUS
	O2LQidhsMk0kkbfc0BhiKotOMTNCbPhSIBW4/21273WfxQu+uG/G5UYsdsCGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769528732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljnqvQ7FcejLyLmSh5biG+cZ0bvPvaTDT2MvmDyOGIo=;
	b=oVZV4nGi0gtGaooXDtVkwNwaPzOcCNF/iqnK3AA6mvH6pVXoKoDvuzsO0/dW0lMnQYKDHG
	UJLmjzn/NsgIPODQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Message-ID: <20260127154530.SPUEa63d@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-10-bigeasy@linutronix.de>
 <aXZJuFXFvvfsW-Qb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXZJuFXFvvfsW-Qb@kernel.org>

On 2026-01-25 18:50:00 [+0200], Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Shoud I pick this? I did apply it to my master branch (not next).

I am about to prepare a v2 and if you take it I am going to drop it.
Shouldn't you apply it, then I hope to route leftovers via the genirq
tree.

> BR, Jarkko

Sebastian
