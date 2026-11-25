Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610651;
	b=lJxEf5zSESea/IFPP17uBcjSL8ju/ILPGDI0lnDZhmJp8EdH8rysbSzR+yt5AyiC55TV
	 DfyaOwGsibPLmN3RC1ino503j7XVk18oTISJoTHRIvDCt6tsvXI5ZIlJn04F5wQUXIn1v
	 UVPLmavE6TVC2AkKl9gLerBhvT8fJ5hj/Lo8keI7PaZBl1B1oA4cTrNCo769uwHBCKgxR
	 CZCM6osFpMymVORMroS/USRcIlMm6IL0MbOzS22FbyqyccproKbSj7ULXdqSawq/mBRK3
	 hdlg4tCxtCcYC4bOtQah0XX1nxGEBAmEVLs+UNVg5DGwKnmUIkRerIrP0o8mWnVJgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
	b=IXNXRgMHfjy3wh0eDKDL016BjtNfQ6QtvV0H7Ni5P87x6thCWPEMeKcPOvH3qgIixrjP
	 GUBMmWw7vl1TIPzWLurzA5G0WVtZedWoq45RY4NazjkGYj9YLZS+6BoCuILKIvcq4rEd6
	 acEzHlDeEDJQ9XD5fJuizTgsrRiSGt/D/84kOz303BUoyBFc89A81c7D5SntZLJPwhw54
	 aSDyAHJQgLBeGFBYchyX5ekEi1+jfBNRg8wzLJshCnwC1Lho7aBwtFKEVjQiTQwGEcmwZ
	 lUosxc8HEKzsvQRLHHRJVEwzn2IeBAjHdS3QxaA6JFTl0GcT17lvx0fCG6CdURvd7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA9606A32D
	for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CA9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49465892f7bso4148019f8f.1
        for <linux-integrity@vger.kernel.org>; Wed, 25 Nov 2026 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610650; x=1796215450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=JcoUc7GMiAh0LkpV1E480w7GXCIAW/e8cF7hpO69S4aq0dcYx4tjFtoWiYr/DAm4+r
         yQ/2E0q/ZEtANpcmhRiWttvENm2b4bj22INjO2Cx/R+/hBXaXVuDkjlb15+GWRRpJToA
         gOt2R0IR6kS/Ao9M36XuCAmR5ct6HS3dYddtARbxeWS1JjHEBmwNCLXhc2QkvjRgk2lT
         AJJAOIWWGoD+UkNdRCPXyT74UpyGH73ouJzCAPdkF/Lr70PZiakzkApmnO3aBQ+SwCeG
         0TuQ+Y4k0z+qEetWXaTlu1C1y6AjZth3CoXXov75D3SM0G7QrDYTrkbxN01Y+ILgo/HG
         90Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610650; x=1796215450;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=vjRuSkCRvnXxJAxn6/mLeX4GMA/mK1v3EpYEX4MpoVUpmvyg84KGWlKeyQe4xCjyS7
         moG06kbqNEzsTAChyAz7RUOFyd//Rxs0i+/3CdvW1klUJPr4UZ9jUPGJoUphKIFYvD4c
         uIYtuzTzain8GafnjokARrsyf5FlHjq+H7EgOafuh2+vl6Vm7KaJcTplrvF555okBbsU
         Z+8D1vN+uyrsZbQzhWrLlU/iM1gzGMBeJx7RXlhlh1dIbq272Zjv024cwnxQt3SGBYLL
         YQbC4YYbliBlsCsNBwamp0PusoShpU53fnX2hmRwSsJLN4GX/h4tAfQDsy8GdFJfX62H
         8HmA==
X-Forwarded-Encrypted: i=1; AL+hErEyqPkCzT9Ir5tREeJbDsMzbhE5CIuCp3sG+Xj7wwa3R4f4Zdivi1Z/vmYOULmVjgtCqOGUz4g4uIyO/qtLErg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rt7A2jqnuvU2uM6h++Ek+Crkzze6zqm3IHX1ZEAdGW7642Ocv
	24wBWaSsJAkVA4BTieVRgnR0jKQOR5Agx80JIajN69r82RYhbM1d6CIqO44MSBrOX57d
