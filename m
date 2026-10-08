Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBC37207D
	for <linux-integrity@vger.kernel.org>; Thu,  8 Oct 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479239; cv=pass; b=r7HrAW0MPq54LzpkJ4sJRCleBIvVs/wUhjTp4t5fJWbKn6QF/qyA2dXqjRmXiozDK0NnBr9bj8eLBIv+rBQvNW90Des0K/+KJvzVdnsSo652ZpWrQCyGhZJ19rKEn6D0A5IwpNJjDdOhTEYVWLA1zUnrONeqfWdLuF2AeNj9RCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479239; c=relaxed/simple;
	bh=QqDI6Bbid4Z5TSJM6uhAIwDVDE3XcRkTjQOjWmVeRn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBNyT0ABnh460H95L/9rzkVTwoM82bBYFwoGZ36HG25gezkXFbQ60Xf6WBz1wiPx9bJ5CFsdIWEtA3rIgQOmS0pq4yjCcvWknDKVjJyXUB/qAVI4Bx0pHgYDGOeCBwcNWWXNeZwBzQ+20/zXlrAgK7wC/YxXd7zdRy8k0dF3ulE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjskiTdX; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjskiTdX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-836c8bde2dcso31152887b3.0
        for <linux-integrity@vger.kernel.org>; Thu, 08 Oct 2026 10:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479236; cv=none;
        d=google.com; s=arc-20260327;
        b=EaBRuIYufhKps6mOsbd/tffvUwUOyelqMiDLWJJHPxoWrORxalqhoSCajHTWRoc142
         bm4h98JVQ1uZpOGl6CbJYq75Tc6jnKHxm625HgXJJhIaQLHSxNahsjFnYBNhzwGPOM9x
         SPjZTuHKhCqyDOSaSkjlKsDbkm3IqsEhwxOlWJZeJlAUu/xuMHb9Z18csfiydRc3DEzZ
         fzeiloq9VK4R3FSa1v1VTvfU+M654Y1REd0Mc48Q0c84DGu7WD21kjSWA4ZrepHRRgO+
         LtXy2qyYeFJwYMyjS2zoMfD0FHor2Gc7c50CkyTPmH3PcmuTjM+Zov9Jt5I8endgzEoA
         FDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        fh=BNiuaMvRfac7m3p0snkbGQaaAZi+M27tsEzfrGV+ujc=;
        b=UAHxYNyPt6IdwkHDStyLleQJ8UOxaYfuajIS7a6W/JOveTGtcCGIeIoxdrUn55zDwk
         wcDA2oPeM5EVd9swUE0Y4vQ7diB83ZkzP9fT2RZKv16vKls28cpxKzpZFNgr8NVlZ18p
         F9HsqAd0DEnWolpZE8YpISoydyFIa+aXNLU0jNrbeie+/xZWgMyV44g31WoLe5ykjtU5
         CDJcsoHWdffyM0V6gyyLJ7LUT1BWofLLAR9WWiQbmwHyUMexGd+bMApVv8WECdko5Lal
         TqyFmwpSZlctnEneCbmMjHxqyvc8ZXdoFh/hau6y8M7o+5/67Fv0hrBby4KsVtYMpCmy
         oRKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791479236; x=1792084036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=CjskiTdXhMBCOIOnG/ji8z7M7K/m2VM8bxynqze80Ch/Mad0y202dkdou7i8ZDrmGh
         pLXt6tEMMlu6isPmJjYONw0zlbyXN57WCSfJK2IqcD5y9CXWdpou684S3S3UefBh8m08
         d2fyETfcYmd/aBr6Fff9lHWFaF9d3TIbPFf5hE2ZYufrgNTosPdvW3Vws0Zn2h/+2r80
         wssMtraSEYY4zJmFsPiAzFjNq+j3E1lRC5s4fLoNSHhoYsIgrzDHSyjl5h+YzswXRf5c
         hEHXMo0+NUFC5JKAFGzM2Ff/yA4yX77jDoyM66BbKKiZWRqsL4WIOtSXFu5Y8BZjmozm
         cU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479236; x=1792084036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=ig2ikD9SfAZ9VVn7wybU08gLJb7qAZBF6FCeBnyx1TNPGPgjLshHva26FLJGM6eZfl
         xuyEdN7vJi+f/sMQaACc5R2Vf4YsyLyGI/AdcUqxQztzqe4psedQj/F2E+9gfSrQBbgJ
         W1GWoMiZQllLda000ce9nSWd40BhgHysQS6fY8gPdfEY4trfi31k+jHMRhYvTovWTTvS
         ay1keiWEc0BrHEC/IsAbp1u42DcNOvOB3TauNTH0eH+EKCSvnF5jI6EXaQZz4Dnt0UPa
         nMsdEaZF19gbcHPc8vSten3uF/FUtQl3A1fHtPgrnPMspS6dIPXlUg4KWFFxvssMLsg2
         +/rA==
X-Forwarded-Encrypted: i=1; AKwUvBxmwa7AuBsbEaHDbLnGDqDNd39cXjBiCSNMKvldRZ6rsIQPRzJstPpYL/IDS7dKGbdvHFI89OHqhp6NoBA2PL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLckZyvlpNaDMfFWKyrNJ9d/SinmVhTrmrLD5TeeBETuhsfYcxa
	jmrm3dzQGsEUm2NXgspVgtuX06U0DDYthMW2LKrZm1i31ATYSWyf6R+z9H7e6sB2ehYRkdh0aET
	u9Xo24c/wTo5AoTzLFVJISuIjEVdL7op2gOlM8xuDdVv1Dh+0EJTVgGlXLA==
