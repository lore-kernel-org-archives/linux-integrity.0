Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE223C1D68
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539481; cv=pass; b=OYVxIzPMOvY8Ycy5h1FzKhQ87z8QnZ7DlwuVSn4CADeuI59wBGHA9XhxPuabsGWhd4I+/ZV/bUo8TrzVSm2IAYI/Pv4EyfkVvzl1kNlyfm1zHu0TL/Fwgyegk7wy9PemxApiA+ewt44ZUrzfxCffaUgmGPmKRO6fPeVQokQ21FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539481; c=relaxed/simple;
	bh=Llu5HYAUV321zAUTnCstCUwOGM/uo5kf8WVYwVpTpcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgYnkYw8W5eY0AVxhxyOK0oxkI8ll0NKN3lBZSUvXQioz4PD4mMj0Ym9o6ojwWZNuAc+EEyhpeTnz3SdiKYpd1mNNBTwJUu16AXsu7emTkg8bNtpLi0dr2K2L135KiAVEp9n1V4yW0+hwINXKzukeb/iyOEGMZo/mIwC8DUqqeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkP5+j8M; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkP5+j8M"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so11876046d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 16:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785539478; cv=none;
        d=google.com; s=arc-20260327;
        b=PDl1brpOhA5fHLOpLgiS8+bpjt20ffSujwXSJk5fwdDAVAC9phSNR3CJmF6Yd/veER
         h9aa2J/Cp2aGtoK8lGAwCslUjb5Qoe3xMY8KnOPOYw3GOMfz/+cNKMTv20wnqSO00Y2f
         KirBDVQ7IRcm7cPoiLj9Qny2dPriq6Tmx+SWMjldyBdzc+9cvw3dvVqKdp58jBFxRr4J
         tI0u1C4f/iwQ/JblSnlAxZz6dw4sYS2tJB1u9IexZZxtEp5NlHLnVn+lB4o9uCChCXll
         ovWCfo2o7DTvKEZsubYvFcqnp7RRzRGzgr18g5fzpkf/U4is4GzgBjHuWgQgaEH4Ee06
         pLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        fh=5blta2lryOhKgqP8WLRStu8rXxCnO5Rx61tMNf0nRqQ=;
        b=NoZQgFHpY/iB62TCDlE3M47QWtgKsTjB3ky3LTfcQPjgHCJmj187yhsUsZ1Ji5gT4t
         RBwkzhIABT6QwBWZRYRCuvcRY2PPysLHbBGlxGbYOMQ7WQSnVeb8PPCvs8gXq9kGyM9Y
         C709Rbip34mZYgS22q6V24K44C5gvIwJoDxrUuVq16ixFDM0ASeMYBCJjExh0sukey+W
         PiQsfqUNugTc1LhCVsqbGoJ5F81nmO20c3Gn5p7lzOHyIvJYtA7VHEVhRM+dLAq4WmRF
         iWc68IOyQVcQrpqwQumDSFOG//eTIpiohtlYeTnq7RtCJEWJdg6XR+wv+BNOP1oWAGKw
         HhfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785539478; x=1786144278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        b=DkP5+j8MtScptzTZZnZoYBhfOUHmZwzeK8WdGHfPWN36kZeocMag3+pCM88pmWDhpZ
         DX0QH9f7ipRD1u6qpcpkTzjegZzahuBtHqxsLLfx9wJ+UTMIrk/4Ukwk793usgN6vOr/
         Kqn/yBhjePKs3aaWE3S8oZ1YlNe6ISadfknrwCnT0aYbeNCwa1LjHRmg5UorJpK3TfQT
         BMqICM4m7i80OBjSyQW0QYcYbNuBlptf6i3VmBTecwYaCwBzvvY3SaASZwGj3J7jZ1G6
         TRkTAYfoW+XygO65RPDOvAtDzLd63W2G7Ou2mtI7XSq2IEP+ubjOl8j+1a/z/Qb1Zasp
         O0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539478; x=1786144278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        b=F99r4LF0zQX2TtfSaYPfl5ZdY6sGt3mxRimY0LwBUsLAtH/C5Kz6WRdD56qqpW/nwL
         g19FH/CLNrtApZQY9aZOV3o4YV8EvVDFs/40BmOZ4U/f5xVbwgC77YV3Nue7axRX5G/a
         oSggEnXepfRnz8GiSZ/aP1l/p6t66cFw45u/apMWGbDvPk52B6UYDJJt8aDFYQ86WMjn
         8jZZgGj/IlZtg+8WjcSzGT2CwIesnQCw3KVortRyLcS/z5GcLsud9MXWFxdl/GERJJwc
         mGxKN3ORrc0U3YCMEJu+/Oc2XY90Q4stL17QW0gqdWyHsvaNrJ9kWdUjss9gac7KX0Xr
         k8Bg==