X-Gm-Gg: AZFdTZet+roSrUhl7oZmA1r3JF4yrl0Nez4BAowMI4WuLO6pJ9MoOhRuqgPFrNGJ50f
	gcK300Y5XLwNrHeGaKVelgVSHda1j2+3AzKJ4EvStYB0kpWzcDrZdChjFwhqOYmou+hWds7cV6s
	l1H2yOSYJOhIy9NIqmhz3loEhPJVSTAaOk45zU+PBKxJ3DiRRWoBMq8ayCsB8lfZY48e6Tnrjss
	/+ikaDYefH3z/PEI+obL6qNFsjq44+NLcStoxQEqStpWa1M7GpamsC7EEsWPoPLPKLbAtmuTE8v
	iMRjfp/4ZoEwCZ+NGBaryywq3nU8UdvObtTFgGH6WIdPo6LIAGaevqW5mr15PvTUgWlhLqoOchK
	IASi344/NJW0CgJhJGxiBzB8OOwaNr7LAuOFeU6ZvR3iVLhmcqzMO4PRBL58y63RZJ9ik8+6ufw
	QdJ7BdzLxEwPuQ7nedXURrrvUJhIb6Pu1VWzPGJUXOX9TE/6os/eFRi8hQaQUh8COJuwzCEF3r7
	ZPYshz+ENDZJLTlPUm3pAqOoLDU4VfNa5AltOJG6aYsv+kIVSNssPm1JRbP3Vs+1lmD/zopPUQ9
	zWf6YHctS/drfwtRASQU9Ad3VbBGnPwzbCNLiuPUllS14KFg60zyWAcoNOwblX4QW7UYa6Hn4V2
	Vz6h0DftBC5QoHTNwP0VIqt0q6LXdUf9XvAciJBYPy8ZgA9vYzpG4XmY=
X-Received: by 2002:a5d:584f:0:b0:4b9:8ac3:f5fa with SMTP id ffacd0b85a97d-4b98ac3f6d5mr4714062f8f.48.1795610649431;
        Wed, 25 Nov 2026 04:44:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm38964871f8f.24.2026.11.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:08 -0800 (PST)
Message-ID: <e6c23984f7b47f9dcfffd6de2f6fdf75d07a14fe.camel@amutable.com>
Subject: Re: [PATCH v2 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, 	stable@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Date: Wed, 25 Nov 2026 13:44:07 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:43 +0100, Christian Brauner wrote:
> ovl_d_real() looks up the data of a metacopy file in a data-only
> layer
> itself if nothing has done that yet. If that lookup fails it WARN()s
> and
> returns the overlayfs dentry.
>=20
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there
> already.
>=20
> But nothing actually guarantees that. trace_uprobe takes the path
> from
> kern_path() and calls d_real_inode() on it when the event is created
> and
> again when it is enabled. So a uprobe on a metacopy file whose
> redirect
> points at nothing warns twice:
>=20
> =C2=A0 ovl_d_real(/f, 0): real dentry not found
> =C2=A0 WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2:
> sh/279
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 __trace_uprobe_create+0x1869/0x25b0
> =C2=A0=C2=A0 trace_probe_create+0xcc/0xe0
> =C2=A0=C2=A0 dyn_event_create+0x46/0x70
> =C2=A0=C2=A0 create_or_delete_trace_uprobe+0x3c/0x70
> =C2=A0=C2=A0 trace_parse_run_command+0x1a6/0x320
> =C2=A0=C2=A0 vfs_write+0x1cd/0xfa0
> =C2=A0=C2=A0 ksys_write+0x116/0x250
> =C2=A0=C2=A0 do_syscall_64+0x10e/0x5e0
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =C2=A0=C2=A0 </TASK>
>=20
> bpf's uprobe_multi does the same.
>=20
> A failed lookup isn't a bug though. The data can be missing, its
> verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what
> the
> WARN() path returned anyway.
>=20
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers")
> Cc: stable@vger.kernel.org=C2=A0# v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes:
> https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chrisdown.nam=
e
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/overlayfs/super.c | 10 ++++------
> =C2=A01 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry
> *dentry, enum d_real_type type)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Best effort lazy lookup of lowerdata for D_REAL_DATA case
> to return
> -	 * the real lowerdata dentry.=C2=A0 The only current caller of
> d_real() with
> -	 * D_REAL_DATA is d_real_inode() from trace_uprobe and this
> caller is
> -	 * likely going to be followed reading from the file, before
> placing
> -	 * uprobes on offset within the file, so lowerdata should be
> available
> -	 * when setting the uprobe.
> +	 * the real lowerdata dentry. Callers may ask for files that
> were never
> +	 * opened, e.g. for uprobes or O_PATH files, so the lookup
> can fail
> +	 * here. Return the overlayfs dentry then.
> =C2=A0	 */
> =C2=A0	err =3D ovl_verify_lowerdata(dentry);
> =C2=A0	if (err)
> -		goto bug;
> +		return dentry;
> =C2=A0	lower =3D ovl_dentry_lowerdata(dentry);
> =C2=A0	if (!lower)
> =C2=A0		goto bug;
