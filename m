Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE546C825
	for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710277; cv=none; b=rd+YzFQWhP4eYV3L8GL9JR+EyLdet2lA1u0F/Nh7ihrq3V1SPKs3ZAFOGzj/V8FxiEfJYxoBYDz5YZVgNyIECbU/Y/EFuqPwn0roN854D+bv7js3QHVmAXRgUOestApn8Kl8PZ+FFY6dLXtIDLCnaaEUsibPzMNkC03+4FC3dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710277; c=relaxed/simple;
	bh=rCv6s6H6j29TvkAkp/AsAzYsZj8a1EHgr/XGLtqd+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOMafYPT2i4jNyCDVOPxyf0bEwGzzMzbuH+pmwtxjirVcy9W18oD0Q11dJ9S7luKSAb6I23xiiNYeu3I+WQjoupCKZAGKPOJAcoVcGYQFkGWCRoO/0OdvW8OhA3GXk/S/+2IHh6x4H2aodQgKA4dojK8TgFJ6+yBe+XvP3EcKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pADFO+VS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pADFO+VS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so1361635e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789710273; x=1790315073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCv6s6H6j29TvkAkp/AsAzYsZj8a1EHgr/XGLtqd+eM=;
        b=pADFO+VSrDD+enyIw6/7dNub7l/OWodGCD9OrW4fyoVgUGVwh50ugGZ0oRlqdc7wu/
         zqY+/nmXZqJHo84Xpnq9tlM410llWSpQmw5ggceHRIJRXwkWxUsGlBHk/uBS5YTdJHKj
         i31Dz60o4VEXDBgFMclIcfUUi8bXbSDijxqxjwTH22qoYWJz5v/9yIyH/nwa5GmdJdkb
         zC7LyCMluqrJpkRY9CjgTtEbSmHthCDtThLguKqeZY4fLR95crrnWbs0qprAodqi8CuS
         DZhOkMGbJeeN6J7HuUHui10KeeEw8YkK/L6h5tsKjTvONLOV4fAbVklaF+RQBpWjjRev
         6h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789710273; x=1790315073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCv6s6H6j29TvkAkp/AsAzYsZj8a1EHgr/XGLtqd+eM=;
        b=iPOB59eH4Jdg6xlY1w74vWMyimDdCe+B0oI5bbfwp3lbSdM0XGvhxPDGwYe1GpV4XF
         U9ApGHp7xhgS0yWhzUO+azPFRbQD055p+SP/7aLiyk3MIVZF2ePfTsU9tHLp4i6Umnyq
         giiV0nlt6KRa96ZySKhp//4jfTbDegCjEHu0Ty4F0yuBF7WFPiJxWM2Ng+r7iyFCXMDq
         YRwHU5r5qwXQnXRVLZ0yx9dqpti3RsKzB2YyxMRtrUnfbDdazxfqOfNbmpAhpIbjRZhs
         ue/LuCR66MgW5jIJyBqNd6/YDDtNpMyOggkOdkTeDoglQP22iBKMRR/3Gw73FNIUCq7v
         gPAA==
X-Forwarded-Encrypted: i=1; AKwUvBzwysguruRrCKIQB4y/22awkFIrO6Sjxm4Pggj8M7lsgWkGroqnulWjNKAMYrY5+httxgprTZrryoF2rEkfAfY=@vger.kernel.org
X-Gm-Message-State: AFuF++ktVdI2J6Mbji4p6Nevxm+FKAnNNEifPX5B+VEIJ/c0qyqYyYUl
	xf9UM2GaPqAi6Br9k5ooPDupBM/CNFLP4t3+jf+K3iP5X9jRxE9OA2HuugSM2RUStWgBlFq6/dD
	QpocO
X-Gm-Gg: AYBFou3Df3coS0seRJHY1Maz30vGHnKUg52E1316mjBOthqWsdYgWWKdTVDg66nLYAQ
	I9gvfc+PRINQ/Uwpj7RDnbuPfdmZzgnhChm/94/LT+GGr7z7vEVv7dAHpmJjooOfih3wFQ2PydG
	+uwm5nvtvXppcFLJ6RztwzJo7kQ1jdZECl+lVgax8LFzNY5GZCg1d9QaVJTon6Z9gJZH9Pp+0ss
	pjuAp2ZS6OiGV/JJVKM74KUJ99/PbJxHlTbKSoe9KTHZdLJkfLCrwvJa0xZF8pxbFS3q6wCi5v/
	/kJRTKTspBAsHs5EEQRtdT2x6+WFvLFC+GggkBzg9PYtyOf6oav4pxKf2MKi7onN7ZjeEqyQXYl
	izSwu/uk+9mGyFa9Gxu8Ht5LdPeP6LWKj1pzTWfwFeYmYpIR7p6oNoARVbRoXK8OjkUA9Sg4h8u
	LT+Itl/rDH+6YwzdL4OPoQv45CdXvgfnS4jHkha7JVffIuJEj/jz3hjaJ5wqCjdvEreChP0qKu3
	GrFd/cCdr+Uww==
X-Received: by 2002:a05:600c:46c5:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fc573e80fmr23829995e9.15.1789710272498;
        Thu, 17 Sep 2026 22:44:32 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fc7cebae2sm21277355e9.8.2026.09.17.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:44:31 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:44:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, 
	Li Jun <lijun01@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <aqzOnj9-35h3gAPD@monoceros>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org>
 <aqyNgA5NdSTdrP_6@kernel.org>
 <aqyOUgIa4lsUwO0I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fx6n3tb2n2barde5"
Content-Disposition: inline
In-Reply-To: <aqyOUgIa4lsUwO0I@kernel.org>


--fx6n3tb2n2barde5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
MIME-Version: 1.0

Hello Jarkko,

On Fri, Sep 18, 2026 at 04:05:22AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 04:01:57AM +0300, Jarkko Sakkinen wrote:
> > I pushed this to for-next-tpm, which mirrors to linux-next.

I don't spot it in

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git for-=
next-tpm

, do I look at the wrong tree?

> > However, since this is -next only bug, I guess I should squash these to
> > the original commit?
> >=20
> > Just sanity checking before taking action :-)
>=20
> My suggestion would be to amend Co-authored-by to the original commit
> message as two bug fixes is significant amount of effort to make the
> change right.

I don't care much about my Tested-by: tag, so feel free to drop it.
Promoting that to a Tested-by: on the squashed commit is wrong for sure.

Best regards
Uwe

--fx6n3tb2n2barde5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqsz7sACgkQj4D7WH0S
/k6LYggAqj4Q4ZuiEmUBIkUhtlL31ErLVXbu4uyQVdW76MnLeYBtJPk1nZJvDeTg
onhM1jLxNxV0qwkOUtYAe3c1OiBt3WfZtyhM7rolIXanvUybk93QwFjHHqh5o9YU
f3AfFHu/AeqX8rNkfaYPDbKGz2cJdMZVIcy5o7m84yJf+kkJX6MBmIob0Iatv3wq
X3ezfmelhtHkTGamLnGqPgGe/lMjiRC5ypWE5NLzWWMu6G7+QLDZ2GUcrcE/Dh3X
sjZDQQwT30fmEew5EEu1LH4BjWueuO1vocKSVIltR8VBc6y20ztkLO6jOBU0m0aH
nOAJlOqZ00N/DHGkoDpy85lXtbitrQ==
=ikNW
-----END PGP SIGNATURE-----

--fx6n3tb2n2barde5--