X-Forwarded-Encrypted: i=1; AHgh+RrvJ2mVo39wDs8xHiHesN1WkAdNdXcjmXILIlmRgoQb9AAY8kyO6Howgp4PhqEj9iQl88nm86pSi15FtWLfjJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZ40RWbV2GLxE7ZHb/JBdUPPImi5O2jAtkCyKTqqv/NW/+beU
	WbGsy6r5aBvvqFaOlaT/yycx1SaEOLkEjaG1yUEE+WETFGOsPph+ODksLEZaFwvDvyomCBfvuJh
	d6gZxfa5b4i+bTCpl2cBg8g0MqHUeHaA=
X-Gm-Gg: AR+sD11bqLq6cSs6QSUEHmcFUVrwr+qf6Ekl6A6KMY+KSr0RH4ou7Z1FudgJ3p3Q7J3
	y+mmLaGq2jLLmuO8/JLxZAreO3Bx598BC6DE1pQDehUvy21c49WdeAzrMTnKO6C3dZo0iPV3WCm
	PYOE0/xrDyNlUJx4eJ+z1+SbbjQcY9L3Ws9Td3tPHPnGDSRgn6xrd0zX7gedN5k9GSHdm1aJYXx
	9mPXyoJLPRJmViZQYa/VHkVqiY6Z7NojqJQ1ETIVo0JonkYb4e5p4K+zTT9u1mfFNfDYq3z9HFu
	8Gr5q/WU1fG1xuAbHURIOVvutsJTaRlL7Js6JU9dvLQzi6CLujQrqyncnXEVdCT2j+o52U9vxZs
	=
X-Received: by 2002:a05:6214:5401:b0:8f2:1d56:3e8c with SMTP id
 6a1803df08f44-9084969d98fmr42804666d6.29.1785539478275; Fri, 31 Jul 2026
 16:11:18 -0700 (PDT)
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
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com> <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 19:11:05 -0400
X-Gm-Features: AUfX_mwPT5QbHLoShK8MUNDhV1cYgpH-wDwOaqHd4-WwjBfuCUGPSRVDO_MBrPk
Message-ID: <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >> > <memxor@gmail.com> wrote:
> > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >> >> > <memxor@gmail.com> wrote:
> > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwiv=
edi
> > >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya D=
wivedi
> > >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartike=
ya Dwivedi
> > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote=
:
> > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kart=
ikeya Dwivedi
> > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor=
 wrote:
> > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Mo=
ore <paul@paul-moore.com> wrote:
>
> ...
>
> > As a consequence, everyone suffers because they first need to satisfy y=
our whims
> > on how all code and kfuncs written thus far are wrong, and need to be m=
oved
> > around ASAP, including the one being proposed.
>
> That's not a reasonble or truthful summary of things, I've only
> requested that David locate his proposed kfunc in
> security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>

Looking at what's left of the kfunc itself, it's basically nothing.
Everything meaningful has been moved into security/ already.

Aside from bpf dynptr ops, what's left is:

if (!name__str)
    return -EINVAL;

if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFIX) -=
 1))
    return -EPERM;

if (!xattrs->xattrs)
    return -EOPNOTSUPP;

... then a call to security_lsmxattr_add. Why not move this chunk into
security_lsmxattr_add, and leave the remaining bits, which are pure
bpf, in fs/ for now, and litigate the total placement of all of them
once v7 lands?

> --
> paul-moore.com
