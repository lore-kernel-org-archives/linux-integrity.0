Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961777;
	b=2ufjzRjLDrx+6jhp83WIs7rwAi3+FbmkkYBo7xSZxkqsMrrTvjn5pwVzZF5UTiHH97/9
	 cJRmhgFwcx6Ghrwri/zvr7hEXAcaXtt5H74iaP0EBBd97XpSRjvjufJbqlunqYGbEcsyE
	 M7zEqM8cVh3EVcBvNyNpK+LMyXqCyPdphPOxw/1yqdtQ3voy/PnDoE6sF6kfK9ERuNCrp
	 et8qx+zV9R7TgOVbbyCK3zM8Jl89gIIjcSghJLtkGiPVdTG4ApCAILnKEvr0ouuHQZ94M
	 Ir89+7AJChIkw7QqbBl9QbcVtXl250EUjCkSQhPkXXIdl/dtD272nkAwrPrfCjMYIoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961777;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=npO4joq8A1mMPraF3T+YJaHa043AOy3tDWB575QexfQ=;
	b=RuLnhGgRtyeHrTPhN+/Cse2210HQzuCmpL6xzO/E/uULRSqhVALK2ZoSehCYOk+iW+Ed
	 tzpgWKdM2dzJ5XaMX4kTJt2aldZOnnS9w2UCnI3U4THjVFydy2HxDWZEkLPQDdFSZHPVW
	 QZjUa5CVbrGbdO79oGQs5o/gq/yGXBZIuzasoD8BXuFyoS0ccykHz38CKS4YADdN0KnBz
	 ppeYC1kYwH9hVgAuCAdKbhOO74sUloIhcGJvKWOP7D2H4ory5ueu3rBhsVOT5UJjBv5bw
	 Z1Ll6Z8A5SSlemdWTc01iAO4OQDXcPjTtZvHuVOhOBVkZtWv37ZbNTpl7gWc0u0U0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Exn0q3sP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 55013606A31A;
	Sun, 25 Oct 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Exn0q3sP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6E70A1F01825;
	Sun, 25 Oct 2026 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792961777;
	bh=npO4joq8A1mMPraF3T+YJaHa043AOy3tDWB575QexfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Exn0q3sPYuMvSFM6C/+u7OzZIbjoMoYxVG3gF1mOvq4mVoadWuR0852/FBAx4609K
	 3NIQQmRdqhNdEf6ZM6qLyh355Ieiz77ZB7LBpmD5kptdyTI/aUhLJTcleJ0lnesnYM
	 L/7AIDnsVdSwR9EUt+LcbddAoZNR6jzWSkByULfacx1xfe1i0NR14rmZux53fiDufD
	 is+RLNbFdg0RFibsIS8AhAnyM+mFpMyO4vh43mfDnYmImV4O/g35jzVVM0FGEuPp92
	 VphbkwQnZJeDk39NdTkw4+suJrLZvR/BvEe78utooOP93FVtNDwG2aROvufThkY5io
	 6ANCrOcECqv1A==
Date: Sun, 25 Oct 2026 22:56:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 2/6] tpm_crb: Split start method into a separate header
Message-ID: <at5s7esFgxkTF8u6@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-3-armenon@redhat.com>
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
In-Reply-To: <20261025201859.221991-3-armenon@redhat.com>

On Mon, Oct 26, 2026 at 01:48:54AM +0530, Arun Menon wrote:
> -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> -	 * report only ACPI start but in practice seems to require both
> -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> -	 */

OK, it came from here and is probably my comment. Still, it should be
put to more appropriate format.

Br, Jarkko
