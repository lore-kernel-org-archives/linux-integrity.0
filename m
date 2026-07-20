Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878C431A5C
	for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571142; cv=pass; b=ikBlYaghHHGEE3JOvxSIsFJ7idLEET3hwgFCVfMZ/0TaExAeEw/tPKDwiIviUCsX+UgstqFzmTRvbB0k0WFaqbqYYzrZ78NWALLArB2EAd0GyCjB58SuTmOohMhZjAz5B72dcXVGmrRFgz02X6HOIKNGvdxmxpwgRw28+cdAAoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571142; c=relaxed/simple;
	bh=1JX430VNbqj0hZ6Lzk0OOAcmh3W6k774gqZhhQCrP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd0ZVUAoP2KtKx8mAAmC5omdZHGcOt5wwaywHONueYF1FHOgXMO0aGrYBsZGhrIBh1vZlCKKM6dDLoB3PbyNh4uZowyRl4MTh/NsbEIGd7iC5iVe2KlzDFzzcWJAxAmk0zo1DOev0/THCUP2PImvQ/1YN7AF4Uh12Li5NDfWfyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLp4eZh; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLp4eZh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso56745095ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571141; cv=none;
        d=google.com; s=arc-20260327;
        b=S+pYfLIGTU3D8igYMKI8HZktmLPKZ/xjYxYUJaXZIu0EDZrWJmHnAn6FjQ/ofl55qJ
         qoAD9+wUbPPoFIq/HmLxJAGbZPyDnygA28GCmg9if+x0GH9y7x15+0wuKn3y5S6bN2n3
         NrxG9+UfcfVdF+uhU43wQcCUU0eMcvMx4AzGEWmppXt/V4lUMwsBnvK4R7eiFwBwpNuY
         Ox587aWgoqtbWyw6WvrAeb2DxPcgHj7c+5VUW+xXJQPAaBcPnICbFvGefUBK8tqvmk+0
         MYd5Xt12CwlVE9ePoVaj3EuRJRpERSHySLWiTtfprcL5xmL3I77xAgNS7cDxvutZ6F/f
         KHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        fh=EFuC3bBZl36MIhsie3kjKStI2vx8t7JRiT2JFRkrDPU=;
        b=dXdIOiRslgQ3e5eiY7m/YUyBblZ9NQk8i77LvY1Zt2sghOmRQM3cK7/C6WHFyq5PWp
         M64x7D0lylDc6LtasTUIsr29WbHHpzEUgVY5qJnRQS1zj/IsKLI+KPRNw5tgbimwJ4wS
         8t3CaZXE9+HKY1VKUz+68hAjjQkziU5TqZnGkuKorO90jL4H2aYw4XJaWJwbyN6FQ8Qs
         2E0pekzgL6Q7/4MI8qV1mC6aKFRLBgXsmDiKy0oiBLXOdKxB0gjrzj6NtIY2uIRpCMfo
         tBr3DbSF9jSngkgWOtD5aRYoSSBLcAFDRoXGJF2JQCAmZ/B3pFBUUS0t7M0cN5qK+0UQ
         VKMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571141; x=1785175941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=KWLp4eZhCGEaAiHAaTC37TOMSNgeCcmI9tjMngAHzbisyIIl4DD9oLzg+2o95wMPsv
         hE6y6Jl2R+fRW6GE7j8EoS1lgNSWUYXfvXHSml+nSoWRFyXNmaPRqI3r+WomGDlOOfse
         KEN5FUQx/u367rVVi8P++/X65Pg7d86mfGno+CcG8y5Z4Ww7bl3cicaMvNnU94ZyGf31
         tgRqMiLTY80YuoEfpKD/fgdKKmmq0VGW5CPlyeiyORPA5gn6NnDOHFi3fY0LAKS55pS7
         zlCeCbqa0b/kzaq5RD9bgq2lWh1NGTSIzn4cGQvlFvEodoT9KXZhOkSsuPwxBpSCMOZq
         b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571141; x=1785175941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=rVmAClNaq9rx2XGM8rxY+uh2TBWxOG4+1lqMjkNjD6dBaoDqpE3a6l9I3ciHD+/lXR
         FZsq3yVNvADDdLiKdCnfc6JT9iszvVz3H74CGouMEwrP7lOg9lnpaaffdRjL3xyrDFIO
         HsqnmNfJUHuTktLQ9GHfAGtnIf2b0dub0iZam6MPZSqYWwzmAx4tJKsKzdgRgGMpPV9M
         hVpEb0mk6uN22QVi6tPbhlF80TLOV3SzpjQngdtrmKpTGb+Lyu/tUVw6I5FAd7bxvk+i
         ApNVRyFtv11Yrjj7XcbXTUWBI3Rxp3JyYqMUAVdGRJYwScBT6NONRY/GC/RSI0b+sV0i
         ZdGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/0DwYKAavpnzR0JhcI9o0Oba7ecO08T6KhouC8ndNAUCkEzHWWGVtFRpZJBvjoclpmR+PPtEip8VwCc1TN8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/mV+EBV4AKCJkPnbR3KvMZuwIsJs6tDZ1ax0jdooRl4jKp9C
	CqvdCNSfKEGxW9HhmH1XIDpExKRKRImXxBzI34NfEvetHulyFjDwMPFyF/Jqdn6iZvJv27GJU+3
	+4VQCbvtohNNS+DUhwW9rXt6OyVcN55A=
X-Gm-Gg: AR+sD11yXNby3FOpqBiu5SX8t4GKUmgeqv8x0vgAlTPsCSuBoZHqKjbQSqsoB70jVSh
	5m6qXNH8HksHCijd449bPAOsQb5EDUo90k8oOeSWlwzusB4xvDOd0H/D+Rb+IIJuTy0Cm88y5Ea
	TGuxEDgAckvJ0ROaSWzjfKPHEiTfisA8LPkOGoaECrvtYGD6Q56iMeR5DcgDLKv30dXTDX+DM4Q
	x1clCKBRBB4qJNF6wxSiiyNksZnkJ60xPo8NUuJOkjxkg8/BLlfZRoz7TFuShEuBI0ewTa0bzHs
	hgIBrzbOJg3mEFkc
X-Received: by 2002:a17:902:ea10:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2cf1f29ea6amr213030675ad.8.1784571140752; Mon, 20 Jul 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
In-Reply-To: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:12:06 -0400
X-Gm-Features: AUfX_mxSx6cvDqWkeZpCRVrryYfuXxFSwFH_5FN2Ivh39vzoR79SkwFUGoqzhZo
Message-ID: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
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
>
> I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function.
>
> If the BPF maintainers aren't willing to accept that, then we will all
> need to find another way.
>

Where this code lands doesn't matter to me, so I'll stay out of the
decision of where it lives.

If this kfunc goes to security/, would we also want to move eg
bpf_set_dentry_xattr similarly?

I'll roll v6 of this series meanwhile and we'll see what the BPF
maintainers say.
