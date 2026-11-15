Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754480;
	b=gJJazoM9zoteRr+AMdhX50PI+RQTunMoy4AAJpsuV6yw0sZOyYqCEnsB99oSqEe43Meh
	 m50OHi6HDVTzpXVRcUQWXjfpyDi4/dqoMgAW22gj/EP27HVLECkGbBSAvBfy5vkqfhGkb
	 v69Kd3XRoFKSf0gm82fVNE0hg1NjXuAZXSFzK6dnKmYSg0yaY8GpMuREQ2NePE7zB2ThT
	 rcJf2HxkcmJcAm9qtgSzP8VsNrEUByNBTErpZxMtbiqPgrBpVKrXftQSPnPa8qjanZ0J2
	 D+kEWbEAvQeNx5+ppGlzvHuqp8IGdgOT8qCgk9DxeCzfYsqmfMLgNuvf7pUhJV29mwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=OYRiSwj/Xt2j3x2jSiGeil943fKVmF8qsXFv0B2kp5kzFjIpv0IA2H8GDmcsu66OS9M7
	 vAh7XUBZQBVPoGQpwiRN7KUihEikTnioazNieGwCGV7Fyo+qYth3iyoM6QI/X+5jboqrW
	 2vQuh6TGZfG2D8ShXINFGcGMQXVkhbIemMwtbryJtuW2p+jd1IFZsVDt4tTl0yPfjlKtL
	 F04+EvhD+CawJrAp9jxySP6E5GsIVmmtbdkwoxcOfV+hSblOua81yxDrt9BXEr/fX2xkt
	 kgaspx/RkQmhj7p/xXVZQQrP4B6uQxFGhHwYeoCfSIGNOu92CgASiqPt8T9+5wsI+xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3D606A32D
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E3D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4466940a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=jbxO63zPYgg3wqqHOqAl5+9zffmt1ksht/woW9nEAj89grNbFXvAvAeZl6W7XytjIS
         Nki+9jFVz8nN7BVF6tUR7zVhsvzd9Yb587/feN230dtKv2FIUCbQdBXSdjCJEQADxKWC
         qmRtbCev1kpcijaATn7PB7x5g0aSA5Q5NcJQflnMbBsNPmlaxfAZNEFBwGaPt9thb/N/
         1FlDnY2nTGcEqMSLmzg+uLzp8Q5rR65mTjnqmRNlZp9AQSzY5s+I+2J+hcJ2jquuwLfG
         7LzHkWARH9baes/zYHV8oDRoDx/mqv9tOSj3fhrlBT0iMROrgg+BDAhTHiEVXZmVYdan
         GL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=UWUJTsFyB8yFMldJT8kxNntR54fbRK3yEqJpZ3i8YQU=;
        b=Td38grM3L5xJCjT6j3y9LR14ZX7pjC1/ztWmyTVffGvONbDwu5Ntb3Apr3/DqmFo0q
         lsT0aer5GQL/o5er/cAmpNqFXNQ1L5p5icFQNxyb8H+6J6sw+qJ51HfcmUhtIq2kIfHp
         LCunT7pLZH9uAeNWRXWhtpuuDaka5ho1Z8KpGEfwqBMkuEYSBVxJamk+MwPkuEjXprMg
         vwIXmFxgjjrqFxEkLUVBEt2i8foAMp8uG5H62vFvCdN9CAVXWfwks8yKRXjOUXOV6Y3Q
         4QssJN/E3Hc9/4rlxe4CMcENOyuRvmDMLQxwLFjnShosgacCmT5VZTfDs1FrS+VRFrcI
         C00w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=E3NBx2wXLJg3DMp/JlaNB6y8MY29NfFLDRUR8M5/p5P3NsIBjoPnKQ62zEFdUWqwaa
         7/+u+pP8lzkltYf3AasPvIT551Q2ILLUdgs4N8V7eo5ghPNImTDhHozMpQmLyzsjUvC/
         9F5WbHcSOgAVF7vcWJGw5RyeLbu2Oie5k97SI80WuXh2O4hnHd0Jm0Kvz42jFxzYkZSw
         jr4A4gdypF9usGUtIF2u0PRX4ngRN+p0eo/k8rdLnCU5SxP3PDRNMg3j9j+DX/vZSvdh
         wZnCLTGyZnYnn2m6i6vRqxkRFhuQDbSkxa0LK7KWT+JrCcpKp2Yd5+l6mJLg1MC1vjA2
         /bxw==
X-Forwarded-Encrypted: i=1; AL+hErGo2w/HIgkCPu2/az4v/JACDMuYDtdCQy8/gdjszNdsnefHH2dt2GJgZJXR0xqp5xQqZR19c7MOSe9dEH/wkk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z85ES1LW6IuVf3D4NbKtR3M4PUhRqlapTTbI4Y5oMAsRdMigv1g
	siLEDJkQu1AYSLP58cqeF3jnm9XHne67zHDLm3HBJ7pOyEceq0e2wvIueG1X9Of7uUBjuK0skVY
	AG/yCUQ99y6bOb8ZY1BeNoGtVxRXk3I8=
X-Gm-Gg: AYBFou1bk/F0qDDFhAxwTbZjfFw6fgBUumTYOlaqZBZJjUZ1nQs2Jf1jkYIMyEreOGm
	+5IhPZofmLosnZ+F9ZtB7XoRXQpLNBj0JEJwcnY6xRfi6vnNoau4DYYsZ8Fs1hiv9Pjx25xWbfZ
	QAE35gx96JsPcfrrnGGI1J7zNFXra9HpdA897gdKpZz7gt3jEf2K2c4yIbbSsBs4Okgb8u0nmdS
	xnwTAGOi6YEuwGGuy9XntV+mlFbfTjBDl1vEAw3tmQi8PcDWhgUnrsG6B0kwm8jHnZCl40Sz8jO
	peVJh6LgjS5mUgQ3hAh9TYKrEw8kvyMpZA/B1SiC9tU5uknjymUag6zJ2kAWtHi+vm0Ufezyd/S
	YVasUg4QrqOfa2YQo0DxZqidTx4cNp5QWfkOpqcirBVBCBQiZCt9qqo4ukphZcU/BAOkkjQ==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
