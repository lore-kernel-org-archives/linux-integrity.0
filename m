Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34A28CF5D
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530929; cv=pass; b=skWoyjNKl6/h792V+zhKQySWK1EY4JJ3T4SOZ8K9g4gjdYnL57O7kmjqWwV3xfCi6i6fwWcUiPv8JIvTW7Z0fOn7XGDFnNx2viY8LaQ74rRSyURJ6lYBQpNIgJZjRZTeh+Ohj9FmrRanuTdLRjuyIssowWYIcTqdZQVNhlgAR5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530929; c=relaxed/simple;
	bh=M8VnBEn1fzw+IBCpYk4jT3YhvULPCFsyVr4mz7NayKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP2UHttTggVn0N9QHUUMOdoN2ERzcpK7P2ldkgoGMDBug3ZXphtf47l6YhPXgp+FbxRadsqOZJHkCJilDd9Nj7b/TAjWY6USGrg1CjyEotWezytbzDkXr6xs1aGROubOygvuAPWfPm1C3NvrZ3FCfL5+eHlE3J3mleHYQPSonJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LdHFbH20; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LdHFbH20"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1063183a91.0
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 13:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785530927; cv=none;
        d=google.com; s=arc-20260327;
        b=rj9OTS1HYqNrM747iYPq108nvDDpGCqFhw8rWJb26Wx4qXv+d5HZCCk1qstre9LNXD
         NFFaus4GIn8HEstk5HWdueJ34OY/EBVs9sMuPeuEtZoueiv8KRaOz32STFMyUhOPHDmJ
         cePPve1GDdrCIrBudRNFzoXXWZpEm7jLEpRAQeangL1jExv5rE1JgMXmikqkYvHJCzOo
         VgHNkbsCDt2jfoQsTMPZGnkR0vJv69eNU4yE4ipv6IVxH421GR+4+vSfs1NGN8MPwuHt
         XFi4/Pz8Rfi5ePXesBqVsf/6D0ApHPvFAmh/TDSr8xA2OpAMXxJe7LPfEq3V2g8EvO1B
         jXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        fh=LG9OaU6JN2s0jcg1UwjLIlYKrhrihhIAw5hBicsfCW8=;
        b=agMuhVkuVBqPCdxZbZjPrG8dC2sY7tzhH9exma46U2SKLr50ewTa0MCndAhUfBFXQK
         fnWSDZBxb4zL0VSf3PhN3GiTshnDJYJXkiA2ksSiCS4BDrvkFaLN+LPB8QOLNftrnyn4
         eWzUo+lMcCka3jAqmY/rIvPSxQa6EgxvWDKoDt5HdNigslgY7HNXNpOjAvm/+oODRREl
         bCUV9OgSIjits8CXbIXS/1CIQkoD/vm/qGvzU2TsheS7/nMwqZYqzFeTYom3KzKkgtnZ
         auAnOKV1EgIl5GDc/WLLKHx0z95UIKkJw2Xnc1chb8+MFYWfOqLn/hLMvsTyst4DiPFk
         s8KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785530927; x=1786135727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        b=LdHFbH20iCZVdvfuvpPkfYhY6pFn0NbfBZM5U58l9BQg2+6m8rZ+bUHF8qH19sXw5Q
         wDxZeTkPpvyefiTYrBQ1nJWXiGVQWvsrrP46ruNDRUxJghwLLaRnCX5I/hm8ws8TNxuK
         weSJbzouzt30b0fh72kvnGnVRemdDNcpUN+Pu6mNibI6yQe6VFweS6kyNnz/r0XdgoB6
         /97UTU8mULx8K+Q48/y0eDhW/h4sYhi117eAuYl7jAmXBDXLVvulBBzUysScDAno6yl4
         owulwUZTveoQTyt6lOdiqcV8j1xtFIMm2HDSa/p3zN+pL7EiE89JWCI1JKT1l/3lpxDx
         9v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785530927; x=1786135727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n99Y4TVdVLwkrmbFc6xvkbJUkFajn56eSscgelJgGwE=;
        b=HkpCgkOznXpQqIsRoaZd/o77+sP2fR2AO47cvt1nmrlTFttSddTF5Av0wwWqwegg5R
         jw+BDtQ4qkGqrzbU4l6pj7qT1jvOnKaJ3N7A1Ch7qxSZareERjK3QZ8OZLN0znyGjx1R
         KkKi9QQlqhIGz264yB+ojlyUBwWTHyxrXc5FLTD9uVDz6POrsOFk1WfAMXHJanb5hGAg
         073lYnRm9nwOcYJApEVGjZhln9srXJOT09jYYKj5vDhcyCWstfYLUD9DvEjku7CUlZfi
         6zZuDwRocViU8+Jm5w7BwbCp8wiDXhCkPJvpvk8CEa7+ihIPwdg8ODyS0muKHVm/Z9zm
         GcYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDNgWFSFUhxj9m25+nU7CD/gxs8mPCFNTm7nrDtauaMq7Z2YbmxRuWHiFXzTNG6M3Hg1wsTq4V6KX1ijAy+Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfSB4UuUFTtz+Er8ghyN0gHLMFr3zgi6g3nHMFvQyUVvywSL7
	Zw9/g4M0SJdDIicbI6OO+MBPdVcyrEDXXgpcvXlM/91CwxJcXLVgPiv3rOVn03GEDMBaF83Ewru
	s23OSXXp2FGfzhI8ffEcPMB/fd7w1z4fdPF7Y201r
