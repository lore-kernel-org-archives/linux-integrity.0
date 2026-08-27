Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE562BE05F
	for <linux-integrity@vger.kernel.org>; Thu, 27 Aug 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794966; cv=pass; b=DfaXHLYGaixB7vKUi9SjivKMg1q4NkeSaffwp/88TyPv2KY7uqpTAZsN+a5qjPPvVUXQ2KQk7CJUEAzdyje79tfAIgQLdebrJdf7m/UHvKrxiJcPAXLsNa9MZRbupfM/L1ktrCpE9CQ7w2mV1bJJsvt6qJtrMmPticnK9Zdtvrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794966; c=relaxed/simple;
	bh=jQXZpWEa69A8mhfcE1SS+n9nS7LZ88iDUXIZo6zOxlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3hJxrJe/Kh9oo5dqH7wbHWapy3uxj3JpY2hAVQUDTBpLvUsesEQY/7c2MqVyJ9eb8DxM1eEPVgvUj5uc4EGENfLmHbat0svAxmpoD7vwrgR7dpmojYfCAZ5vHq/zdW/npkKMbfhQLz8nlZJ0xMX+TucjiodHXhGRAJcrwbbgIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZS/rb9Jb; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZS/rb9Jb"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedf433a99so1472087a12.2
        for <linux-integrity@vger.kernel.org>; Wed, 26 Aug 2026 18:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787794965; cv=none;
        d=google.com; s=arc-20260327;
        b=lEy7r6y2jC5flxAed/p8aUwXyXyT3/pCKgAx71wbS7R2Ihz2J1X9sFZalVzKAsfdV2
         WPML8RM+9GsQpAZc9MJdu/U6RjnY5f535takLEWF4ohqqqRdCMTqmOxgU7HNTyRG2hAY
         X8gpVaIdeaddUruek9QS6Go/48O1Mm+PjaqhJAL7Zdo5Re/4cAh9tEK7I1IWY+mCTZTQ
         C4ZsV3rjnNFygWakvKMPkyxMZmmceBYwV/MElHOd1N0gn1EfVydAAGH4N7DdMt4VHDQC
         zuUpjAtiDP1PW6Dvtea9YQ9EmBVsch1b0beSIfBme3Ui+YBRdkbswnmBHRAC96evJLGi
         v7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        fh=IlhTjDxpxrBRWnJV6xlPEKUDUQpP1gOEFS8F+hwNWOk=;
        b=TDzVD4DL0sDh/8RG+R+NPmJf7/uXaLULa3PIo0sXMHPlZN90rNbszX7yWxibJk9Fl/
         nNjOdfrqNpWwP/OUSPH4K3L4Ig6OH0Qqv2IwFpRat3xoXhFQQKV35YKaHKi6qtqYD/fH
         5yKcY/BqCXkAEVf0O+xgrNHhn5kodQAU0h8jsGgfsX1gL0wDH0jjNg8yF68UaFPZXjlc
         g9cwRqhDqIUP+/5GRAJvRIgIKlLfIRGfHK+KS/D/J/s34WaGTSwM/grxkwOG18pcSgIx
         g7/ot6Cz2jE/K6NBPAq8lNkZT0DttZMfv2V2a7CR4+J4VxdDa1uvMWSnNmVyBHzrMD58
         d9zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787794964; x=1788399764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        b=ZS/rb9JbpBtoMVh7PAYy6LGfjcUOZP2BzJct6dr68tYf05WpE0/kXRfugBF2dt1Xmp
         1SX1TGUOyJpv3Ekc98KdvsO9TqoPSoJDMl7a5U/mYuf/mT480m+596SZIHcwwDxSBuQP
         fbk3Fmw3qOIQDaCNJjzxAtzqZ3ayPdb/izVnwgfw6I+u29RzyxufkTocXOsm5dnDhvYz
         gYI1GEr0iGbXl4e9kQE7CSSROv7FGbZ3Y/0xb6kytciu7fohVc26DxWGwu0EjROrsOZg
         v1z0KAe1QAWQFgmpgodEuZr7DfP/ysAWOuUr11HAF9js4TeX/w+SVXp35Dvm3HRsWJs+
         u3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787794964; x=1788399764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        b=Kowv4q9hSZy4pD4mOpsX/+0HjZHyXDqq8Q5hYDy+NLsoVhwRx/YXYzAS+D/cPV5PDL
         Hh2htf+aENPDMCwfrp3AUSejSkzscpp5mVMpP32rZwnbXSBTtVQySgYrdme2t65LKukx
         0A0kMuAZPWVeEDODYYAyKqA9gM6+yyqCQKNjsuVlaDo7rP1wDqJzpEifQpPPTtCLy3VA
         hrgrAr3pMySrxM2c1oxyOoAGZRMBQbWoP3MkdTBWz9oM5spn66zr+zMa+CAKhuX7/gQM
         WY6+DvgQJ+eyqfSt5Wbr1IxaF2OF+S9nIHsBIsEfox7RLqV0gajWvXpWtruiMFqArNd5
         9uvA==
