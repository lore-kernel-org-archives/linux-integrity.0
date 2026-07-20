Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD8446056
	for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570785; cv=pass; b=NSDTtj/7p2i6qPr+oBbDkfGUKXPG3LOvgBZ+VyNPSKipEUoopSH3HraaLuLk0GKy6sq2yK9CH2Pv7eOpQLTjTJVRNYigo4pi/tn7KU42g5COhu1+6rE69i+pWjnbKhQAjNFrsS3DnF6ed3s1WYfD/U6VcQrGpNwFkRZlxvuVnCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570785; c=relaxed/simple;
	bh=6sJy9PZJ/5uu+uq4/s91e/0S+srBf6fkJM0yl1tesOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8+GfLvczhAIoduD33peCR3VxL7+g78EyHV2A6nTwTrfkoERf7I7DYhYjwmBhKqcbvJ6vO0eo/bCN/XljihiiCAA3leFPm8WjQYHlaS/Z2bpWZ+9g+/Bxas0GgHPpInzn4jQWX1caWZsCiH2hZ9HNI+jXeeyb7LomFHLqzvKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVuGv4D9; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVuGv4D9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so45927426d6.3
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 11:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570782; cv=none;
        d=google.com; s=arc-20260327;
        b=Rxpr8FA1Lv7xo7DAZ5u6Btn4aS6KjFvJovR60pAnXQXBhgNyXRkkRDzK7ztdSFnlR8
         E0INv/uLUe9MfFB5OcEbKNczV4Tq4M4xXcL2nZ0Ys6tylvCBgMHhnCW2uXx/c1hzToqp
         w229lJdkIlUApLbVLerhAfmAJ7Nqs1AKvX3i6PvxcYG18qL7k+WAJGi64M3DMn1rqTNW
         kjeckXCGCq2O4aHdCfIQOjFsw/Q6BbsCAEDDLsf3H3mnfW12mwLae9cluqguBbOKUX0Y
         p3JkrWkvRumw5RK2veNK725D0kH+Lg2ec+T5Q2gaJNg/cuk7acQGHcFfubk9mF5hCo5S
         TyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        fh=hEgXQu2fZY8jqJrDjtbslCPdBRdJZrKDEjbvqBOm6ws=;
        b=ruMh+bydZjcRJb3sksGuAs2iHlC9CsuI7MzhU7A8G0RPwTcdkKZuIeLo/FCQ7dUF2U
         nYaf4C5rOse4IgY1sHmLvKZLOotouYn/TiExYRGX7ppKnWmsY1q+JeRJl2UX2wk7TtSY
         N0swB/0BiJQE71A77X7ywexIvlAU6iUIWGA8JCGIT1I7X5YV+ycXs3QP8m5ZpKFL15CI
         1c5t+zzP7sEbkXXtz9bFTYR1p7Br5fNpdlBEvzbE0zwSqJlJer+YWzIDpBQit8QXodt1
         lCwZa98Ct2wusJ7uqicjkSJo7b6u13rLnI+UmYY/DC7Qf14E/fzTPEMnO5Ntzke6Bp8X
         LOuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784570782; x=1785175582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=qVuGv4D92AgPHJeaD8GZFiyzv+DT7Rd0tbKf9FpNpK9JWGWh8yNPZ+dDFAOJpgSQlf
         dKkN9HCTovfUqy5M/xL9HKeA4CTVm1ovHTIyUsA1AklqzmcsMZ1X8gz+isn+c+ZWvNWc
         y1h12Otum0BRnlX2KQ24j47IRyDiGGThUZbNz+aBVTEypmsZan1aTXjs4xSL4f6qpMJX
         bx6j3Dgjv6AnSRHoQhc9ufDQE3/BsFxokH9nK2DwRV8dE9WJYQAU18uTa+xQFLKAttqK
         yBtERcaagBEo8O0jmMC8JMB2v5xsws2OTAzXuO+A7xbna373zvvhR+GFxYCO4hkKD2nP
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570782; x=1785175582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=gEiiNL/j51Nr3C17RjdrxTA6+SxI3wOx/betyD6nrUuU3hGPLl8k4DwofWHPxIZ/A1
         X5P4VTLv9GqFWnb1GlExBZ8zcN+8KdY5tp85I9tEw4K8AUXXy3YXaa7erYLXdI9VQSlB
         9/yDH86kXEokD60SMMS8ZuKf9VSB6OhcFKxaumTpSmGBHpOQ2aJCUDyZktBx0Y07b5fC
         RbNapbq3E+JQQU8kuDqhkAGokTxXNXABbIDQiuSMxFGthKwNggjRrhMn2euaBquFk+Ah
         Qqfklxuc+Sy9zl+Fpr2hpE28K+Iim+bSqMxlUMwh5QPBGsAeWuGxdr9Uzn72EGcK7D5R
         hSsw==
X-Forwarded-Encrypted: i=1; AHgh+RpI+3OInH5vuEZ7zI7njsXTVfO7BnY1MtmEA02yq8ETjqD95Vbf+wAVtddZcyccrAZjTNPIvosLFtO93U3EFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv06IfzWuwvhMCtrJRirqRHdbTONhqc2MGxJXMogmdzeIZ1Bw
	UM3DmpwXTKoYlX/Rasm97+NRLlNav/zfoJOr/NEZMwWd8AfqWjHcbwUWqIrppV6ezyfA6Zi1JOt
	7z8Y/YIf/QUiiVCojgg9yZNpxmTRZo7k=
