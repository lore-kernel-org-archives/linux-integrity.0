Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508792;
	b=F3GULAXo4/+W9GWhuAS55exlPdipuK9dWFiNGOH7/hepuK6pvvAzvIl+DL5/xjI8BM+k
	 9qRydlsRxqgWQgTnEAg5mZIWWOA0jJUEhzRBVe/fZhqWMBanJsZX2Bb87HWcTjyHs6Cah
	 5qElGOTleSrHlRlza9n8oZEbtUJDCqo4r1fG5OIr9Z2zCt/ONeCzolPdULWzuku9iiQa8
	 vM6I8k1/WaaPFaDwRGjB/6ytaDZBYn9FqXcxovURouUn+VpmDjjSEwJLhnGzzzfvBi+Us
	 wCcmgMaXa9PusshFSs2iebvKsH0Zv2fmmBBK6rAWxc8VRPFwuBh0rwXg9CXyIG7oI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508792;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=boAZcIvOelwzMMKehmMw/xFxPdGTILRFEwH/uKnXqRE=;
	b=s/I0dqtaGaSnoBxa4o+fnQl/MnulXdP/MgwcXRdeN3hckEpY/ehm0Oeijoe70TR57LjP
	 uonkKE2qCEYW4P7do/JWqcD+X/2RSzLgmdw7I0o+5RmjHixFHfarTh0u3CNg5idDPaj16
	 1MU7TknTnpivOz6yqVgMrnTH9u7GhcGkvgAgp38yV4b8M/k6fbXQ05V/W+KIOQN+fv/Gk
	 PbOCvIO4ucgvauE+rpi43eFvDc0Mb0qTeWvl/Kd81Z2T8v8sb+6fc7ff5lbyQCNyeheVQ
	 D+TRpccksOCCZr4lJvD7hBOz5NERGSu7zFRONLaw9P5vvcSj5L9mOExYfNjlpfNcbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXvxTDpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 37E0B606A321;
	Thu, 12 Nov 2026 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXvxTDpc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7A55F1F000CA;
	Thu, 12 Nov 2026 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508792;
	bh=boAZcIvOelwzMMKehmMw/xFxPdGTILRFEwH/uKnXqRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXvxTDpc8d9iBSmr6CH/69hwlBQCtceI42diiFBA23boeq6+MO6VBT1XPmFzX+ov5
	 lX1oFrPDTGBfubq3yerHCdN0c0h48Gcfg+tglyzDFm4nzDZIvQfAmswjOtDuMuFV6a
	 DCEQ0hvGZtRngg33ppHMQWNELrB2NHnvHGbG9VC7sGC4vYJDZjP8+fNVG6fi+91Dtq
	 HVt+q1quapebwx6v6ZdiYFVlbPH3lLlbHKL7fK0W+cRON+ABFcVEOgTWf5HnaCTZIS
	 UuGq5c2moOR/J65HrJcFOCEhbzXwaJJjgAWJxrKiLfqePfh/5Of/mzDRqKvGawGj/g
	 1ikgOE+5eMylQ==
Date: Thu, 12 Nov 2026 20:39:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH v3 0/8] tpm: Rework timeout and duration handling
Message-ID: <avYH8zHb23JUue6C@kernel.org>
References: <20261112163846.97654-1-surenkj@amazon.com>
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
In-Reply-To: <20261112163846.97654-1-surenkj@amazon.com>

On Thu, Nov 12, 2026 at 04:38:38PM +0000, Surendran Kanagaraj wrote:
> Review of v2 [1] asked to redesign how the timeouts and durations are
> handled across TPM families and drivers. This series is my attempt
> at it. Sorry for the slow progress.

No this is great! I mean it is right even if it was in some ways wrong.
I have zero expectations that this would be exactly right at first, but
now we have something more relevant to debate.

And I think this type of paradigm shift towards more architectural
changes makes kernel development much more rewarding also for you as an
author. I don't think anyone loves that much competing with LLMs when
it comes to smaller details and random bugs.

If we don't do this, we'll all become check-and-stamp machines for LLMs.
That would be sad.

A bit more intrusive but at the same time well thought changes make LLM
attention to work for our benefit as these bots help to quickly
stabilize the landed code.

Br, Jarkko
