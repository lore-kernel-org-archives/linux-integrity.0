Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598303;
	b=MHR0g4F6bjbwoWfqmQEz+cQ3JJQjUnGLtw9qW6j8F+/8GpVkTlESzdTJDCVL9N+zfLj2
	 pG1lTGv1b+23roJznGf//0L1F4YU5WR9Bx0AqWtyeF1MX7/F0rLBuhg5l70CqvnzSkPx8
	 SOgJsIcERFKVTw+TIivrI9acMBsz2ZO4kSN5BPoj2UCzIgQkXdErR2Y9Mtw86QyDLnZKz
	 9dAeyAE8bpjpz/RtVW1ELRKVITt65vCek1EVr4os3l/2KeCziJZkFa4mmCdEdNJYE4GCC
	 96T/WT0E111Ft9DdZYwZySCP9K8c1kkifdfpZ0olFCmPOEnWQaHizxm8aovUlNdJqPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
	b=4h/TJsUSrXHB1Vhj/3fl8kblz0EzKCZ6Q50L8UqfL9dQnfZFG2LmLPMAqObjdqKx7iGj
	 gwoFBOeb1uI/JCJpLp/qdF6TaMBaXicY4rcdKwAhgcMQAfVZJmUJ7L/Tlri3pT+VQRu/1
	 Hh0cOvIyrLToxz0eBLmW7vopGRX+5mt1+tIROMM54M5XI1V7XN2YSeERLYyHEeeRW9e8L
	 /8TxH3/4VCieeHxnj1+Fc//lsxd9DxhJsP7jHlrJm1w3gC5G3zBr4yL1fi/BxAonyppfN
	 bEZPSwB8jgyi5CkspIBPPfp+SvuhS1uiwpdAVgfICwSBRrFkqg5hbqHtayE2H9tSbgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i96HhJqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAB606A336
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 19:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ACAB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i96HhJqv
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67d8221074dso1499205d50.1
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 11:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598302; cv=none;
        d=google.com; s=arc-20260327;
        b=OG9rawlWxW9SxOvA1pOQtIaOsUHjiBGmY4Zw7ufy5eQj2dSQk/3D7B/4CkLyJVR2CZ
         oxz9gb3SBtBs6WSauKY1jI9fiNL4+HVVEsE0m9Ltcyb+B49foGt+j6zNPPudWAlVQpuz
         /i+q+RrwtlnFv7wtUl9W/aI5VdPkq+pdyfxkenD4oev7wFMKKtD+FDTIuz5df77vyylD
         1RPSV/WqBgCFeoz6y8TYxlLciqVsme2MVNrwZXZLn4CUxHTcMuCsdLYtJx7OLjhvViIy
         lhdbJAE7AeUu6FxhjXNY5l8TcvQKz9XD8rJAYDpy0ShmbhPGGD91nDFyjQedzp60ZgBB
         H8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        fh=1FBrRgxyRNAE8de1qZrHhXjsiz7g21I8bThb4Vywgs8=;
        b=b7YxMXcDkMd4rZredff5zmk+PhLwi61TuhUQD4t2PJwia6B1ZPY7TtdPxj/1WlVVy6
         pbOikURQBzdJ2wRjpgxhWU3jBnW3eZOzne2ZQ8mK9m8MoMo2OxseMPv2mMQjnZfLpCHY
         qNPfY/s4HyPZWNDm6HzsxynQePnVhINSHtpI9FcG7WTfhszXveDXKj6ZMllT9KCkCgZk
         2QRa03tG8WQes9JUidu7WKkUhZbAZxAo+S3dXJe9WKQADibuTF8Mmec7mJ89lHoWKq2Q
         MmHc/B/91oM6RjSFX93y74Bs+7djHfv8gu7CHifvWVKX9M308F2AQM2kHJi8Fe8RSsJg
         LuEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794598302; x=1795203102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        b=i96HhJqvWrTkfloIwP00dkvZjwmY9I0ZZlc18pqW4XTYz/FL1eSvhFHrDERrtxKx7T
         Pk92K6uR2BRK+HurO3NJ7E7da4ordorE0kumjyEgsY50RREZTrepkmdspMqGqL3j8y5F
         xKUalHrwFszgeFazkrZU4nj4HPbJ6b92FO4Slde25lIRsMSbtkHVzMTiz80CTL9+1rhJ
         FBrb0gnZDTApJzlGKfYxOKV+pEmtOHF4d8/HgW1NcDaip119+FvQX2wxxIBQ7TaUtGkp
         XIJ9X0IfWJWqRH6JDUvVqqZXIhC6DVavhXXLV7xle0OuWoMpEy7a4wrtuFRqf81pCx4n
         Jfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598302; x=1795203102;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        b=inr2NAirqYDujKR07dw9C9N8JNMiGe4pVEhYJdJaVCCCTcDj7aHvHwY2ugp2rDdU6C
         j4yOa8Co2usr4TLkcDugaldQ5lkuCez+bsvHMrnfzwQzH9L1FBeTD/ST/uD6hEr4H13y
         th6JhYznjYidLb1LjMZAPlBti0WPXy5U8OgD8gLawusClAjPxfIqoh2WAzNJ16fxf/ng
         QwwpWUntKvcGsCMeFUHUJIHoHGcwCwGrutv8xaiWfMQRxXIrcOPA9/LMT5dZsZAf2QAN
         BHKVRorPx82ggbtb39dX1PUuDKvDz0CQq7FjkAHatUz2v5sxeBAci/+S4Obo2NHsvOnb
         HsTQ==
