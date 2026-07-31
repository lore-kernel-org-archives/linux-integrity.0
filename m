Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37A3264D9
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511039; cv=pass; b=Sq6zfLj2IPq41kqs8+PMG8egfQmJWWEOrUTwTXIY6aYckjey8UmojLa+1bACaadLsAieHmXxpqB+VrJ2xtsRRo+4+6HbWkce1kQdWPSZ3rmL+GPgDb6z0eF34UthrCTnhTVXxZwn5HxVzH0eCKsWGUyvvfYdSL0aCZ9ouPKMdwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511039; c=relaxed/simple;
	bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8E+0ChGwmlDWjKvFwCGkFmSS/PSB/kYsKZ2KolZ/vEERALCySAVCjSSDlwbu0UMNIPXt4xualpJKCLpOMvw7fQOHYzLUdY75b9nKzpKdlzhksqviBlZtqN8O+F+5IbMxeBV4amuJV4bajsp7KPwNPa8v21VY9+aYfs42dgrpaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5URBVxJ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5URBVxJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacf197759so15113235ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 08:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511036; cv=none;
        d=google.com; s=arc-20260327;
        b=lIrEC4+tB4v2A55IWB0EpdgphdZ8G1zWNxELOWcq7s/rzn/0yA37UXHkmcuZSYJ8EL
         Bmmd9oOk3hfzHat8Xnkq6Jdq3qigjvwin1q9ki3Dg3kO6MIk9N2o1o0FgitVSuAq++O2
         7NroFGWd4vWH4EEMna9dJGp+So6EVYcd7a90byhnhxHhdzjhyer26nBfIQCD3u96t6Mv
         aubGwoZd0tG1S5Xj8MUUxtedHQd/ZY0i2h6cyx6YpFrxYjtlSgVu1iZQvdqzNZNZe0MZ
         jIUHxQcXbE2qurKc6pj2pa4irVP2u2k0LqgE9K/YObxwsn4ZwMeWnm8tk8+IcQRSwQIg
         nFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        fh=Qj91wsCpxfuvTRZbgYBHNTzh28V2TwG0ISdAL9L5tes=;
        b=KVFcgMXXmUlxMxX7iPC5gOoqnk/de8tM8IbcKlcbbnBC+vFvvQ0V4cwAR4VeO/IShZ
         XT05+N3QMUfNFFd7BWX45DCcVD5oKDeLrqx0yVGsbaniBMyNB4KuN9FILL/aVJcycAmR
         h2fhFqNgQMLxkxxePeloi79wdIK0ud5KkKm0hYI62SApNarIZGCcu+Jk3IzMfqcvuKpq
         KRdvQDG8fNL/XMwcLp+1EFbL8LbNsRljQc8yCVizCUh+GwDHkrKru+V/XQk1j7qYT8+r
         FO2zX1C/WVvwtSH0Ka5jineKykjogqcMR56y1C6dkpP3v8JHOXRzvq8K7a9DKmUSmN8P
         HUJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785511036; x=1786115836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=C5URBVxJ5tERBLgnpI1F6Uk1I8wczA1DgsZx6wU5E29TDJD9OlexQVboj2ikm7m4Vo
         G+DVy29rCfY3z8DteBOBZrGBt0A6NzbErXM1yBfFloMA1eBgxFG47mHi78CJI7hh5MTS
         Kajg4htZS9wNxXJmoOulS7kZUqkRiOhQe3zOkrQpebhQd9lt9YZIF1/aHmfGmxtjhxGa
         rD/2gv7lce/d0vipnWSBIgY6IZW6n4Z1DEk+Iv3wdUrZyhATZdXzysAX6p/yE0ZA9PHy
         G4lifiyT6/Kvh4p2Q7Ogfwx4NUJ17PuYzIPlojAjBifCDzNPoMo0FU5DWkCLgTqj15n3
         ZXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511036; x=1786115836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=mUef8o3RFR76ksAtxU5Y9tn3ksfZq/MYFwnROgTbIzXrqzRAgYqSAEt+YjltEWw2Fs
         ncU8o38/KnfxduHTKffZ3GyM2ySvzrGS/DXLGmh+9TW8HFHIJ1Nn/rQu3I66j1ThW/IK
         2msVQeUNCEm2ccMp+B/IKkd5JlaWgVSzxDd5mc6VLN+U8+jRQg7kJwqRXUuzlIvVY2kU
         gvrZESXNDHZWJPJQ5RCuqzPFyp9kzAFoFrlRu2PhilBIlIuFAwtU4zbFRlCH/VYJykIB
         VS/8JT7G/9UYavarj2r7U6WFJH+hbOiCdWvtnwc5rD1PAwMuvO/Bgxe6pmwC06W5n8xe
         GRFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rry0mbf4lGYl1R08+LfHdKl0zSiJrKibcszYm2ZyLbumAcW6idXRkpj/QaeDlLs7qFaujEa9xhtPkg6Qq1II2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPIAEBOZykXSZs/fCizJw/4eRSakUpIrGq47/jA7trRz7Ci+M
	VzS2j5M3wXyXIo2ig3sKuIhpHu+oKVj15GQPYZp1O64WX52Tx5LoGg9YJ1E5gKJxkYZGm5zC8op
	xE6zhGGwfNsn+R9B/Idq8WqYajJKDESu/HQmji65c
