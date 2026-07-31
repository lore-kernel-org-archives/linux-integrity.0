Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A616440A22
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512205; cv=pass; b=Uw/wQPPfpL8okuFwm+3nAKddWWnI0X+VqdCFagJa9kl42mwZHKbm3lS7+nPsi4D/7M9T0q23KsW5e7WK20sZpSx2LUwDKZyEeXjve1SJYlWwnxEs4Bqsd+BEQAQgFRke6L2j8hIbfZcmCorWczTiNu+sJJWRdlfKowxgi6tmdU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512205; c=relaxed/simple;
	bh=kPzEtdgmgmrhfEvclMUzFEFQMW3YYfNU1BZsWa7XSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGowC/O1oXnOdfDV0/zwjtwJ+osNGFNSREpr+hMWK6opS5WsDYwfPoLzRETgQQfExsqTLwIazlUU8MrOiIrEjqlSCl9LHmjy2B3SZ5FJGH2RHctO5Rmar9TOtmv72RJ8sc6oMyeM2Zds4q7/h9LVtAlxVOYNg8wNjEf03XppfjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFc/OdTg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFc/OdTg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c08df8513so6398541cf.3
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512203; cv=none;
        d=google.com; s=arc-20260327;
        b=R7w/jdlveBNR91d74bOQ9U7irHXlefouyBXc3zE9W891T3lHtc97lwqU78mMsISzO9
         CyVQukZR2hF01OYXY9RHNqlFPJmO4rbU8x7QHx2Ubeo6FvHnYeyfhTytnBY2iAb0NdGe
         9HIoqOyhzTvUSVWK0y4g3iyBqzGe67bZtt29iTCTJkywVn0iJ0U0rtBhoiRtkztRbjiE
         RihXIKiLnoYAZeMdGKy9lPyZleXTRz6gWkdzRbx1UgpcRcn3Wd0JCxFlrRnzKTdlFmtD
         O56x/9ADjd2Wi+njg0VTQRLOLIVMCS3Kb1arP1i6gmM7CW16pS+5Tj5Q/92is6XlI/1a
         YTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        fh=nfYk0xXgRULeIfZD/SCKsDE6rBXjFNKNh3pp/scoCa0=;
        b=GUaC9Cc1m2D8GwBAxG2u8f+LRcqG6I4lEU2pa/WEF96xZJ6ljWcxBysC1iZTYWjJc4
         4ymaRS47MnuFj6/yE3TSriAVCvMfwkzTc30VHqusfynwm16Wdg5lRaweI1QgjlubxVxh
         6fE89X9/1djte/YTHhpGYNdIgkKqqLNO1+QqyHZREJTPgO556UOgrpHn3DEX9GpDaoeo
         AeJBZM1DcBt2V5ZDPnWQzDbANBBSKdg4m4PQhx1Hr27+UrB/4hmqavBJtM6Kt0aTpG1q
         FyPuHFTNs4GJ2TXVI0sRxgWx9w6nwFXnBrpTdM5E71317vMwFhCEAfD2Dqv8xmP6JA67
         u8iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512203; x=1786117003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=IFc/OdTggyxdx71WMUkmunfFJv/VBdRsML2egv3SAZWPQsqAefG+GCW5wF/exbuiTa
         QR7uGfe2g2p08Fxi7cbO7yEIIN8XKQYDgkRTTzsgAQkPuO3SGaSSiGhnwIgPexrOySZa
         +pZ+yNZlpxVkvSZoEM6zMPBqP0Vph8OkXnbLafOl4HbYSB/gXqgS0me72Dh31n5iZk+V
         2TfcgprOH90j2Y/h/YyQJmhoWqYtQXHojL9LdYazVTSYgmVIeG3kvXXY655TfaDon/Hm
         OOzMc1jTW2zPFrgbpFNTk0g5clcA9sqMzcETIeySBrsKVqu/NoYYyuQ5t9XCId0uEIcl
         kJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512203; x=1786117003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=hwkzIYtfYVZM2ufna34q+xB/VqpDfU7obS9bSiSwAcRftgVwa6p8Abu9iVQ7XJxseQ
         qjTZmSqv3noBD7Dspthf1l7yzabLMlXr1KbeWp+3N658qIptYDFPkLQzgHqV2pAVSWmy
         83tz1dMGXQoS5bi5X40Y4ztdGO8ENE7ta77ChmZCl54Bnk7Lq1h8qNmjBQBjZexBIG4s
         j4nJ9qPefPYL97fw0UVk37QcetOZvQ46ec6jFuNhnhGyruEqkkSSnA4e4uF9X/3V/Iwj
         fFp094SS/wsa3gHoBHhxZdeBjbrOfM3rcGnizkOXeTWr7lu0UMOjwHIu5MnXxRuixB8N
         AJ0A==
X-Forwarded-Encrypted: i=1; AHgh+RpUJYljd+FkCyzrO4sz1SlFEUEvqbddGxjx/m1t9jjvL8wFb2m2SJzRNnWJhD0ZFLzm9vGhXbDV+C1tgSQue0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyE2nnyfKd62cdX8uIUkb84Xaejnd9BPo74X5oSwYk8Ygnj2pE
	AkfbV0QJW8cconVBFw+BdZhmnG3L4MxdvBVRqEMuZcYfa6Z8p7bD/zG1fowOTWGa/WRfmFjd9Af
	I6ZjcgYp0Ra8TDZ1nv0CrSkc8DKwAPdk=
X-Gm-Gg: AR+sD12hqzpCYIAFpZCW/6x0L32sUkxmOHgXvwgiBQbzFmQUAuJYYUtRzzs8EjL1qRt
	JDEFWPWA5NGD21nP8e9Iu574DvRV1arDdYCAgNQ1L1dZsgR8oqqZX2hhSsQM1yUjIRgf53iuGcN
	I6WQgt480DJs2IpLJ/T3BRj2Ry4qjys0PearnLu53VYNOWZKx//FZQ14fBmyMzfg4LZ6oshjZS6
	ligu2d/N7/rSMHRDWQaO7cxvOWYTNSPa2uFdqxqEcLUxIK4jPK6ri6fEXFwQT5D24iWW/cRiuYY
	BKqt1PbHtVpmcdQHE4Jc6QR5qT0GFLukspbvbIMcCsBdLGvGwlKGgjcbZgv5EUNkeOGdJ4MCJcg
	=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52b5679527amr12582491cf.32.1785512202948; Fri, 31 Jul 2026
 08:36:42 -0700 (PDT)
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
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:36:31 -0400
X-Gm-Features: AUfX_myF-Fa2Dx12J7XG4FMqMoM3YLOYocj4Wcd15kosvCgWFWfK34tns1g5ePo
Message-ID: <CAEXv5_i+OOJqr7xb02=5JMR2O8soLJARckG2CK7yvcv2Ycj+eg@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 11:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Nope.  That patchset has its own issues, one of which is the location
> of the kfuncs outside of security/; I simply haven't had the time to
> review that in full and reply.
>

Makes sense, thanks, just wanted to avoid churn if possible.

> --
> paul-moore.com