X-Forwarded-Encrypted: i=1; AL+hErH7RA86NcDgi1MT/hwmTHOx7Y0XNY0jq5rJnjfu2W3eSqzGRAJPzXp8Sv1Zi/CuoACCusYibKha817tPxFGvD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z94ZiC9d9ZSDpKUl3tKA1Pr8GaXfAFfDXvHxt0zpOLg12CUrjBV
	roysQdDi9B9iM+lA5eTpvB6fukBUQCLIKg/h/EGri4GI+bCd596G5G242vS+1gSiBbwBlPvUlZr
	+All2HgXe6BDag1J4V2Ne5oc9UWNYz0I=
X-Gm-Gg: AYBFou0CaLi1TE2BYISHtBFVUanu+IVQxJ7qFuy0lpsAvfsaWixls3dyAYmqF6SNzzl
	wh0pARVCiXG2xkeax/DT5jpOf/gAT1znX2NCQbk584IqLIjCErpEwMssavw5XE/YcY2bDCQUyx/
	0nCRA+sSW/ZewBBwDmYycFcqVtdZCVspnybuLrQTwgd9DEgCpEy0x0RUlEW2MYYCEPlD07HxlbZ
	hKlHuGigkkKW+rivt4MaC/jeyM/Xp+H/7oMb/Ho+IhVBcmnwNQCSGqAaWQVuPrgOrFv4BohMZ+5
	ELgFiX/3lvTWaZwkfKd1Xv17isTIeZ1VJCdkbjVtT1PxeqAwQ1rHUsGs7IEe40/OfVetw3fzLlO
	+0nlr/EoC3ZbE5eKE8iHNt1LPXOopxNai8S4fEwttmb4APPu+sYVxqVhp0gwIAEwn++FDLHMY6t
	kYEmLVntvbZD1IHJc352c6mYADS+iNexUXF0aJ7kWRukzcjlnmndq+5uB3xzVQ69KjqC/0TAoY7
	XLBXO5J
X-Received: by 2002:a05:690e:1384:b0:677:d804:94b4 with SMTP id
 956f58d0204a3-67d896dbe48mr2401686d50.65.1794598302165; Fri, 13 Nov 2026
 11:31:42 -0800 (PST)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112233807.70664-1-sidchintamaneni@gmail.com> <avdXkLKJwuNv0vZ4@kernel.org>
