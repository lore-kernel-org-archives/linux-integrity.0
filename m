Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3D25B09C
	for <linux-integrity@vger.kernel.org>; Sun,  2 Aug 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682215; cv=pass; b=j2fkdof/XnD9fcU/85QAUT2GMn0egQYte9DNnHVNKcfVJ9Q7tCH/URF1I1b0qs6jxV+Bh7grVegXwbCCrcSERYPnikVUfb8NP4eE1fsyxIgfHLprbJmNXYo8G3fCFVjeVzmH6eHOHxLN2argvzWiIJ5R6SsbldwixuM1eKjpcRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682215; c=relaxed/simple;
	bh=7kkcp+wOorntAb3DNadH0Q8Sg1yGSgKiD+TONbs7qUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plBvqhWutP3LSs0v+wpCKGnM08QrCgBFEbkLBygKYFTODsSPgeJZCR/KXSTMjAzetqebbNIPdnYB2C0M1deRkBuOpEEZ++wGgkZZnR92QeAMGK4IZmHBQUPX2JzQsl72GAmQ2rgzwxCV7xW+nH060EuhTNHX9qiHPeAwMQ8e/0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3TmUEmD; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3TmUEmD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8487088510aso2626214b3a.0
        for <linux-integrity@vger.kernel.org>; Sun, 02 Aug 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785682213; cv=none;
        d=google.com; s=arc-20260327;
        b=DXYmjnAP8kKmGusQwnq0ubTt0g2trQn6Ta3yJl/MwfOCdmmcJzHc0BmMz/E4erDnQv
         VC6oCwdssB8tBqFUG/f7B/0HLcqV09SD4kHfgviCMx7Y43fKNeKjQKS/y7mB4NsW7TXQ
         moupr6Skb7T+U/wbn6h8NHRu9/pp3eWPnxoOOPij9OGFic7XMSFFMb5uV332+531rsRB
         nMzIHyu44wrQ77xMY6o0hFQgDmW2ggvocsuD/2/IUV734CR/M0vky+wNXnAP46hHU4KP
         bkJGXSNF3q61JyQDm1xINtSbC7zCpCdxj2KBjPIdK5FR6Dn/rycVCgmhPWnae8hvzsh3
         bTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        fh=9yebfx/u20iWusunoroLQKlHDvke56murJkcfIJm1AU=;
        b=nBEEa6uxpI1pDg78huFmi980tyj5Jbldeo9cUHDGZiq2rZUV6Govs8zrmdU4kpKZV/
         e8sm6E/mDUOdfV4iBu3FCOjwIP+0fgLHypKlHTZ/sczD59h4QAyV0/Ptn6Rc3RtKq42m
         yBOoug2hJx0rwnx4JVIvj6KrPJHGXSMxc/0bdpLog7lkBLv9V64/0FvkbkE7rLZY81EM
         l+dKvDUtyn3hvdYMjOmUMLZSS9YZ/qkQmyEFxII/+URC0OSIiRSsv3YWGezIMCKCcg1q
         PWfB0zDqlCbiRWt/GgmhWqoBMLhJ6XE/sSoztWVn+VyIkmY4dS4yXzM/cMlhHzuTmoWb
         pEzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785682213; x=1786287013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=d3TmUEmDewxJT2GJJ7flVa7AXI99c0jYB/Vci5U63n3USKpC5+LDvLpUnz4on+ypxi
         a/iyVr7JUa0NIzulDnSprmnZdyTmouYpUiDDFC5wel/7jkvzaPLhR46rOzF/X9RAu6AT
         1g1BZaRSKENCDMGTi7RlE1Xu++pjSkF0+9myK99aZTDszaTD7vn9SH4p5xWpeUJ0kzcu
         ln9n1Ye7sIwrY0SUdzj58jQBwZbVu9ffhcJeJlsjiJCt6oKF0Nmoz7uMUf9iOQRkl6Kf
         abDInXlm5RnSjfJ3IH5DV0+J4Z8YI317/4LJ1/KC3fEioyR0GHlcv+b8ZtLGH36/6mqk
         cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682213; x=1786287013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmgWl/f4uXW4AQpzfCn2lxP5muAJ5BUlRpvNvDKBVgs=;
        b=tHtNk/Iowl0qz2ayDlCk8zbhhWfgCbIwFQYIW6pldO7DXfJfNnk5yzscQYAA3MnReU
         mDoJz/Q3yJD4l9AOCSrg5qk6skceMF3wjHIpVVu7O85aglDnY23l/P61FM4N+PjQycng
         irzRdwY+EFCnZ302FvrI4x6HAhVekZm/54BWpt4ri1y8QwfmiI632Hchq3EpOalcIpdi
         CA4C1z2rxJ0SneC91mBMLmpw7oOjzj1LWOSAbrzUGlwfK3dM5IHQjbKQjugsguYjkrIV
         mhbn6ll5fe3YrvWTVMbXGPS9MhDygsN1gOjYQuxrJVk2rmnYkg5o1WBHvbNxhNZ7pDyS
         ZYuA==
