Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE839DBFD
	for <linux-integrity@vger.kernel.org>; Fri, 28 Aug 2026 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957028; cv=pass; b=QkyJSMm6nG/s6xLZDiTSelG8Gi1vHKMlVL1XU/KVhBEx+VvKqzANVB3jE+I0M+93YQyRjuKiEInW4aaeR7jsWnkejW/yj0lCQW+KMaBaIvv7xLx1FRqgLCNcKG+XtWVR1JI5+Ngl98A+AarZIZ438DgJAhGWmAGQp66I6hsfsBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957028; c=relaxed/simple;
	bh=DGHs5SQQXiotArDuQZ0B9Dgbv8T3sLVqVQ1dRhCjkp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqSqbC5SEmZGiP33ZiCZeDzruSM16q+vksclstM6ZG4UPhoOpF28Q/cyKNWmtoVY5q8eGW+jvf+539veQQSzEzUkLjbx0Rzfd6TxI4C9SqfP+JqkgBBamKNNZlK1aPvLMA2xHp2KdxmJsGqggAVfQ4A6uDoQ8H0U0k5s+7/Y3TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPWObJC9; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPWObJC9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f64e8dfbcso29768707b3.2
        for <linux-integrity@vger.kernel.org>; Fri, 28 Aug 2026 15:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787957026; cv=none;
        d=google.com; s=arc-20260327;
        b=b8bMAzqtqsgfTRJNpfOKyUUTlgws1N6Kb6xzcIqA5n5sPj+lFB+Qmvl0KXt+JRaLuJ
         HuLPMf84kzqkHjeupBXtBHIbBqGALvTR4teEGAWeVd3afGZA6P+a7MGuOwjLBjcZ8daJ
         HmaueLfopnwSkQxHN9G1K6r1jPc6YVFuXswjTEWp6wE6h+n/34YuIzPa1ksHstoOa3d5
         his54WBwN65J+EsNCsQkME6KzZNq/qNLqixPKDjM0g3ofqVzHiqp5JI9Dn0vy162aFCb
         RNZyURlpZny8qiPfPxMo8Zgra47+Sua0pnfblB0hcvqAl4Q0yREw7eijlpqpIwY6C8dN
         9Yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        fh=InjfCldm/8eIvg49s/SprK3+sTvOgL8EjeOy/1l1sPM=;
        b=hkItzBlWJA9uRYuDJY5KrgucwdY64Uk3bDiU4T68vTv6aOKRy5G+aCyz9OIz3OmvKN
         sXU8K+S+ul+zfKnc2IiER6kao6HR+MhoiQGIZsIb92LI5AflJRnSraMXAqqJqGWUohqJ
         QGxd90et4R+B1P8M4mjvliPjIUwZbimhTBW5UYQhAoc1NpmMePNc5GBdwtbAQecM8l6d
         UOJIODtAj4HJaj2Krf4ZbAveasLSD3jCIBrx6ek0L7vv3qBjlbcmc68P/Cpa8GgmfBqH
         6M+Tp8ilTkyba0POfm+yUaPfloR1/IRIqhAKgKRLoNffBDzbcg/egzC0Kxv1nJr2T+Nn
         ZOug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787957026; x=1788561826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        b=ZPWObJC9XErP/c51Kq9jXBBMOXDC9oQtDCDrLpg2KI/n+c0DchOMIVyWUYwNIN/uWZ
         ZVyicpqhFFSnUuw/RqCTJdjnNNd3dfIDi/O54mFtjTW7opIKJ5ioSkWATJ9FzgixuAgk
         YOTzztjMzAkv9qRyr2yoBV4BbQMp1our3gGxJT7dwkepd/q1l/9+LY4f1Mdeg3pzjL+3
         C2cSAk0C/UEszSWwlPBEh+SaAGkeQKNF6r+pCSG5Mht9ngeSArY4bDbhBBRLRc7SHSts
         pANgceWpIW8S9vdYt6JB3iYoZA+AiMcMs3AZnJuf7rR4xaWjRza9E3yZ5tfd9AJ8Dx7H
         kAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787957026; x=1788561826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        b=P9T8JFl9xQwGdLlFyi1q3FTFnwR/BUHkO9Gk769jjuv7P5t64FYonzDLOAnw/k+wcN
         rzBA+7t8f7VMy1E8OISabraSKSttE29oVxviLhM2+r+N1Vp58vxR6swzza08XWcUCfje
         FrJpuVyuNdGL3oC2ZbbenenvATxY0vt+1awG873GTvXCxGOZQd5CrOX/EPvCIVHhkZi6
         sW9M7FI7id7/JA8rlIqd9QFn1/TXIZ8E+azYazKw2kBHZJWR/JvkJQSqbqcd7xmbMzuw
         1wSMQCrdI7KxNIgosoHPkkxAM3pMlv5iHFcNxUy1L9XdJLqUCb4RHbdeZcBV3eTGw3Vu
         +4xA==
