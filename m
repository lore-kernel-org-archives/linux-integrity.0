Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435008;
	b=bKG1J9TAtYq0hEOQx3aTN54Hs59alw0sp+GEfetSRt+6OvEZerl8aAEP4t9zHul4zjdH
	 fG6E6HlLGIp4LyAbb1JRsqGFZ1r0RbkdwuXPVrV1nLlfgPHfAciE7Ajb5nb8LMRVNNp+9
	 eQAWRVVSorLu72ec9R8JLDFZ/UVwYanH/WPW8AR/k+4yi4oodRZ+m85yDL4gWhWguGVJY
	 ZhKUbrSH7BuhDuil5pbck8L3IymmxIBwrgsi1yx3GAMT+oX/yCrPhif/jukuiKBuQnqbs
	 Io3+djx9xggFa4i6DsXGlztA6RcU29rRwrUWKGwk88XNSxYZfYc6ZUE+zRZ352ehWtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435008;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eGvH8AFTMYKkAES3Ocv5+KwnXAtK17RQGdW3R8thXIE=;
	b=Qtwc8IZqO1lYsvM/uUvAKovo6NBD3eW8/QyrwSHYO3yTT4GOTK5ibwSv1qo9UQD4GLJo
	 rmc0QX/V8F8p9Z5nV2WFs6U8h+k7VjymraI9HGEcnrb27m49rH90OVwZ/zHffV3EPzLXF
	 si5A5vDNR4u0daKO60/ZGsOH2byl8osvzFizIrAEPbeLg3YUqSgTvMM1uX4BAseuCSs6O
	 ulRT+czw7Gnh+BCatb5xFlA/8d8C3xuezraCRwDe5Cjju45v2d1brlzui2wMshtk2A45k
	 17PQIgVWZUHplyi09GXUKsPzSEtBtajlcMJ20OP9PLbXsxgDUtt/yXSa9FKgecKehpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrjG1Q9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3F6F6606A31B;
	Mon, 19 Oct 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrjG1Q9b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3EA5D1F000C4;
	Mon, 19 Oct 2026 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792435007;
	bh=eGvH8AFTMYKkAES3Ocv5+KwnXAtK17RQGdW3R8thXIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SrjG1Q9b/mUXohpv8qhAo8UqSYRye9nF/8AU4GFNYo+WH4JRhK0vFJyPXGnlaQxAU
	 EQ86kyal5BtlZPNHagEwQSoodUtFfkDASoMGHeapxQ5v/fg36Hj0QVy3bfqvhevhn+
	 pDrpQHOxO7JcONsMKgnlHXea6UYaHBr+JCA4NE8ndwvKY7U0VrHEtjsDbtc9Ekbyhq
	 hUKMtHIcy2HBA7W6RuiV0ZkCU/rt86idUn6VHUPoU/hI+FFJCWYmnVtJz/MbhJYw6W
	 Q9Vpec5IlxOikjiQuzMdQ1C79xOMh0os0hAiLiwUdcUJM7e1/Vejg8UM0FvZ7Z4Zfo
	 /JAKJeT0Ne/0w==
Date: Mon, 19 Oct 2026 21:36:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, leitao@debian.org,
	nh-open-source@amazon.com, graf@amazon.de, gunnarku@amazon.com,
	joshlev@amazon.com
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Message-ID: <atZjPERR854RL0Yk@kernel.org>
References: <atLD-d1v1B8ARv7x@kernel.org>
 <20261019182713.57308-1-surenkj@amazon.com>
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
In-Reply-To: <20261019182713.57308-1-surenkj@amazon.com>

On Mon, Oct 19, 2026 at 06:27:13PM +0000, Surendran Kanagaraj wrote:
> On Sat, Oct 17, 2026 at 03:40:25AM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 17, 2026 at 03:31:32AM +0300, Jarkko Sakkinen wrote:
> > > Yeah so this needs a bit more redesign and while it is a possible
> > > way to address all these issues I don't believe it is best possible
> > > way imaginable to do something that lasts long-term.
> > >
> > > I don't want to go into concrete proposals because then I would have
> > > to really engineer the whole change while at it because I would
> > > likely try a number of approaches out. I.e. just a bit more effort
> > > and innovation please.
> >
> > I can give this:
> >
> > 1. Map the whole flow how we fluctuate values of durations.
> > 2. Think that if you were starting from zero how would you design a
> >    unified and coherent flow. This includes all the callbacks and both TPM
> >    1.x and TPM 2.0.
> > 3. Redo the flow based on that premise.
> >
> > I.e., break more things with consideration and if it goes over the
> > top then we attenuate the changes where needed.
> 
> Thanks for the pointers Jarkko. Will work out a design and send a
> proposal.

Yeah, this is also a theme, as generally the tone of kernel development
has changed to be slightly more intrusive than before in the sense that
addressing architectural issue is often better strategy than doing
minimal effort as per code changes.

This is because it is the way we actually decrease the LLM bug fix
activity. Implementation mistakes caused by the more bullish approach
has factors lower price tag, if it can affect the rate and density
of LLM storms.

This is why e.g., I've put out a patch set that departs assoc_array
from kernel, and replaces it with rhashtable. This way we destroy
nests instead of mosquitos.

> 
> Surendran

Br, Jarkko
