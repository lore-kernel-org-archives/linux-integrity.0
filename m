Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706873D413C
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654387; cv=pass; b=c6t+C+yaFDYMJfIzomsvnDkOWUTKXQYco/Kgz3NHSBqI46EckADRg7agzgfeseplBhL56sCyufAKjUqUFAm+a97pIziEWBWfpiDxsV1OpchoPJ0u/u5PVriK6WTeVOZo8iZmHhYdGYkZ5hDyXexPttEtY5xZeudd5LcKt20gA4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654387; c=relaxed/simple;
	bh=WSrgqxvCEtEbSAkkq6kSmJHoDqoYrXnYhDZynqlvszA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh8uSJO36mDSm30BS5PX4tGrAqyWB/5Ho1i9Dy6Xrel+iVLT3Cd/wXo+Tnp+h8K/Cyl3osGdK8+95CJk99sdju9WmN8fEvs/51ivzelVv0sNkgNsZHSig5pS+g4LTcm2ZbKAAfFoIDKqP8MkKizwQybMmb219w+CoU4wZO8P6tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzJE3hvT; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzJE3hvT"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd4c61765dso23915147b3.3
        for <linux-integrity@vger.kernel.org>; Fri, 01 May 2026 09:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654383; cv=none;
        d=google.com; s=arc-20240605;
        b=Bjs042mvSSrw1I4c2IucimGQryns2Qv1d6LbF7VqK+Xff7V+zCwOUsrL9O6UDfiuFs
         KvDkefN8UCNPOhalJvD+dGpdTsXWNmAoIT/Mg2I9vy55WeSAcCGkCfpvcD2SAddppbp6
         oZDUHkM0R8/CUEUU6IEY0o6woLLvJjMDJIBkmlVYt93aGFA7VkOD8wZgbdqdoHxQX+Fu
         kXPxtN7mQVkNoChtI100xP1G5Ts3DCaR9XeuX0M6r4FEQ8Xl6MnY6QQ+O4pMD8DHY4/5
         JrIY0v+GliA0a1rJTCzbNp5KiHv0I2Kk8Dj0Za3ocTmmuXSrovd0cZeM6FqRzXjzdpL+
         AulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        fh=v3H3t+Za2zHOnlEn4BASWE/ui3UTY2LvfM36io40mxg=;
        b=W9coqfHAoDRWnVncEXOgjgwbmpKL/2pDWWcrd9nNgBcinyrdiWFBKN42eDVWbZhHG+
         ZQ4EUW5B/BiwAym0xWzlPAnTbrpI72ENoEgFDMAqgdX3cYWfhHe3rlqZDr0kF8q4dvTA
         xIOltx9Ju+H4/yCoiRSmpIBEaTFKR8K1uBF1s8vOjfq8b/+kM70v/hYD6q+gFMzCi7bu
         cVJ4HdqeeCKZGX3nU12zS6qa+v9uMul14QFhuxaHDI2A4fKpY6k92cTCUCJbYd5zX3h5
         xP1gusfTEdPqRzudANeObu4UOwoi7SRv9vuMAi3ODzNe6gb11qNbZLo06KbVERf6FaGI
         3HNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654383; x=1778259183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        b=GzJE3hvTLQj6cb4ENPG1LoElqZx2MsBvO9nZTs8EUJTC37sZjromNUT6OcGnb+ddc6
         d6PJxhHiXE1SeyQkrxVQ7Jrs3Uepb66G3Z7GMkwd3kbmBDNofuoh0rjaEB/rCMwPvYvu
         kj4aVzo7VEFqXzzwhDAlF0lCnuJ3sUFJZGlol7m/aKk4cggYoIthHeM6a6U3weq5F/Xc
         f3i1TfUTzi6F+GTMZ4+LAHwT7k0o1PbjI3a8ffHgbSTdpfS2p0tWxhjveAXU6CPrGkXh
         BHVLWXYfIh8Rv/FKKbMwgiApRrHyRj/IlSGwjyGzn+pzcvK1tsH04IdSYz1nfTTun8NJ
         pIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654383; x=1778259183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        b=OKyMaRo6MhECONbalmrYPNxW5DYQt3lZ88Q44w+kwtgPNYzgjflTlliJ90dEsp7o4d
         AwK2DVQZKR1BksK01FadLszIq6IU/nI4BQl+FNID30xaRKX9zMdJ0uIo/cna1yZf6uaI
         fs2KqIcfh+V1PNySdOhKqUw1CoYQsAZYqT3B5KNGf312YPY14m8hUOrJ15c1JWO5OZLQ
         PP1RGJ+ZEl+NekbrPqIxrbo0azFTQZ8RGJQrjqrm5pQ+oR9txRYZsERVXy1m2D/YsvAm
         RZm/2BDLFx6i6MYQHFsWqpOj/1SldyfCI2ONKgHSkEqy2mWX9W5cD2VtmRjUkScGRCT5
         bo4w==
