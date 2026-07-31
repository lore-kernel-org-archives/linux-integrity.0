Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E747011F
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523334; cv=pass; b=fNp/GvUWRHEKHa9yzXvlFrz80fnpT9Dnw9dvqmckAtD4/dsjfcwqH3ar4I2mIuR1xuLHZucqRXTh+YJsYrmmECN/iRRwGr8KrOKAMwvYceLYJ53XZV/mJ6yEN4IiUBSKt5jOhiJ7CXTu1ThkhLg2hjgCpb98Gb0wZWrZItoZAOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523334; c=relaxed/simple;
	bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNKyI78DcQn7ZgBLsOCmiJ9gpHXydX6a1sx0QQL6XifTofD6iOMwX6T0w8lZfWmjJrKZ+q+N1Z5JCCgXg/KOnDbt6ezmAGpFhVNZK+fiuD/JRIyIqK0nlfiLuAj9AfpEP8LJoCXwijgv4H7N+DrafcIzys1BHailyB8+RfSpmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RnJTn1gs; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RnJTn1gs"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1156454a12.3
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785523332; cv=none;
        d=google.com; s=arc-20260327;
        b=IzjGj0IUJIgmoBNJvikcU2AQWWZKT1cbY7LmsxdlimE5RemrnmlV/jcYsAuhanEJCG
         ytHtBPPVZYZcNGWZ2Qqt71+865IggOPBMcQ+FhxirezViphSuaanBw6GcVmy+S/BpP1E
         8CpJ3/PC2mHIsYDBxWg1wcXhiMiPcgI/t32zUQxsNZz7ZhXCQnyX3TP3z/bYTFKwNkoY
         LGjzjgXra0AKMUePwJr/3U0utms23t91F9+V8pL1z1tt79jm2cIoYylQ5HBxZ666//Jr
         fRP48iprIy90Mau2s3IJlpFPoDgZEMywJqqEGjmcaRAcZBekcyp6fXjhCBm7twUO4W3G
         5AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        fh=s5+WcNMvdtEuCJhr85NYYyocPDdXHvMAuh4NXolz/rw=;
        b=iHdyHIaybxIkA6QWwGHzDehYgycM+VfDFlDXv5XSqbfb1eunhrfCuiY6ojlHrLF5mS
         vYj1ksw4e60zkH7D0RPCIIoZw1x8o0xVDU6n0y6KR0btOMpWan4+KIXNsi7uVAgm1EsX
         Ow7VnhscDG51r5wISU/82LUStMYLQz85qaJPBXFvXMgG+1Uy2WmQXllIrng6rWui9mGc
         lNF+T3maWxkNUJie2WXrBDG+Ml1FDi02Q3qlPE3Wog5A2r9ylGSfQIEwKrLW+RBoKJrC
         Kq/G2woCaqG8Qrp7ynh7M94rwQKccNDmWo+Yg7hlwEVtUX2O3Fwo5AwFfNQqPdGmI8ty
         CAHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785523332; x=1786128132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=RnJTn1gsg8Uvh+FH/JN6RNrus99YZFL8IUWO8gsTbGhi7g5TdULCt76g6yFSun3eam
         /fzTn46vxP0Z0X2fnq7JigzVRr/xdX/XHA70QC1cy6h1utGmvhKCDLCFoQ/RNBGOckvg
         97y1yBejqtJ65K2/0EWVzZaebgnnON2raioNwo1ai9KoWhm+MWWt5xCgxgPjfqBM7qFe
         QNakghMFv/aMxbH4adDhNvmjTErcD+whz8nvTCoYiABhrlNcPPUHkFIIUASoypBphT6V
         5dD86q/GjkETaPz+Oh4RXhVxtcD3gzD/ealPGd28IbQNTXDVihOUC/6CdXG8SsU4bL+x
         ODBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523332; x=1786128132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=BdvGhPhIasvRJhuUqfXCuPAcwawB0nK1uFRSjjgGtGHwngqeo1hjcsJeeqjeJHiynd
         jP6sEjR6NyHdBkKsbFMzsZhpPlynbjs5aM+X+3AybjrdfqQjqAKypX//m/jo4L7c/Yxa
         1rtnLNzWYIsVK7zAjJ9YBGMxmaR5qh1+xXmLxClN33XCCQAUjXMkNP7dYj6K3ZG8H0ef
         uIA9foCOAUZbhJHis6D+lelT4MsE5OlOVCDevGsiegNHn08vs4Fdo0JjUiq6iBJfs8PT
         b8v80uNf4qBYF4dR+Sy+1RlQiZ770mtQbvL4I8tCvPtM6J1X9j83oqzzKCdeVNX5kJfM
         R0GQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGchPP8dFXtSjYBu7wY7kqel/wGvSwESJl7W/v7YMwtAbow4McSvQ6Q3bmDxiK9rwy9zzMPmsj9i0AFBDUQVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1R0iQL92jHDyWXFm4Ewz8w8JtkQQK5ndekQA4Lc4RiOWdWX4
	5zjEUCVcPGabf8C01lgCU0ZQZeibMD3/xbJ7SGEC7Xqw//JVavEvsPW+rwN7lx7BZIHtCda/gsO
	TCF9aTAKVkRKgsDYad0iQOUx/qm9v7SQkdtjEdcJU
X-Gm-Gg: AR+sD110uEhm2gkIMzQ+Hfj3I65nHEFKXozuuBdP2QgzpRAYsyj4tOINRge6YINqU0f
	BKu6mUH2JpEYX5AYUIj0qOdm8xK28QDkzp0Forjh/+ZaS9SJXwwXThWOAPA9+5Ak69sa12YnRz+
	zGthi4SKZpfnm/2Z+vvrDpennZmV26LRH4XPqlY4hIMS7aY8VZYfG2XXtFL5T+f23E8M42YQfxq
	KQVQcMICfKFvZf34tMOVHcKNnCtk0COVv5pd6PkZwpInz+u0byPtInLherDuyA1C3cP80hXBNqs
	rmAt7ttHyb0p6Ge4swCJus8hR0NHss5LxnB0Y3O1Mz8GSrO5EnuBkJE=
X-Received: by 2002:a05:6300:2208:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c92a8d3125mr777248637.56.1785523332205; Fri, 31 Jul 2026
 11:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
In-Reply-To: <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 14:42:00 -0400
X-Gm-Features: AUfX_mxuliCX4ORjmGWbiior9WDlNPKrwS-oHeLLni0oyboDwl_jDraty6suaKI
Message-ID: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:

...

> Yes, I understand you feel it should be placed under security/. You are e=
ntitled
> to your opinion.
>
> No, I do not think the newly added kfunc is a big enough layering violati=
on such
> that we need to do it ASAP, disregarding everything else outlined above. =
I am
> sure you see that too. There are several other instances of similar kfunc=
s.
>
> Therefore, please attempt to meet me halfway here.

I'm happy to work with you, and/or anyone else, who wants to work on
finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