X-Forwarded-Encrypted: i=1; AHgh+RowLOoRzxT8Fdnpn0gzkWujGVNkbTypAM2LokkiDBLkUNTHLgRRBIiacsgNQo6O5hsovlC4Oy312XQEVtkCLio=@vger.kernel.org
X-Gm-Message-State: AFuF++laqwkJV2Qw+s352WuWY3+hp0eCiZSAj/QJ3zq6bfS8Y6581sBP
	qkCr7Ir3fdvSsong8oWMoDIx8S0IIaLTuwA6kYEpSizhZIbEFyuH+QyEFf3+h7pDm8CC745cGCA
	gi66OEoaFZNrfKmccekUolgniEYwXTnP6ejd2pF3H
X-Gm-Gg: AR+sD1212mbUJlwFxqbXjiRgXwxfVRFC16jxZiSf30THrrxkCkKJUYMgN2GaTPhg9X5
	rPu6kitJMroKawK5LVal4MnAUD3q2i5zRMyu4i2qNbNG8/OCtT0w2q+xyLDyjMTEiFCbHs3+6X/
	l/WHW8ljjzClycByeOS3hTsdcu94o1PNIATMcnen2k2FVgkMWQviig+1T0ZKqeb4nuFyFu5qTb0
	LezQ74mtQixDods7W6DbpXz1/UVHv6tZBgx28SyRAYP3cPGIFKat4xwXXezzF8UN5loIEhgNSYL
	BTwRQuuET7+Ggw1PRkBffjzuiX7PPPIZnrjp6NY1ZpU0
X-Received: by 2002:a05:6a21:9202:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cf76283ed6mr24475298637.6.1787794964690; Wed, 26 Aug 2026
 18:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com> <7F4D890F-C006-4855-888A-62ED786A32ED@mainlining.org>
 <CAHC9VhRvoDkJ0Pn1WHgTAEJ5RwZTmD4vChFGgqATn90C-Aae+g@mail.gmail.com> <1129ADC2-8838-47EE-A817-87631D933BA0@mainlining.org>
In-Reply-To: <1129ADC2-8838-47EE-A817-87631D933BA0@mainlining.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Aug 2026 21:42:33 -0400
X-Gm-Features: AcwNN1UZQjdl8nAFoKRE5OXLt1mXTI6xe4mUlw-2BQCvwnerelt_uTfOeFp0llk
Message-ID: <CAHC9VhT-SH8ci5f4cEGafAub4qE09KgWPJHRMgO_Uhwca2c3Bg@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel paging request in integrity_audit_message
To: Bradley Morgan <brads@mainlining.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com, audit@vger.kernel.org, 
	eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:23=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
> On 27 August 2026 02:22:17 BST, Paul Moore <paul@paul-moore.com> wrote:
> >On Wed, Aug 26, 2026 at 9:06=E2=80=AFPM Bradley Morgan <brads@mainlining=
.org>
> >wrote:
> >> On 27 August 2026 01:50:45 BST, syzbot
> >> <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com> wrote:
> >> >Hello,
> >> >
> >> >syzbot found the following issue on:
> >>
> >> #syz set subsystems security:
> >>
> >> Note:  here's my suggested fix, in security/ima_appraise.c
> >>
> >>  path =3D dentry_path(dentry, pathbuf, PATH_MAX);
> >>  +if (IS_ERR(path))
> >>   path =3D NULL;
> >>
> >> apparmor and tomoyo both IS_ERR check their dentry_path calls, ima
> >> is the only one that doesnt. NULL fname is already handled by the audi=
t
> >> side
> >
> >Thanks for taking a look Bradley.  Adding Mimi, Roberto, and the
> >linux-integrity list as the security/integrity/ima/ima_appraise.c file
> >is their domain.
>
> np man, do you want me to submit a patch for it? or nahhhh

That's a question for Mimi and Roberto, but if you can put together a
patch without too much effort it definitely couldn't hurt to post it
(make sure you post it to linux-integrity).

--=20
paul-moore.com