X-Forwarded-Encrypted: i=1; AHgh+RpC8uap0j1m4GMQsze9l42E+xzmnSReW1g/wBw8exowKA6gdcM1CLJT3VRoCpEcOO1aWySwvMjCS77au93jTRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWViqiw4DwMLExHnqWXhgvDwQUPecpepWj7Ygcgv/JmgajGEE
	hlORbQd9YD5NvK1lOXj5FMJr7JB1bm4y9/QcbIAUzrPP3/iftnPfwrU9GNt69kRV4qnKLkddi/p
	mtTO6BHMJE5yg4AGz95kJgkmLj7IpSsE3mbNctxmm
X-Gm-Gg: AR+sD110s8g1RbPVRnAY11uFUabmmIc+QkZQmNrhQbaSlD64AZFtYytF3TlOvaI/8eq
	H/0RuVjbug5wRbeeAdT64bUracj14tAIfKN4HiM9qaEdMF3wZmI2RISfEdWKE7Lh5C+9BuapKyl
	JX/udaMRohM808hHY/m+U4UgtXF2CRrl6X5TcO0dYt39Tqu/hy3AHBMdvJbJyhyd0GqoLfypZlH
	1VrxgrFm4gStRnOf7yTpvfN7Q+NwxjkGEMU+17GkqzTBD5zDc7ciJT6rSv9Y47CFFyGhkO1bHN3
	/HwOzs8vxTzigz47feVi+vPQegYiEnL90wc2eKfBpfOY
X-Received: by 2002:a05:6a00:9289:b0:848:6c1c:17c0 with SMTP id
 d2e1a72fcca58-84ee47c7dbbmr6238656b3a.19.1785682213526; Sun, 02 Aug 2026
 07:50:13 -0700 (PDT)
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
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com> <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQxeNJ1U_cUX=4mdJT17jG2ZFY27YM2CXK8wcuRPQYtrQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Aug 2026 10:50:03 -0400
X-Gm-Features: AUfX_myOurolkOWbQTM-uf1kAESEJT0FADttjcAMdHsh5yOJTC09VeSrydmRClc
Message-ID: <CAHC9VhSRbwLD_yxEPKx38X59KcjZWKPQj2QnGupP4NFC6zu66A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
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

On Sun, Aug 2, 2026 at 10:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 31, 2026 at 7:11=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > > > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwived=
i
> > > > >> > <memxor@gmail.com> wrote:
> > > > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > > > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> > > > >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > > > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya =
Dwivedi
> > > > >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > > > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartike=
ya Dwivedi
> > > > >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrot=
e:
> > > > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kar=
tikeya Dwivedi
> > > > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore w=
rote:
> > > > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar =
Kartikeya Dwivedi
> > > > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > > > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Win=
dsor wrote:
> > > > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Pau=
l Moore <paul@paul-moore.com> wrote:
> > >
> > > ...
> > >
> > > > As a consequence, everyone suffers because they first need to satis=
fy your whims
> > > > on how all code and kfuncs written thus far are wrong, and need to =
be moved
> > > > around ASAP, including the one being proposed.
> > >
> > > That's not a reasonble or truthful summary of things, I've only
> > > requested that David locate his proposed kfunc in
> > > security/bpf_lsm_kfuncs.c, I never suggested he move any others.
> >
> > Looking at what's left of the kfunc itself, it's basically nothing.
> > Everything meaningful has been moved into security/ already.
> >
> > Aside from bpf dynptr ops, what's left is:
> >
> > if (!name__str)
> >     return -EINVAL;
> >
> > if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFI=
X) - 1))
> >     return -EPERM;
> >
> > if (!xattrs->xattrs)
> >     return -EOPNOTSUPP;
> >
> > ... then a call to security_lsmxattr_add. Why not move this chunk into
> > security_lsmxattr_add, and leave the remaining bits, which are pure
> > bpf, in fs/ for now, and litigate the total placement of all of them
> > once v7 lands?
>
> Thanks David, but my comments and decision are based on the kfunc as a
> whole, not necessarily how the work is divided between the kfunc and
> the LSM hook it calls; shuffling bits of code between the two doesn't
> change the character of the function.

To be clear, this means I would still need to see the proposed kfunc
in security/bpf_lsm_kfuncs.c to be deemed acceptable.  Also to be
clear, I'm not suggesting, or even requiring, that you move any of the
other existing kfuncs in your patchset; I never suggested that as a
requirement for your work.

--=20
paul-moore.com
