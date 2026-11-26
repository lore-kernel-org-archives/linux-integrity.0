Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714025;
	b=VObV+D/KAcoQiTaTLwkW2Cn7dDwxh5YxJjo305WnFxh0E0Jq4XG7fRAn9pkOaBpWqBkT
	 YjIMQB5qf8rR2ZlvDJCw9n6CkwWBRvpfBbBeiKrzlO1oxwi9v94GuH4wzCPd/kDJNolRN
	 Ecr3+EDX/qlXTLd4QSPEYv1BxyXwfj/KwmHR3MD8X2K7mILB7PLmyj3TtzziVFTsHVd5o
	 xE98jrBC5jwa3KGCX/EXA5kJln5UcOAGeFtJdHXAHCpnkz3vZ+52iKzYDsi0tByn0rBzA
	 06PDmdGGoJRySfnclrIbo7evtB5uGxDvROLw+58SXiJ/vuhK1fsnze0WaABXzNEzoRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l9mHeSQge49T1ujr6oUogf7xVgC9wJskbfbDgjvKLE4=;
	b=GTgRiqqR1BwPDdYJWBdAbPQFvTBUEd2Sl6gtAiWZsFIU8nhIxRMjtcWB91s0Vw7A4bkF
	 WxaZrZiS/dTZsb7oLGSgMjxK8P+ax6vrQ5D9gRB9K74VIFefaCNMaU46ST+G2nfhoeiL0
	 yr8oRlOEsJ1ym3UyR2ZLvTWrvE9jPAPaQ2123M8ynNzUdxRbsCdbQVmDLcG08xe19Me8v
	 8T+3h7SC7oOIfO/cfw5AzAI3mKVwjE2k7UJURdSWbBL3hcTr0jGgVA5LiOqfit+qmw0oA
	 FmZx/ue+Q8qRalKlOzEr/Zgzl9ParlPsj957TlKQtj5Bw8kCevN8nFCjpzEVjvbsGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2cHlddt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4AFA3606A31C;
	Thu, 26 Nov 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2cHlddt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 495AA1F000C0;
	Thu, 26 Nov 2026 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714024;
	bh=l9mHeSQge49T1ujr6oUogf7xVgC9wJskbfbDgjvKLE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2cHlddtt6KnPzdb9HLfnYirG7A6/TyJ6XGz2n6aMGgYQNRk57hYJ5UpSY2BusEgP
	 qhjs0+H25LtkezDGyLietcPYb+D8WzmwPWYcqUE/rfZwF5k97ZFH1v5bN9A0p/GvbC
	 uR0yVBDjb6+UKFLg9FmIBBywW0GOv09UezptNoimRUUrFIxV7evhrp7aUknT/lgqbK
	 ANksgtFJqHFB21SNOk4kzO1cnR2n7Po2fJNhv9OKh0BqKZ31jDIEr8cZYfOd+8gPm+
	 xE2B9+iAOYqMX3n87KV6X52CMw5cQz0sDUtJk22/zTv+5DFnj+PEZHSqOEPACiWL8O
	 0ZUTtQEKsNi0Q==
Date: Thu, 26 Nov 2026 19:27:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awhr5NnIx3IAqLMb@kernel.org>
References: <awXHzblUfp05jZSQ@kernel.org>
 <20261125065429.1483868-1-rmustafin@cloudlinux.com>
 <awcT0WnnJ-fyovnn@kernel.org>
 <awcW90qZvOim7dbh@kernel.org>
 <awcYZNG9f2YSIz49@kernel.org>
 <CAG6=z5sThdfZLY3mQ+NdzpFYj7bSN-CsV1bEdKCASw7b_b2g-A@mail.gmail.com>
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
In-Reply-To: <CAG6=z5sThdfZLY3mQ+NdzpFYj7bSN-CsV1bEdKCASw7b_b2g-A@mail.gmail.com>

On Thu, Nov 26, 2026 at 09:08:27PM +0700, Rustam Mustafin wrote:
> On Thu, Nov 26, 2026 at 12:18 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > I got them applied with git am. It's better to use separate threads per
> > patch set version.
> >
> > They are in  my master branch now.
> 
> Great, thank you! Will do separate threads. Thanks for your guidance
> along the way.

NP :-)


> 
> Br,
> Rustam

Br, Jarkko