X-Forwarded-Encrypted: i=1; AKwUvBxxqn3Qu9CG6NgDETO84hTTeCOFtxs4itGsZQTjXECk2yVv9ilOqOACgjbkoC375mHYaSFg7K0oMmOrPFc+D+g=@vger.kernel.org
X-Gm-Message-State: AFuF++mbCajrnKcec34FEPyv+rHZvkPsR9rmu9SSQwMp3QPr+n/lfElD
	7UELPfh7oLsZBzayXF0N87iJiI/6bbHyDhW4cxbJnWpWods/uOnzHlznYn3QOiBLDUFi4oJjAaU
	9uAkZyr9C89QBv8ukg06OE3GcRmzkVXw=
X-Gm-Gg: AYBFou3y3gwBoCrOdmEy2adhBrTAaF5ectNwRIk3fBfgJvZkNK0y3UMntdRi6XdqdFn
	/WzN18h5dy299sw094Sb0Uf+N/1xiGGCA5OaMa/I6yANg0fsNIRLlE1OGYRZNYTsKqkz66OvLFt
	gqThIA0zrQf2uuV0GPqQvfblYQekdzsawgr+tuSp2q+ncVeladqttZbZbbzFdOL28OggzF5S5cK
	ZZ8+8DZcyRmgj7PNvoTaLTCzr/X56oUiwgDP7VuYwmH9rkt86v3NZ0KLuRhO8v2MKyY7vtnB3Nf
	JFGSnLy7TOufe6qzixFhbrRI3xDsul4nrPbBEKufroAFv4hlYelBuWATvuGfqK4a1+rbpnB/CyU
	y
X-Received: by 2002:a53:a690:0:b0:668:1c55:4283 with SMTP id
 956f58d0204a3-66e4c76d946mr2712395d50.49.1787957021314; Fri, 28 Aug 2026
 15:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955564.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12955564.O9o76ZdvQC@rafael.j.wysocki>
From: Julien <julien82453@gmail.com>
Date: Sat, 29 Aug 2026 00:43:30 +0200
X-Gm-Features: AcwNN1XYBX11rSIqXNiWyf1cOFtlIqqPNasGuWLMN_MrER9LH0cNWCpmTMsLH7s
Message-ID: <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> with resource overlaps") attempted to avoid platform device registration
> errors due to overlaps of resources of the same type returned by the
> same _CRS object in the ACPI tables.  It did that by combining two or
> more overlapping resources into one, but it went too far and also
> caused resources that overlap completely to be combined which broke
> the arm-cmn driver that expects two MMIO resources to be present for
> each device it binds to and it expects those two resources to overlap
> completely.
>
> Address this issue by adding checks for completely overlapping
> resources to acpi_platform_adjust_resources() and add a comment
> explaining what is done there.
>
> Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with=
 resource overlaps")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162=
/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    * It is better to check for complete overlaps both ways as suggested
>      by Sashiko.
>
> @Julien: I would appreciate testing this on the machine that needed
> commit f234fdaae1ca.
>
> ---
>  drivers/acpi/acpi_platform.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
>         for (i =3D 0; i < count; ) {
>                 struct resource *res =3D &resources[i];
>
> -               if (resource_type(new_res) !=3D resource_type(res) ||
> +               /*
> +                * Look for overlaps of resources of the same type that w=
ould
> +                * cause resource insertion to fail down the road.
> +                */
> +               if (__resource_contains_unbound(res, new_res) ||
> +                   __resource_contains_unbound(new_res, res) ||
> +                   resource_type(new_res) !=3D resource_type(res) ||
>                     !resource_union(new_res, res, new_res)) {
>                         i++;
>                         continue;
>
>
>

I have tested this on commit 1b78070aaef6. It seems the patch is
already included in it.

TPM device still works. Here are the logs.
acpi MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded due to overlap
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

If in the future if I need to make tests again, should I do them on
the Linus Torvalds' branch?
