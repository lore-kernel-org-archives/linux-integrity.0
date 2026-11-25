Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642417;
	b=3pB2NQ3rRXuYvgJUFbRMR70IwcmO2cl71eZS9bk+ZFUu5Uj05bMIzdvskXhiKSPylljC
	 joQhMXZvy+02Cy1+HpWaNCtwG6pMq0wZlz6uOLnv8hdVR/XTUpx+2dHY0vNIz4K/gBsOm
	 v2Z4jL5zNhrOomyWDf/Mfb2sc2gVNXXCtnk4evD/2E25PO4tH8RU/NeYUmnx70a0qY4Bu
	 O4/GrK3HflOUVOyAaIvF7+hVyjCyg/XYRgCeClw4PapFqWzoM98+7ZNgCKYgYG0WXZLcA
	 vIGQ+WYWQlAEcM4XXXnslwCAezRBtKUh0GufORnbi+nYO1aUpCQ5sTGIYWLigsIyAKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
	b=01nibI8A/I73pxc6RQq3s/wswJKfvOeJQKvU1eTfdc4lkTBPM0Z4GB4Byb+naYbRODpJ
	 od22xdTXERA/J3LwWe9soZrQfgO5oojWHYRi/cRwk18kB86IyovpL/hY98vH88PNmkUYN
	 HlkKdGZF5grqz/RfQGq9kB/QehWSuFxf9Zk/tdVfzBQLzbGI3wXKAplIPmkm2PlG+dszk
	 kAyhoV7AbSHe6SpSu73cW7ZEJhVQ5nyYqotAWzqga34pDK+Iod+19WhpBIDSf/K24BFFA
	 N4JHZKIwASuvGEC9zcc+fq7h6DDxLfL6cjImoPXsmXF0qJORk4arAOTSQ4gtmR4ULKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546B606A327
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 21:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4546B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49412eb1474so4084830f8f.3
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642416; x=1796247216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=LyaNhQwkXbqpnZKQEFhSkXYdJnRuGKBuuLo4jMsASztOhDAKo/KLjtuUsGuJcBlEXa
         L9q5KsH0RDu7VhTtDI/7sQNdeUHKbiCE4UoTYbpDjatBwUbHY0aghBKcJ1jAy3etEkOB
         SRACMXZz5iIdXEUmV0YEGNUmGpDA+sNgu6gEYF9DmXC8KGwmX9bCsi/CJOLNgO+wTbbG
         lhvnHY38xO9YEx6YYjl+XslYqIdorjHMYTu7z3o6izDZiq+V8t7zvkDvaFfxCYiKSkSe
         OIEvBBzRuYo1TczJtkPUnW8+3ij30yPkrtXbZqfgQ434wojlx8AeDgewp82b/5hogoP1
         RBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642416; x=1796247216;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=zhkRpJsdga3/o7rNLgSblBri6RULpzu00Q6Ye/eo6wbV/lbqjEQMgNPeI7n4GuYKLY
         lfUyfYFvu4kldmGArYQnLNqymF3XMozsZcLyP5YkPGSYdHp5iJjysZu9FEHi9tSZv6vo
         UKvpZZddQvSWoqeiIojUyAj82N77H+YdUIBbMpI7QUGdYqVfI0FPizGktDHJrw5qoyOh
         Q7GsOmtNyRDzdy/C8xW45ebfrsgOm1nDlHlZzvZ7yF3rXKDlyxk1B4g1hgMWLHqJ3oeO
         AL++Xeln3ZEuu4p1VXbOvINGpP+AK9g3tEWAlj4ryfDy8pOsXhXEgbQMKc0e7lSN354M
         aXRg==
X-Forwarded-Encrypted: i=1; AL+hErGQaUty3phvJw0ctH1S2sPVOiaD2G5ORUsdLehNK97mVyj6ZWsjYNoFj0qo9V6hWxTOpBSAZHVAY5UyaqAlBnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9y0n4Z4VWiIP+8fvJJPKb8UCT/DP8hHIhx+NzxoLkADYxCzVHk
	ImW1l/8ukPnXnZNdjKetVphz9Zfci/EX7RLS/uyiA5Lgn5mom+CDhwbE
X-Gm-Gg: AZFdTZfmS437/z7Ux2R9ubS1mbqxr7rrwKDDH4y23HNa3fZ6SJfE98sDb0uktBZZHvR
	NO92qynePX2zTzf/1dSLGBenu4Ws8+UlWnmT4vOgK373/+gr9r8K1ejr7QfNcypBUPAPsAaB8B6
	gysSC1oLlMDCU2Chndw7jv3KEAzYXhELmmTcjLJJrzusksuGIvKiIpavp2oK/3na776cYvwQ1Qf
	+h7v/cxX6ILlYAo85oR/SOOA0ThEuw6Gip7kD+ED4IyuZ07w7674NISZ7mgP3ZviQArGmYoO35T
	qOP87GOKI82zWjfi1K2qMK+lItibiLUR9crVRJTRtc3XdWSpX5ftLeWLbIO6rL7aSbDcBmgECx9
	OF+PY2cZ3mlYb3/UCqcvsC7mAVSNOTjoG/0IXeotpqkt5EZ4ukeAacEIw/ZWXVXXZsvyptmfL4J
	s6Sq6UV5wGjt105xFgttMHBie3BirGHRJZ587uN5oBV4KIgOLbTdFV1tGpFs1MOWZx09LEn1gOg
	qjihGOeV2sAVBtJU59ok5dEINtJ5WsPArHkOpPCq9VX8LMYM3CjSj7ozuD/b1JMqbyvTcZVKRpO
	Wny5b7Y8I4aRjo51t1gAuj9WtiyqohaohD85rpqTuwFcSscRGH3s/ewEj1tNbhiY9g==
X-Received: by 2002:a05:6000:4a0e:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4abb7787c05mr35815085f8f.50.1795642415460;
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680355sm30439805f8f.27.2026.11.25.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Date: Wed, 25 Nov 2026 21:33:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Alasdair Kergon <agk@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Benjamin Marzinski <bmarzins@redhat.com>,
 David Gstir <david@sigma-star.at>, David Howells <dhowells@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, David Woodhouse
 <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, Ignat
 Korchagin <ignat@linux.win>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, James Morris <jmorris@namei.org>,
 James Prestwood <prestwoj@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>, Peter Huewe
 <peterhuewe@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 2/9] lib/asn1_encoder: Add
 asn1_encode_integer_bytes()
Message-ID: <20261125213333.23eedef1@pumpkin>
In-Reply-To: <awcBD-bp27JCVpc-@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-3-jarkko@kernel.org>
	<20261125091921.4bf40279@pumpkin>
	<awcBD-bp27JCVpc-@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 17:38:55 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:19:21AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:36 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > Add a helper encoding a positive integer from a byte array in big-endian
> > > format.  
> > 
> > Interesting...
> > You allow for integer values longer than 127 bytes but don't allow for the
> > much more common likelyhood of the encoding being 'implicit'.  
> 
> This is the first thing I wrote in 2024 and have not touched since
> without further feedback :-)

I wrote an ASN.1 encoder/decoder for a tcap library a few years back.
Pretty much everything was implicit and some of the tags exceed 5 bits.
About the only things that needed multi-byte lengths were constructed.
Oh - and you can't fit in a maximal length SMS if you use the indefinite
length for constructed items between 128 and 255 bytes, you have to use
the two-byte encoding.

There were a few functions for 'add item to buffer', but I didn't need
this one.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