X-Gm-Gg: AYBFou3xIH/nBz4pd4hcCwfu2Hc88VTwYO/1QFGEL0+dQRl+vOSnPOcuZy8jE7qKvkk
	JFf3oVUMIGPMCxmf3Lwtb8OARvtI2a5u/pVvJglNi0s9JM+SMzXx/sEmmff5lpktOvtFM9dQQRr
	YpJ35mk3l2c6lJEl4XA3jUpzcadMeyra99nj2jVbXAIOOgHN02RVfWmUVq2spZYptbU6VYQp2ZP
	Orcv5LFF3rrhzI3RjZ2rNHWYeTRvAQZaMs5XQWeWEbzsDGt1R2h1dKYHdf37+gPL5Zk7mmyT0bT
	Km0BI4M/FpnNHRJcKtZMmMSf7L7kD5aRu4ifR0id6hOCts6MhdIuHmgL183Qas66rYvfizsw8g7
	6Ifgfn1+2BSosNSFSEy+n76Eg15Eyceethx0P/gbaf9BBefHkliL8aFBpB3/eXkLIN8J9twmmGo
	JLP1J9RHlEdVsZHughjH6RM3jJqsDdB74gwY2zX/yu3axBCFgypZd/zjU5m99ByD9HKXwcH+Sd6
	58X4ZjB9hHbXLp8AgZOPcZ/igAI825zeeRRfxbeiyinU60ps0cWDtscm1B94aqLHqz+DldyoKFd
	FarSCnyzCTEQuYFAsTpd78SECEtCNZqCssgAGn5Ymq8Pt+JfJiYNceUmKIvq36cqCkSgFOE0rAa
	DYkFg1ZaKDWNGXJJyqLsGGVI+GJvlly+akmbprxbMPNT8G74mHTqJrJieeIC0uKIx
X-Received: by 2002:a05:690c:6d84:b0:8ae:b617:7113 with SMTP id
 00721157ae682-8b05ae92339mr32919307b3.6.1791479235462; Thu, 08 Oct 2026
 10:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132532.1155166-1-matthewg@nvidia.com> <20261008132532.1155166-2-matthewg@nvidia.com>
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 20:06:39 +0300
X-Gm-Features: AclHuK_axRHHNMJXbXP5qGzIg8glDqrcsSviR3SuESczjar1LzYO3sHRH5FmG7w
Message-ID: <CAC_iWjJJMgTCPwmVA+vhDq+qfh5U36TbBiqyzPaKeDxTaYjqsQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
To: Matthew Garrett <matthewg@nvidia.com>
Cc: mjg59@srcf.ucam.org, keyrings@vger.kernel.org, 
	James.Bottomley@hansenpartnership.com, linux-integrity@vger.kernel.org, 
	rafael@kernel.org, linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

On Thu, 8 Oct 2026 at 16:25, Matthew Garrett <matthewg@nvidia.com> wrote:
>
> TPM NV indexes can be used for various purposes, including using them as
> PCRs without depleting the limited number of hardware PCRs. It would be
> beneficial to have one that's under control of the kernel in order to be
> able to prove whether certain TPM operations occurred within the kernel
> or not.
>
> Reserve NV index 0x014c4853 for use by the kernel, and filter commands
> submitted through /dev/tpm* and /dev/tpmrm* so that userspace cannot
> undefine or modify it. Blocking definition is more awkward so let's
> allow that for now, not being able to modify it means there's nothing
> interesting they can do there. The filter simply validates which handle
> the relevant set of commands is referring to and returns -EPERM if it's
> the kernel one.
>
> NV indexes are from allocated ranges and this is a range allocated to
> Linux, so there should be no userland depending on the ability to access
> this - but let's gate it behind a default N config option anyway.

I think the idea is useful overall.

>
> Signed-off-by: Matthew Garrett <matthewg@nvidia.com>
> ---

[...]

> +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       const struct tpm_header *header = (const void *)buf;
> +       size_t len = min_t(size_t, be32_to_cpu(header->length), bufsiz);

I haven't read the entire code base but don't you have to check bufsiz
and make sure it's a valid header before dereferencing header->length?

> +       u32 cc;
> +       int i, index;
> +
> +       if (len < TPM_HEADER_SIZE)
> +               return false;
> +
> +       cc = be32_to_cpu(header->ordinal);
> +
> +       for (i = 0; i < ARRAY_SIZE(tpm2_nv_modify_cmds); i++) {
> +               size_t offset;
> +
> +               if (tpm2_nv_modify_cmds[i].cc != cc)
> +                       continue;
> +
> +               offset = TPM_HEADER_SIZE +
> +                        tpm2_nv_modify_cmds[i].handle * sizeof(u32);
> +               if (len < offset + sizeof(u32))
> +                       return false;
> +
> +               index = get_unaligned_be32(&buf[offset]);

nit, but get_unaligned_be32() returns a u32, might as well define the
index as such

> +
> +               if (index == TPM2_KERNEL_NV_INDEX)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +#else
> +static inline bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       return false;
> +}

[...]

Regards
/Ilias
