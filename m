Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690033;
	b=sBLNS4YjIZEto0gMKeGdOanbZkJFPd0sDWeDE6PvPPwqpi1yrpy0vkL7ISV710nPL+5M
	 NPxvh3cVakzZmxQmBR+wPqIYzUoyekWtt6B8taIUHYwNMMB+6N5CMM3daJTRWrl7Co6Hr
	 LVgo9vrTZdz+F7SP5RZWsENEtFspyhgs1msVH/k0nzgD5wOuH6whnxR6Z5cOIipUxkBbU
	 Mr9wXXchYlRl5Ha4mGYzU+oWhQqQKiA3rTV+xpRBVVwskDv9pb984E1X4oZSzyuncbsn+
	 1+mX0tZHhzbNnvtsbaZt4E1M37Om6M1IyvkUQZ6o9bgnPWy0j3Mzqpc9bzAqCSoyKcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690033;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SJH68/COfyvgePXxUDhK6tjwJvIpIRYp5jUXCkHgbaI=;
	b=S1IBX843TPznR07XjXQCENQZX9napsHR3GYd2bZftEYipY+IbVO1BHdf/TED5d578cNh
	 VYFNrP3Kecp0AOHAVHvMTmM3HYe576Gm1FAPJRl1q5p493uW/rKuej9q/KvZuBln21LGk
	 94e5h2heS1fYqeS75pzXFHEMxwrqxRPzFGSqxEWTwh1NHyM+jMmbDfIYlJJX/TLnvYpEC
	 F7+DXZFV8DhecKiMIPre3Q33Maf11JbyhBlIPbEZUxdfXlr59cJ7eYcjvMoSW8Qk3X4QH
	 sel8wh3pv8zdk/98F59o5G6+ib0eAZ0fO3YyGcOGUMSOp4GAXaxZqeYhKMsq4oILLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGSuuXIW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E87C3606A323;
	Sat, 14 Nov 2026 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGSuuXIW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ECD091F000C4;
	Sat, 14 Nov 2026 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794690032;
	bh=SJH68/COfyvgePXxUDhK6tjwJvIpIRYp5jUXCkHgbaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGSuuXIW2fiDlGuT/Ku96ytrVsVSlzF1Lgr0obnt2uXIVyVztUyEMYF/dqnXXJSIc
	 7dRDBZY/xshq+z5uIBHlGuYFMpoup8s16BQQZ1SyKZ5tMeixtfNiYf3NjwUldaZPpQ
	 CMm3z6wUYEt9nBO59RFM/ix8qh53Gvel0O/F0A+HQiSfJbSnP1Ul17+5HF6JHNgcuu
	 8fgGJhUXvPD5boiNEWN+1IBvqeOewNa4OHYI6SR6+I+isCtPGOIcZeBDTA1f5aFjST
	 GJlca8czrfp/98f6yA88gFMdQ/GSeZ0+n0RM56fVKNLTZmGFy1kondZAde7E2OWeGV
	 lRK7HMtLTJspA==
Date: Sat, 14 Nov 2026 23:00:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Cache TPM2 start method
Message-ID: <avjL7GI0qQJ47lF-@kernel.org>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
 <20261114193434.117714-2-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261114193434.117714-2-sidchintamaneni@gmail.com>

On Sat, Nov 14, 2026 at 07:34:31PM +0000, Siddharth Chintamaneni wrote:
> +		status = acpi_get_table(ACPI_SIG_TPM2, 1,
> +					(struct acpi_table_header **)&tbl);

Nit: no need to split into two lines and I think you can also express
this in more compact way:

	status = acpi_get_table(ACPI_SIG_TPM2, 1, (typeof(*tbl) **)&tbl);

Br, Jarkko
