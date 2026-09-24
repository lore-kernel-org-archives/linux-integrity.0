Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6046C833;
	Thu, 24 Sep 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249290; cv=none; b=hxYoR9AMhPO5TgRsrDsvirsbMkHwGJ6qS8prdk/VQaj3kRgGI1cgasXTv2QzCyZA5bkUFN40ahiV5WLXo9CRUE4ebUv5VucSTtwdxYIfkEWg1ntwrj3WZs/Lq+TGdq0uuX3MaiSrdFbStMd9b6HMVV8MoK5v1MXqrx7g6MnfQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249290; c=relaxed/simple;
	bh=m0xmm0/QbNRvUfMK5KAKdsjz1gPnycBcPGf2iYw/Dc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h49fZ56sJbhDn/mO+rTnQnx7rzAn1zEw9HeSppgtBJsBJtmIK2g5B5EpOJVtCpOw83EQk8mJaaAZsv8XwB7IVFX3wc+zDf/a536RKPE4C8KvcFkBwECpWGi2GvR/CujCbt/DUHH4J10MMor9rvwFLFFewiLJPH8mvB2og4UbpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZl6PRMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZl6PRMz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 235681F000FF;
	Thu, 24 Sep 2026 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790249287;
	bh=/49d0QU20P67CDjkCEhRHvmdmUfXZn/yu/mTR5KxJd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fZl6PRMzQU4A6L4kiRPOivQjumMm1AaQqqWmcfKMX9+4gQ59wxk/SiNEcGr/RLv8z
	 vg/Li+6HRHWLgPKImIvIbfEtdv1QLjIQd6tNix9mIVn60AlSNSRTpHpanE3MT4+EO1
	 XNowoobxi7s+TYNBxswThoFqLF+cAbln3nmbiNnjsOtau+PYLh1Swvvt71oDcFPprv
	 9SdVuGF/1E0bmuIXj7cVRbQOa4R+LTj2Uz+BP3rI2+K+VOWGvZajC3ih8EjQnkJQUA
	 xEb2Mw6M3A9fqqAvMnGnvf0pcGNoApjXn3Is+0PtezmgOlcY34Po2vHfuj391GMuH/
	 nkcfRIzPhByTw==
Date: Thu, 24 Sep 2026 14:28:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Li Jun <lijun01@kylinos.cn>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <arUJRCc7PhOFi65a@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org>
 <aqyNgA5NdSTdrP_6@kernel.org>
 <02f47743-49e0-454f-839d-1d6c41ba5165@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f47743-49e0-454f-839d-1d6c41ba5165@app.fastmail.com>

On Fri, Sep 18, 2026 at 07:49:12AM +0200, Arnd Bergmann wrote:
> On Fri, Sep 18, 2026, at 03:01, Jarkko Sakkinen wrote:
> > On Fri, Sep 18, 2026 at 03:58:11AM +0300, Jarkko Sakkinen wrote:
> 
> > I pushed this to for-next-tpm, which mirrors to linux-next.
> >
> > However, since this is -next only bug, I guess I should squash these to
> > the original commit?
> 
> Yes, please do, it's just a drive-by patch, which I find easier
> to do than reporting it as a bug.
> 
> No need for Co-authored-by here either.
> 
>     Arnd

Thank you. I've updated my tree accordingly.

BR, Jarkko
