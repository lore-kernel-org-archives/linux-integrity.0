Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611199;
	b=N7G0T5ndQuW29McUw/tEfz63tSAYgck7/FWkkAe421o+lzWnv4UYmcKC1PyHu2Tbkbhb
	 EBhkzAtuDw9GiWT2KRmHkZHczbdcpX9mIoc+YvWcSJQ3LIPB0If2bfqq46pDRhh5HIzFJ
	 o0U2Rk97ZLN8e/GOCaSDoBuxY2JFY4qUrxTbdAxTb8Pn2XiLIDVqb3lE3J/WB9vxo5xLn
	 l+JdzavIfjfV7kkGcquLXtGi2E1DCryxzx/r4VzjRMxHpw9q3WBHlWJntRrRaLHGy6XGa
	 nPuNdp73xz4RJ1NAh2HYelAEQUr2GN16r/KDFR8xuv7BvqgDMXCshFvuy2W5x23ZOJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
	b=tPEyIJsbfgl8zU0/O61BICTRtCeKwW/BB5P3gEjkJxgTChRu1D9fu1b7vmVwUGsg3TKg
	 aykoRu3+ANGz/qdzTnWOK+z6L1CR0iWT9XRMQKKnrB625gQ4E4YZBP/SuGVE+hPgii4+n
	 KgjQgU9RuO8z3r3XULVxbgo1OG4cAt82urTUJ2gygQgPEpCR6fNiRMdb+G5/Vvh7la5D2
	 fWc0Z5eQJzuyWwRRxtOXp8SFkDrFk093+0kvfrTNkTI83tEH5cHF3ewJYen7Z44m6bfBG
	 gzus5qJgDb26IrvkASeNNJvaUiA8t2Di2W9RpdPwQm8bi0885zWLvYOCEG6VVbJY/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43780606A684
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43780606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so73790245e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611197; x=1796215997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=QOXEZ5Pu/EPca6q7kzgJRCmLrmsoVFR/ZRe4q5d58yeOdbJoHTuz9y0u/Nmk0CktwI
         CoxL971qgH9IAeYEJL9OV04KK9hoZrCZxCXphCDmaMaCEIiYAFkXm9z/Jipc+urQTX/j
         Fk8I31Tuids+3mCeGda6Q/7DCnEHSLo9OC+CFzZ1uqDLrPjUm6OialCUSj83o9zL6oVG
         iksZBRXktSiMRqpVyhlcQqbeKVyrA1zYnXNdKX3aSHnLNR56AH4l3EmMwrecUL/g6kYv
         65m48YXn1HMJU4OXkynxAivRZrQT+c7z3fBFxX7gT5o5ijKHn00slucTC0ZtqVCasBEY
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611197; x=1796215997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=cj2VyiUI8IUiGPlnMHoUNSwMdRKQ0ldYaA0PfwV5OtQP/75I1RlqPATjIjrrVIHZT1
         Dv1fBriUGxXSZaYC48EjcHZmMsJ/imwRrd+1AHB9TRFs0m+xvIdLtmhQ3p13gzgWwLgA
         t925Dp1XTofYUCMz3xZOzikPSpVjBqoG8DHOadDtek4bQAEL/O7PP3+Qc1m1dSs1JMOV
         n78v9y/1sRcWZcHQQXYE3PEUXhM2wn3SftS1HWVRH8FKCa3G9GX8kcaBfYSwpOn2cOaw
         1JHmtES2ujQLcbhr8/59++WuE1WfAE25jTmPdqm3ZE9YXsZT/KQ3tcsEvW6+t2JI73ry
         dzjQ==
X-Forwarded-Encrypted: i=1; AL+hErEFvOAFO/Xd7GCujhEPRekd6QGt5bmJWySVjsdx+J3ckgjyztLlc7FKohYz1vMurWr9WKwXiUBhCSVzxC/LbY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EfwV89dvpl6rzbkR9oJ5GzOzSvZK2xZs917CqIEiQYhv2+18h
	efTupVCKXjbcnTOeYquDmOofD6lMBz8U1hZRBWOFT8ysMXGjK6aqsG3pbSm1AgLETnkY
X-Gm-Gg: AZFdTZfXVXtCgjKFKQR3Ez8eZ1/wDQFUrFl7jroYr8t0dyJfvcp6ydzUyuiHmZwkIp3
	XtroCs43U1i7FJaz1lzAObyhtbl07ncTssW8U80bwOc52fQSETdHSmMYgxo34eWvucEYaE+bmmh
	1Hyr/4hOtgGwj8C1CI6g5q1XF1oh2e96BZf/orD39zF+qOT5Od8v6qlhrWQw7KeuXlucrT0yAO0
	vk9kx12nXz8HEDQbRY1cEphq8QYkpTRDURqGep6sI5UcFvAzG40rbIuU2j4tcxNbjInLbsyOna8
	w04pbW5Gq2Qy1uuxJsXT3PU57bb4IGSJBxTHG1fXoyMFJbpTeaX9U+/ZpFe81H9UuYnmC/KtzXD
	ePlVJn2z5nPO8lebgnDBkozyGiiThTF7ZWj7su+EAwf5++Wh34nENjak1/EWdI4/X+3Lq2CCV5x
	q4QSqbYWdPxZMlEXSW0oiev8r9ThVdTng/RRPjw8OP9rYfJcmDjzXnbvTdILhHKNSk5kxSB/8nc
	Vdg5TMR4nL+mrusm7rfEDjF7e8G8OqnWu1jVjdIZwIxeDX25aeDx7qrQErRNiS5nM0oQPDzWjME
	kVO0HLpuAqb/7WxvQJcA54qOzjY+Gf2YDp2TMfFMg3lVlSJ00MLe79vIEBQ4gHsj6TFj/s+EcJy
	ULUkEGAfFc2arqa8KzucFYUag7Vo+x/ORr6aZW9MHMF0s7rMCAEJr8FTHfdoLkWU5A19Wn4E1EZ
	w=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr356853675e9.16.1795611196651;
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm736573735e9.13.2026.11.25.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Message-ID: <45510e886330ade6013838f94cd84c688b263aa8.camel@amutable.com>
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, Fan Wu	 <wufan@kernel.org>
Date: Wed, 25 Nov 2026 13:53:15 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
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
> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and
> deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that.
> The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link:
> https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@kernel.o=
rg
> Acked-by: Fan Wu <wufan@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/ipe/eval.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 4a7be96c84f03..a2366eb9a47b3 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -102,9 +102,16 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx
> *ctx,
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		build_ipe_sb_ctx(ctx, file);
> -		ino =3D d_real_inode(file->f_path.dentry);
> -		build_ipe_bdev_ctx(ctx, ino);
> -		build_ipe_inode_ctx(ctx, ino);
> +		/*
> +		 * If the real data inode cannot be resolved, leave
> the bdev
> +		 * and inode fields unset so the file is evaluated
> without
> +		 * dm-verity/fs-verity state.
> +		 */
> +		ino =3D d_real_data_inode(file->f_path.dentry);
> +		if (!IS_ERR(ino)) {
> +			build_ipe_bdev_ctx(ctx, ino);
> +			build_ipe_inode_ctx(ctx, ino);
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0
