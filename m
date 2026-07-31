Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B2857CC
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456075; cv=pass; b=g/dsHZcFlERq38clGzWURvpswJQ9StYoy4QK1EWgN2IMLnnP3QTgngdZOXeHY+s4a2tt19xutGVNb1oYs98DpuKj7k4Xug2fRph5ggBeA+DV7JA07Q+N2uoxU5gvkKXDmZkbi22+6uM11iDNppKb04z1oWtcQ8Z8Y9+eSpU02gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456075; c=relaxed/simple;
	bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZZUlS2mwMbnHTFSM8jb+UTNT5ewiAHe4dTlRqNuUg8nLMFdHnnl8jS7rlO02uHhXzaH1Z57smf5dFapxMzf6h1Ff7NizBlUEia+T9HtwqF8yDyU3vykLSJpeN/Fwge9sJt6s2WgMxXjrr0XqHJeOFQfdi6t2eOBQevHDub/eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/DigPl; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/DigPl"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5218927884fso3151201cf.3
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jul 2026 17:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456072; cv=none;
        d=google.com; s=arc-20260327;
        b=rL8xP8wAEtT5pL98xpLSrPfLzb39v4u286t5VPFJJ+yE5RMqHRC2G2Xn7bUJcKrK4A
         c9u1tWF5wFiUvrtNi0JesXXSdXHPF+e4qpJ6p+1Z0yXeIg5gT120oo5HacERg8JlybJX
         lUgIXl0PZCg5U/mdArekpm6dTJEGwSfs0VzZsRaVnlFtsxNrTvWP1qjkPu8xIMEBhJB2
         BIhtriYfMxF3C2m0FtRElkUVxHOP0H8nuV1awINxYknvTt8M8IxX8W5mxBA1YidaSedv
         xvJOmoL8uBfjiSwXo4iPMwKN+7Y7RQ3lC8CAKLOSKi4TcAJ83PhgQfS8h+RfqVrHJ1QM
         47Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        fh=RVOAkbgM60bS1UKUas+A9bCPacMM3I2kI2R40jlqCkg=;
        b=WVFaXp2BtQ6Rn55mJ9UjFTlUKwiz6pN4TGqj2GcsG4BIsu16PnmB0XM548RrLBj3Yx
         64WLxySp1UQfciz8sUp2HhlLMNqZwzVRot79KLgYuKzKiY82abtJANo+5pVOGxobO2d9
         BhmlHyZ/3g/489tBtYGF40YbPSXR3T6zQtpBRzRmARSBik14O6hIkyYNYn6gzJj6SR2y
         92uq8dwUyiursI+eGfrKdfYkZ+xeu03talubDpo8PSLSTCioBFEE/CmY/F9jTG83TF6x
         IMhU2hU7uyAs0puiXBwqXgtc6h+EXa9L3XXLAvSDja/jm+g+4v++JAGJ5IWCMvkvfrr4
         mmyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456072; x=1786060872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=lk/DigPlxuCIVbt879jIb6r7+Nmnr5dRWu2ogJeOmjjYjmD3QHGH4CSuEKHKoWHdhn
         AkdVhyIiBI/9atob2UT3f3XBr+Gwe/XQr630TJhEO8Td2mvak+gSBnKOsvd7JDzA2BpU
         802CBeK1z42D9bofWzkflLi+NCEfsgwcPJc1UKLMxl36m5WuF7T4L4mzzcHfeuyeJuK9
         bcFgGVdoJvnrF2886wiECWyWlwHg9e0BOXhMICgDnf8EmkLNVlCKwPfyw6I5QEhArx2J
         SDVPl59nY1Z+PfLyQ5k11S2DmN7I7ltlCukpdmARMsRI6b57LbPsiay8XnUQ7GT7+xj7
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456072; x=1786060872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=r/PvtaYI5BWE4HQhwjDWy5nezs0rA7nxbKt3BWX3DZi29TA29vLa3tGs4PCSxp66jl
         5hGXIx5VoXp7rSHZYrMbt1wL8p3LusrlmxORzB4inrr7MIUsMmOPxo1S4ya8IjkUpbhk
         CGn4cDcVI+fRiTtkB/meschErWGwGqWP8a0mw/fLX/Ky7QDKTAhST/xglJAJpaFtTsS6
         9r35U6/ZtGdT7QX8lNo+Yb5cr17p5684K9ve5Ywz2tmcYzrM1n3bOoa6KIQ8rlEIDBLy
         ALtFc5MbiyL9vAFPdga4EzoB0g01akjoi13IdS1zoHxkoDReMdu3ZjlhQW25wvXLt/1A
         j5lw==
X-Forwarded-Encrypted: i=1; AHgh+RrFYi2wTCNjpDjmiAe9876IpXaSQ9O1ePdE0jLjHHLz/5ZMSu3Pd6Qx72pCETHx05qAkd5ISNh1+zQhL5G/4EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0F6kEHAwmjyLs3e5NgYHrEED9C6NguiDQMf5HeDMqBbTxeth
	Bn/vpkYncQVJpZlYJBzYGGuTYL+lbtSLKcDzg+RSNQCRVBlHh/b3iKi/7+BbQRt2m/YiKPo6+ZS
	1YXyS4FwnyltiH9w2IqYJmn0tRksh0mk=
X-Gm-Gg: AR+sD107KNzPSo126ADy58+3PxoNIQvECfq7rNGq+J+tWIqph6hXwR/Smpu3cUEe1dA
	XlqS9oAKHdMiDJMmtgdwRR1y/n87hUb/NyygvtAu30E7p1zPsTjOHKB70GUXbu3zAUseLI8P/Vv
	R1oKbgCnOjF3+xzo2Bry8I5Uh0zOmzqyULNiKhByoVvq34lRect0ZNc02jYVK2txZ9oVaTDmf2b
	mX2RBoXaVuVkW3CPSVGZeo552QrYCLe6JcVBLRAZVUHD7LVa7p22rVtbkSz+N6RVptGwXDfa48/
	crXiNqheNfo08fJAH7W2p/ct10WmphiIrzpO9WfiiyuO3uOgCh+gi1S8U5DLOur0L9JiAUN9rSI
	=
X-Received: by 2002:ac8:7d0c:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-52b4b005354mr130221cf.37.1785456071885; Thu, 30 Jul 2026
 17:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:01:00 -0400
X-Gm-Features: AUfX_mzzLAETGk0-GNkiDsgUNvOmEZOv-UFFgDdgdht4DdfS7DnllTiGk_VUitE
Message-ID: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
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

On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Based on our discussion in the v5 patchset, I was expecting to see
> this under security/; did something happen, or was there some
> confusion?
>

Nothing happened, perhaps some confusion. I was basing the placement
off of Kumar's comment in v5:

> I don't think we should do that in v6 though. What you're describing affe=
cts all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

My take on this was, leave it in fs/ for now and then litigate the
placement of all of the fs-related kfuncs after bpf_init_inode_xattr
lands.

Happy to place this in security/ in v7, if that's preferred. Apologies
if I misread the thread.

-David
> --
> paul-moore.com
