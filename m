Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395482;
	b=uAD9uFuP/vajCZrFQRP68n5ki4iBTM5ZRlYSrCMcSGzN0dut2iPh56/eKi1Rl17F8z4i
	 JAct3my81hkSOy9Ea1Qi9D6lJqmac8yD4OAIrSfq3C743ML/ojyMr6ago6dDvNHHqchUA
	 odaYHGS0rZP689xYlfUmBg+8DfLLCK314iCnHmNM94V6UcSkU6Mqf5YnAim/MCvrMSHUl
	 pYEJAw77QEYGC5twFgcYskLiGywKtYSq7ZbTUqvOKCcvUsnUCi/365F+HdUjBdATj0Xwr
	 NmQJtQy88RFTHoOJM1r0VioprJz8zM0CNSnRrl5nHe+qTDm0unUSnJBrZ9w5VLl0pOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aQ0Es9+34HNHRUII6Yl2Wa2R6Euk+ARdRZIX1Dn+ouk=;
	b=g6CBjeJnJ0LiamMEjXaf9c7ZS9cddsJuBN5CoCpjXuYctthxjCvia6zRnEeFg41nlW7m
	 USzTTG6rA3/mML4qfpJqMD7iv7nDl+JQDF/BSb/m/08NyVQXHHbYWjgiJw3Tri/y5ElDu
	 Czp7gUAVCQNkf3tSKH17HGqCQMPcCsmwwhR+GpbrX08fW8OUiAB9WZpd+w9EREYmD9XUd
	 m8PpMuAA8QXD5xRcj2J8ciigLITz6+4oqAWd72BrmZldIrSkWrlfUD0mhLK1sp/LHPepc
	 CTmtqsqjz8qGco3QnK12qnzNj1NMfP48JnJ3STj5x0yehBRO3YmNjhFaQTPZDbI192w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3Jnuwg9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 054E1606A98D;
	Fri, 30 Oct 2026 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3Jnuwg9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A4A71F00A20;
	Fri, 30 Oct 2026 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395481;
	bh=aQ0Es9+34HNHRUII6Yl2Wa2R6Euk+ARdRZIX1Dn+ouk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3Jnuwg9ZEx8638kcTmNJ5bdVxPjENZEL/PfDOsNMj1OKb3H+nHd8VmfHs2h4/9M9
	 k8u3JvLxq5bv1xTzRfXl2I/V99exQmsvGjSmNbtSBau1ejwkDt8l0WFwa6fiAuPqJv
	 BDQKD2AU6Rz8OkAFlCJvP3FrHvTSgPDWmbqbjQqB45iXXjL0IaP9x/ZeTnJiTsw6u1
	 M5kYeFHG2C7+CV1fATibE2E6cwo966qtrPNTFyXMU0rI3kEpAH8ZH1rKMcCVu++5HO
	 Llq6UYRZDH/VG32ADiV7CTpvoXs3CuusZJF3WtOpsP0NNeU6IK0dSH8N7LdjfLTFh0
	 ST/TwSq7CMeiQ==
Date: Fri, 30 Oct 2026 23:24:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v6 0/7] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <auULFhtOCLdNS69G@kernel.org>
References: <20261030200649.357508-1-armenon@redhat.com>
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
In-Reply-To: <20261030200649.357508-1-armenon@redhat.com>

On Sat, Oct 31, 2026 at 01:36:42AM +0530, Arun Menon wrote:
> v6
> --
> -  Rebased on master and the sparse __iomem warning is fixed.
 
I appreciate the trouble, thank you.

Now it is applied, will push soon.

Br, Jarkko
