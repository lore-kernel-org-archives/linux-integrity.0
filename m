Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBB3AA9C4;
	Fri, 18 Sep 2026 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710580; cv=none; b=oYVdBjfX0H1+LHRN/nqjktXYTEUwocmJKVv3DO/2kCYrdQkXNmH6iSvlfkr9LuP5c6AF2G1UnzeSFD3sssYqbnyXFdArKL3qg+9kwmt/nBUKf8admh7qXfOb5O7F0E30vuNY3G+BHHUtcfvL7n7XhrXSefUwvlTaKE1Z4XhBs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710580; c=relaxed/simple;
	bh=YaQHxm8cmSBCUVC41rDmDKjuiSG50qsunFu5Pa4P2u0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H4IG43U3D7u/jHbCznPxQe0eKKtVPm0Z4EGemLwm+PGUpNmytR5WN6uncqbcaR0Aska+euQKXfMKKewA8UQyEwSrcLPtbbzxxbWBoeCuiWAbxgDqoY6VuQyUyexAswj/XkQlNwPGZv5UT0cZ7uyIUQP4DuFu1ZskyjmB/WVWLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AXEgWf/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JG/fAVZH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AXEgWf/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JG/fAVZH"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E5ADEC013A;
	Fri, 18 Sep 2026 01:49:37 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 01:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789710577;
	 x=1789796977; bh=5q2MC6Tjcli2eHScQ7hLWa0QMm4HradUohaTFLpFiBM=; b=
	AXEgWf/7hL1ZlOaMR6tqHwktR/9MjX6FJeAE9ZiiUqIRsK5ANCOlFzbZiZaoe2wL
	57fgi9eSyslPrHeEI6+2oAFvVVEKkAY+ppcU435894VEDFES21pscrtBodtKsy18
	x+WQRdg/av7RQ27HE9SBAVuXjZHVEtuuCFq7D1T8WBMqRJIKiuT5NrrYsHvJ5V0+
	6kiAHtA2kAu3UFaIz/gu6uiZCQg4McF5XsD98t4mAwr8tmDvL9e26eGhGkC11dnw
	TzGhV2rTnZSYvW0reV/6BgXp/5vYRf86IORii+iIdZhtC8bSIQxrKxQ09xWOrj+a
	9D67LO3KAUVTtUHCkVuUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789710577; x=
	1789796977; bh=5q2MC6Tjcli2eHScQ7hLWa0QMm4HradUohaTFLpFiBM=; b=J
	G/fAVZH2OZG+T32rYUntDZzkVDC6s2HhwaK22fXK85CvB5+MMHGmaTV+UKJv7p8x
	VEJbTx4kiQ4dFxVokw7ojutIbQYRcCvw00Ex16dt6Gfr+rkZA2P/H+gCIk/ZS/My
	p81Jv3V2cDrIOJ31gPPnc9AEwuN2hmjYf62HSzDcTe5nTv5mBjH4NDZORmhrYwL+
	pV0Y/zkx4vT+FFDeclUJgSfzv7Y/h//V9RRmRT+JUfna1Qx2Y9wjN9wNyPZPovlf
	fm60WUjWCNVikTq04VAhGrve4AVqiczCna5o4AZPp5/iRBf2+4Uz8E1ZoaDEpwht
	IUg34m8TDXjth0Yjy73kQ==
X-ME-Sender: <xms:7dCsalyGhMRsPFNmODnQTNtmQt9FVk7u7NrcYajn2gZoFCHCqItdFA>
    <xme:7dCsagGxgj26GG2VEDLsaeHCyRon4UCOJgyqgr_3qVPiwvlTWX0YLivrjVVrdpZr4
    auiyKMMbLMPu-ZO9mbh86yEqI7ZaIQ-qB6Z10G5X4c5rX01d9vvHnRS>
X-ME-Proxy-Cause: dmFkZTGW0wc6PgWet1E4H5O4izJyMhxJtaKMf4Au0KfPI/3TWUwDpZ4E3n1ev/qvkiXNCl
    /baWVFPaQHkhuIe2P0NSgEz/xNHDh4d6/nKxFfLKskXnaGW9WRAMt6JzlHLlD+0E/2A5rS
    qJTx6G6TMxWdxUItsxf6OMIq61z8qOU2IvNYKA+ndrM9OGTMG4u3VleF8vAt7ACSInZxNX
    f8NrWysoPTPRJBEVyjfyiX+nKx9khGWcqXAvOCsYAAqeLNwOuJRbkCYPbNV6/pIE4YhvTA
    Amk+tYTmlWhKr2Sr8paIOC6DxiG4o2BE4tGNOAMMZvOGDVOG3e96FbmYmaHQ7zggukE7Fo
    JDF0t3E8POzN8ubzvuQree3eit9STLIFkVB9GlQaU6SiVKaAKvALvQ4Ksyn57G0v56QSxL
    jgoRVv/5RJn0f2J/HED4XQX/AmduT6YCHboQ9ebhqmC7pzzD/ta/XdER7P+Xn0Er88/2ga
    k6NSQvuZweFcF69pT5fCk9YTfuQoMhalnjbc+UPZSe5YUa/CiV8Ipg3IbzVB5KyNpq77E9
    k0zYZxlMp3oXuOZilO+tpjo5zP57iVXV+/Q99JcuGyusSXerG7mvPk8jMwFINiJSsVKKIJ
    3ykiZUgHxQfBnLiFDzGju+6Ps/E5frLfZMYPpZE80h8gH6SOFE14g2jghluw
X-ME-Proxy: <xmx:7tCsarZ1KAZCrFlkCTIEHckPBGt0d9f0U0lkTDAIpPVg7_Px4uIpug>
    <xmx:7tCsakcCEaMGtRgfbRqTManHLhLtI7yE1Ig5XTUdw0QRnsxeX8Yn6g>
    <xmx:7tCsat0dmNXKJyY696vBV_qrQnZ-97MfqVuRGsYgAX0tawMv-jGgWA>
    <xmx:7tCsajJAvlgVBoDZ9Oywzy3B1-9gQnhXt3IZvEXJchAYKJxUS4UWig>
    <xmx:8dCsasIziXHCWOuRe0BHN8NgJyW-w2cq2tyk8UlePMf0dukHAGJ5XpgQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0BB5232A0084; Fri, 18 Sep 2026 01:49:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aic8pPqpfZwN
Date: Fri, 18 Sep 2026 07:49:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Li Jun" <lijun01@kylinos.cn>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <02f47743-49e0-454f-839d-1d6c41ba5165@app.fastmail.com>
In-Reply-To: <aqyNgA5NdSTdrP_6@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org> <aqyNgA5NdSTdrP_6@kernel.org>
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2026, at 03:01, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 03:58:11AM +0300, Jarkko Sakkinen wrote:

> I pushed this to for-next-tpm, which mirrors to linux-next.
>
> However, since this is -next only bug, I guess I should squash these to
> the original commit?

Yes, please do, it's just a drive-by patch, which I find easier
to do than reporting it as a bug.

No need for Co-authored-by here either.

    Arnd
