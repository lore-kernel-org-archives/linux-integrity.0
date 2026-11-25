Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610995;
	b=1HBT8YGSJ9i1ggzyvVjhwKO+0xIAIr4bFJcXlR90T2HaVoikJHeZwA6LkN3pvmNRe8X3
	 BsSMl+Gbh2lKFYGxY828Z5Ipn8KRyQnoWTK2oM4vALVfqANA+7kTpEqnvWSIBxq2nyvKL
	 AI+5n41tR3s2J9WPpGsXn77HPsWUDm+BSA7+OnzL3dW0rLZfgEvNeEsIpsv0PzJkrZstj
	 7cPH2lwIVGCgNEkTgGE+Ee5F79dws7serPH6wPD5g9X5FjvlqZWo5uU4Xsty44mb5TFeG
	 9esHxH5rFqrAeYRoMXf6WZ/pv4HUCrsnirSnAOrfIhrnXdiIcXNmfn09UdAJrOLluzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
	b=Fc+GnCF7pbUBpTlTYYip7OCfnN/e3oojGX8NEJC0R6smKh1Ripf/tNUY9yA9Xdswfocg
	 SKOi7w2CTOIe/ZsIodHLqWcCpsV1JjKoiCFdJm06OhhVoOEL3Rq7wDbTTqoL/uRbVOQu+
	 hc3qPI62CRlhAg0l7TVPi5JytHTpayqUFF5ZtW1zDhLroV34wQHlFuPQJHydRpyHi15u2
	 rtaHoZb94hFonVuOmCDrzaGGQejSrZdpYjw7QgDWsCyoSt0kc7AzTVL9aZzoG43eHB0qv
	 94HuO6RlFUY6eF76M+ziXGALrp6xWhUzX7kbVn8WYF8vdeLUC2jMiPoLB7LBskHM6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A65606A32A
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A65606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso56528265e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610993; x=1796215793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=ijrvPjrs4XPMGxLv2/cLDzYf1DTkp26koBrs+YwuqX5elYJruc4hClaOIjF62Q3+YN
         LRHIUBC22PWGF/rAGALu7SoOt5zqUHESVTCa5vHMQJoFy4B5gkLHeV5hugIirMLPKc1z
         lwkIjSkykztPQpKhyKTDraxT5P3oaH7NzwApTcr02ARr2hT5KerzhwRvxghSP1A3P/Bp
         EtgDED95aoU7Ek6mxljMaLWO6Bx5amJKRdXl3ABZkqxCYsSCC5SlDmTZNR4DGfcavrRk
         HtSpSZ/UepV+pwNgpwEHfsqbflJPpiVU5KOF/FpJhp5lP9+HVdK4ulKpQ0NMqA1E55T/
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610993; x=1796215793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=nFTUtGr+oR4cPug55ZomKgEgJ/Vp7wMB0xLuB3aReQzdj5Lfr5LM8Bd3F64h6T2zUc
         qkgCrfiEFt6pXJRbOMxJUv4LWIVXkRkA+QOLzRGPJ3b9pMa2PM+15p92ZiOFdBFoqHwq
         HnEm821Gxs43wd4lBqs/PLXqddNdm2uJEHovr/LkBiQU+VswkCnERDxjGzxQBxMl5/up
         p5v9ucp3QukUpv2Eg6TWTlCDhK06jo41cdzrG423Qr5F4C/SOOqMLTVV+GCOS3P/zAdS
         CuOkLxtgvLvlB3Af6ltx/rHQVNqoo01zLKBXZM3J24/rH9a+5HTqu28dqtSIyUNnN58j
         AVSQ==
X-Forwarded-Encrypted: i=1; AL+hErGjBxAI9vuicto+XL5fGwHOrLpsDmZ9rAm6LzmUTdl8/Fz0fKUYUSV4AeY+B7EKGOGjMjT83aAWvsu6Wfd8ABY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2/gaTTOFdJi+ruoCejaZLvjGWyHp2V/s5vPK4CHSp4iL8DI8n
	cDc8nEhvn0D/iSIZ4xjGC0LkPzP1cfDsMx7KOfqJSdPqt8Aai/7iesiwl0gvqb16IH44
X-Gm-Gg: AZFdTZcw7VtobvuSA5GytZ8Kqqx+TGO88VtczNffCl76FOEewCT3Q0ZcXRRTaWyTvLQ
	kOxHUlqkuUxAClLLHdplevmsvfVBjIIfUjFA49EpSygB6PUmZx83IzEbjjE42GFfqbF2IZVGXaJ
	CF0T4jiwPSXnK8VQkGSSe6shsXQ6OeEO29KLVrQLnbGsponWwMZadd6xoWPhpaBn68/9Kndzh5O
	GM3p6H8eA0j/VBQuNwdUBDCkZ6GzjmrWTBnIVCVCUY07A+iC99/FZKWjXcYPx08l1hnMKPRMHO+
	P33UBBFEdt7Hpzu32rOpuRfQ4vG60ZqnnBPsFg7g/WcsAIYcicw39zm09KeaGyZsAJNf/Q3ayeX
	WRmZIBD/lyZusN5LAz2U3UbiDDeKYZTM03nJqmbqXbKAG+NgBHH1rKxbHEKY4xyCZow1mSvTJe7
	YKvJjLMTHPJ4NDCHYqzN9wVu+uI6ir8WAoIcc3n6ysitmi8449xXTJmpOjV7nZSFg2GH3Tt5/vL
	eqxdZbSMpxIlWTbZxOeJadgmb+oYVDmhK0dliFzivez7lQkBIu4YiDoV6Oj5d1hYE5GZeqgd71t
	70o6ou6X73Vy0U510u/nQNf1NBOv0TDA9BsXiIXgHQViaFe+VVdp5lzX+768Pm+b3cCalWA5i6Z
	uD6tHoLvixtamCP4dlMzdynHq48LxLrPY6bwFnLIvZOzuxPRAcwWYQA==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr364999585e9.16.1795610993400;
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm710678895e9.13.2026.11.25.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Message-ID: <34297f66e07c1a64d81205c7669801738676f356.camel@amutable.com>
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:49:52 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
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
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build
> instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0Documentation/filesystems/porting.rst | 10 ++++++++++
> =C2=A0include/linux/dcache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
> =C2=A02 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst
> b/Documentation/filesystems/porting.rst
> index c38f5df755bb5..aa0fc43907017 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *.
> mnt_idmap() and file_mnt_idmap()
> =C2=A0return one. The idmapping is immutable so nothing should have
> modified it
> =C2=A0anyway. References are taken and dropped via mnt_idmap_get() and
> =C2=A0mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and
> returns an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a
> metacopy file
> +in a data-only layer. Use d_real_data_inode(), which returns the
> inode hosting
> +the data or an ERR_PTR(), and handle the error. Use
> d_real_metadata_inode() for
> +the inode hosting the metadata and handle its errors as well.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fd8853622f250..fe1aa8fea0c7a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct
> dentry *dentry, enum d_real_type type
> =C2=A0		return dentry;
> =C2=A0}
> =C2=A0
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real
> inode.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry
> *dentry)
> -{
> -	/* This usage of d_real() results in const dentry */
> -	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> -}
> -
> =C2=A0/**
> =C2=A0 * d_real_data_inode - Return the real inode hosting the data
> =C2=A0 * @dentry: The dentry to query
