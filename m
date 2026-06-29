Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BF3630BA;
	Mon, 29 Jun 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731579; cv=none; b=ua2aOJuz6QNX3SNW0yLjq+Rn/LyZAn4FKh7Ig8LbtNqJCRPrA3rMtstk/gyas4PiLLWw6/2fNhi2zidSCThEJPMD9E7MaY5vqQi94O9IZ2bE5Bo3+FilTI87buAeQaJeLUJBOYKdfwOt8xd426y2A/KmGTRsJGgzZ42oP3P23pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731579; c=relaxed/simple;
	bh=nS9DpnVwx1zjHZwDcWFnZKcZolb+ONUdfziZ2+0LNLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQ2PuWKDW/g9ApiTrsrxBwI3WqrNVnqMAmdFCcLiwiJJtp67wHwlHHz2gqkJGtY3KLITSrgwBueRux35PREnNEYc8woi+F1hdImQ8DyVOulwmyIeiEV4x07o4JTy9tPrSvMig2I59VJHprmXE/u7xK4Bw3pGCsLt9JA+YX/H95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK/8dN9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK/8dN9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6531F000E9;
	Mon, 29 Jun 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731578;
	bh=II6UFmS/kZBk86eBwc2++62peQEiQa8YkmG82Y63ygs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YK/8dN9y+lJGv9+y5AfOEXUWUafvy1CPBci2prcfSZcbGSx74/vxgjKXHzh0yAKAC
	 IsglvZmbRrH0SJZP3vnZhOLO7RWJodTrVLSxrjAIKABiCyhsXkJYXISx2AWi06IOp+
	 lX/xmQ7cD8V/jt2TwgiUDh4acL+V6RzIXPVjWL/cEyGQ4wvlytEGsoX1TyYwfcEomn
	 gzRoy6aMtwF2Ll6fK65lAMkBPWCWUjX5Vr5Y2LWTIyXi80CVFk1XelkiBj+9pORW3d
	 8ZCvAX8eStZA491T1hS5wuIwVZ2r1b/Oqc7cS1ox/xBR6ZLo/BILF6SRX/3SRCfuUs
	 eMjJTWNR2oB3A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Tao Liu <ltao@redhat.com>,  kexec@lists.infradead.org,  pjw@kernel.org,
	palmer@dabbelt.com,  aou@eecs.berkeley.edu,  alex@ghiti.fr,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
	linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
In-Reply-To: <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
	(Baoquan He's message of "Fri, 26 Jun 2026 16:04:37 +0800")
References: <20260529032739.13264-2-ltao@redhat.com>
	<CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
	<CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
Date: Mon, 29 Jun 2026 13:12:54 +0200
Message-ID: <2vxzh5mlk3bd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+Cc IMA maintainers

On Fri, Jun 26 2026, Baoquan He wrote:

> Add kexec ML to CC.
>
> On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>>
>> Kindly ping, any comments?
>>
>> Thanks,
>> Tao Liu
>>
>> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>> >
>> > A NULL pointer reference issue is noticed in riscv's machine_kexec_pre=
pare,
>> > where image->segment[i].buf might be NULL and copied unchecked.
>> >
>> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> > but kbuf.buffer is NULL.
>> >
>> > Fix this by simply adding a check before copy.
>> >
>> > Signed-off-by: Tao Liu <ltao@redhat.com>
>> > ---
>> >  arch/riscv/kernel/machine_kexec.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mac=
hine_kexec.c
>> > index 2306ce3e5f22..d81d576f9cb5 100644
>> > --- a/arch/riscv/kernel/machine_kexec.c
>> > +++ b/arch/riscv/kernel/machine_kexec.c
>> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
>> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
>> >                         continue;
>> >
>> > +               if (image->segment[i].buf =3D=3D NULL)
>> > +                       continue;
>> > +
>
> This is a good fix, maybe we can add code comments to explain it as
> below, just for reference.
>
>                /*
>                 * Some segments (e.g. IMA) reserve space but have no buff=
er
>                 * loaded yet. Skip them as they cannot contain an FDT.
>                 */
> And is there any other place where the similar issue exists? e.g on Loong=
Arch?
>
> Other than above concerns, this patch looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>

Yeah, the patch LGTM to me too.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

Although I think IMA can make this a bit easier to understand. First, in
ima_add_kexec_buffer() it should set kbuf.buffer to NULL and kbuf.bufsz
to 0 explicitly instead of using kexec_buffer and kexec_buffer_size
which are initialized to NULL and 0, but never updated. Using the
variables here adds an extra level of indirection.

Also, perhaps we should add a comment in ima_add_kexec_buffer() about
how this all works, since where the IMA buffer lives and where it gets
updated it fairly complicated and took me some time to piece together.

--=20
Regards,
Pratyush Yadav
