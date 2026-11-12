Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486058;
	b=UuAe9sxtZR7NIIDSMbUjvwPgFU0lSZ7tCFbdVbNhVYVyi7kK3b0YZSwikOJ2dGSe3hx5
	 EBriIfb0GNtXBZVwsEXpg+zaKz1ITnXTap7yUXbZDBxu2z1oLq9igO5lKdCSx7LI6niUV
	 Qjmg1othburL48iGQv0Ha+pKbdJuvt9eQ1sKp0mEGew3DSPWW4BMyZAR23ub5VnImmxw0
	 7oUMsvEaInauzTEGfTcDgnNYnc0L8zvZkBacEq5PZDd94SkdopspLmotK6oXDGMStrPBi
	 3EDhquYH76+ats+08J2muJK6HlzGVzDWprdxMcwKpuVyMAc0+G5OF3Oq1WfN1dnCscA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486058;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=6qULDUmO4UBM9C1l6Ed5iYgq4aFZP2+fuD2zoUz0J8o=;
	b=JSg6eFmLvRmCYeDgm5gE0sO4ZdLR/Awf/RfxfW8ud8Nlqp6yz2DkErLizakXbRQZyrxx
	 Euc1XZx6s/dhjewuS0EqLacb7awMVaoDnrpHT7g9dfEj7CIySyY6SrEF3K24EIM1Q8T9g
	 V5uHRfQoR4JEVe+GQZn0u/ml88MMRUJ7roDvRaGK0JzlP5ELbLie2hcvNamCDdwq2QACc
	 F8MqqjkNm6qF8gccgiJJOnE4y8hdNYa37nneaHAa9GTFsgqFdJN0P+TCpgrzJC5Cc3Ivn
	 w3s4ST5BTjD5v5UHnL6RRISYiZBkp/2BallNep+s5KRzzS8oXAX1YeFcSOF1cvfD5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Iimse1XT;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B530606A31C;
	Thu, 12 Nov 2026 12:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B530606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Iimse1XT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6qULDUmO4UBM9C1l6Ed5iYgq4aFZP2+fuD2zoUz0J8o=; b=Iimse1XToPEzotyQ9ZSJJnyJuW
	7N1d72j/yPmxF54swibO2hFX58qEyWuxxrsTtZiFecDdm2np3YN18ncbWtoXQJLhBxHmGAbkCBKfv
	GbpAUC5MxVVCjXOuMjDmKI3sk7PqF7HAffwSV7zI/EDWXwF0e/AtGgowoscASfIykjI88zSSAbskh
	rVE5yhxYIa+k//fQ+bEfxLN7/RcDNvCQ4aN4Sv0+eH8c0Qi7VZW1G3EW3p9IS9z4S4l1MUzAxsVpr
	VnJJqZKVK0RnErDez8er6HPtShqmTdeRMTitHIYFAmE28id6Fiw2AEswxL74KF5MYneHh7mTqv6NL
	I6AfmWag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRTnR-00Dxtm-2Z;
	Thu, 12 Nov 2026 12:20:54 +0000
Date: Thu, 12 Nov 2026 04:20:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, surenkj@amazon.com, 
	noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avWtchlNNu6DWfKa@gmail.com>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <avTsh6pCI-sRGAJp@kernel.org>
 <avTvq4VaYbxMnZl9@kernel.org>
 <avTwXhEGwVj71VmH@kernel.org>
 <avUdBbvxxFgXkUJI@kernel.org>
 <avUeC_szxkCe5GtG@kernel.org>
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
In-Reply-To: <avUeC_szxkCe5GtG@kernel.org>
X-Debian-User: leitao

On Thu, Nov 12, 2026 at 04:01:47AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 03:57:29AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 12, 2026 at 12:46:57AM +0200, Jarkko Sakkinen wrote:
> > > On Thu, Nov 12, 2026 at 12:43:59AM +0200, Jarkko Sakkinen wrote:
> > > > $ tpm2sh return-code 256
> > > > TPM_RC_INITIALIZE
> > > > 
> > > > I.e. TPM has not been properly initialized by TPM2_Startup().
> > > > 
> > > > I.e. TPM is also saying that it is *disabled*.
> > > > 
> > > > So acting on this proven fact  makes most sense to me.
> > > 
> > > 
> > > Actually, should we even disable TPM if it returns this error code
> > > already at the level of tpm_transmit(). It is a guaranteed dead-end
> > > to any possible TPM operation.
> > > 
> > > I.e. while this fixes hwrng issue I think it might be addressing the
> > > issue at a wrong level.
> > 
> > I leave room for figuring out 1/2 but for the second issue I would just
> > do what the attached patch does and call it a day.
> > 
> > Br, Jarkko
> 
> > From 093124e51a26de8191e21ce41988532ea7e0bc8a Mon Sep 17 00:00:00 2001
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Date: Thu, 12 Nov 2026 03:55:00 +0200
> > Subject: [PATCH] tpm: Disable TPM on TPM_RC_INITIALIZE
> > 
> > If the TPM has been spuriously disabled, the game is over. Let's reflect
> > this truth with TPM_CHIP_FLAG_DISABLE.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 5 +++++
> >  drivers/char/tpm/tpm2-cmd.c      | 2 ++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 470b2da3234e..1f1e22341155 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -256,6 +256,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
> >  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
> >  			break;
> >  
> > +		if (rc == TPM_RC_INITIALIZE) {
> > +			chip->flag |= TPM_CHIP_FLAG_DISABLE;
> > +			break;
> > +		}
> > +
> 
> Sorry, should be TPM2_RC_INITIALIZE. 

Ack. Thanks for the suggestion, I will include it on my v2 then, but,
while testing, I needed to change a few things:

1) The check needs to go before the RETRY/TESTING break, otherwise an
   RC_INITIALIZE reply leaves the loop before reaching it.

2) It needs to skip TPM2_Startup:
          if (rc == TPM2_RC_INITIALIZE && cc != TPM2_CC_STARTUP) {

A TPM that is already started answers TPM2_Startup with
TPM_RC_INITIALIZE as well, so without the cc check a redundant
TPM2_Startup disables a healthy TPM. I hit it with swtpm's vTPM proxy,
which sends its own TPM2_Startup right after the one from
tpm2_auto_startup().

Let me respin a v2 with these changes I have been testing, and we can
continue on that thread.

Thanks for the review and suggestion,
--breno
