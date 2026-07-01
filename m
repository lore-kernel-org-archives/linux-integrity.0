Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAD3F44CA;
	Wed,  1 Jul 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907611; cv=none; b=ZZ+mXdkl4Ln6ZzWDMrEpvG4J4Cz3IzegJYeFJ2C8O0HQiDvlCQnTvMxjLAxXDYLxNp+iKS2AfUXXC9zB22qhZclUzN0KCvmhcvxAqzDkm/na+4Sz5tz0rzAYTwMoLqrkasyDUjyp543/58dFr9HB96GvOO+JJE8NLmpz6HlXjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907611; c=relaxed/simple;
	bh=Q5m+1kR6qSgjcHtq8/avoSqmbIOfvV1/csQ7HKjTpX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=un3ThnAj7VrdDtFRX5/yW44NFBk0eNR3FFbIAXfOnUtEPsrsZ8RYjjDEUrOy/7Hwb3svm4WDk1EeCCrQLc+3HOzbsecvDZDaTjfDrt+VVt+Ml+wX817wACK43K0Y5jR+peSftUar3H0UC6biNMx8RnnSIfZz1pjJpTsyXO8bTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOWpQrRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOWpQrRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A713F1F00A3E;
	Wed,  1 Jul 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907609;
	bh=Hne4NKxMdbJBFIiD0wCOi2iipHevw0mcVZRCTIIGryU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LOWpQrRhH97A0fz5LUgzxyegEAGwXRsHMYb3vqySjqS9mxdabcfZ6VlENUAdS96Ud
	 f7T0eRj3gJuhgXnXx9x+EGoOBhK1kRjaytar+2yi6TXjJbS6LJkNzrjs7cwdrkodEF
	 n0XEF8l0UTwlAXaRhPhRiSgC1fR8EJ0B2ZfURlzSepWEU8Okyfa3gF7U+lAVb7Axjl
	 dKy58x9a04WPcSeCb/qHszbUDg/WJTeaMcdVE8OaO0zh8Nm8t4ZSQIiWl+5Iu2fKWY
	 SLv5HE3sCyI2ttG09B9QcM6JHgvwlXk/1QBxWHzEIZyiwDmKeSBj4CzodBHdri8oeV
	 QjeXYEXSGlcxQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  alex@ghiti.fr,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  bhe@redhat.com,  zohar@linux.ibm.com,
  roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com,
  eric.snowberg@oracle.com,  linux-integrity@vger.kernel.org,
  pratyush@kernel.org,  Markus.Elfring@web.de,
  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
