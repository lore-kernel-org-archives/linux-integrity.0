Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90E442B0F
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511856; cv=pass; b=oI72mdzz4jdQtBxGGzT0AOpvQxNYP61Jq8X5mV/OzfZi2tUzwqdDF2r4Xnqt5Tr3MXQrRw5NwdGWnJKqkcqXkWvzTx4241FeFokFfVbGOX4NGh6WpyptwdaUyXW3SUzQni0+YiRR4GbMCu4UL3P1Ha5VgU4vXdwQS9sWocL0mOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511856; c=relaxed/simple;
	bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoW2kNsujitlyF41vrUNZHInbZ+Q0nMcGpsW3cEeZNFsKFNWEPNZUSHT2qsdpxh0IP8otlEDZga4+6yWbAEIycLfPnFC4T0Wdtu7Z3MmHGWWw4UBcBOH4PnJzEw0dhZcTQxpvKo/PU5hiRKrhDfrKVL5lhtvVP6As/8s8OyWN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv7almrz; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv7almrz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b4e988c77so3246811cf.3
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511851; cv=none;
        d=google.com; s=arc-20260327;
        b=c2eiL2YmPOUjDljWqR9Y0Ja+j6D5Xud5HWG9gh7VgnpwDsW4gHYZ1V1VYNTK0ri1/P
         wS1z01lL5WQdAySldSZCy9tiRr5zCgzBmrRsx8OhZMGy/CbtvU6wSZKtg8/JmHSSScDC
         0O2XLDIE2TNrw2BuabKWi5CQH8fZFizeMhco5/Ub8j7Mn45aT2+OIIZfAon83HiiphPy
         6n0E0mSKd9FvrEdYBnzF4jmHtKSwu5lYlEkY/V3/3rEeonazcTO8XInTAWQ3xK0jDxQ2
         tG+UV81TJFPSLuqlUFx4m/qf9UTWi5LzaPAZ6GX0IoKL76v9XKMPzZN4irBOrNv3lHRR
         zVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        fh=UHvGIlAWHE0YS/Crl2Yc5/8cc7yr2s9axhGqKSHY48g=;
        b=Yx/FTQJdxugjNZJ2ih5sFrsgib9QO1i5nRr4GuruzU3sp2Vg28sBNROJp0OctcoyIW
         twgStBjSR62M2tWUcppricNDK7Lwd9EMNMUai55X+FgU1xK227f6yAU7kqBGXNO0Acxp
         qk+KZH2qleJtXYAqiT3U7ptJPrV0x4Sqh03+BrE12/uRvYsw2+/Q4VCymKBe9JY8d75u
         +fgki9OGCW+iUr4PwlnZS1vAAd0c7DA7Yy+/kyzHwVy/rIGNHocuulk0VaiswxG5TiT3
         VoWqWfHeSyvIFB9oXbmaH18myarreCyV2NdWkCnVZ2YcwdtRfj/E83TQSZNEx+WQRAgD
         mEEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511851; x=1786116651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=Dv7almrzLgInu2aUvUTgDuu+AvSYoQPoJXwtqMKfNk2NvNgNV0ChgtOEbKITkDLxY+
         IK3lol9An0jJKwGRheMIA+9coU1UPxmoAQXv745nA3ijvQYWSKJZRN8CRoniQeol38ty
         TMd53QOjEyExUV3Dj2NhzYMcIEB2SYh1p/oTzzwX2fZkKSSZpAtVpZs4neDvUFx3FpTD
         vXMdnAtoW/r+VnbMyBqM44EFfSx+s6qUJbqq9+5447JTkLT55aJd+QYldBMRk5bXcXUS
         vDUN4pPibTIVAwUfmZ6U2mv9dGMTQrLPcQD1aCC+5XDH/zI3oiiwu0b/0yey5Qx8xxjK
         0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511851; x=1786116651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=gXF78DNu5DtnWR0Z7OPRnlHuwyYDNREDN5h5XOCHtkboBHteK9VkB3lDflYVx0Is/6
         gqC+m0MJK+A57smA9Ze6IO4cuQDe4N2Le3bB6GmCZIVCelH3iirAOwxWA1iE5U739atK
         50R+lYR5xGOAa9KywHmeIRyFewBN1IvZcamUX4Snqto78/+9Zu1XYo78N0Y7+mDnJ7iQ
         3im2U3LVjMJL+F8i3sY3SdZVxXAZt8XvIAYlcxN6JEqPiQ5fvTm7E/wJeQ4te46oAMpY
         cW3br2XHUBGqI0SYhpopswIP9GaNWMeWOptax+CF9XYYEUiS/01Q35S27n4aEuv+vo7c
         AfDA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/dfJ6Y+t4nfPBxFfRWzSywIter5hIqVffg0Olb3CMEsOirpfPNvpOQJO2yUI78K0xYvi/350mBjvq8bdB0P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+Y2vn9jDT/R37S5CVfu0vuQQV/a4PhRvroiOKMO3ydZgAaQG
	0xlK03smANT6hpJ10bhlUfKgb35ejFGRabTqBdvxMe/VHjtLhrRH04TkmE4np4m9LXkShxjWOfI
	RywWqskj61o7CpUJkhhelp9al9z+KHcU=
X-Gm-Gg: AR+sD12AhMcWfUIwC6RJnpZqlLGnobhRFutjl8qUPlaJuGHGEL9bKziZJ+QAFwn49Be
	nYcWjAuCi1ftNmKPROgth9+rqxoCONMhiUGYxnhnEy0B+CBdHZIJiUDRmDbHD7R5N/g5l7YSuYe
	yIo802QqrqVJBhEMw/u86XaDt/aMqsnHhA/WicqRhaF/cv002Pg5y7utRlf2XTfoTuvJi/y5BJ6
	JzfYPT368l87Q5G5asAE+MyVTvDoPUI3xrLO9exp71ndmNbCPWItMyk1lZN8MU5PlFx5UdefsXq
	236mbWHGFp8EibOizmv+V4O8TKUQ8eZ1d2cnBnIwQQT7/pdDDJZL8kk+BRPpJnvvwO5rXDFOjEg
	=
X-Received: by 2002:a05:622a:2590:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52b56673ed7mr13843131cf.1.1785511851030; Fri, 31 Jul 2026
 08:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com> <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
In-Reply-To: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:30:39 -0400
X-Gm-Features: AUfX_mwCzstzsX_jENhs2p3EGP2HH7m68AkpKrdRcMR6AmexYou-kWEv9wNOVLk
Message-ID: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
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

On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
>
> Okay, it looks like there was some confusion/misunderstanding.
>
> My understanding of Kumar's comments was that he was referring to the
> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> not necessarily the new kfunc you are proposing in this patchset.
> Kumar is welcome to correct either one or both of us, if we read that
> wrong :)
>

Yes, after another reading, that does appear to be the case =3D).

We'll need v7 anyway to fix the ocfs-related UAF the bot found.

> However, regardless of Kumar's intent, speaking as the LSM maintainer,
> my stance on this is that the kfunc you are proposing must live in
> security/bpf_lsm_kfuncs.c to be acceptable.
>

Ack, will do this in v7.

The Landlock series currently up for discussion [1] is proposing
placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
go there?

[1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail=
.com/

> --
> paul-moore.com
