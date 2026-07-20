Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9842D76E
	for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572303; cv=pass; b=T0vHLspdZE3n/6UJMba2mjzQtA3zaKHQjjX+Ch9YyadjRIefmfkDKrEr2lrHWAz2CEuYXbidPd9HmOp3mL15S8422QmLS06F/Dji5KqyxT2pA3SFkrypuciV4YVG/2Otx8IxTPicyrDUSp//KzKO6E70Q+NnSJNIYxCOZ7M/yao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572303; c=relaxed/simple;
	bh=LC7hykOo7NcQDgbbnYkuyatZKfLvtqyYnzCxrtoDhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOjfUzu+HMi8uLJuO7hxvX8cTnXt4WaOdhtYMwpqiPy+LUIwum3MqwQVRWKOQbVRDMRejrnlH34Lz8xF8YRbNDemvveguWySCoK8p8jnRSldRwjosiVmz//gYAbhSA8DL18iYMbtvJ4zU9+NVbdhcz/Y3avbGtjuh8V/ODDxbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4oDpAV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4oDpAV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so130124525ad.2
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784572301; cv=none;
        d=google.com; s=arc-20260327;
        b=I0m7Z7l5jgGxTKPh9tMVWd7JfYUx/8JceQGyuu1P+Y52dvKu9i9Zed1Qj7H4/jxF2N
         idZ8Yp9kcQeP4t2urINgWJeE0afJvr2vyD5giRnXNlnHYSzOyZLXDJ8SpY5DV65gKQJy
         eIAWSq+EygJLkA6XjavsGjIwlpGVFZsX5cCwMS2kl7A4SZP0QhcjM+xbk91qJrIOzJss
         kRRQvCCuzNh18Svrf/zfyJjN5nmCbx0lWFBPk4ioijMl/CYbNr4sKUwXmP/wf9itEgWd
         0UhOmE2A4T4y+AKkFF0KTxVF7jO3f8xvh4DMflZRVplPnQyvF2I4GxY8Z36vr7pQexR6
         TAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        fh=1fXJ3KRKa3nnUAFCD/AZrT1fVlGw7/aWXRnl4IoMTwg=;
        b=A28zAuuHUga7R9feszdUsLM3ksZDPKnkp39+W2rFHwN7dyjWho0chgdJqMeNJSJLyE
         Am3xXQtvwRzJqPPy07wnAOXq9U3+7rUY9n+QNH8IJPda1U2qyzMphtuvAphqsbHqnwVk
         6pZHNkF/OgLKcrENpLrJk15S1zL3gS5FgUNJtXj4EQdRzsyBs+jCau3V9cDDd6vwtq0D
         yiCiVPYApbwR/OaN0gc2oS2V+BJdBHJy0AU4slOPvwYHEuAg2R5hmcKA3uRBpMQXtOju
         m1zFAOwdJKTpJz+s1B5Lo9fz4OUuY1w0CmztPrtniE5PY1K8FGtk97ZSprfGL67iSIwP
         /+rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572301; x=1785177101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=SF4oDpAVjRYKdSsd1An806F+kBH3rf003d0u/ZUMNNm7Z3eZ/kHMlpnc10wsos72ad
         oUVSW/oegIFYOPHJjIelk0S79rBUhoWc1IxaZn/GFnBqExrzXoMic3eoXfLINQQIZ2qz
         tA9QBh17mfw2HmoEip2+j2tXcSavY9xNk+6qFYmUxbEBLFOg+1y78i/MUQpeItTjTJWm
         BBeiwakKjw0Otg45hxTUrmXoCmRGjkLygItlPBW01aC3soRn+U1ru7O6dzq3Xij6aWuW
         HWrIU51Yw4aQ7Wp9fC+8Ioy3i7m2/hJl55Afq+HIz1ohnbQvRwBMYwsoWHSQ62lpQjgx
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572301; x=1785177101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=rsJvlN9XQPZsrlovVhZatStK15M4blwU8yDqFMS++3i0dsvpip5MHGDAARqoqfnREk
         +dImW76IY1b1y3KCWks/sZlVMhdH0TzQuQHNbdFvPTWnRymArUnZJ/lirNtTa2YxpPAW
         AEUvnCVaLSRhrJqoCc0BruRiWuJRGqa1+4ymEcK8LFgm52O3vEWS/AFsslUGwU6Gv9PP
         angKjmV45Fx2skRDkOspyqSb14Pb0hK+2wTF6ZJ2I8i8AE+q7dL5yJW2mEyzCTZ1gk7v
         fT105bK31eEE3bg0B/BlE2p/vL/ozPrxg8YBxYStofMOOXumg7F6np1pfrlX3jCtGTir
         vwbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPUmnQ/sEbWuDFLd1jbXtUMIo2yFeNgJ+wcL9QfRJYGDF+UzQDtlLB3o8oaN6JhDoCHXZE8KYMn81inZ7PxoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkMZgCkwkYK/LHQ2qkOt1Gi+U2GkdTFPBEfywadKSLr67FmR1
	hYbEdxLKRJ8aHAs7fI+hqmTOF50a/1gnu5pC3rb5i3JPlQv+4BHEZVg9cwZAznETd51wZOCitgK
	3XfdadTBtdW0JfBKN+lUHz8OOZy818Cw=
