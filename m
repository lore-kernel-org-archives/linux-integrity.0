Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5E3CF1F9
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946713; cv=pass; b=Te/K/ZQLWyOa6g/y27iF5SXBTn59JiFD3ZX/oKn85DAWGScrHNKfvXlo4C0GWT0D/2IFOKoimuQvvbGoEOBLV3eaxmb85GHxC2jGjyYfhaXPshtZU3c6FC/AWCCEukdCzjBcsU/F+v1IS51Qe+b/TD8RXuoVsHuF9jtc4nruhGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946713; c=relaxed/simple;
	bh=v333IQ17seFPobRriFVv9irQiGfOh08ZeyJ80kHbi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ2zR0BF+tgk2xd1eKsFwKHEqiwP4exMcBHSiLn2WZYpeCdO56VtIPRdKxZrx5QRT3hvpdPQ9tlBADb+qp+LMrMCzGhwLh/RdCwEvR7GLfzTsbjIzqNQTSYuVYVqdXT9S3m9mi2Eha8v9Uo6vc9xtzQHiAONkSzml1L0K0s1PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMFLejt; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMFLejt"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so10096586d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 01 Jul 2026 15:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946711; cv=none;
        d=google.com; s=arc-20260327;
        b=gcN4a+I8AQrY8AXqbryS/lQk6pmcaf7IV506Rv0kc0CkiO2HOR4ruV4VFwdI4h67Uy
         Kb6Zj/xeCzQqt9LBCyeKhTHeGaMmeDBSAVDG09Re4rvtmDT8IVAI3qk1GHPckU3JjfQe
         6ZYagJxrqtDGjFzZICK2zc2/Kv69JdGgqsh3UvhrvTHTAhNDQIDRBsyTW3Ns8EbsWMZO
         VNdFEHE5VP/z7uxfJvq8L38eGZn65mssP9lYvKGzIHEohCLPqKJfthzKy31kDvZU4J5q
         JmiK1ce/z60tgZoJPAA1Nj26h/roKvcg/EhAaXjiUxP70LNpm/Sx7nr9Rd2zq4+qYsfP
         vRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        fh=M0uSv0hs/OW/AhZJ4G/1GzXHgPVRzOGGhkVeQqS+c/w=;
        b=BFVbuIQft3/BIT/1uYVVBrbBlDGKf/Pu1p/bCn2zHZbhG0kQuzitwPTtEJtPnAYYOw
         I5xcXhc6Z3fpWfJIcMX1n+zLXFnzETl0uXtiJYjF/v2YvGiNojInNW1IExOkCV0bXsSl
         6nBR1QtpSPWxEkgzJlo8ueoTZtUVT3/dlc4PpYaA6KPHAOx7RO/k/5b5OAbp+SStW0Gm
         xqQj8r65M2qabD7Kht4G8WmcmRFoyEw/DCGodk46eoourBAJKncldo8tm9N07EJfOEvy
         fZBtzXPrfXuL8BfQHXZMmLxypmDGQkZ4NYstcQ3h1p3F2xGTD30cDO9ZyNwpy8z1kIxE
         mMog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946711; x=1783551511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=FFMFLejt7D9ehe+p004hrq2XpYh/HnFijFKVfrm8olTlbQQ7Q7yb6sS8daedUAOGKB
         6ppRzKfwcFgKnNWKKZCE6lRbSrfVChgXrJ2eDvBGCtvSvvffEJgsf/boiPb+ZDxXdvM3
         jEmUVryajCTjqPWMW4oqmFlumVnrN9HEaI5FyMjkJl2TwZxGCHXsx/IhjQjvDSRsdW8y
         ci4HYwBhSnUhNKlgPp2+jbNcb7bE9UE9b8PV15OB0S0VWPHeifUM23eKuQT5ZR2Jwm4+
         guR9YrxXCt6E+5bP4RccjNaIhWPN5J4t5uV62EOTkayWIG7vRIM5AgvE/c5wYCTy8lnT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946711; x=1783551511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=cyhVdaUmrLHu1GmG3GCqk1OOwO9B6H8XnCyyQAriJItVqv9oZYL0Kvb4L+dCnn7rmw
         O8u/FZAJ/5zelyN8s8AYbR71f1GDiH+a7uzmo2pWcoLJRrXKX6j6kqFuVp0P+e5fvTfo
         WdFibMlOaVCfxFxqoj9eRxRq7r94ppBnTywit1cVths8YFdsWXiHBROtA7+32m4qqrKN
         cmOfQO1vbHsjRp5SSEhddVH0CfmuduqSBDg3BoOMVz0khoqdYzbKWyetun3QpjzUWQaW
         w4SviXdWQ89Hvd/1mrMH5zGKbDN6fhLQlccXjTsZRfIjejHYg1ePC1PG6np1xk949FdG
         HQMw==
X-Forwarded-Encrypted: i=1; AHgh+RpYFFlklbhbKBnxPCRO1woR+eWNKZ1gbM73XxElReRBjSPxdOlJOrGUQ7cuJon02aV7dxJTDz22XJL5j4lMAL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh2hhkW0Jvfi9pUttlITQdVCzXmpTtFuOpVPkSWTxOSC0Ictn
	U/uH7fX5ZSltaG3vMQvAqzWWsuC2bxeuWM8xf8PD/Ud48I1jTCB/BiujTeFi07HzLQedq7G7J4L
	uqlAvVJz8HFkbnGQTFPCcT/ztUGCXn+L/4PDIxm8=
X-Gm-Gg: AfdE7cmPOvcwvZ4Ro6HrdINvrzbPE98Qa84Z/0nZa6T8Rejuet3R2NGEls11Lr7R6wF
	1OQr6en1RBMqJ6DwNUzXPj8CI+Ke2uvINNhMsGb064uWUO//68Nt1edcrAlgZ0nfEhR0cQAdB1y
	ZUlVP8GP8y6Hv3WsdvrtlRGyD3c42AfOpF7s24csYkztoj80xuIRjuPXsyfgt5h5e61gCGyRvCW
	TMW8MxTIcibKk8Io9/BJIC04oAK7odl3ooYJiZYDPJ6Lp7AqAtc27W3GXgOLMMOQty9PNNpBYVS
	XZ37amMBlBa+NWMXcs++QRzqaR8=
X-Received: by 2002:a05:6214:55c1:b0:8e0:c0f3:a2cb with SMTP id
 6a1803df08f44-8f24ead200amr108961456d6.0.1782946711091; Wed, 01 Jul 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:58:19 -0400
X-Gm-Features: AVVi8Cd--WxIEfBHVAG_4saw_HtYaBPqRNY7ATulZIzQtiR23TCVwYiJaDu_5Wg
Message-ID: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
[...]
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)
>

Makes sense, I can do it while I'm fixing the remaining issue flagged
by sashiko.

I'll route the LSM preparation patch containing struct lsm_xattrs and
security_lsmxattr_add() through security and the kfunc and selftest
through bpf. Does that work for you?

Thanks,
David