X-Forwarded-Encrypted: i=1; AFNElJ8zm3TBLuoOVItaJ8xSxGiyGMpEpF9MsqPgMeZvLFiTGGQNSaI9+dgtvqilBPxzyM21jccjC7f3i269uxwtDnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLdIY5txXuimOejSozpaPAghcmHEajuS2bcpxcfEtDEWmZoX6
	ea9ZMnv9YBcInJeMUEYLN3Rvf6gsKxF3YpRc6d1OyyF+hPDJlYEJ+VZMD6rg5PLvMDkxRwfGM4Q
	8JuyT9cfhneE3w7joqqo997G99mn1U6s=
X-Gm-Gg: AeBDietADTK4U51uWFkTzxgfezRZ+aZk0xPVXTbbohrR7sUhwO7ejpzmxmKXftsY3IQ
	i98unZCPmZUP0CuQWoSZ9bMn4GrjLN/J2CtUOIcQRar3pmI6jVMbhaIpc+iSRXTxTdUKTMZ5rBf
	T9OTxSQLuIglxB0N8NkBwvj5iIauHbAKuiYADXIyLkRpiV6YDNFrzpfmcCECJXP5VigrZcx4jWd
	kV4HnBKNppoDjFIi7mz703VHQGngJMuLRsbSyineYxiObIKWKPGGuri9Q1LDXstXNVI+W/jQn4P
	eAK/0TTUnemX3uvfZuvv98Sfl2cTOqTCknZ4NBWjuXkZrydehrcPhRgFOcBhITZvG6dZb+s6Cv4
	pAyIIvLelDTl8sObRybvpe2viaPusqfo=
X-Received: by 2002:a05:690c:c4e9:b0:79a:b1e1:49cd with SMTP id
 00721157ae682-7bd77126443mr1403037b3.33.1777654382869; Fri, 01 May 2026
 09:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
In-Reply-To: <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
From: David Safford <david.safford@gmail.com>
Date: Fri, 1 May 2026 12:52:51 -0400
X-Gm-Features: AVHnY4JVldFvGpRy8AVR9UIjGcDa3SwPwwl5jSipOcT4G7P3qCyc6tJtsxpRfB0
Message-ID: <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:43=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > With above change I confirmed there is no meaurement log
> > between boot_aggregate and boot_aggregate_late except "kernel_version"
> > But this is ignorable since this UTS measurement is done in
> > "ima_init_core() (old: ima_init())" and it is part of ima initialisatio=
n.
> >
> > 1. ima_policy=3Dtcb
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d3=
5cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
snip
> >
> > 2. ima_policy=3Dcritical_data
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab32=
61194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e3=
12e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >
> > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@ar=
m.com/
>
> Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> initcall.  Hopefully others will respond.
>
> Mimi

I have also run with this patch on a number of bare metal and virtual machi=
nes,
running everything from default Fedora 44 to a version with everything turn=
ed on
(uefi secure boot, UKI with sdboot stub measurements, IMA measurement
and appraisal enabled,
all systemd measurements on, and systemd using the TPM for root
partition decryption.)
I too see only the kernel_version event between the normal and late
calls, if ima_policy=3Dcritical_data.

dave