In-Reply-To: <CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
 (Tao
	Liu's message of "Wed, 1 Jul 2026 16:58:09 +1200")
References: <20260701025732.66330-2-ltao@redhat.com>
	<akSOb1_1tcJvFyda@kernel.org>
	<CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:06:45 +0200
Message-ID: <2vxz33y2j4mi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01 2026, Tao Liu wrote:

> Hi Jarkko,
>
> On Wed, Jul 1, 2026 at 3:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>>
>> On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
>> > A NULL pointer dereference issue is noticed in riscv's machine_kexec_p=
repare,
>> > where image->segment[i].buf might be NULL and copied unchecked.
>> >
>> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
>> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
>> > but kbuf.buffer is NULL
>>
>> This should have a proper call sequence. Now the root cause is
>> obfuscated.
>
> Sure, I will attach the stack trace in v4. Here is the one:
>
> [   62.867540] kexec_file(Image): Loaded kernel at 0x80200000
> bufsz=3D0x34ed800 memsz=3D0x35d0000
> [   62.879983] Unable to handle kernel access to user memory without
> uaccess routines at virtual address 0000000000000000
> [   62.880736] Current kexec pgtable: 4K pagesize, 57-bit VAs,
> pgdp=3D0x00000001062eb000
> [   62.881185] [0000000000000000] pgd=3D00000000413b4401,
> p4d=3D000000004151bc01, pud=3D00000000415b7801, pmd=3D0000000040af5801,
> pte=3D0000000000000000
> [   62.881969] Oops [#1]
> [   62.882077] Modules linked in:
> [   62.882717] CPU: 1 UID: 0 PID: 894 Comm: kexec Not tainted 7.1.1 #4
> PREEMPT(lazy)
> [   62.883037] Hardware name: QEMU QEMU Virtual Machine, BIOS
> edk2-20260508-2.fc44 05/08/2026
> [   62.883365] epc : __memcpy+0xd4/0xf8
> [   62.883685]  ra : machine_kexec_prepare+0x8a/0x298
> [   62.883914] epc : ffffffff81393ee8 ra : ffffffff800366ca sp :
> ff20000004a83d10
> [   62.884214]  gp : ffffffff83258db8 tp : ff6000008573db80 t0 :
> ffffffff80033640
> [   62.884433]  t1 : 2152ffffffffffc0 t2 : 0000000003000000 s0 :
> ff20000004a83d80
> [   62.884710]  s1 : 0000000000000000 a0 : ff20000004a83d10 a1 :
> 0000000000000000
> [   62.884987]  a2 : 0000000000000028 a3 : 0000000000000028 a4 :
> 0000000000000000
> [   62.885208]  a5 : 0000000000000000 a6 : 0000000104e33fff a7 :
> 0000000000000000
> [   62.885486]  s2 : ff60000082a35800 s3 : 0000000000000000 s4 :
> 0000000000000010
> [   62.885774]  s5 : 0000000000000028 s6 : ff20000004a83d10 s7 :
> 0000000000000005
> [   62.886005]  s8 : 00000000000000c0 s9 : 000000000ac0d220 s10:
> ffffffff835420e8
> [   62.886218]  s11: 0000000000000000 t3 : ffffff800000007c t4 :
> ff1c000002138d00
> [   62.886515]  t5 : ffffffffffffffff t6 : ff20000004a83d10 ssp :
> 0000000000000000
> [   62.886860] status: 0000000200000120 badaddr: 0000000000000000
> cause: 000000000000000d
> [   62.887162] [<ffffffff81393ee8>] __memcpy+0xd4/0xf8
> [   62.887388] [<ffffffff801b253a>] __do_sys_kexec_file_load+0x1b2/0x338
> [   62.887612] [<ffffffff801b26e4>] __riscv_sys_kexec_file_load+0x24/0x40
> [   62.887855] [<ffffffff81395ea4>] do_trap_ecall_u+0x1a4/0x5a8
> [   62.888134] [<ffffffff813a9eec>] handle_exception+0x16c/0x178
> [   62.888445] Code: 7613 07f6 ca05 86b3 00c5 e7b3 01f5 8fd5 8b8d eb89
> (4198) 0591
> [   62.889223] ---[ end trace 0000000000000000 ]---
> Segmentation fault         kexec -l /boot/vmlinuz-7.1.1
> --initrd=3D/boot/initramfs-7.1.1.img --reuse-cmdline
>
> (gdb) p image->segment[0]
> $3 =3D {{buf =3D 0x0, kbuf =3D 0x0}, bufsz =3D 0, mem =3D 10737586176, me=
msz =3D 4096}
>
> The buf =3D 0x0 and bufsz =3D 0 comes from ima_add_kexec_buffer(), thought
> I'm not sure why it added a NULL segment, but it is no harm to add a
> NULL checker here in case any other scenarios similar as IMA.

From my reading of the IMA code, I think they do so because they don't
want to add a buffer to the kimage just yet. This is because there can
be IMA measurements between kexec load and kexec reboot. So they use
kexec_add_buffer() to reserve the physical address space, then they vmap
the destination pages in ima_kexec_post_load(), and then update the
destination pages directly via a reboot notifier. So they do not have a
buffer copied to the destination pages at the time of
kexec_add_buffer().

Now all that is fairly convoluted and not very obvious, but I am not
sure if there is a better way of doing this off the top of my head.

>
>>
>> >
>> > Fix this by simply adding a check before copy.
>> >
>> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
>> > Acked-by: Baoquan He <bhe@redhat.com>
>> > Acked-by: Pratyush Yadav <pratyush@kernel.org>
>> > Signed-off-by: Tao Liu <ltao@redhat.com>
[...]

--=20
Regards,
Pratyush Yadav
