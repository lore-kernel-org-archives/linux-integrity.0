Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754079;
	b=vDqlnOmVZcMd/OCCPJ5QsLjjBQpaSMAQRZF0HB4v37zkZ5wWbTumsyyM4e+Hu4DPEmGz
	 wKk8roIA3XcJdpB6ilvmqpNWwYqjUqySXkR7j/APXFuUcYe5cy8EgqD6azBpeU09MgnaT
	 kCPffkNYpeikCyT11Pat3np76f+PoIXk0Ra9xvY9fyGxqovqSd8eugx08aXhPD97n1wTO
	 yMys+mcASRd5gKiO9sFQ6UH3f5E0AYDaY2cktWoGz/j4/7yXYYEepSrXb0PgHYCq7ETmi
	 f6f/aN1d60XK4SaV19HtCgqym7Yre+/Gt/GAawbLP+EnbISRARtjxVmhlixjrT6vDuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
	b=ya5cxPguDS65sYkWZ2rE+UJbd9XCYZB8nuAZDSzBYHGLfVGnfGEKi4/3DvyIQdjYtk+c
	 /hjQ40YUJsfJX5v4Dyy5qYXWW8J1QT9MGt7qbJ6UdaThZI7IpVgr6p2acRfBA6+kP8qKZ
	 zZMA9KX1OmL4vPcIwaCgxAX4CjfCsII6HWFZbnunQGitINUi5gwq7uCV/gXQNIT4Xlf59
	 T9CqV+7SqHK70zFLu+2o4d8vrV/v6YT73Jnr1hFA5aMCYXHaLgyoTSsR+OYp8eHQuovEp
	 kcIRGoDP1GSgXI2MzCF5d2ZOiER0g9R7RdSEAouhYhxsz4SebV5TIoYGhc5vW1Maf1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901D606A31A
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2901D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso3747957a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 06:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754076; cv=none;
        d=google.com; s=arc-20260327;
        b=NHZVO5KKa6E+xxI6tHKU2eN2VVoaJZnCDcW7/ofMhxvHuDBXMD8or8z4XCGg3XowAT
         Ru8tH4I7a9TxFvX+3rNLMTW9uN8tPZ1kr38QBcOGYyjwzM4g4orFof1yf75akeEn0R0o
         YNIWNo37ySAL5ZhjUWSfojvzRMjBccjDEhGm06qOiuIdECMiUTSyp03ikGzNnMMBBKWP
         NgW4K7H+1LeCtiEQX2+9kQ89TxYNUqyu30gHKt9tmGNJ8iQ1J4LszSLJRtRxjgO7d5h/
         LNLNYADGkPIbZD3m9s7TXG9qpemqXvlUYnHI70wShm7OceRORqwD/uKs06o+7JeKXuOZ
         grNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        fh=vbw7RoyVQw5UIfbE8VKC+onn9rh9ZdRiqkmOg1GLkVE=;
        b=hPGBu9iD5BcjMskBpjdwkiaPdL+vlkZcsbqmr6WsXVtzyihfKpD+P6UWVkptUclztx
         RSTmNsTsNUsTGb5YQndZTgMJGTtM02w+Xmu7kdem6O/rdqaZl+rcBS0yGNEcmalrXVwP
         CvKY2ExxY3VbeixlwWdSRXlmWKUGYcN6rvlEDKtbe6z/4ChXy8xGChtw+4k0Jh+DwFyx
         3UbjXdJE2Rv9UOhVHmmtSSC5FShJIzcvxKW1jFiH0jGnhGZYnut459jNrO2Ii4+IExGi
         n3y0fj+3un049c29fiqIvXyR79WZBjxRz15Otun+ZalHEDi0rH/gjJ1DCc30Z7M2B8pR
         89Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754076; x=1795358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=vdeJy6VCk2IGRpnrLWlGo4pWLhKneS7IPoBk81bLTW0iD2g50lPI0We72sIkSM0SV6
         cyTbNZB4O3d6VzvDDG9DPV5xAXhxmw4YkAyPQvdWI1M8aVPLRajltXh2AQAOKJY1EPeA
         J/3fQzDOEdKdl4Og0NnAs1e+UKlTuJcD65e+vWcNglfpyVM0bRYj3j545Ccvj/p07kIf
         RJxqw4iAkOZDz6lvhqxGAdC4rSJXKnOPRkFB2PlSiergeTKJSozBYsIqbEfROUxsRiwA
         +nC6LR2BKa2t52tGscFSOG6fqqncSzV6SKT9uOygWHxo9fsmCNg/KFWBsER32dA/LqAU
         Q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754076; x=1795358876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=DdbqX8KIym55aUkaC3/80u+HtER9cy5PKA6svAfRDA21StVK1Sd7WKxNjYk7lsCQUL
         /GlDd/+CL7iWsDHxkt+7lJgXVzIkSNGh/F1xchWHqp9otye4FXdF0L3uxGRKtMSvqKzi
         N7DjS6+JnK5spzNkLfHCroCNSDUfMRsFXjsC/rYC4AHyMgC3Yb4J29Z4WdKJBc+8NY0D
         GkubhGrnvo8b4Is4Qb+tBhHC5SQBZN/cMYnOgUfOV8Rf5Ese+tuZIlIil5Q47Y6Qp93W
         MMl26T8HXIX52WSTcjUDUzpRyXc17jq6D1aNvAU6b85484BSmSr6FxZ4hihSROcuBx9Z
         AcGg==
