Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611124;
	b=ESbIhQ03pp7Qz0WJ7wcjzKUB3TOmjKlAwpf3aDW/U4paDJ7Sf7MQKZwxqc2I898tXKbK
	 Z/BinyhARmj9n1rQ14eMfgCQb5D4DS5kyYcd2zb4nrMUjscp1G6lLzi24bgq9dCTV4LpM
	 imdsCfb63eQ0uQ9DL3hzeMG1WicVXaYplRvCyEezQmeJJ2Xk8mgRgvStsPbREWZuD9/I3
	 rQd0BI3lmmTWNQsBzam/6VyPuwTRQZfMrj88e65H2D29d+2FcKswtYEiwB3Z/Sc9wyo/o
	 GZaiz/vtEZMUP5+QDdefJ4w3NmPg4DppS8JCmqMfIeDWWY0Iarf4vMWkJFjpYUkhsgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=a7/VZHL1+Zykiy4bJ1WLf1Y545HqmJxQ5d1ZgPnt3mk=;
	b=Cwd6uTA9xVyRxZbcarCeY6TSKhBi32QD/V2zYwgMtoYDoCT4V4gU1mO6gWdwH5xEQ/Ck
	 Ww7wJUEduoJ4iuWbLw+nWK/TWDX7PfBu5hH/A5vjgptDrT5kuFT6MSMk5h0DRqNgi9gn2
	 r5YOEmqAqXAxGw8Ad/ietl92tuyqrUp+JOVSEf3W/3y+f7tJlSCi340xpQNnmf9AoQ0Il
	 phgF7+MEyOF+laggNHvLzJZNn+UOjwvUDHiE1pMjvILo25BWItIttzDDgEWxziNgSdmCl
	 iGx/EeZ7yvt+QheAfCdhc4SRQOGMtYAzT66bW/MuZwGi0N2sgyqZrYqNLAWR1WtzScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FaCzgTzM;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556C606A331
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 12:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E556C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FaCzgTzM
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so48799555e9.2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611122; x=1796215922; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a7/VZHL1+Zykiy4bJ1WLf1Y545HqmJxQ5d1ZgPnt3mk=;
        b=FaCzgTzM79b1rLC7Y0lWXfgV8Kk74ThPrd3xNDQRSLLtP4cD6HFhqDxdgzfRpsemVJ
         nlHA7kMT8LMBzgIaoEVuhln9+qlfYcisGaufmlaQlBPDNbUNMl0FzRzOzlofD/x5ucXU
         mlyXC7EVj/55iFpQqtldUfCZrRH2fJWwolf2TAbQ9i78WxlliAnlpQJy+9a4Z7Nf6hFj
         MU/eY1TbZYqWmdJ9ZrdkFlIrUXIdSzZ23GtO/Q2ms2lJQWbCgceGq8MhfSyACCqTKgKj
         FK1ZNyXFvflrgIeKL1MU2tFpy8QVFMyhixIbzztTn/4PLq2RIOuCj9bCXtpsblECaNTQ
         ZOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611122; x=1796215922;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7/VZHL1+Zykiy4bJ1WLf1Y545HqmJxQ5d1ZgPnt3mk=;
        b=eY8dEh6cvUevwnZ7iYtP+fzBMOjm25iZAe+qwq5tzsH3rLEYSyYSfXdfnH8XfRtTqz
         MLOpc/WruNJzrlMQ5R2tc6IfmgpgnpOxc8Qo2GujJqnw27TBXFu6g5cvDPFfxqe1DjR8
         UJ2dWcx1CW//zLe2qPbbzFAiBse7XG5Mbi/gG3hQ/zplQ7B15RiOyzMG5H5fpJGl5Xvg
         3zMk74lZXH6Hdy6jkyJR0MFVl1Vx05cq2ZUtzsRNcivX4FB+Ok/VZL8PbTnjL2ZuVwfX
         CUMGYA50sknQQVLfcu05Y+UT+lgAZDVggw7XHQ+xCfdWslxZOJKoKVzwnMwt5V9x175X
         vPRw==
X-Forwarded-Encrypted: i=1; AL+hErH74M2Xtak8UZ4KI1Br9uHudtRsV4alTHPrVWp6J2kX8sbaRdOXPy/+ug/XGiL/oHlPg4lpJI2K+o4RoV4mcRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pn7aX7uAWyHBd6C4Ej1gq5RMOM/x5iJdnVjIbfw3knD4YHflJ
	JFhO6w1b5v3nzYTN3mpmWmO4BoB9peDNs9IIGR586sr4rHuIcWohO8wS/TP6Q9isOzef1H/S0RS
	yG8ESc4aZ
X-Gm-Gg: AZFdTZc9RsALN03Wqm0d32XRGUvp1HwUWWtz5r86NwILeP9uu0OF94vxx3r3SO4DRYs
	wM7DuzW8WyZ6Yn9f4MlIboE1NQMotXGDfx77CuQfEl6B8wJo5Fd1gHZYVpNnjGg7k+LoiOWRVfU
	tWwz296F2aWgFXUyoC713yoQLbR0JKiAo5AxMC/RUsFKE+TCrIysSNKaEozVDRaXB+LU+OiaA9s
	JCUkEQHHx/IOz0J2mZi1I62vPfUYnpKyYVrpW5lG27Pb0o+AUXaBCXGskbxnQUgA9IH6Tb6xbCJ
	W2OGxo4hTtfDB/E+Z/rBFPcjA0EdGf7/lFtXOXdpixdetbfDaKPNUgWkb5r28brJ4leBcqrgEfv
	VsCQBxi64Wp9Q0Pl84ezb1cSFwJo6UjHeg4nR4A51Y6k+6kF5SskYJ/n2A6VnLJeSGNnAK3+Ehy
	qX5M6o2CbXxw56vgV5SU0HVijT95mrOE0T0wxaygitdwE3oJaPcm95SG2aHa8Ca4FUDzU5gO02Z
	rsxbkgVnrzWeqwOwTNm2TtPfruBw2/sHHnLvRx0Sc08VPzPGyjhaDZT8W4qk835TKG4+nUgDVeY
	MdPDjIqQFs0QqjHrBx8yu9NxsGKrIrnTmLbRCuhA1oIy1w1FXpbHLv3eL45ntxF/5M+Ng3MLlOZ
	2BXKSt++Z4Qjm6EXrf2sUWpNYdhfzYAvtbPTWQEUr7qj8JVyFaxUS9g==
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id 5b1f17b1804b1-4bb8880f0e0mr363677835e9.5.1795611121806;
        Wed, 25 Nov 2026 04:52:01 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm462265225e9.2.2026.11.25.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:52:01 -0800 (PST)
