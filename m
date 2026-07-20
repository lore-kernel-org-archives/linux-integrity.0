Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47739902B
	for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543710; cv=none; b=jhF6aa54R+aYsVyyGGNzDqmnEGLk3OJ2ryS2rRfYIVXQWb0vVprEl4ZMptFZqNL12MwB8WJbKRxrknYOLm/pXG297uMF3tydqMqCHF6VSaoXy+Vc30nAUOTnleFhiSANSTBRZuI8rrZtOy9p2rTQjGBQiwVWDTDv7VffJbrPyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543710; c=relaxed/simple;
	bh=NtYCSfnijOuf43LYdvfcJWtyNX4MSCBqCUIVCWr1hfA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=Lxun4mRvyHkHrBqyTBfEYUdh37NhaR9viWqSakCAVnt2JkcbLqGD4traJ9e2GE62u7979m8ycqzw3qsMCZ3PVKF8i4GOnxBIzP/r0S7NiAvyZnXr6k4D/FOHo5jp4U1N6ANQyCC4ktDgJGLAR6R+cUsQZ/0eSejsN3CzOlyHPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sZ93UBYX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sZ93UBYX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso29838615e9.0
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784543706; x=1785148506; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T/UHcnK0u2PtiV111f+vwISiyqebdZ1bRHYB6k/SjEc=;
        b=sZ93UBYX+HK2wIdKizFcZE7ea/tjsP+aArs+VDnPJNdtg0xItvGODHKsrV6V8G/wXd
         eQLhc9g972w5WyLqMkq9Vn4REKFIngtXbpt83hjqUkrChSL4p0ekjMrGBYoCm8oQ77zu
         u5DAMuDL/hFPEsIbcGrUbIO2UgwHdnIosD9WXY3Dw7CJx8PoKl78h83RBfuGWJy1Yesb
         jlH18pSgYX0ovOw7NDr5jbtDKCPxBOxR7rO/OknSdYBPshUpO2W8u1bUvgEko3/zbsLL
         DHbMIg0a8QaCg1SqJoBMM/buRlKz4s3oy6Hn4DHqUgUwZTh0r3lzvPLWfN5/mnZMHOAF
         1TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543706; x=1785148506;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/UHcnK0u2PtiV111f+vwISiyqebdZ1bRHYB6k/SjEc=;
        b=cHxMZ5LK6e2xR4YLa2Z5snLK6itEVXBp2gTfQyeeM09Ji8B8/5s2V594mP8bOflC89
         Cqb11Iw1qwKMBP35/q6tmdE8zTWnJRPPZWDHNdys4dGf3BQb22XVCsB5DrLhbkcSlN+p
         jJX7Wh7UOxuUle71FKqqGfPZ/AeQ7almcwD3kYfxdaqFBNmbdprR1sDbbqfaMUOzSQM0
         amFGi89YIrlnk81Z3sRa2nPmR7oPfe0JtXdmMTLIOswg7gPFLQibSJ3Z2QTzhRvj+/TQ
         zmnKQbcMDbAKaPaCEa7tFJgvr5LNMJB49+zPzUXuefhb9FzyeESToVzRxsQEIO2pm19H
         DB2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpBJ8/OO0wt4Z3iGOWinT6hRqPcrRZmZCm0oZhUS20KLd9t5hhedZq+/+rtEJD/zOFWst2Sh6/0MljtoKOiZw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSMEP1zQ5xGroRS/exg9dHdXJaDavij9P3Kn8V5fu/vQaD1wR
	Ee+OKdpoAvs+0Y8n/nygIOzWNa319dNin3C9YGMgqQTXWr2/lg56tuID+LI7o8XqHcc=
X-Gm-Gg: AfdE7cnMRqsHmJvBuFppqw7eu1bRqJuxzm1pCy721piie21bj+Ii38CLu/YnD/sCGM8
	1OAvOr9bvcA+f/qaGNiIzKYrVWF5TSTF1fOKiXhqNFJoA4rmo1GyNmh5mvEYEWyDd7uZadD2sl5
	mDGZ5Lqh8jP/jvM0E7pRoXT9pxnTaZO/uwYhNMP0mHQAqtALEQPRP37DM1I3a6dKqQpsN7Ue4UJ
	hGJIZJ53DKJhfaastqpBdikgNtPysawmg6du2djY86oVg5l41FX9RBr2ywp/I4Z4lL0hgxD50dE
	MfVOil/+RUYBTui4wuseMYI0/JAkCMRBsXGbZrvEF1Sd0P68eIX9VDY78518pVzTLL/XbTbGv4D
	v0olt0hrx0OwBX1XdyG8hAhwEi8geAJrsrkNTQKAXWvXT/NTLHdjwxMp8KRo9eO/q3sypdLfyel
	NLn0D9pLZO7TZOyEy7vzjHM8ixhev0kNNRbTd5EaO17BJM65Oq+ayJar5B