X-Gm-Gg: AR+sD10jLFWwoJlJ6bHwVzKyoT3jJ8Qc0j83fI84ACjbd5+o7TqncxcxvQxD+qQuKp0
	CAqnB9MOxibZ5YfXxi6twbAOJ42UztHNzllJQIVmyI/mLaIZ8/0/XBgZZPYQammAJcAX7CL2g6k
	Gums0w7gAv5wYhcpcwjwsVSkoAVL1zeWtO69iIzgn8TY5a17bT/1NBzylT84wvHGhv32ktJJ5fr
	65kKdFTexeAKEV2OdhGa2M/gpslYQltOenzu6Y146Kfptzqs9JejunrFUhVw0mLO5p8DQVaAhfR
	U2hWgxmm0UDY4FMT
X-Received: by 2002:a05:6214:e45:b0:8ef:ddf7:3135 with SMTP id
 6a1803df08f44-907783b38cdmr173632066d6.38.1784570782095; Mon, 20 Jul 2026
 11:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
In-Reply-To: <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:06:07 -0400
X-Gm-Features: AUfX_mxzIpBrzcPTV9KeowoimwOb7WQA9GzVVHyfVuwu0lx2Q8xYaxFF_5bIdv8
Message-ID: <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> > +struct lsm_xattrs {
> > +     struct xattr *xattrs;
> > +     unsigned int xattr_count;
> > +};
>
> Please separate out the 'struct lsm_xattrs' related changes into a
> separate patch from the security_lsmxattr_add() changes.  I know they
> are related, but they are different things.
>

Will do.

> > +#ifdef CONFIG_BPF_LSM
> > +static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
> > +                                 const char *prefix)
> > +{
> > +     size_t prefix_len =3D strlen(prefix);
> > +     unsigned int i, n =3D 0;
> > +
> > +     for (i =3D 0; i < xattrs->xattr_count; i++) {
> > +             const char *name =3D xattrs->xattrs[i].name;
> > +
> > +             if (name && !strncmp(name, prefix, prefix_len))
> > +                     n++;
> > +     }
> > +     return n;
> > +}
> > +#endif /* CONFIG_BPF_LSM */
>
> More on this below, but this function isn't strictly BPF LSM related so
> let's drop the CONFIG_BPF_LSM macro bracketing.
>

Ack

> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name, const void *value,
> > +                       size_t value_len)
> > +{
> > +     struct xattr *xattr;
> > +     void *xattr_value;
> > +     size_t name_len;
> > +
> > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > +             return -EINVAL;
>
> Sashiko raised a good point about xattrs->xattrs being NULL not
> necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> something has gone wrong and -EINVAL seems reasonable, but the
> xattr->xattrs NULL case does seem like it should simply return early
> with a value of 0 (see SELinux's handling of this case as an example).
>

The problem is, SELinux has already set the sid by before calling
lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
before returning early here. Returning early here from BPF would not
mean the same thing: there is no label anywhere, in memory or on disk.

> > +     name_len =3D strlen(name);
> > +     if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > +             return -EINVAL;
> > +     if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > +             return -EINVAL;
> > +
> > +     switch (lsm_id) {
> > +#ifdef CONFIG_BPF_LSM
> > +     case LSM_ID_BPF:
> > +             if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> > +                 BPF_LSM_INODE_INIT_XATTRS)
> > +                     return -ENOSPC;
> > +             break;
> > +#endif /* CONFIG_BPF_LSM */
>
> I like to avoid macro conditional code inside functions whenever
> possible, and I think this is a case where we could avoid the conditional
> block with a little work.
>
> The LSM_ID_BPF macro is already defined as part of the UAPI so that will
> always be available.  While BPF_LSM_INODE_INIT_XATTRS is dependent on
> CONFIG_BPF_LSM in this revision, that should be easy enough to move
> outside the CONFIG_BPF_LSM conditional in bpf_lsm.h.  Eventually we
> should probably expand the lsm_id struct to carry this info, likely just
> a permanent/local copy of the LSM's lsm_blob_sizes passed during
> registration, but I can take care of that later; just make the
> BPF_LSM_INODE_INIT_XATTRS macro always accessible now.
>
> We should also probably record the xattr suffix/length when the LSM is
> registered, but that can also be done later with the other lsm_id
> additions.
>

Sounds good, will refactor to remove the conditional.

> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
> > +
> > +     memcpy(xattr_value, value, value_len);
> > +     memcpy(xattr_value + value_len, name, name_len);
> > +     ((char *)xattr_value)[value_len + name_len] =3D '\0';
>
> You'll need to add an additional memcpy() here, likely in a switch
> statement to handle the different LSMs, to copy over the LSM specific
> prefix.  It's a little ugly, but when we have things captured in the
> lsm_id struct it will get a lot cleaner.
>

Yup

>
> --
> paul-moore.com

Thanks,
David