Message-ID: <c4b406a5bb8968e4fd73bb984c55f8aafb4ce355.camel@amutable.com>
Subject: Re: [PATCH v2 07/13] ima,evm: use d_real_metadata_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:52:00 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-7-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-7-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> d_real() is about to be able to fail. D_REAL_METADATA never has to
> look
> anything up but we don't want to promise that it never fails. So
> switch
> the open-coded d_inode(d_real(..., D_REAL_METADATA)) in
> process_measurement() and evm_calc_hmac_or_hash() over to
> d_real_metadata_inode() and deal with errors.
>=20
> evm_calc_hmac_or_hash() returns the error so EVM fails to verify the
> metadata. process_measurement() passes the error on to
> evm_metadata_changed() which treats it like changed metadata and
> resets
> the EVM status. That is needed as evm_verify_hmac() would otherwise
> hand
> out a cached INTEGRITY_PASS without looking at the metadata again.
>=20
> This is a no-op as long as overlayfs can't fail D_REAL_METADATA.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link:
> https://lore.kernel.org/all/CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+=
3775xA@mail.gmail.com

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/integrity/evm/evm_crypto.c | 5 ++++-
> =C2=A0security/integrity/evm/evm_main.c=C2=A0=C2=A0 | 9 +++++----
> =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0 | 6 +++---
> =C2=A03 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c
> b/security/integrity/evm/evm_crypto.c
> index 1c41af2f91a60..17d528771d8fe 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -231,7 +231,7 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
> =C2=A0				 uint8_t type, struct evm_digest
> *data,
> =C2=A0				 struct evm_iint_cache *iint)
> =C2=A0{
> -	struct inode *inode =3D d_inode(d_real(dentry,
> D_REAL_METADATA));
> +	struct inode *inode =3D d_real_metadata_inode(dentry);
> =C2=A0	struct xattr_list *xattr;
> =C2=A0	struct shash_desc *desc;
> =C2=A0	size_t xattr_size =3D 0;
> @@ -241,6 +241,9 @@ static int evm_calc_hmac_or_hash(struct dentry
> *dentry,
> =C2=A0	bool ima_present =3D false;
> =C2=A0	u64 i_version =3D 0;
> =C2=A0
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> +
> =C2=A0	if (!(inode->i_opflags & IOP_XATTR) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 inode->i_sb->s_user_ns !=3D &init_user_ns)
> =C2=A0		return -EOPNOTSUPP;
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index ac8328812e6ef..71faf156f9d6b 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -763,11 +763,11 @@ static void evm_reset_status(struct inode
> *inode)
> =C2=A0/**
> =C2=A0 * evm_metadata_changed: Detect changes to the metadata
> =C2=A0 * @inode: a file's inode
> - * @metadata_inode: metadata inode
> + * @metadata_inode: metadata inode, or an ERR_PTR() if it can't be
> resolved
> =C2=A0 *
> =C2=A0 * On a stacked filesystem detect whether the metadata has changed.
> If this is
> - * the case reset the evm_status associated with the inode that
> represents the
> - * file.
> + * the case, or if the metadata inode can't be resolved, reset the
> evm_status
> + * associated with the inode that represents the file.
> =C2=A0 */
> =C2=A0bool evm_metadata_changed(struct inode *inode, struct inode
> *metadata_inode)
> =C2=A0{
> @@ -775,7 +775,8 @@ bool evm_metadata_changed(struct inode *inode,
> struct inode *metadata_inode)
> =C2=A0	bool ret =3D false;
> =C2=A0
> =C2=A0	if (iint) {
> -		ret =3D (!IS_I_VERSION(metadata_inode) ||
> +		ret =3D (IS_ERR(metadata_inode) ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !IS_I_VERSION(metadata_inode) ||
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 integrity_inode_attrs_change=
d(&iint-
> >metadata_inode,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> metadata_inode));
> =C2=A0		if (ret)
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index e463cfc1e3f43..016de5a66eced 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -357,10 +357,10 @@ static int process_measurement(struct file
> *file, const struct cred *cred,
> =C2=A0		}
> =C2=A0
> =C2=A0		/*
> -		 * Reset the EVM status when metadata changed.
> +		 * Reset the EVM status when metadata changed or the
> inode
> +		 * hosting it can't be resolved.
> =C2=A0		 */
> -		metadata_inode =3D d_inode(d_real(file_dentry(file),
> -					 D_REAL_METADATA));
> +		metadata_inode =3D
> d_real_metadata_inode(file_dentry(file));
> =C2=A0		if (evm_metadata_changed(inode, metadata_inode))
> =C2=A0			iint->flags &=3D ~(IMA_APPRAISED |
> =C2=A0					 IMA_APPRAISED_SUBMASK);