X-Gm-Gg: AR+sD115GxlDdV1IUAUw573XwzJb4QKXGh8EaZJLnC/885lLHaPfoJKA2leR71KLwJj
	xPXsoHgxbPfWQGBRZmhxLxj6r8Byty7Ek1ezMJobOouTaj49tMPkPHfP2dIq/yeD9FVYY2+EYZ0
	WVaMFoRq+vUij6Y55xmz57UnqWSP1vJqz/4aNhDDW0meBPib4QqSHjB90v7AjFwgGNOM9E2Zfri
	0cbTiR99AfwioJLBSP9ghuUD2kO9AFOcd3NwP7ylmX9lj/vUWC7BLS+y0HPGwr2Es//r57ylk1T
	U7hXPM+cmKqooN4v4rnq7V7TPoP7+qnoNXTEBt3Hb62b
X-Received: by 2002:a17:902:ecd1:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d0523b96d8mr3879785ad.22.1785511036384; Fri, 31 Jul 2026
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com> <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
In-Reply-To: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:17:04 -0400
X-Gm-Features: AUfX_my_07XA5O156m3d-t8I3fv7r1HuUVA6nIPOKrM8LOdCX7kqs7sLBvl0mUM
Message-ID: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
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

On Thu, Jul 30, 2026 at 8:01=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Based on our discussion in the v5 patchset, I was expecting to see
> > this under security/; did something happen, or was there some
> > confusion?
> >
>
> Nothing happened, perhaps some confusion. I was basing the placement
> off of Kumar's comment in v5:
>
> > I don't think we should do that in v6 though. What you're describing af=
fects all
> other xattr kfuncs. That's a broader discussion we should have separately=
 when
> folks are back from vacation, and more importantly involve FS folks where=
 the
> code currently lives. As you say yourself, the lines are blurry, xattrs a=
re as
> much a filesystem concept.
>
> My take on this was, leave it in fs/ for now and then litigate the
> placement of all of the fs-related kfuncs after bpf_init_inode_xattr
> lands.
>
> Happy to place this in security/ in v7, if that's preferred. Apologies
> if I misread the thread.

Okay, it looks like there was some confusion/misunderstanding.

My understanding of Kumar's comments was that he was referring to the
exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
not necessarily the new kfunc you are proposing in this patchset.
Kumar is welcome to correct either one or both of us, if we read that
wrong :)

However, regardless of Kumar's intent, speaking as the LSM maintainer,
my stance on this is that the kfunc you are proposing must live in
security/bpf_lsm_kfuncs.c to be acceptable.

--=20
paul-moore.com