In-Reply-To: <avdXkLKJwuNv0vZ4@kernel.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 13 Nov 2026 11:31:31 -0800
X-Gm-Features: AclHuK8cZbEkeSRDtbCQkhfrXJYZHXhWNH4fr0GNR6OJpPd_lgMe_pOQXSkn9K4
Message-ID: <CAE5sdEgEFjGz6W0e5g4uxRVC2Otyvr4Pak-aAZogObWaFtNsTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tpm: tpm_crb_ffa: Only register driver when ACPI
 TPM2 uses FF-A
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 10:31, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Nov 12, 2026 at 11:38:07PM +0000, Siddharth Chintamaneni wrote:
> > Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
> > when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
> > tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
> > confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
> > commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
> > device_initcall time (and when loaded as a module) without checking
> > the platform's ACPI TPM2 table.
> >
> > A platform's firmware may expose a TPM CRB over FF-A Secure Partition
> > for UEFI boot services while advertising a non-FF-A start method to
> > the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
> > non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
> > should not probe the FF-A TPM service.
> >
> > On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
> > ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
> > partition and tpm_crb_ffa_probe() unconditionally sends
> > CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
> > That request wedges the calling CPU in Secure World (with Non-Secure
> > interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
> > stall:
> >
> >   [    5.507519] ARM FF-A: Driver version 1.2
> >   [    5.507519] ARM FF-A: Firmware version 1.2 found
> >   [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
> >   [    7.150580] Freeing initrd memory: 293640K
> >   [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >   [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
> >   [   65.530031] rcu:              hardirqs   softirqs   csw/system
> >   [   65.535589] rcu:      number:        0          0            0
> >   [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
> >   [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
> >   [   65.555228] Sending NMI from CPU 66 to CPUs 10:
> >   [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10
> >
> > Check the ACPI TPM2 table in tpm_crb_ffa_driver_init() and return
> > -ENODEV before calling ffa_register() unless the table is present and
> > specifies ACPI_TPM2_CRB_WITH_ARM_FFA, matching the check_acpi_tpm2()
> > pattern in tpm_tis.c. This ensures Linux only issues FF-A TPM requests
> >
> > when ACPI advertises the FF-A start method (for both built-in and
> > modular builds), while preserving normal FF-A bus probing on platforms
> > that use CRB over FF-A.
> >
> > Fixes: 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in")
> > Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
>
> Pick the older.
>
> I attached a prepending patch that caches the start method, which can be
> later used in tpm_tis and tpm_crb.
>
> So that totals four patches:
>
> 1. My patch.
> 2. Your fix using the cached value.
> 3. tpm_tis update to use the cached value.
> 4. tpm_crb update to use the cached value.
>

Sounds good! I can put together that 4 patch v2 series.

Two quick notes before I spin v2

- Module loading with CONFIG_TCG_CRB=m and CONFIG_TCG_ARM_CRB_FFA=m:
  As Sashiko flagged on v1 [1], because tpm_crb.ko directly references
  tpm_crb_ffa_init() and tpm_crb_ffa_start(), returning -ENODEV from
  tpm_crb_ffa's module_init would prevent modprobe from loading
  tpm_crb.ko on non-FF-A systems. In v2, I will move the start_method
  check into tpm_crb_ffa_probe() (matching check_acpi_tpm2() in tpm_tis)
  so both modules load cleanly while still skipping the FF-A probe on
  non-FF-A platforms

- regarding the location of caching approach -
  tpm_crb_ffa never allocates a struct tpm_chip, and both tpm_tis
  (check_acpi_tpm2()) and tpm_crb (crb_acpi_probe()) check start_method
  before calling tpmm_chip_alloc().  Would it work for you if patch 1
  caches start_method once in tpm_init() (subsys_initcall in
  tpm-interface.c) and exports a small helper (e.g.
  tpm_acpi_start_method()) so tpm_crb_ffa_probe(), tpm_tis, and tpm_crb
  can all query it before chip allocation? (Also noticed a small '||' ->
  '&&' typo on the header.length check in the attached patch.)


[1] https://sashiko.dev/#/patchset/20261112233807.70664-1-sidchintamaneni%40gmail.com

> Fast-forward when these are in the mainline, I can send my change with
> Stable-dep-of tag to stable@vger.kernel.org.
>
> Br, Jarkko
