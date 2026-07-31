Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C637F8CB
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535479; cv=none; b=mQ9p87xPywAFLd7Xpsh7nhGEcd+qwXigNbV4ztK7jxIiScVQMtz0MnlIRBerTcp7EQIcs0xGYrje8Zqpj1IR82eWpLWnVIG+zIYLs/O1aWzTvU8Rn3qvSCi0ogViTijA0oNVOtUZO9j+M+/qIwMbo2SiajVpgSVzgKWZEbKZOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535479; c=relaxed/simple;
	bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q3HaswKrymlLAaMFpwd7TSE5bQy/D33IrvMgV3AhBrnev2m/YTYEmCPqzLSVM+7Q3wnIpjk487ZiRCrfvZr+FzaUmM3RTTttt1/FVrTO0YVP2gF+CTDLX5/Aqux8W4Pn8ORa0p7wPWAZYH3B2j0F3nFdMSEGyL1hbTt5y5roH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIYc7LW1; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIYc7LW1"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so755492f8f.0
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jul 2026 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785535476; x=1786140276; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
        b=PIYc7LW15LqbZkuMZDZjDpDgb1MFX210iD/B31BuAI42dM5EYfOBbO/Fh10jSoFIY/
         0u1l8A5Hx7/s+GvcEcBhy8cURVeHM5Mo+PR2U7rr73gqoB0XO+TXH85kpIDxV9MxO2iF
         u5ejd1oHvPWQcEiG7F/4S55oI4uG4XLG4Fc4TUFTmrClQjiESbHEt1YOsgEWzsglrFRj
         cfYQblJxRtDV8yHUAR3tZg0wJFtDXzgtj5vCiP2rW7j2OTqYYiQy3oAnl8sPTXBC3Vgd
         TNwm9tvwJZIo2J7M9aGAO+ZMMIfT6tWgpS1BgGWNZrZbwtFrUtc2kldvKC34K9wz5nQC
         kzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785535476; x=1786140276;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2mO12QQOJ2mz4UuDmayqPHsK2P8n8l4gan0qKokjpE=;
        b=cyUjkv5qQZyVQ8OIEFom6vmfls/ffScsrM3Cat/pTjfMJTySs0sqX7pcLaNCjORxEZ
         luUIQ0vqtGLe9YBUdwendGk/X+hu/1lyp8uvfb04WDokaUk/mYDJnKyp1ObG+grZB9cd
         Jaza1ZSU6cW0elBE4eJ/KBxawHmQ8PHVZ3/rY4z6K9MbCBrmc//bgKH7VOHm43/iirvg
         Naht2/0/5nf/vkGr5eT5QQRuQK6yHhTVHv9GnwSLkDrsLGzKdRn+okQXzB14SwtL8a/o
         XNhJVrmNpZ1fMGiYuqItfzYbkkIWUUM6DKOihUEsRqyCT0anYQzU/PfgdQ8JLWmH9r7t
         wz+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro0AZC5zTaJ0/QqQpCUD78ozCUV5BFfA2X4B5PvyBrp0xDYZJztNg4FfitkOF2DZ3oW3vE/VUzlI914RuktJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsC5xjInYMV/+uINLOCM9/b6tfwHtPEHgsyMeF5yzc0SEIjvGU
	eLVOKPoYD+ZcRjKqrj0bFOYshcWU8Xoa1TA7TuFUntaFh7940g1Axb5f
X-Gm-Gg: AR+sD10EzfCuBlrp8pCgblP+UHC7g6JECwfqCnmAQv1W8kTLBtJOowdIWzMrSgi31k+
	+75Kms4TWhhvnZZVfRTH8+ms8wYgGracgphDkTrni5Rj5zjzFgWHezSIdpwTsTfnoG6zaAjyd0f
	x/Rz8ZhNZupCJMtlaWz4eWgYGnRgE4rC+IMeV43z3YFEZHqoW2CNvm8LlUvbH5sa9UCVE72McYQ
	KYz8kPMlFR+K2E5+Upk96EsT8kdbvFTWoYuJgYNW5PNKnL4jbWz4zRZ8yweRlU4R5xg6KRwjB7J
	IXSL7QLDKVj6rfAKPsTV8JWTmeHk4Mt+iWZ097MwTdnc3oiH9cn+Xgdks0AJT+YiD1Wwzorm5/n
	amD3hj1S0HxORavCzhat9u/inX+3fCi+62wBbMUkBlI8/rc5kS4I1dAiUtq0IZEoTfOmHqwyVnX
	Y7oRCoE4E5EQOGbQssDqBmg/2gbB3UNX9F13aZ/XFln6K1cK5s2Mfc7nTVa6pkZOOI7PCiwSX90
	q1UrYvHoe/SQrLPv93FVP+Sja8IVaAP0UcZ6ttPypoVuNOycAdfkIPmF+VGCF0tde2+9PcpWTqt
	3zepAySLPpnpfMXZQqYkRGXGqWo=
X-Received: by 2002:a05:6000:2707:b0:47f:7005:285e with SMTP id ffacd0b85a97d-47fd72f988emr1633857f8f.53.1785535475666;
        Fri, 31 Jul 2026 15:04:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm9623006f8f.36.2026.07.31.15.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 15:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 00:04:34 +0200
Message-Id: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "James
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
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
In-Reply-To: <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>

On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwive=
di
>> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya D=
wivedi
>> >> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikey=
a Dwivedi
>> >> >> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wro=
te:
>> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore =
<paul@paul-moore.com> wrote:
>
> ...
>
>> I think you keep forgetting that you cannot unilaterally decide this. Bo=
th VFS
>> and BPF people have told you that it does not make sense. What was clear=
ly LSM
>> specific code has been moved under security/ already.
>
> I'm charged with doing the Right Thing for the LSM framework, and in
> my opinion it is in the best interest of the LSM framework that the
> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>

I think the "Right Thing" would be caring about your users and the project
moving forward, who want this functionality, and figuring out the best way =
to
make it happen while working collaboratively with others. Life is full of
tradeoffs.

Instead of dictating how others should bend over backwards to agree to your
arbitrary rules on code organization, which they don't agree with.

Everyone you've pitched your idea on code organization to disagrees with yo=
u.
Yet, you remain adamant that it's the only way forward.

Materially, both you and I know nothing of consequence would happen if the =
kfunc
stays where it is.

As a consequence, everyone suffers because they first need to satisfy your =
whims
on how all code and kfuncs written thus far are wrong, and need to be moved
around ASAP, including the one being proposed.

Not only is that a disservice to your users, but also people who've reviewe=
d
code (apart from you), and more importantly the person who worked on this p=
atch
set for several months.

At least a month ago, you had the good sense of not dying over this hill.

> [...]
