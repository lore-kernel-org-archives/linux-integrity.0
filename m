Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460906;
	b=Nb/RokfR509+F8ffx80/+bfjL+zig8c2GyUjl/B2heYl5xrIqCX7xJGj9QwDK9o6uwKe
	 5dhUIdXRD6lilCOdSBjmGG8sk0t5l7cZbBSKLRjIGwXWQEYhyh1fXsT6wNwYjfgQ7GthY
	 lCZUjJ6Ks+JsIUdfDPZrkYPlCKpRjvYEaF8aneyCOH6oKMhkytkY0PfOzlwlhQAnENiic
	 CZmvdCVjXkfzdEowFMSKtTmQW59VJVS13oKoPw4xmW3p9bailWlk8v4L8Ga8cqy8TZeN/
	 NZyGfPTsf31SL8KkG5r6nWblINIRjPwXryNMZHMH5YH9WCzJMb1AgYkh51un1S/3A2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460906;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BkU3YWgq9jMpDGOPyu1t6/KKvm+woIJPzoucCWI4baQ=;
	b=3eoJePySXLr7g6H54QTOgiZnvW/9vUefRezo1WNz/JfP/PQ92jk0wmkjR3ICiMeOYUZx
	 3zmTzmLHUhC3THzNkrCKBICXXBbdv/o22Nix4JI5077BKcP5loEWBV/iZxcjhyLVMiE/w
	 MeK93QMmOHDSXVN74Wr4puMW+bFzqBKEo2TtTB2I+zDDAJlPApnPkx6n0+dCTd0Oif8o3
	 CLjVopgL8+/CoJW5Ec015TQ6pHzAzqpw6arzbsXiN95uTSjFFxYhlvadj5Ike7S5tTubz
	 CdatacKByCfDjpJpGFQnwYXOxxizDRKM9ZriRyc8KRZcAuQo/FAR1VKY5HjTOfASWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4ydspDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BCB71606A31A;
	Mon, 23 Nov 2026 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4ydspDu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AAABE1F000D2;
	Mon, 23 Nov 2026 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460906;
	bh=BkU3YWgq9jMpDGOPyu1t6/KKvm+woIJPzoucCWI4baQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P4ydspDufQYkrsAKgMF5cgWP6xQfvTcV/MwPHHY0QJHe1vSouKXeRTsEQLwHxyh6t
	 onRlUESmX+ng3U14yZS5RqNgsiMUErmd5FbhnEsX6v4aL1T2dkZfS4YnJ+XZn/IpXF
	 D/BSReMuUuEGIE+OY+agmlZAn5NBV1OC7fb7XfWp0p0Sv8YrsSK5nH9sr2L8dq1csH
	 wJl4rJoqma7NKfE2oQIutMGoSi0RjKgRL6ClWtbKH6b5Mc5aABuYnMN1J1J1/uTJ8M
	 fGZUfJYwCtraJ+mAvXqcoY0LYCqYom6fJggn9h9+/ovH5cRMOZGiBkMJKsysr0EdJt
	 ILqkWTLT+cv3Q==
Date: Mon, 23 Nov 2026 21:08:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: tpm2: test that io_uring reads ignore the
 file offset
Message-ID: <awSPJidop9NFsBrE@kernel.org>
References: <awGr_tB3QXwnW1G2@kernel.org>
 <20261123165638.2161305-1-rmustafin@cloudlinux.com>
 <CAG6=z5tCJNyaPbOBYRCskXTCGkbJ_Zteg9Y-N_FFdU6Ag5FxDA@mail.gmail.com>
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
In-Reply-To: <CAG6=z5tCJNyaPbOBYRCskXTCGkbJ_Zteg9Y-N_FFdU6Ag5FxDA@mail.gmail.com>

On Tue, Nov 24, 2026 at 12:11:37AM +0700, Rustam Mustafin wrote:
> > +#!/bin/sh
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> 
> This should be GPL-2.0-only, as you asked on the RFC; I copied the line
> from the neighbouring scripts. I can send a v4 with only that change, or
> you can fix it up when applying, whichever you prefer.

NP, I can do it.


> 
> Br,
> Rustam

Br, Jarkko
