Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB9378D91
	for <linux-integrity@vger.kernel.org>; Wed, 21 Jan 2026 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012753; cv=none; b=ihMlgKug683Te1hNWMdkQYvDYfOPPvfhWuZ5fJaotVq76LNeFPElgQk+OJEQPJloC82+ZZmcDhIhRveE8Y06pyxdk4SGqmynLNtvHo7qYhMIiztEbZZQbQRcfvluAxa/nIn4WSPjXHrR1vTeKyYJpJ38UCI1/ssG+bsLnXRK/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012753; c=relaxed/simple;
	bh=sDXZ43cuHWu7fDJemSHBPXvLB0TztHzhjoU8+z2DpEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0i93j0dO12TvFMY44buyaG8WXVXXdOGId+qjOBBAaHUWhuDN9g0d7LK3RlAJTWEq/fmnCkqRW4DXvT9fBsDBmeN5zgV4qwtTVcKZrP+lIa0YuorSUieHMo2cPWCFHsUBBicdtT6hF+zCX/KEVSSHq7Gy0WfdrP0Z/JZwvqUhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz3lLYDF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz3lLYDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A02C19425
	for <linux-integrity@vger.kernel.org>; Wed, 21 Jan 2026 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769012752;
	bh=sDXZ43cuHWu7fDJemSHBPXvLB0TztHzhjoU8+z2DpEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xz3lLYDFDp7n/pDBF2vYYftKWO38z4d+uElT0SZthiWhCuVVAIuuSxvSYS4541IHk
	 +6ijyUAnG1P9gT1onFpsSowwLLW1mj7Gpyozu1Ic5iR/zh0DT2FoV00kHaaeUmANjB
	 cgrJkhHa8s+Kdo6sW5YWX1/n+8y1KswabgLxlXN78ayh6aQyMjyXuke7jA5Y/woDeC
	 TUrISCvLINJ28oISp3RpiUN/pIeFQzy6QNuiRopklwc6rUcJC7WGfwxKjSrSF79V6r
	 8EAQZlRJbPDXc6QMBIQAdLH+qUsnlRMth+Fy5vHM7xb+I7YHCsrzESvpyHBrW4zeGw
	 nn5cUcGfaFfPA==
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a07fac8aa1so13595ad.1
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jan 2026 08:25:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm96L/ssef5oGjfQEbi0lthAXLWIRT/uT9OSaq2gyV1oyPIZP2PeGmm5gMYA2AwHJ5YyynoXe7mSmPBOWeudk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhOTtjuaFvCfDFjxPIOLwYkL9DXORxsmRMWqVWjLzKPb9eu1w
	pe7Xlc4Rwu3+Oa1Rqkf5cVZeGXsTZMFCDDv/diYWT7vEohmFVN4BEhVN6IQ/9+Q8cqRCijP1cZ1
	zfDBgG9P/AdpLbG/0mBN8RZ5q73MytUM=
X-Received: by 2002:a17:902:ecc6:b0:2a0:afeb:fbbb with SMTP id
 d9443c01a7336-2a768b7a743mr46677125ad.1.1769012752394; Wed, 21 Jan 2026
 08:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115004328.194142-1-coxu@redhat.com> <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
 <aW2i3yacr5TvWU-m@Rk> <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
In-Reply-To: <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 Jan 2026 17:25:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
X-Gm-Features: AZwV_QinD8JFxZrBNY-rXjMhWA_acQR-WgojG7fUerVuX5e99sfTa2O6odTmxSw
Message-ID: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, Dave Hansen <dave.hansen@intel.com>, 
	linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
>
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> > index 976e75f9b9ba..5dce572192d6 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
> >          bool
> >          depends on IMA_ARCH_POLICY
> > +       depends on INTEGRITY_SECURE_BOOT
> >
> >
> > Another idea is make a tree-wide arch_get_secureboot i.e. to move
> > current arch_ima_get_secureboot code to arch-specific secure boot
> > implementation. By this way, there will no need for a new Kconfig option
> > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
> > concern.
>
> Originally basing IMA policy on the secure boot mode was an exception.  As long
> as making it public isn't an issue any longer, this sounds to me.  Ard, Dave, do
> you have any issues with replacing arch_ima_get_secureboot() with
> arch_get_secureboot()?

I don't see an issue with that. If there is a legitimate need to
determine this even if IMA is not enabled, then this makes sense.
