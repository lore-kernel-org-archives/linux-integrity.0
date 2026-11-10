Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308443;
	b=hjLqdZibiiFBc5blIcG6O3rrkgH5k37eW9ZNZbfD8biNpKd8tO22T8qNRpFOrbjEDA+/
	 fsA50xlAECM+oI/6tpVY1SY8AsY4iTzrrSidV2F6aTJnooVlDvvxLCirTeWfSEIYG1Rtx
	 CyWmB2Errls1d5gIKvVblZ+SDNgdUAEeIAwICT9l18a4DvmEvKxi/rw8pUUzU7swKBylb
	 Si2hjKxzNnxQxY3jgFJmtCeJv439MbM8jshk1AbqfKaPEbpxJ5jQLaNXYLkdOsMRvzXF9
	 6pOAAVbe6sD/XZO9IexnycpwpBEuXGZrLqQ8xd2mk3AiZwxIhVJB5dgz0Tp89Z8nOGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
	b=43laj11GxrUbK5w4ZwIPU8LJctK3ciHJhXhvnFr/HD8rcTjWjRAEwmx6S1HRJjEhZ//x
	 SFUax1NcB1M9MfAGwz1U/IuvFzCtC7PttOIEMFFcomLBNQBLjRBEBzeU+cK2Nm9ao/H+X
	 iRL3IdlrMXkYVPZVi4Pzb8704wU6hD0YYEoMepqQQ0Xi7giuXqPOhHxy2ZnOewYnGwFUm
	 UyqCZtLjTq+MzB79Ouzvw6Fn7WYyDXN40ndsO/rEzp2i3C/AniF9eM4YlHZ/n60lx4WUJ
	 GL33O5Ep6ehCCJ/Nw64egMapry6SuufQqvOdQaOEXVvXmJc9P2tSEBDWK1v361aYFJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BC60A383A
	for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A98BC60A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso12752015e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308441; x=1794913241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=UR+oRQENsNTyw3m8WPRxHakPMD/6M89G2GAH08z8luOgAuTYMwATMm40YkQjUmifrM
         0I0lYgItJ8iRTCd2Zi7HSPoiCb9Jfm897ztEJX6ly4PAjZK66S7FQpnPTnp4WfOgil71
         sS6EAeBEnAQXtYBXug/wf3vqUhZlNR/waxaiX4Vbpj2853UP0Pj/t+2kEPD3uzJ4Z75N
         Vj9xgTWOoMaDcdSmCpYtZWf8y5aFClQ9S7OCYqvtOzp0DKEA6vOIZHfTzdUKMwoECdwy
         qdoejJJ5aBD9AYCkstvgOzgJOwMHKNFwgSF/h1BLTJc5BS5UWlvnbo/XPoCHV9iRnUUh
         itTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308441; x=1794913241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=uQKWWgdrZ/FyI0XwYLpJBx+MMQafHkiLoXi8sADNhoE39zRn+AIcGDWW+erZ1S6hGr
         ouecnMuX4fxzK2cIf8FZN9HikiC6w6J9VCTgu8l1PM6Df7MY3mOb1pYxx3OohrXfF8xQ
         Y2WUwjS7VmZfqH5re66U0z9QovI1RcB2I4JZ4Bt7pyUOlJfHswn6Y2eP0K2bjB+/BDEN
         Iq+ZtZmfs0/02kh9AFVjn6VO8XB8BQV1RLeWLehYC9E3ixkUCJ73PPv7tR7BBuxosqQM
         BssqJBPqOzstV35g8bQbVSDHKvpa3sfl0oGd8LQ+Aydwju4GbmGrILCAgw/gzpM51LcW
         6Sng==
X-Forwarded-Encrypted: i=1; AL+hErHsDYcN6c7yuw1dpgPqPUGNWF6r/nnC5NXoAm1vUQZ9VhgU/U9+GsOuxiar9GDIOwKsdgLuk34OMRJcN8+CZOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WjnmTP7QFPLblYxldjvRyhBOITkjZY5ZzvpxOzdLXS1B5bPxn
	s1X62W69GM/ftUxAFjyEizGGBHJHig+GhIe2Dk8vTtCIW1RlGFGO0UNI
X-Gm-Gg: AYBFou2zG5q0arVWhDqcxfIyZaWonDvvHx9Dj4qrLUgRHmK+zDz8oxiLbJ0K81d6OSl
	FN/SpxtwHcYRc5NyL6J+eDCQp9XLCKXitXSD8oAArFdLUKHnEXc97Gj7tO0V/UhKbn1EZie8Y9p
	ApZrdkHutgjOxbaWiVyWi+odA42TSkZzYkAvtWF7VfjUo2wVGjNUKAlLQX+C7+CAoEnZn7Q9n7Z
	iWktCdM27Ia1ITRQuk9SculPGBNnLihXWxI3eirdnaTH5/d2Pg8fp05KAPRCl19h+qxKA4Ym2hY
	EdZfu/RRwhz8rV0Bn2uOlokwCYdyCUMgrD7kVJe9tqVtrkZZAjwzBqDWSj0JjTklq41kAmKxlJf
	lVfOABhKvR4waKqG/3RfoYbiFSqDkS1i8QXDfcIXejLt5fdpykztSNg3EmpLZQAtg6gJcxbo0eS
	VJaJSCoiOCpdUNDtzj+0L/2FstMvorIj0LQvbjH6bto3jxQ/ma4zZ2uG9iA3kMVxajtjmFMD7DB
	t/+9qZUPI1ynxasLD88WA6EpDHUUEV8XJLKgC5KB/BFmhVg13Lo5TzG1jm7D3j2jRbjXSBOZCzO
	OTwvbbDDtBVuR5jtbREDNX2xIUTN5jRRzLvgdBh+we+Bbclc/O91Aev9nFdD9K4vlg==
X-Received: by 2002:a05:600c:6387:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4ba02349a18mr35485105e9.20.1794308440720;
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02381916sm25962625e9.3.2026.11.10.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Date: Tue, 10 Nov 2026 11:00:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <20261110110034.0a46b9f7@pumpkin>
In-Reply-To: <avFcjHwnh9mrOEnz@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
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

On Mon, 9 Nov 2026 08:39:24 +0300
Dan Carpenter <error27@gmail.com> wrote:

> In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
> to avoid a conflict.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec676..2d6cc53539c8 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (private->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> +		unsigned char boolean[3], *w = boolean;
>  		/* tag 0 is emptyAuth */
> -		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> +		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
>  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>  			return PTR_ERR(w);

Hmmm... how can that fail?
bool[] is just "\1\1\1".
I bet asn1_encode_bool() isn't inlined - where the compiler would optimise
most of it away.

It is a horrid variable name, asn1_bool_true[] would be better.

David 

>  
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
>  	}
>  
>  	/*

