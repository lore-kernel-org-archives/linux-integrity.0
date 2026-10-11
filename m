Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493F1E0DD8;
	Sun, 11 Oct 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711029; cv=none; b=fR75r1Bfy9D8OxRCQDVfBGqn5sUkC4XhfQCZ57tu7X8zAyHU+XFkIYO1SUlyVKFX+voumwtHg+OvkTz2sxRTLU5UPHCE7NTKLJYESMaIbAVlmEQiGntuSsnyga8VdcWJPiLZakh6e4SBi2ER9GrMMtYoKtGr021rKfgpEj2vxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711029; c=relaxed/simple;
	bh=hSpAMAz6L66EbSt4QATCBtWKU6hlfSpYqtv2qGsi13A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IgB3XUI/3OHxUwMNstaQCuZTgsNpYFpBaGtGNJE08UU1dso+0gJ2XoBGSg5iuVvgbuWpD4XNUu5s5ZPMTEVD2jfeDkBHhWuOOj3qRzjW7pRYkh8SmCkVbYTsbDRA87444uFZkriwErlFzaKC81Ip45GhCXhmcSttb0khmAl+QOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=e7kuzT22; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="e7kuzT22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791711025; x=1792315825; i=markus.elfring@web.de;
	bh=2Tr2pAfI9CT6tJlmMA+Oy/YVrov/x/vP1QVyrXDF0is=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e7kuzT22COUT8Ps1E/lNtMJDVCGuLMpdKie4HHkUAdYCgd+OvcHP4BzBua/4Txa8
	 5AAnQIaNgSIFkt4Exg+wx4EMxuwdZoBdDFcaMABaY+ufZG3p+MW85UcG/DOXxuCod
	 jQFk+7aPi9w0Ng+0Ry72klYeYZbpqZAMkPgH85O6CrV11HZYUO4z8KLIFiKKpUKiA
	 uAY8V5eXeTYR6kcISMSzXukzhA/jClxqPhhhqF00H6goObnN1C83MxPqvjExHoWTj
	 TCx+5ILXeoqLho9v+Av6PpUDreqiXMJiWWW7oYfW6R3L7QnfXHKE2yhMRlOiHqKYS
	 Ze+J8B1L3Gz+YNh5tQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1xRP830yUA-00Gdgi; Sun, 11
 Oct 2026 11:30:25 +0200
Message-ID: <74850205-dba2-4a97-951d-cda28be129c9@web.de>
Date: Sun, 11 Oct 2026 11:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <error27@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
 =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ar_DUjuGv-9vPzga@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1/f6U7KPfin9Z6fIf39ittEO/iO2JNFHDt4XdqOPyjsV+NBXrVv
 3EnjtmTJm9M6Nqj3q4lsRdE+8TyigHE7UidAUOlF7mhpE1RH/V1GrO8CMhB8gSpCJlLL4YT
 /0Igji9JSVxH43wgErUin035WUMx9ACrase3Sx59ipKm4d9OBqoZzL1CZnutF/ZRJynjXqW
 PM4cQydKn4Qb383rwSj2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HNNmcHyfClk=;Le9U5dA32zi6C+mfFjwrDmYle1a
 +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

> The bind_evtchn_to_irqhandler() function can never return 0.
=E2=80=A6

I suggest to reconsider information once more also according to the probab=
ility
of return values from such a function.
https://elixir.bootlin.com/linux/v7.3-rc6/source/drivers/xen/events/events=
_base.c#L1453-L1461

bind_evtchn_to_irqhandler_chip()
https://elixir.bootlin.com/linux/v7.3-rc6/source/drivers/xen/events/events=
_base.c#L1432-L1451


=E2=80=A6
> ---
> From static analysis.  Untested.
>=20
>  drivers/char/tpm/xen-tpmfront.c | 2 +-
=E2=80=A6

Would you be looking for further collateral evolution?
https://elixir.bootlin.com/linux/v7.3-rc6/source/drivers/char/tpm/xen-tpmf=
ront.c#L267-L272

Regards,
Markus