X-Forwarded-Encrypted: i=1; AL+hErG1nOdzWIpnAIecyr4LHctw7eKUJ9MX2rk+F5mxLpcHVJQ04yBqzn8nlvmnoM6KwTpq3mrMhmDLQxl4R8UQen4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5VE/C6qO6sl+HU3P2vuRcZFDqSFtfC8RNLQQdv+aSKBNid2Y4
	Gp3LEhkTnVg+7nePLC2yYH87OPqZawbtK86fYlSvUjH+G4Vjw2420Sz7zBCqglbb/GXRoxSiHC6
	1XqhK8eAfWupDmJiA5EcHhIxVkZCkh98XoSfZMW4=
X-Gm-Gg: AYBFou2saDlQpSdd5SfheuWRrVuezcYH+sJvZ/4+ckG3xCCuhhDJV9AEiF5ppd92+Pm
	uMo6wmXfi6f1zhZnIQjNW5iyFZa+kq3lza4dfd8ni4SPNWZHWHQoM0H0lYY2DRW9YJW9Eoa49/z
	ocJ2PPxFGRX81kzbP0Jbp3pOKIOQIT4BSBFsUpziepQJmteIwsj8Le4InBkz08KAloEf/FIqYTz
	EuudMjTaYx8c1K5h54palQSvaSy4QwYY+Ou3JPGIaEe4qxSz+3yF6uoi7wZWZRaBRxlff7HiRp5
	ht1A5brIUEzqaOvyBU1dvH3xMoZoBVzLLo6PBv4LK2mso33RBQMH+p1kWUQHKS99ghxUv8QYE8/
	S0mHlZ5qi37OBjWJYRYjq5T8YrfYA3uJJ8Z85GA+mxeH8czTse218Hk+Jz3k3H3oUwu8L2A==
X-Received: by 2002:a05:6402:1d4c:b0:6b7:e12e:7f1f with SMTP id
 4fb4d7f45d1cf-6b7e12e824fmr3426650a12.10.1794754076394; Sun, 15 Nov 2026
 06:47:56 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:47:45 +0100
X-Gm-Features: AclHuK_at8qVhKBNN0WXPGQ7F2lmyjSQgMjlfNE9nQtuQriTEXeBZE7dwGmSTD8
Message-ID: <CAOQ4uxggW+UifxBJDY8fAb+g5EWrsD+rELwXa1ngZ_5X_OZx0g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
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
> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice!
Thanks for cleaning up this mess.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/vfs.rst |  6 ++++++
>  fs/overlayfs/super.c              | 17 +++++++++--------
>  include/linux/dcache.h            |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 1824462a43711..6953f399672f3 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1374,6 +1374,12 @@ defined:
>         for returning the real underlying dentry that refers to the inode
>         hosting the file's data or metadata respectively.
>
> +       For D_REAL_DATA the filesystem may have to look up the data first=
,
> +       e.g., for a file that was never opened.  If that fails an ERR_PTR=
()
> +       is returned and callers must handle it.  D_REAL_METADATA must not
> +       fail.  Most callers should use d_real_data_inode() or
> +       d_real_metadata_inode() instead of calling d_real() directly.
> +
>         For non-regular files, the 'dentry' argument is returned.
>
>  ``d_unalias_trylock``
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1985b553a47b7..39d4d57dec230 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -42,7 +42,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         }
>
>         if (!d_is_reg(dentry)) {
> -               /* d_real_inode() is only relevant for regular files */
> +               /* d_real() is only relevant for regular files */
>                 return dentry;
>         }
>
> @@ -57,17 +57,18 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>         }
>
>         /*
> -        * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry. Callers may ask for files that were=
 never
> -        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> -        * here. Return the overlayfs dentry then.
> +        * Lazy lookup of lowerdata for the D_REAL_DATA case to return th=
e real
> +        * lowerdata dentry. Callers may ask for files that were never op=
ened,
> +        * e.g., for uprobes or O_PATH files, and the lookup or the verit=
y
> +        * validation can fail. Return the error then, just like ovl_open=
()
> +        * would. Callers of d_real() have to deal with that.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               return dentry;
> +               return ERR_PTR(err);
>         lower =3D ovl_dentry_lowerdata(dentry);
> -       if (!lower)
> -               goto bug;
> +       if (WARN_ON_ONCE(!lower))
> +               return ERR_PTR(-EIO);
>
>  real_lower:
>         /* Handle recursion into stacked lower fs */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 674bc50b81827..5b3b34d271bd0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -638,7 +638,13 @@ static inline struct inode *d_backing_inode(const st=
ruct dentry *upper)
>   * If dentry is on a union/overlay, then return the underlying, real den=
try.
>   * Otherwise return the dentry itself.
>   *
> + * For D_REAL_DATA the union/overlay may have to look up the data first.=
 This
> + * can sleep and it can fail. D_REAL_METADATA never fails.
> + *
>   * See also: Documentation/filesystems/vfs.rst
> + *
> + * Return: The real dentry, or an ERR_PTR() for D_REAL_DATA if the data =
can't
> + * be resolved.
>   */
>  static inline struct dentry *d_real(struct dentry *dentry, enum d_real_t=
ype type)
>  {
>
> --
> 2.53.0
>
