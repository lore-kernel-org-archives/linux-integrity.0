Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754132;
	b=ZwClaN8r+F8aDlPF5LLoLZUjA0oY8/E3jQF85qCsKwyNNkqOGosWNcaMfM4/tFQwECjl
	 ULQin23dyVIUD9WSvvrzkdkIt5XpSnHF38wd3NUgbN5iyzImKD2lUOn23hlBahSKiHJRa
	 9mn9AzP3LYbR7iwIr+bQB/GWGmav43t3ZC98AeMq2t/3VXe/XEPeLsG5FPqYsc6mspwms
	 HZV3fj/C+G1kr1iJolyhT2P8zUjczrDcrBUPuQz3W2qt3W3Xr8nOoWFZ8eQj4CSrMa0AQ
	 63P2awziM2iYjHilqdRm6tKRr6V+XpF6ZDuIMFDpVL7HXu6DrbzMl8rL8qgulBBTQMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
	b=pjbqsEbt5G2SWuZKIiMALVwC0WEwglL7/g6PBa2/Wb/7AhCO6ddL08bl83Px7NZGyguE
	 Y1zuvyILMOAz5D74Q0LDQHQvhff7itbPwy7wKFb8HtCXmbIob39E7Jl5APzBg/BYt5qgn
	 aIrh9/ofsmeKBD3sErhAZujffJ9vfcGYYtAm+BnXibHwbPTI9ZS5R+ujWAvVsL3eFrK6d
	 4c4yRzvrWROIQKIZx90CIY5zYLxBhVKuONeZ0E49EXReyVzJ2Xdmmz9BsYDV83aov6GUO
	 2ZUDlTkH0R93dek4TjtfaKbdSp6CPirjUpl+Hf+Bnfok0Epc+LlOpf7bNgcjDJmdZ6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5g/XQ3c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCF606A327
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74BCF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5g/XQ3c
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so4154488a12.3
        for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 06:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754131; cv=none;
        d=google.com; s=arc-20260327;
        b=AzPvOS0uy9BciRqI9xYGYdUT0E/U/LiaG1JBBuok6uGTVh3sx5XstBOwdAi7ucziUy
         DzEpdw24+0Y7mHMJUNi04zJpwcsuQ8+aTZ2D2MHwpGQ5CtmIngn/pgQFQVKVaDVb76Iu
         kZS23HQDt3cTKtJYfnzNHCUnn9EF+bLKJPgRCrNSmDaWdNIg9HmSnyQQU0UkJhaCpXzL
         o5Z//OqlyN4u+E9AvaxzIXPS0uXJFrgoYD+WKimsGyxxAHlo2Yd5ikcLete+CyEBxCfi
         SWKlkjO67j2ITvGEPMkY9Gq/Um6fHbGn/zaBTrdngqKffZU+cpy5szzM9q5Fr6v0ZoBY
         5fHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        fh=GpnbozhLlJtLusQi3AP1wms6cXMpZNY5JqxWO0tgNAo=;
        b=mK3x/3zez2RhGuVHxTkoMimwhNanlQkzRHNfNwaoWxyviS/bAj3I079H5C2g6sF4xE
         jBwlNOXpb8EtZF40i+NW9aNGvfsFK/V2HJtyNuuXkVPEnNa7BYUQf8t+Ox1u7glQpSkE
         5cA13/tDaWJ4xS4g01f2vz5lOGGlciurU7TqssEMYNVCLJiY3XT2VoqnMOgAPi9Df9Xo
         sU38i7YYUR5b6NEvmj8OVHApXeIEMS2CxfKJ+RJ1Zzrj5+IzGT9hBI/NAAjCLpycr2SH
         5orqiKlJRrzZ8zEG7pUPnXEcgsTCZs2vMwwRWEGxco08Ca0gWIskldDRqujhjQDS2etK
         8R2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754131; x=1795358931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=w5g/XQ3c9k+Vmzjr8H8faYY5EnV44gyfCeTqkUEnB7IDVxBorehzGxTmotRUcFMd2k
         yEd9UzOdm44dKGOB9vhvuqA14zDF0izirGlMHcIkPmvfAWV6oC7EWoZSr/n7pMgjOayy
         4XbbykfX2tOLXKQEY71fD4ubWMAf5smyh0PUCbn4ouKSDid+wdpti8tnvMNzC9U0omm7
         PfP/4oysMFjcZt/QSyQgeX6xWgKvlNh0WDaR4PRzqjFkBPghAucojPZwp0HxO1dsPk5w
         0TrSxGukXHJtQczzx+u36Zh+VEpUmtRmnvhCaIPp54UmNZzIkin7PEC6+n43usjPmyxQ
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754131; x=1795358931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=oit3jFRGvSrcY/odKtg4GkiokxnU8eMx/1ETo1nQufWTBNgA1qxdBIkVO3DDgvdf0b
         QpGd/ZoeGZ0QhpGzl04Cx5/kB5DwKa6WVI8rAme5Iw6J4PhUqlgAKT5FM0Ylozf7PZz6
         wrF5OGF9g/Qam4LV/MWxqn6KAMnFHfVsZRNes2zNGgrJ19KKPApg6VmDRSDZ2NbWeqOQ
         Pglz/BIWWp1sMC0/bvtmQcgNLOYEu6heAMhvzlEh9pHWOTa9KWL5t368NqQ2PMu58GAV
         djvhzrjapElpBeMO2pXe5UE5MO1xrX5PSUymNDqdnzD7skdgETkyAuZJBs8u4Gbskf45
         VF1A==
