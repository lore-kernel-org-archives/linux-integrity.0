Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FB209F43;
	Wed,  1 Jul 2026 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877812; cv=none; b=TspWHt3qdZa+a+/anaytyJnXax8MuDSX4sWUqyEWGxO0wwIm9lysy33/MI3+iF4EP7DLRW29RuUb+cBiHPplbvJmH3gpGTx6Z61hqBwbY3pvHj+EdRjvlh+w6e4AfvNy8mBipg75Tk87ZDhuA8lploryhe1fC2/xRs5yFIMkB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877812; c=relaxed/simple;
	bh=8vKfOGoaCFSCpkU2ReLrQ4eVeWJVwRdXqRYCnYJNNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk92NMdvxssnpS7Qf2R3zPk0qt378lTEu3Y9yvD1pQ5x9QeCP7FN9F4vZMSTWR1YVEcl+l4A7K1HMLS+XO0n4iV5xvOl/VmA2RorWDwVEibHyqORmh4VE0Cib3VzDHxacsLj7bOSW0dIFJWfyC6LslJX5d+b2QwcDTHSmFfbdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asBx/pvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asBx/pvW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 34D621F000E9;
	Wed,  1 Jul 2026 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782877810;
	bh=T2hTvlYeEHmVWblghsmcULzurIVmIm0KteC2foXWL4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=asBx/pvWNrFnZYBspRkbA/I6pxY5wRW0Lvrd7tA0d6v7MXkJDjynYVi+iPqtGDH2H
	 omMweFN3sHn5Uzygl0ckOSfEENZ1y4tk+wuno/wawIL/eMUwv8EHKjc0iXqjU/+Sfn
	 7bUt5qrgAlQMDKusfJ+TQUegRmfcz7CutCLGc2mbud98u5klDsr+hjS+PGWnYVGn4y
	 JS+rXzClMk0a1KlwkP3DUUgIQ8wwKrSmJ0P7G96OOwsMn8iZ9SOTnY7JWVcMPVMdwj
	 JStvyC80x133tJVhaYjzdJn9o2RqtVa22FiYcCRd1S33nvLklNjxWez82dvJ586v9r
	 CH9YzC9mNmEEQ==
Date: Wed, 1 Jul 2026 06:50:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org, pratyush@kernel.org,
	Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
Message-ID: <akSOb1_1tcJvFyda@kernel.org>
References: <20260701025732.66330-2-ltao@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701025732.66330-2-ltao@redhat.com>

On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
> where image->segment[i].buf might be NULL and copied unchecked.
> 
> The NULL buf comes from security/integrity/ima/ima_kexec.c:
> ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> but kbuf.buffer is NULL

This should have a proper call sequence. Now the root cause is
obfuscated.

> 
> Fix this by simply adding a check before copy.
> 
> Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
> 
> v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
> link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
> 
> ---
>  arch/riscv/kernel/machine_kexec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 2306ce3e5f22..afc68f6a4aa1 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
>  		if (image->segment[i].memsz <= sizeof(fdt))
>  			continue;
>  
> +		/*
> +		 * Some segments (e.g. IMA) reserve space but have no buffer
> +		 * loaded yet. Skip them as they cannot contain an FDT.
> +		 */

This is destined to rot over time. It also adds up also potentially to
the backporting effort while backporting to stable kernes. And most
importantly. Please, don't document every other null check.

> +		if (image->segment[i].buf == NULL)

if (!image->segments[i].buf)

> +			continue;
> +
>  		if (image->file_mode)
>  			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
>  		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> -- 
> 2.54.0
> 
> 

BR, Jarkko