X-Gm-Gg: AR+sD13RhSR0VT0Vw43AsvKeI+ERgm6htMeeYR5g0D4qFse80vwb2oQ5qvQk8WvwnEh
	fNg3jRn7rCsRZjBlrdMmWPlHsg6sRg/RtFiAdi4su1wLL2DhHLtyQTvcO8d8VFULF/nYztqugNj
	fXrcFXiFUCqo5gg8eV3ehRaZW6BHszpqhp4ejVrS6mD/gtyVAuulguOppUKkvHivAsh0T65hrl1
	LKNEC1InzVRPgRmGJ3hwz659qDWWGxgIa5azlgmgAio+THBgG2MOIg1/lAbIXOK+ijbcd4MIwSv
	B6Jkwn8Fr58ekzwA4y7sw7V8DiU=
X-Received: by 2002:a17:902:fc4b:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2cf349b590bmr166172285ad.22.1784572301567; Mon, 20 Jul 2026
 11:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com> <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
In-Reply-To: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:31:28 -0400
X-Gm-Features: AUfX_mwvFwr-TgBt_1bjRhuE8WukQ5CZki_9yiHUuJNp8q_cbJ7bjwASItGBHzY
Message-ID: <CAEXv5_hc9x9XJZr646efGe=HD5Y90FtB1m_xi--0wWuaD18EKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> >> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>
> >>>
> >>> I'm sorry David, now that I'm seeing this function again, especially
> >>> with the LSM specific bits extracted into a LSM function, this absolu=
tely
> >>> belongs somewhere under security/.  It's only callable from within a
> >>> BPF LSM callback and all it does outside of some BPF pointer boilerpl=
ate
> >>> is call right back into a LSM helper function.
> >>>
> >>> If the BPF maintainers aren't willing to accept that, then we will al=
l
> >>> need to find another way.
> >>>
> >>
> >> Where this code lands doesn't matter to me, so I'll stay out of the
> >> decision of where it lives.
> >>
> >> If this kfunc goes to security/, would we also want to move eg
> >> bpf_set_dentry_xattr similarly?
> >>
> >> I'll roll v6 of this series meanwhile and we'll see what the BPF
> >> maintainers say.
> >
> > I don't think there was any preference expressed from the BPF side. Log=
ically,
> > one cannot be faulted for adding a kfunc to set the xattr for inode in =
the same
> > file where similar kfuncs to set xattr on other FS objects / entities e=
xist.
> >
> > The question about bpf_set_dentry_xattr is thus valid.
> >
> > Anyway, I will leave it to Paul and Christian to decide between themsel=
ves where
> > it makes most sense for this one to live.
>
> Also, perhaps it makes sense to use set/get naming for this one too, to k=
eep it
> consistent with other ones?

I considered that, but we're only allowing one to initialize the xattr
on the inode here. Once it's been initialized, one uses
bpf_dentry_set_xattr.