X-Received: by 2002:a05:600c:4504:b0:495:495b:9248 with SMTP id 5b1f17b1804b1-4954a3d0cf9mr143689505e9.4.1784543705762;
        Mon, 20 Jul 2026 03:35:05 -0700 (PDT)
Received: from smtpclient.apple (213-225-8-251.nat.highway.a1.net. [213.225.8.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495516c68fasm193931675e9.1.2026.07.20.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:35:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 Fabrice Derepas <fabrice.derepas@canonical.com>,
 upstream+dcp@sigma-star.at, jarkko@kernel.org, zohar@linux.ibm.com,
 dhowells@redhat.com
Date: Mon, 20 Jul 2026 12:34:54 +0200
Message-Id: <1EDDC226-1CDE-4A17-968D-EBA26E81B596@sigma-star.at>
References: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
To: Fabrice Derepas <fabrice.derepas@canonical.com>
X-Mailer: iPhone Mail (23F84)

Hi Fabrice,

> On 19.07.2026, at 18:41, Fabrice Derepas <fabrice.derepas@canonical.com> w=
rote:
> =EF=BB=BFTwo correctness and type-hygiene issues exist in the DCP trusted k=
eys
> implementation.
>=20
> First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
> without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
> a payload_len larger than 128, the subsequent do_aead_crypto() call
> writes past the end of the p->key array into the adjacent p->blob
> buffer within the same struct trusted_key_payload -- the caller's own
> input, not unrelated kernel memory.  While not exploitable, this
> violates strict array bounds and triggers static analyzers.  Fix this by a=
dding a validation check against
> MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
> matching the checks already done in trusted_core.c.
>=20
> Second, calc_blob_len() calculates a sum in size_t that truncates to
> unsigned int on 64-bit platforms.  Because the DCP hardware is only
> present on 32-bit i.MX SoC platforms, size_t and unsigned int are
> functionally equivalent in production, making this truncation harmless in
> practice.  Nevertheless, updating the return type to size_t (and
> subsequently updating 'blen' in the seal/unseal paths) resolves
> type-narrowing warnings and improves overall code hygiene.
>=20
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys=
")
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Changes in v2:
>  - Reframed commit message as correctness/hardening fix (Richard, Jarkko)
>  - Changed bare return -EINVAL to goto out for consistency
>  - Added Fixes tag
>=20
> Compile-tested with arm-linux-gnueabihf-gcc on imx_v6_v7_defconfig
> with CONFIG_TRUSTED_KEYS_DCP=3Dy (W=3D1, zero warnings). No DCP hardware
> available for runtime testing.
>=20
> security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trus=
ted-keys/trusted_dcp.c
> index 7b6eb655d..c078adebe 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -69,7 +69,7 @@ static bool skip_zk_test;
> module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
> MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zer=
o'ed");
>=20
> -static unsigned int calc_blob_len(unsigned int payload_len)
> +static size_t calc_blob_len(unsigned int payload_len)
> {
>    return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
> }
> @@ -200,7 +200,8 @@ static int encrypt_blob_key(u8 *plain_key, u8 *encrypt=
ed_key)
> static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)=

> {
>    struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
> -    int blen, ret;
> +    size_t blen;
> +    int ret;
>    u8 *plain_blob_key;
>=20
>    blen =3D calc_blob_len(p->key_len);
> @@ -242,7 +243,8 @@ static int trusted_dcp_seal(struct trusted_key_payload=
 *p, char *datablob)
> static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablo=
b)
> {
>    struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
> -    int blen, ret;
> +    size_t blen;
> +    int ret;
>    u8 *plain_blob_key =3D NULL;
>=20
>    if (b->fmt_version !=3D DCP_BLOB_VERSION) {
> @@ -253,9 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payl=
oad *p, char *datablob)
>    }
>=20
>    p->key_len =3D le32_to_cpu(b->payload_len);
> +    if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE) {
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
>    blen =3D calc_blob_len(p->key_len);
>    if (blen !=3D p->blob_len) {
> -        pr_err("DCP blob has bad length: %i !=3D %i\n", blen,
> +        pr_err("DCP blob has bad length: %zu !=3D %u\n", blen,
>               p->blob_len);
>        ret =3D -EINVAL;
>        goto out;
>=20
> base-commit: 6d41c11ef3044788902a05e292cd7f0a9c7a8157
> --
> 2.53.0
>=20

LGTM and thanks for the fix!

Reviewed-by: David Gstir <david@sigma-star.at>

- David=