X-Forwarded-Encrypted: i=1; AL+hErFxHc9kPA5s7kTZwcbap7IkmAbaeSiN6qj4Tbe2c0m6+bvxANMeLhmk0bhi1DZyP/AkU+lVX1RBlGOZ2HKtfoY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qHlI0ABTPwMnkqePItxwYGgHnej4KWIgXWBy/R4YcUGnmQBPL
	E0dAhCKvCo/VJXj1bznRsB6e5FQKwBGBqdTtgfdNUk6mtfAJOYia3ArR8d2e1a8pGdZPEesN+YX
	zAKgPiRHjNCb9WjvANjJCTYjglpcNUqA=
X-Gm-Gg: AYBFou3YM0cV3MWlPkmbRMUyOMtnhssnIQJWf/eZ5qDozlFjFDM1Yee3+zj2O01Rmlw
	zu03e84+hsCNRBawjEJ/YAv+GqBqRDWMDxka0naDBuQfycqNife2pf+vCcvRqOX/KpivmnpnThj
	9IWdkJPa2QOUd0XghiynSdjnw/Rc/mNkBcEhDM1UeKeFIbtt7Vl9N1Huoq+Y7MRIxdmSKKMNCKe
	hKq0LFDEsOwlCp+YHquiHCOFTgDDgTtRzX0hdled1qBFY/AcoeViPq4ZRFjumJQ2qtZ1/YIcpnn
	hOHlJKs95GFVPyj6WtHOXVNKx2WQxb4YWfde1SvC4MacKw0MyRGrlMU+/PbOdchtDY5zJbnaQZy
	SQgGYzy8ePCRYTDvpRFrBqLgUNAaYZRXFHObswmWaSr++zvaM5O+ex1GOxKeRkeIMotiinA==
X-Received: by 2002:a05:6402:1944:b0:6b6:edd7:790c with SMTP id
 4fb4d7f45d1cf-6b7c0d2c969mr5932123a12.45.1794754130672; Sun, 15 Nov 2026
 06:48:50 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:48:39 +0100
X-Gm-Features: AclHuK_loWLpZnEsR5-ArAPNE_f3U8cZmm7GbEpqPveHBdFtxvcWfTtvtccYOKk
Message-ID: <CAOQ4uxgiwKsadtv1Me3ZkSsTawjNey3wDDWVAnx6U0+Oe+uoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>
> Add a porting.rst entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  include/linux/dcache.h                | 13 -------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index c38f5df755bb5..28a24b702f2a6 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *. mnt_idmap=
() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified i=
t
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and return=
s an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a metacop=
y file
> +in a data-only layer. Use d_real_data_inode(), which returns the inode h=
osting
> +the data or an ERR_PTR(), and handle the error. Use d_real_metadata_inod=
e() for
> +the inode hosting the metadata. That one never fails.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 5b3b34d271bd0..2b15179e9baf9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct dentry *d=
entry, enum d_real_type type
>                 return dentry;
>  }
>
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real ino=
de.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry *dentry)
> -{
> -       /* This usage of d_real() results in const dentry */
> -       return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
> -}
> -
>  /**
>   * d_real_data_inode - Return the real inode hosting the data
>   * @dentry: The dentry to query
>
> --
> 2.53.0
>
