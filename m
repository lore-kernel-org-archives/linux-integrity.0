Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C54418CA
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512005; cv=pass; b=XkmwWYni+ptji0c5OWD/UhOSfX2rDPPaqHfdTLb7AWg44GNjbosmOqIuVVZb9jSczbptvDjLLUU7PwGmwPoYlDfomNdfLklKPdURuYLBqS25t57aqyN2jsh0BQhSPSjn/hpgp3UucZSohCggLazfv09NhIsZtQsOwIAEGP/g6G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512005; c=relaxed/simple;
	bh=VuFNcnIpHKuBE9TqXe/JfxuxV9DEEfYcH5BhOui7Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEE+THOcHyMiqSiYNaX6WdEdeju5C+Ru6L3sQtFJ+ouhCUolgkeUxvJ02G3j6g3Ir3XBZUtLSbbtM8dVGcAqOjL3Fp6HfNnSkbTjEB30iKdFm0i3oCrnSeltVjSvowb6sVPMIZJBiJutOXKn4TlMcuz9bO+0bcTbi7WGpNaVnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WlLS7APe; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WlLS7APe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso978568a91.3
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512001; cv=none;
        d=google.com; s=arc-20260327;
        b=PrRfwgC0Mwp6LLlwuOfiYDzpYWxsov7uLi7HKCU2U7I2G4vHpc6Zs0tp+YQ1Wigt8Y
         SvQ5VtiREs0xUdBk6WfKBPomQcpVc1P085OZmMj+2lVagFG2GtC/M8vyTUqyFve0nRK1
         hRAeBh5yf+h31id6LPII7ml5WZQ3ylHMkAgTEHmiBPN8vWv+E1yWzoM33uH2iWTm3RiE
         rxHCYLA2HO3FgO66QStOWI1CJ93cxZo0b3Nq66GMfFoBUI6F3P9a4QjCzq37aMrDiztX
         aYw4E4XMv27VxXwk/s3cDApDd/XTJN3sCW5thyqFKriSryRK8pJwxKARsL/jqOffyr95
         K2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        fh=YBw7amj4N8jwgU9D9kY4T818UnVJ0o+dTuzuiOTw6VY=;
        b=lzj5G2+v8ZAqhR/qalUi0v/5PR+HRqkL0UTsFzmLGJOd7cy4d0NPe9oPcZ2ub5A4xg
         C2El+Cg2lv1JKUU6CeLNJKxba6pqDhLVFqTGNIw8QfiVSZEbLpNQn13fYSLnqmnrRTba
         JccXTw1mDA5ksRDJLX+OZ+JNroMvUZljwRhPQM/JD+WkV4TNHt4+jEDmNVvG63QiszTb
         g5AO8sDF3vNmMF3C5vkeLnGir5cu/vR219qq2yZWUHVuPE1IG4M1CeO5pLsSGA4E9Qpn
         WKLi9rrgK10qvsF31d8MgclhWih4jpaKgQ1YXyZEYNeWORM5TeWf3q/gnVA2pg20zNQM
         O2jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512001; x=1786116801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=WlLS7APeX/hA7NEpMaOEESuBOy9fewR9hgrNZhDweuEfsAh/zoyTHKGTJF9U9J5tq/
         s847tazcBtQqqpEIPCZXBYyQ3TC7humVlzydKPbO8qx9opWFdjz7TCnoMEGa4QIO2Wi+
         Ahj5xFgBiGOukwhXTPUjJYDHwXCGm1hXlbLknTbkVQvxbQqL2OkPbu3WWjJxOCfQoua4
         v0rgXyVwMwKBUiPTrtFyuoJ3JH1JQYPFRfSarLn5gtHHWLOZnhRsC/r1ro+0psVHAY3z
         /saiuR+VjYl9I0MSElkym7L/BAmicvjWjbB3CcOZUS1cwve44tpIhC2lftzsyegxt5Ww
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512001; x=1786116801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=FLuPfDtAZv8PuSJSwC9yXZiusWxQZ/ap6crzz3ZErkfjtwoaaoMvvuzANvMuRmMBlI
         hSSIejSfnwvjeR0o63DePMpit7lto2agg4baYwmc4Ac1ecIPNesRssi7hL+YClK71str
         KHm7lrXW1fp2hZ5nSWQQXyNcOVYvL14PHlFc1yUr4IJqNZdXy58fs6Bfp5xiMQmK14zB
         uhQ1BR4S5FnO+aKNdaUK6ux/bcpqiZyYN3KTypIZaMpJpKS3hy3eD1cdYj21wioFjpWO
         zX5SC1ckTe8KPs5WOR77SpNIZ7y8CNIV93y59p/Hp1GFT0RG60C/9a8m4E3t4IZkNaAt
         wjTA==
X-Forwarded-Encrypted: i=1; AHgh+RqdVKk2GLOCEkfLlXxmHWa3MUl6Ms75yMyqgoa3TB/PpCLdmtMAJpUUyJnB82TV9heJ0vMLiombcjGWQYj3et4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxj6vL+LUGxKQ937U3riAldai4J1GS5wDv5r+Fgkk/uK572wl7
	TUmRHsEtGBzv5cZu7/1p+mQSqJhwxMiV03xgd2+2WbazbKuo+xGT/5hqevLtrR8mGeXBgPQhO3O
	CzQ/9QyMhljAOYKs/JJWCVeSYR4e+B7450v6QAB3J
X-Gm-Gg: AR+sD10Nc7vkx0+Rx5a8mQKe0FW2VY5Ow/R4dyV7rNvxM0DyW3YlPFkdMOR/D06R6xY
	roMN7h+/H7XBDmtsenYBK9Ga0X+x7hBdzTuvYwW5MhzuaP3t9kabzljAq5JQaALbw4inmSys0Wb
	KOx7wQ/Gl9ay1vHiEG6bCGalFf1h+zVPONkTt4WIK++GsT87bZ63wd7RNXHRPj+bvIlwoLt9bq4
	/f5PQWsS6Ng27GRlG6pfxQDC0JF7bwC5i6HF/U50gSB/UpiykOWMJMhtMEtMr5oCQD4hnqgAf2X
	xWRAkYV05mB+XHC9vDUCNarJuLJTbnmSnkfObYSkf95f
X-Received: by 2002:a17:90a:dfd0:b0:387:e0db:bc24 with SMTP id
 98e67ed59e1d1-38fbc5225dbmr287131a91.36.1785512001460; Fri, 31 Jul 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com> <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:33:09 -0400
X-Gm-Features: AUfX_myWZz1m6PowWXy7WcdAAbaku2QnixOSUt9yTgIUfLpwiNvXahY7xKnDbwo
Message-ID: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> >
> > Okay, it looks like there was some confusion/misunderstanding.
> >
> > My understanding of Kumar's comments was that he was referring to the
> > exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> > not necessarily the new kfunc you are proposing in this patchset.
> > Kumar is welcome to correct either one or both of us, if we read that
> > wrong :)
> >
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>
> > However, regardless of Kumar's intent, speaking as the LSM maintainer,
> > my stance on this is that the kfunc you are proposing must live in
> > security/bpf_lsm_kfuncs.c to be acceptable.
> >
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?

Nope.  That patchset has its own issues, one of which is the location
of the kfuncs outside of security/; I simply haven't had the time to
review that in full and reply.

--=20
paul-moore.com
