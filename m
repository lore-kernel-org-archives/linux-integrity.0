Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EA38D3F1
	for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572218; cv=none; b=rRb29AQJlX0/EOTYudmBKtsodUETgLlCYI1g3VLDg//EX77x1sw+YETz0yXeef3GZazB4tnEcbXNURypT/c7QX8QrddKGkv26clwMgpNyElyZIXNs0CqV8XmAqQsRlFevm0Me42iTz0EfLTWPGuCZuZzeKdFOf0WiG8AxXzJc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572218; c=relaxed/simple;
	bh=OwznwCCL51DqvpfNCtpfM2jVCP0UbJ8x8niEoEDbl1c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eLm/31lPN0NUiOHKYoB/z0kC9ax3GUw9YTgIH3TGAMU42hIMogIrwqoKM3m/RQsfXks99Adf5RnCSY6SYxwzqsjc2pxWw0Zncl/SRzACLskPheLqU0O/wh1C8dE1hPkg6HPAVkXAggsgCbQf6d8ywd8lu32wP8uiDv70yiBap+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJHo0iPx; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJHo0iPx"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so2877343f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jul 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572215; x=1785177015; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LvO6UAbRFcGCSjoBuZmDbMqs86kUUw9tJDf3lq23ABQ=;
        b=MJHo0iPxIH3vbeR/eb3ZK37zC9/W4Xhpm5/kuTAKx8kN0C9YFsg6m4mmlVYnYxdrgx
         sfF3XDvy9CUrh/4IMV33rdxVlMHmOvRMqIdT4+OJuFdcu+llOt2LhDKyS0iT48IRk+Em
         swZ21vGyec0YAU9Gwo0aIiO/SCqQeTR5UMSqPqpxdMFw+z0KJRKFc34BHVxmP+tI5DCG
         rtOZQURBk+tWbA/SulQhuwDiSNXDt+h7nFFKHLsOdbnwQFUJMx4RBYDcXhLuxwuslSxq
         SmgyxlmNuiAgIf8z+fNi69KN7ox9pAIQqr5dBsTqfMteAfWrbKtQrYFv+1mv6Re2oPUt
         gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572215; x=1785177015;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvO6UAbRFcGCSjoBuZmDbMqs86kUUw9tJDf3lq23ABQ=;
        b=Zev3vovaCS+g7QqHphWpNRUwuf0zHlLeo22ek+FtP7lRmjrLkHuxTfz679BwvnOH0j
         05CUlmldPg65+xiRyLOWACRILYoqbHOznVXyG/9yUhqFf507GM6rYVKpVvFjwfFUp5q2
         CfI+RI784HlkNsvQAW1yGL2pH/X+gqJQ+aCRo051QsAcQBe9aYn4Ekam/XpchLij1bnk
         O5pf+SHUtqJL784EEod6QwmnBoQE9a3GwCMNOX+AfAbl00+EbbiNYxvSGTTMyYHG0Y9l
         DP1bi12LLFYR6PIwu9rtsScPIAUlyOSR8tqQaSFA67ZaSfdj34QXxAMFN9/vVBCzE6kb
         1/6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxcuWK2XkeVsi/QnUGFLP0tRgfumm0DnB3M+ivWRqOfvJNarmM6+FdFc+QAuoNEJvkjvBFN9XXqPF804kISco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTbIaoNfIMpcczYbSOQsZGmi1AHeFkMqtRpvAt+FyE9BItKUK
	WxqMq9XmoGXPDMDoqgE84e0DpexRPaRHXABw9TPYBwXdJR23P+kearTQ
X-Gm-Gg: AR+sD105j/wXZAbw+juaBvKtA6lJ8OgUl1eGSU+nP4nNOKdjsjkjBsSIcbWGJMfvIFf
	8BqHUCGQ55EA5XGPpdCzvfIZNTCzRuqJPSMm1hNllGUTbU64aG6hpHhrf7NZail7oa14EVHJtpp
	zlxN6DxWh5f2oub3ng1FEP+Vqa6f1u2OeMS4dTdtYWc82c0OMqPwWLZ/B+H9vFbCqE7cWfjbvW+
	L8S5t35khV0TS/3uby9Nof3jpRaNey7dM/SkhKy8arbPv2To4rGaUQyOZgfa4hkJvXoZ4OoZ0aQ
	j6SPAMvgiaGVW7w6VkDnqSlx4G2feJ3w8/0AFgNVLdMKkkylUUNCD57kOjmmO8tz6kJYU9VJy6I
	vNQEtuhGvj2eYOABwwARSCHVzjUUoAAsMqH1U0R1W1zJS0ectu7pj5pqeE2ogBruAd1RHu3DPgY
	H1C07f6xoG3i61WqAGpHYfTzkrM/AJwaeTOkq86CUOXa+fmQkJJPEGl8agHRptT10VYR6LZRSIs
	TS1p3Q842M9xrw3ECoYnzYrcjl8fYeXBve3cZ/UiflPgTcwwvLFPYc=
X-Received: by 2002:a05:6000:2385:b0:47f:756f:9a83 with SMTP id ffacd0b85a97d-47f756f9bdamr7960451f8f.55.1784572214440;
        Mon, 20 Jul 2026 11:30:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm32759891f8f.8.2026.07.20.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:30:13 +0200
Message-Id: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Matt Bobrowski" <mattbobrowski@google.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "David Windsor"
 <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-3-dwindsor@gmail.com>
 <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
In-Reply-To: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>

On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
>> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
>>>
>>>
>>> I'm sorry David, now that I'm seeing this function again, especially
>>> with the LSM specific bits extracted into a LSM function, this absolute=
ly
>>> belongs somewhere under security/.  It's only callable from within a
>>> BPF LSM callback and all it does outside of some BPF pointer boilerplat=
e
>>> is call right back into a LSM helper function.
>>>
>>> If the BPF maintainers aren't willing to accept that, then we will all
>>> need to find another way.
>>>
>>
>> Where this code lands doesn't matter to me, so I'll stay out of the
>> decision of where it lives.
>>
>> If this kfunc goes to security/, would we also want to move eg
>> bpf_set_dentry_xattr similarly?
>>
>> I'll roll v6 of this series meanwhile and we'll see what the BPF
>> maintainers say.
>
> I don't think there was any preference expressed from the BPF side. Logic=
ally,
> one cannot be faulted for adding a kfunc to set the xattr for inode in th=
e same
> file where similar kfuncs to set xattr on other FS objects / entities exi=
st.
>
> The question about bpf_set_dentry_xattr is thus valid.
>
> Anyway, I will leave it to Paul and Christian to decide between themselve=
s where
> it makes most sense for this one to live.

Also, perhaps it makes sense to use set/get naming for this one too, to kee=
p it
consistent with other ones?
