Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82C49BD8E;
	Mon, 12 Oct 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810547; cv=none; b=TkUQ+MRpy8J2kBQR1J7rNAAYOvtK/FsqmGVxH4y7XOO9VjS/VqGA+yMPF4xQIGnPYR5mSpxdesR3OwvcSbD0e+4eNPhNB4sRJxbow7X7vGuGx1MT8Rw+CdI7dhQouhH7o6ZROnQnwm5BUImRafdax1DGzKFhQuSge4ykmVd7yCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810547; c=relaxed/simple;
	bh=VLRaozWfdTWxb8Rd4DWYV5ZEZQt8GH6bkhwa6wyOxnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucZt51AlrLG+1JvZun6xS1MSjAITCnuI47jBn6EAoM/LOq5WVNj9slyQnm+sYRz7tZdkTvgD6bx2ezKrxkH/zGw3lWQFTkZLsTA6na8BT6JhYZdLD6X2+H+LKw/g0BG5V+ZmgFhvtPIGhEdgMmm2LnLTLeOpyRbMktMSENpDYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHTYapgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHTYapgh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BF39A1F0089B;
	Mon, 12 Oct 2026 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810546;
	bh=htnToikM5oWNWLcWINlIXAhrpOBUmE0m+tQ2CYJoG5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WHTYapghOmD5jhcHmMzmSJuuGExOpuexOOGu9ZgC4Xg6NQWW4THCb36O82ceG1Zli
	 hvPJH6HS/qZZxLFCm1g3UdRirhE/pniMojfShSaizvji6VRiXSlqXHvhAXK0+cpZVm
	 Fgp/tA0mEiDclikbpWC74CMUwaBh6j9yeReEvcmgKsZqDDhxTeanPpQQ2PtZ0r2238
	 tiqrJNy1xi9y7mDQIGxybiTcRs3OZUdqrsIG4YHuqaeB3qEpRR/xTmF7n6K9SA/3GU
	 Lia2xfPPrq0jntrdJnLOqYsUaFzeB5Q02Dwpwz67lTucvVPlrCiXjpHoSx361k8i5c
	 0RAaz74mQ6wcw==
Date: Mon, 12 Oct 2026 16:09:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-integrity@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter =?iso-8859-1?Q?H=FCwe?= <peterhuewe@gmx.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
Message-ID: <aszb7oOYq-ZfeNDK@kernel.org>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
 <74850205-dba2-4a97-951d-cda28be129c9@web.de>
 <asvSXjQQ0vEvF7yL@kernel.org>
 <0d6f94f0-208d-4cf8-a973-2afd37695690@web.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d6f94f0-208d-4cf8-a973-2afd37695690@web.de>

On Mon, Oct 12, 2026 at 10:03:09AM +0200, Markus Elfring wrote:
> >>> The bind_evtchn_to_irqhandler() function can never return 0.
> …
> > I do agree that something in this patch does not appear right, or 
> > at least not very well explained so it is a good catch anyhow.
> > 
> > My decision on this is that:
> > 
> > 1. I'll drop the current patch as it actually does not make a case
> >    why zero could not possibly happen. I spent 45 minutes browsing
> >    because commit message did not have any technical details.…
> 
> How does this response fit to your previous tag “Reviewed-by”?
> 
> Dan Carpenter provided also some hints.

There's no problem with this. I sanity checked the commit because I
did not (and do not) understand what you wrote, and started to
check up on things because of that email.

I came into conclusion that the commit message does not nail down
its claim well enough so I did the only common sense action one
can do in this situation.

> 
> Regards,
> Markus

Br, Jarkko
