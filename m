Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741449EC4D;
	Wed, 16 Sep 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550707; cv=none; b=jGogI83LhZ1/iUhdDsyTuSeYA7aZEeQ+LELYskt+7n5dImBnKJi/e39x3b3+oy7lJK7UTIQ2kEpf/EHOf42K2x/O30ZNBopDRO0UG++puLITlls2VhFu7xcQTtofHU/wisXyA3LKuNDwqFEjDan57sDUL0/VsXsuILtposi04PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550707; c=relaxed/simple;
	bh=5IPLzuCK0J+FoZIp8Ta5ucldQLBz6H3kKcCMnvEVBvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmtCFpGKpT99br3JXAPlb1ytF0J2O/sAbbDcMjpARs1QO2n+c7CXpaAfpWH+5gVL7xBawR6ADrS98UZKMGg+fpUumIUBillriT1+Y655njKQgllLJi5i5vRCpzeZF2im8oudnGo/DeiN2od4vfIesDNV/M5uD3RxAnmys+pPvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IsWu8xut; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IsWu8xut"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nU1QJvuM+qB0W/XO8IflWXVEzEt7/smcXVIvtO6Gs3g=; b=IsWu8xuth9IDZQXw3ZmqDX8TTD
	r1Kv1NAUBeu/J8Ln7dZ1OUZjsggeoK+51TNiZxx3gIL4Kvr+i3oWEHUzZMa5qOPm6EdtnkLTphCHW
	8lndlv5nzJdBBgakQ0+3Cwh/1/66xg/vjB82L2qMbW/SEK0BL1vw2TWAdvxqdc1iuNOZewkHkxqtT
	S+VI1Kr0gIcnsFZatn6YF4rvpgU5ieajEpm8jRVlS+wYDfU2UT3CTV3+4apeuLFFyBtdyUep6Qqg/
	Bc/yQ+kZwb8vRR+U59h5o1dyGXoVa3KPskbanXIgNLP3JZZ2zxmWv67o4BIEmjAE4JJxmYgtKBP3m
	2Ho7jgtg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6lsU-0054HY-1S;
	Wed, 16 Sep 2026 09:24:30 +0000
Date: Wed, 16 Sep 2026 02:24:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Li Jun <lijun01@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jim Broadus <jbroadus@gmail.com>, Alec Brown <alec.r.brown@oracle.com>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix build regression for tpm_tis_resume
Message-ID: <aqpgPg8D6a_uiGq3@gmail.com>
References: <20260915201239.3529332-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915201239.3529332-1-arnd@kernel.org>
X-Debian-User: leitao

On Tue, Sep 15, 2026 at 10:12:29PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using DEFINE_SIMPLE_DEV_PM_OPS means that there is no a code reference
> to the unused tpm_tis_resume, but that fails here since the declaration
> is hidden:
> 
> drivers/char/tpm/tpm_tis_i2c.c:322:61: error: 'tpm_tis_resume' undeclared here (not in a function); did you mean 'tpm_tis_remove'?
>   322 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>       |                                                             ^~~~~~~~~~~~~~
> 
> Remove the incorrect #ifdef.
> 
> Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Breno Leitao <leitao@debian.org>
