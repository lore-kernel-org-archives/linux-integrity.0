Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB627FD74;
	Mon, 12 Oct 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792211; cv=none; b=rlO0BrT6ow7bqP2Cr2G0JQw/jgxR6PsmTSSRZ9df7buQvb/DeETVp3j25l7nzU7VwUvdXz7tujnYc1SmOlO5GBM3njNvqqrg7xrlyOr02Yr0Ve2WQzttrNDb/VeNSZRgeC2zT4j8Th+SAhfgh3SVZsJayZBdbiBhlYf8Jqxm3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792211; c=relaxed/simple;
	bh=fuAXtCYQzy2hD65zaTobxl4mwnKhXhEmGzM+A6Ui/v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMw3bKVoJ+N37RnwL+43rgMFjZkylWggZFrY3hmbVq8v6JYqv266YVR4C0na7ZeXfA/cCuPum4WwfCakkk87A3bY0+ui3hMW8RYOWwYyub6eGdZKGZmPWC+B9Bjd3S4Cdl5ThomWfn8DPF/n3sBQyqowFXjKM3bySP5sHLYPLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cj2hQ7IO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cj2hQ7IO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791792201; x=1792397001; i=markus.elfring@web.de;
	bh=tzGbd7CYNfL6dO6az24ySnuJdpyQDAxsT3R9jUgvnWA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Cj2hQ7IO2ody3yYYJpwG3Oez1Yl+hw1SaIxhgMTL/9uQButHU9BovD0+pJoSyAHm
	 JN4L8fRwZEEQCQr57utoBtH8yHhNeTec+7aOkoQ5EI1IN0DtbnHBXqpjHyaSGGx9u
	 MY7OXq72wxjj1oij16Gdaw6HbfucLdjxskRZrVzYXomFicfORA8asqwoyGnPzQpLK
	 uyZd3CWKmo85WCDWhsM9d7kC458OK0s0arq1cCGBDlnTZKgLGzzyDWtUWw1HYTWMD
	 cylntrXEif7iniH35zasZBEHE1gtgCMtn5Hca+qrIVFARaf97+qhe0RLFFBvZt4pP
	 Hk6oGVsy4uwNCJYtvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1xMXjS0n9z-00CPMK; Mon, 12
 Oct 2026 10:03:21 +0200
Message-ID: <0d6f94f0-208d-4cf8-a973-2afd37695690@web.de>
Date: Mon, 12 Oct 2026 10:03:09 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
To: Jarkko Sakkinen <jarkko@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-integrity@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
 <74850205-dba2-4a97-951d-cda28be129c9@web.de> <asvSXjQQ0vEvF7yL@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <asvSXjQQ0vEvF7yL@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDP8VoV+xA4WDzX04s2ZXqY35UAGPVQyfX0zuzfA/Vft3KeAV9m
 XcqlTuzS5PaPj6nzwlfJtQYlt5Kjhqh7bz/it1B+TYyZIMzCECm/J8e2yvhXyKLV7Eh4ewa
 uZv7NFG/HKY8uBjAqTK9kcdA92ujiebgiTmbAp/BpMHGO7xFT7HgJ327q6fCZhW9H7kYEbh
 cOlaWgc8GgS8nvAcBAjtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uXQUxa1tHjw=;StNWkKJmRy9QmW+EWNwXeqoQMdL
 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
 qsLYVceNhvmDQCFlvMDtU+GLGgYZZyaxHUg==

>>> The bind_evtchn_to_irqhandler() function can never return 0.
=E2=80=A6
> I do agree that something in this patch does not appear right, or=20
> at least not very well explained so it is a good catch anyhow.
>=20
> My decision on this is that:
>=20
> 1. I'll drop the current patch as it actually does not make a case
>    why zero could not possibly happen. I spent 45 minutes browsing
>    because commit message did not have any technical details.=E2=80=A6

How does this response fit to your previous tag =E2=80=9CReviewed-by=E2=80=
=9D?

Dan Carpenter provided also some hints.

Regards,
Markus