X-Gm-Gg: AR+sD13nMXlA95he6NiWMzgAV2WJ/yvKuAZ3DIhrQ5ESxUEVRwiAA6h3kYPUt2rnsqT
	6qw5RuPfveuaZG7eDMGv50vdGZvSQUbHifz3weVlNE6anJQu6tIkgpQ7kuI5Hah9m9ZhNzXuMLk
	gwYDbu1Hca4Dbd06BHLMtet25ySkqAEyjYVP0DhUtnmafECYSn9pi4ghnh8RQ3LrsVVwERk/QK5
	QwHuzvKXht6qkx6MI6GH8Hc2b/sGd7sHqGkNVSvYukFX/zPsJ2slOao6NfNPjdHeDT3G9v8j8TO
	j8H1AQl/xF3nedG0REYxMtfXCFt1GL+yI5ht0a3pF/Lo
X-Received: by 2002:a17:90b:4c44:b0:38e:21da:9257 with SMTP id
 98e67ed59e1d1-38fbc55a8ffmr1001602a91.37.1785530926988; Fri, 31 Jul 2026
 13:48:46 -0700 (PDT)
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
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
In-Reply-To: <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:48:34 -0400
X-Gm-Features: AUfX_mygZc7iXRdpSQn--2JfmeRTMiYoMN85HlxYxxZIHazgpGRFnpSW3d_XCEA
Message-ID: <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwive=
di
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dw=
ivedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <pau=
l@paul-moore.com> wrote:
> >> >> >
> >> >> > ...
> >> >> >
> >> >> >> Yes, I understand you feel it should be placed under security/. =
You are entitled
> >> >> >> to your opinion.
> >> >> >>
> >> >> >> No, I do not think the newly added kfunc is a big enough layerin=
g violation such
> >> >> >> that we need to do it ASAP, disregarding everything else outline=
d above. I am
> >> >> >> sure you see that too. There are several other instances of simi=
lar kfuncs.
> >> >> >>
> >> >> >> Therefore, please attempt to meet me halfway here.
> >> >> >
> >> >> > I'm happy to work with you, and/or anyone else, who wants to work=
 on
> >> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs=
.c.
> >> >>
> >> >> Right, and for that file to exist, you need to get everyone (FS, BP=
F folks) to
> >> >> agree on whether placing all such kfuncs there makes sense. It is n=
ot for both
> >> >> of us to decide on our own. So let's revisit this whole topic once =
you've done
> >> >> that exercise.
> >> >
> >> > The kfunc that David has proposed must be located in
> >> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
> >> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfun=
c
> >>
> >> Sigh.
> >>
> >> I now went and read the archives, and Christian already told you no be=
fore [0],
> >> which I missed in my first read. So two people whom this code affects =
already
> >> objected to your proposal.
> >
> > As mentioned previously, David's kfunc has nothing to do with the VFS.
> > Look at the code if you haven't already and you'll see what I mean.
> > The only relevance to the VFS is the fact that "inode" and "xattr" are
> > used in the name; David's currently proposed kfunc is an LSM kfunc,
> > not a VFS kfunc.
>
> I am sorry, I read it and I don't see why it is an LSM kfunc. It is absol=
utely a
> VFS kfunc, that is using LSM APIs to some end. The LSM specific bits are =
already
> in security/.

We clearly have different opinions on the matter.  I've mentioned why
I believe it is a LSM kfunc, I would be interested to hear why you
believe it is a VFS kfunc (what VFS functions does it call, what VFS
variables does it manipulate, etc.).

> > If you find yourself required to abide by Christian's comment, despite
> > this not being a VFS kfunc, that's fine, but this puts us at a
> > stalemate and David will need to find another approach for his work.
>
> Paul, let me remind you of another email you sent [0], in which you contr=
adict
> yourself. I don't know what caused you to get confused over the month.
>
> In it, you tell David to move *LSM* bits into security_lsmxattr_add(), wh=
ich has
> been done in patch 2. Thus, by your own characterization, it means the re=
st is
> *not LSM* code.
>
> Quoting you verbatim:
> > As I said previously, if you absolutely insist on the kfunc being in
> > the VFS kfunc file, the LSM specific bits need to be abstracted out
>                         ^^^^^^^^^^^^^^^
> > into an LSM function.
>
> You yourself made the point in that same email that the kfunc can stay in=
 the
> current file once LSM bits were moved out, and your request was honored.
>
> At this point, anybody reading this thread will only see your position as=
 a way
> to undermine David's work and waste everyone's time, such that you can gr=
ind an
> axe against BPF folks. It's a repeating pattern.

It seems foolish to speculate on what *everyone* reading this thread
might be thinking, but since the discussion has decayed to the point
where we are spelunking archives for quotes, let me provide my comment
from David's v5 patchset where I explain myself:

"I'm sorry David, now that I'm seeing this function again, especially
with the LSM specific bits extracted into a LSM function, this absolutely
belongs somewhere under security/.  It's only callable from within a
BPF LSM callback and all it does outside of some BPF pointer boilerplate
is call right back into a LSM helper function."

You are welcome to view that however you like.  I saw the v5 patchset
and the nature of the kfunc became painfully obvious to me so I
changed my opinion.

> I tried my best to engage in good faith, but it is clearly not working.

I've been working with David and providing feedback for a while now
(perhaps before you started commenting? not sure on that), and I'm
continuing to engage with David, you, and anyone else who wants to
comment on this thread.

[NOTE: Dropped Matt's address due to bounces, see my other email in
this thread about that.]

--=20
paul-moore.com
