Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166A256C99
	for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208779; cv=none; b=ppDw+SDW9ZWsvtKELl2qsCeVMiYXWMNsR4CUdrX5mVf0hFMGx1pOx8Z8jbY72sZiX5wqxocxDruzYypx//N3eTL4wzFpo9DitwB6poD5aCqUrln3aXmkL3ZZQJSrxEsukaN9rgtLS7ijbvlImDnxGJIsfCx9gtsBPqkA/kjyYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208779; c=relaxed/simple;
	bh=In8FWysFKKKSXvdPAw1N4X9ryaHzVVF9VwqWQJTNbY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=UzCnowJpNaMMkJGYq312X0BQBdAHMLvYN5con2CmMqmihkjlTJFh3d/T5qEkkwnikfmsY49yRscuECF0+Qmq/7/oW8GnEoINHUUhU0RKiLAUB9QM846mrAIV0R2YPtd8O5ibLOIyg+YiG8CtHtFGIDeZ8QllxXWEF6BfAZ31stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAe81Z+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAe81Z+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC16C4CEE5;
	Mon, 10 Feb 2025 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208779;
	bh=In8FWysFKKKSXvdPAw1N4X9ryaHzVVF9VwqWQJTNbY0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=KAe81Z+bSxNoUldvPBIXrVF1QidWzF0pApzHNW8bLtwIwSzjXKt5jbWg3eKKW8EOc
	 bjqyWrHy6Hdxq122iRvPQi08iKW6jUf2RaGyGfMKcuH7sNkFsBxCj2t4+zPGHdnU5V
	 JrQaWmDbKRvhPd8/IBP+8gJbwYPzBJG8JGZ3n4xISwA03PjIU6sGmilObqLF6K81A6
	 T3CVz9JlQBHVWGGbaJEE+6ZWrL+WJk5jVf26DYZmVy7yzUyn3pAqYGn9VqeIhZPgpF
	 o1ym1wk6vRz5cZhyiAk0eMxzfNNw8uqPmYiw+SH/TWOTIyb5DEy+rswTpFP3DCNl7P
	 NzjhWYnUZ3atg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 19:32:53 +0200
Message-Id: <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
Subject: Re: TPM operation times out (very rarely)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan McDowell" <noodles@earth.li>
Cc: =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz> <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz> <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz> <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org> <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org> <Z6om1DIcDW3b0fAh@earth.li>
In-Reply-To: <Z6om1DIcDW3b0fAh@earth.li>

On Mon Feb 10, 2025 at 6:18 PM EET, Jonathan McDowell wrote:
> Who then handles the ERESTARTSYS though? Part of the issues we've seen
> is the failure happens in a context save or load, which is all within
> the kernel rather than directly under the control of userspace. I'm
> guessing the HMAC changes are likely to hit similar problems. I think
> some level of timeout improvement in tpm_transmit is appropriate, if we
> can work out what it should be.

Right I get what you mean, not all transmits initiate from syscalls
And obviously this can happen without hmac too with tpmrm0.

Hmm... so I'm open for a patch that radically simplifies the state
change timeouts, i.e. sort of part of that old patch.

BR, Jarkko
