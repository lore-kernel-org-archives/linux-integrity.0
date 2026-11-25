Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642014;
	b=nz+BkJvVl7biFy9FB5y5o6kTWFv1bIbDE1Z4pIq2Mf+uwej1yvT9ABGu7AYcigUJlWKb
	 u45kqGGUxyiWk7W5A9SG+KPNAsrS2fRvSps4mxWy8xAjVre6cwjJdOs0QfLWRKe3j0Hn0
	 VJRWgpYjj7/Mk82XXT7JwbQhFAGpMyXvQCTQmHorZNFSeWmG6PQrj2OYI62nOHmBLoRc1
	 MgdAX86DofHLHCrFmmj3tYZ2Qa4SJ9Ev8R5P50GdGEAV4ys02W4zCu7WXstw5A6SvwPxB
	 PPXdBu7Ez35o98B/OhT+8Pxb46+JHhQ23r3128pUbg5sNomtAeNz/UwEQm2W7XgxzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
	b=VPCJY20PcOoRjc2kZUxzMZhjnfc36uyT+TT8oEfIXL7t2MKx8L6RQaAammb0buSUAQ72
	 +B4qnyqrfVA7Nfyj50Ue/hgfCdItFWY3MvQ/q9vHzywOYlMuEzfoOGvnS+iCb9OyHXyGX
	 vf7mFyfhV4OVgo8PpNFBdmqenSNEsEPNyumfgqQKMhsM9aTvWk0oxJjxSrQBoTH3mupdF
	 3k41vkKm6yN011Bm+YGmHRxiWeURTPjkq8ElAlp/SCLCZEeWOXP0WizsNwubQkZmPTArz
	 gCm/odiY69Kl0i2yrZsSeUBL46fcQggk8zny0OQprQVNwgJa87tQ7dhjm27/XMjF/RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8E606A334
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 21:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB8E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb61185057so40828255e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642012; x=1796246812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=khbHvIZSswKzRKScFBxEP5dKyjo1fhxkUl/Tm9a7vooLiIEIc3+D/8+f+l2qOQAqqt
         NkhbUqa1fNS3fq7OMj0WJMaJl1khGxmmDggv3i+SWU85FgAdjmbQ2zLZepZPts3zxApM
         +6QfPBplV6uwffDVwMTmMBw7k1e3de0G6FQe/sfuWrH5Ds6lbEvkXQTXgjHFZ3p+bjez
         1kr4qDOVCP9dTt5FKMHZl8AC9yxsqKbDOwSROd6mExDAJeQ3K3/NchHUz2ApoMTPzZeQ
         /uhnbwnb7ArGmTHzNkayy/FGQamuBbJ3FEoi6BqwxfvCMlyHosFKu+w8DEKRCPmU15eV
         1whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642012; x=1796246812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=MQdkVbfI/nXX8h6c5dkMfL71uoaW2VUkNFtHeIVJ10/U8t7kyvtM9oOFqAt1o4t8wj
         oW75A/bZ7g14Io6a6KOUcvUBbiSvnAWfvscXgHCGQ2cR29uVGomcqICkKGl9PFUlYFXu
         2X2X+FT7KriHgxpyZDjvaJQCkqrKQuZiEWlw5LiB83Us9RKDU1uVcln3+kLxk9M0yzrg
         t9EiDKtPzv8rUp21DHMgmRBePAmTy2m6AT6ldSX39QwiLlrkW0tiz8YTnWBVhrGJ/BRO
         jyVL+oqfHZKntOUMawbEI3qRti2pdECtMChByPYSW/jjP0I+Vd/nNq/yVEILjEefRLhW
         SBKw==
X-Forwarded-Encrypted: i=1; AL+hErG0EwmDjUJKNermobl+JPwi/sKDcvxUhrDvMJVvUihNKy6mU1gScjP47cu3l6bH6tL6PLUweznQMdOajOzLPMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/98TdlM4eaWOE5nEpzby7UuOt6QSm7HSTPkNHpZH9/3NU6enTz
	EtoAAEBmZKqHj8+ezGQxLsr0mK5ztWOtfV0DC6e6tTnVUD1DIC2E1QAo
X-Gm-Gg: AZFdTZcUSX8+1bI4FpZF/95isWDAv3AjOhp5KCPMDQitV9oi2REjASeYYAyPFyc8FBx
	zWm9KIYLLEtu9hijeZvXZFhjLTvn1/iEvspc13qt98xxwYCBWpiOLUws7PUuVUAWU0j01isQn9J
	blnzuYRXtHrW8E2ZvEqVj89EImT8NPheaE0gv/x49c13iyVLgBueKXasW/YLOXldq91UYsLfONM
	FQD9DMftJ/AUadaROgHQgt9qZB4zBeASZb9UzssDix/YtNh0uj0qLsxifi1H/04/SN4638o97Uy
	f0FQfIFxszvr9LHn5IQKU53rySp0mlmaUSztO8+v0Gri3KniLoTw2/fwZmyC5TwZXSXUIjaiwTo
	YTUn/mLteNtggSLdmAE6vvAkrlW0JiosvneY5SmQt80yGOpFnQTme3YtBizUDucW5kbvpUz0vcD
	ikfTC45l4KC0jK8Gj6+dt4PuRaYDEK0t2Odsafr86V2AUOX/cMqMk5QbIUyNabpRqvD1HytXY+Y
	YZXXLDeRJB6HQbYQQKnqSvUCx6SQk0mYROpjvhBwA+PdAVPiZ++RFB+HU5Gp5vl/QQJoIgWXnVL
	yH3E0eDfCl2uvxDTJ3ZSHqmfjD1HAfz/4ULXs4dzNu8p5Kb8c0pCu0Gsl1v5QTRb2g==
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr433032475e9.31.1795642012525;
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm310815745e9.2.2026.11.25.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Date: Wed, 25 Nov 2026 21:26:50 +0000
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
Subject: Re: [PATCH v2 1/9] KEYS: trusted: Allow ASN.1 TPM2 sealed data
 shorter than MIN_KEY_SIZE
Message-ID: <20261125212650.479bea7c@pumpkin>
In-Reply-To: <awcAeLUROL0l_g3X@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-2-jarkko@kernel.org>
	<20261125090930.698d8f1b@pumpkin>
	<awcAeLUROL0l_g3X@kernel.org>
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

On Wed, 25 Nov 2026 17:36:24 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:09:30AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:35 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > tpm2_unseal_cmd() rejects unsealed payloads shorter than MIN_KEY_SIZE (32
> > > bytes) with -EFAULT even when loading an ASN.1 TPMKey (OID_TPMSealedData,
> > > 2.23.133.10.1.5) blob.
> > > 
> > > While kernel-generated trusted keys ("new <keylen>") and legacy old_format
> > > blobs are at least 32 bytes long, external TPM2 tools allow sealing any
> > > non-empty payload up to 128 bytes.
> > > 
> > > Keep MIN_KEY_SIZE for legacy old_format blobs and accept 1..MAX_KEY_SIZE
> > > bytes for ASN.1 TPMKey sealed blobs.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > index 30188a0ec676..d7336f25b514 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > @@ -559,9 +559,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> > >  	rc = tpm_buf_check_hmac_response(chip, buf, rc);
> > >  
> > >  	if (!rc) {
> > > +		u16 min_len = payload->old_format ? MIN_KEY_SIZE : 1;  
> > 
> > There is no point using u16, just use unsigned int.
> > 
> > The same goes for data_len.  
> 
> Hmm... or just int?

Unsigned int can generate slightly better code - especially for
array indexes.
I sort of prefer it for values that can never be negative.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

