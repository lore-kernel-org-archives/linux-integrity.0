Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D8376A0A;
	Mon, 12 Oct 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811846; cv=none; b=Ys5g6mTXyLt+T+mWeuw4BwVybhsnVlhbkbQ3Uzgsw1Ydd755FGvmtcpTP4KjNRK6dmlYGgiupRtoTeCSJsfTWD/zFGPZxDh/hr1+Zj6CUOINtnCBy0+Qb91ZuXAMJTvcGzrhuF8xygfWG7uyggDDuyNKjhFP/qQHFlhY117wzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811846; c=relaxed/simple;
	bh=0CsFDcUl4vUEFJpyVzc5ee3/iblxrL0In9kxzYcwb2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKoflQ79QVbeeVcfE8YhgjnsuYg5LploCxbWYfmtysKaCQABXGY7qba1tdWQmnyKqPifLH8fl0uaY+/SsTxFNPrppHG6j7dETk+dmPFN5HDBsxI0qLbmPxMQtmIhaHBybjmuSFlWDLbPk9npMJJOxTvzGw8GETkARkUV7umE9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CwSa/OT0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CwSa/OT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791811842; x=1792416642; i=markus.elfring@web.de;
	bh=Wb5Anf8gbinUhDA2K5S1xrd4hP/lWo4ijB/0mZl2mTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CwSa/OT0vHqQJ2HmcZiLqaa0qoFo5BtQ2PniNuoBjUjVddo7XPCY1rTZcw9AWbDu
	 iG2+PGo+xLeNOxVznZHZtmGlKW8lgQs2z6RBoDOqyEBcN6yi6ehTdvfKpa0jPopE3
	 7iV6pLOEKC2SpKABThS3v6aY1xdDKjTBrNRYjjSn8QPuGlmeDaUbqGP89SDspTnWn
	 gk34QmkUPNPi+SF/Soc+jZVHOyWXIP+cZhbZYNGjN7dDwioH8fBoYHuoJqtSXVtWn
	 vBKtcFYu1EkrPDTjexr7pLaXvuv6cLvwHMtNW0Ra2HLj1SbNLtXE3g4OXxrBXzWA6
	 uoGPKAmGdmLTalQuwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpL4-1wsT1s0T9O-00ivMH; Mon, 12
 Oct 2026 15:30:42 +0200
Message-ID: <35f555b9-8e7a-4fec-a4db-2a98ef760bc5@web.de>
Date: Mon, 12 Oct 2026 15:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm: clean up error checking in setup_ring()
To: Jarkko Sakkinen <jarkko@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-integrity@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
 <74850205-dba2-4a97-951d-cda28be129c9@web.de> <asvSXjQQ0vEvF7yL@kernel.org>
 <0d6f94f0-208d-4cf8-a973-2afd37695690@web.de> <aszb7oOYq-ZfeNDK@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aszb7oOYq-ZfeNDK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+997D96u5NRsV8nadJbLWAzCNUyseynoYBrCHsAtZuvfOipi94
 MvJwDejxkVppai68sv0NVY7ahAZLxL9mn933rz9cdCbE3AuaT13AqBhgtZ958IH/L2oB8HU
 i+m3W0EjipmRxvdlTUppzfPoz7kna+N2ka1VdIwz1CJM2iW5bEoFfbuxEYIxShJiQmt5AaT
 xk5Uz6T3qCb3J9d15nCTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W3e5mFgI3KM=;oOQWPBEBZLgiRfo+z/WPxsgvRLo
 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

=E2=80=A6
>> Dan Carpenter provided also some hints.
>=20
> There's no problem with this. I sanity checked the commit because I
> did not (and do not) understand what you wrote,

Is there a need to clarify remaining communication difficulties any furthe=
r?


>                                                 and started to
> check up on things because of that email.=E2=80=A6

Thanks.

Regards,
Markus
