Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588130DEA3
	for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292884; cv=pass; b=APySx6If9opSAlNZIpVmzwBjolGcsdtBfOENIEy5FKVkMCWYNU6KyLIlc650rp+LR9ImV3Rb+I0CvIs7HNZVPx3f82E251JekgAnCXKYKzW8cP5J8GZ25WWxeea8zyQdUVvpCEMP6OQfkCd0DqHi10E49hpXItlp50HacJt3NTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292884; c=relaxed/simple;
	bh=hIIWOe8rGZOqxD01lrJKJbEvMRQfqkzsLVgYpmbDrBk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=th5VEsCj/Z3n8vmIDLR57lBzq2+kZwkMUettc5h7NaxPv35uLzkzhwcKqYuaIjEN7ejYg1hg+L450QEYHkw6dtjaoHokI1kjTYfXtuqFlcJ85YPH4ErBwOXISHMxNxUo6cCySs9E+SCtHBSgKp/mltoO6a2nMFlcNki10HbuCzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UscAw3cu; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UscAw3cu"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87c90648f99so327143b3a.0
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2026 16:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790292881; cv=none;
        d=google.com; s=arc-20260327;
        b=at5CmaFa9VMc1BuHm1MT6jWBawq5YcH8Zl+IatRiHeNX8j2YB5mKPZh0opkDZCSr82
         JoBg/9b3s+KKyqWuy+yASy+g0rKV73PVOe5QTNwHpAcjZERKs7KHYx9N9UPUtt3VGdDm
         BlhrT6fbreF9d7RAx59h0H+iLoUFQETZTaj92lE5+2YFPkru4wEim2jmgxJ35WbKu9aR
         SNy1AspEqJZS16EltaLqxrwkmqoVNSMYwA2PFaXjp9dTbU2GvF3pZ6qGzYGsM8RjUmX7
         rTb4FKuGrXSanf51KfplH8mVca8s8W9TxBO+cyJk2smnkkmTNV+eBb2sQDAtImWyiHA2
         AaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=hIIWOe8rGZOqxD01lrJKJbEvMRQfqkzsLVgYpmbDrBk=;
        fh=1W12/XV21Zuw873JI6il9CydE13+i9BfTl6Afs4PL5g=;
        b=jBmL9M7cW5LqS5pNzswu5O6rgZMZAkBAqPmKhUUo+YKAEx/ORNZV00qHkBXA3JK/f3
         oPzncE90W19TPkbDTlfMcbCKpUqsRURcGCplZbRQk+jCjaNfCjtjYTQNmSbappapRkNc
         u+BogAJkXX6TBzj7risE+67yhP/TANC1pQRuSEKdvDueF9qPB2PJBbDdx9pEU358f2/B
         MHBKMLmdCYkVVq2UsTBUOZGlFMcJoijcrUCPqYjjmVxeB24tfUdsX8/dmePVEeXTR52Q
         FIJPYv9O+7fZlLdzklXJsNS58Dc0I3mW/L/lmkgsRZyCiYHU3A+MmiSAneH6SDkgsHw7
         XNeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790292881; x=1790897681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIIWOe8rGZOqxD01lrJKJbEvMRQfqkzsLVgYpmbDrBk=;
        b=UscAw3cuNt2P0HhHDjZImTfQGlrGXGyCV+GxA5/DTxdv1UL3vMfTQiH+wi/YPSUeaw
         kXyAn/MstceHwa4zfTpNsYk4hrQfpIACde3GVIgXUz9SE0ZncuHvWQVomKYEpvqCqe1l
         o/4LLssCvuKGhqw2fzsxg0Vfp/73uhSUxKe8JTaiDHzyBFqqavvNFLryVwrg5pn3Mgwl
         menBOAm5iGqgH9KAUzJVelt4RjrbNqV44wBekiblC3EiMuplPU1YrLtk5XiaAW4isvdD
         3KNJBVWBJBbTROazHwqfVq/6BSckTkdjm4gTYsGUo0NGWAXHLUnZuqr8hnIYEj3LLgZM
         Tdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292881; x=1790897681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hIIWOe8rGZOqxD01lrJKJbEvMRQfqkzsLVgYpmbDrBk=;
        b=jB3n/qUGZaPgLZbONsRrBLCa2t7Gyy4hXkM/nlBdLTOQwGCuf6XxjUYmNGCgR1gQQJ
         HD8od68tDx8pkhxG5Yt4DLVEzeiONDakoUt+/wHIl9j2H5eH3nYKVyLlPwo/3bV8YxiQ
         tkYix2cHTfa3hux5839gK5S7bh14RJC2B05GpWfabeK9lsPJ+Lm9UaSq9j4Oci9ErebX
         viJnkk6B4CW1sWcnGpjAdLcBhxWrEcLJKRMQzCFH2W+zpZBl6a+JDWedX8/hfrzUzcMV
         UMgmUDXcha/OVNX2DGk6aWqnrILEgRMRQGsUWpBryTfEpTW6IDe8MsoqPJczRnoZ8F7Y
         FYoQ==
X-Gm-Message-State: AFuF++krpFnXNDztBFKEue1g3o0N/PUR03zSoqfcSkb8qx+OfkZfJu3E
	IMf+ai/IhEiAdUxi31ghfF18++DiuLc/E8FoxsnAr6raw/gjpEvR2xecWLgVqqs3OIJJb68PHDm
	hNIVlIZcCwttXM+LH2i+NROKgBwje30HAkL0R7WTcY0Qh21SH3jchKg==
X-Gm-Gg: AYBFou3A5bREu0KPQidRwlSyjde5O12HYiI8UotbO9Lhdcze6V2shzfpBW5dIMCa3Ot
	PHHk9rgt0x3uWnSK/0I15fgpaRMmo3Ho9PjVJVU0aY30X/DYQFITFD6hvREJswIIbRvGAkxB/LQ
	E4aVkeV34l2p97jGdc0J6y7JTJlLlcf5peMC6MS+zaah5vO20/INgbrm0DsZoD509Xmlrr7MhZy
	vqYODDnLiG3niOydE25VxtfpkEeTS3aDoEXhR2hNDWKmVg3DohGRB8pdDGGVZWqAl3TxSy6J8Kn
	Q97hJlRRFqjg8Sb7e0Y8Pzz40HznHRFUYuFMwVhogwXlxMRpRxYdCvO+5zDgthx46ju+ANjAUoO
	/kGV5xtkJNRU=
X-Received: by 2002:a05:6a00:981:b0:87d:d4e5:c56b with SMTP id
 d2e1a72fcca58-87e9f631f8cmr3621751b3a.55.1790292881447; Thu, 24 Sep 2026
 16:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danny Hu <dannyhu@arista.com>
Date: Thu, 24 Sep 2026 16:34:29 -0700
X-Gm-Features: AclHuK9IkDBuzSPncqsk5CphrlCAAZAelouVeBwEYz1gKsUxlITqtZndT1dk6g4
Message-ID: <CAFn2k5AwOoHesnqB42kpfAGx0Wf-CtQbpU3px7LMj8PeiACvZg@mail.gmail.com>
Subject: [QUESTION] IMA: kexec appraisal and the unauthenticated target
 command line
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	Pierre De Abreu <pierre@arista.com>, Julien Gomes <julien@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a question about the intended security properties of IMA
appraisal across kexec_file_load(). I am trying to understand why IMA
supports appraisal of the kexec kernel and initramfs through
KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK, while KEXEC_CMDLINE is
measurement-only and cannot reject an unauthorized target command
line. Requiring a signer-approved kernel implies that CAP_SYS_BOOT
alone is not sufficient authority to boot a target kernel. Then why
are command-line parameters capable of weakening the target kernel=E2=80=99=
s
enforcement state not similarly bound to the signer=E2=80=99s approval?

This appears to leave a gap when IMA is the mechanism enforcing kexec
integrity. A caller permitted to perform kexec could use the signed
kernel as a downgrade trampoline:

1. Supply an approved, signed kernel and initramfs.
2. Supply an unauthenticated command line that prevents IMA
enforcement in the target kernel. An example of such is through
=E2=80=9Cinitcall_blacklist=3Dinit_ima=E2=80=9D.
3. Boot into the approved kernel without effective IMA enforcement.
4. An attacker is then free to execute unsigned code or kexec into any
other unsigned kernel.

A few questions for the IMA maintainers:

- Is the lack of KEXEC_CMDLINE appraisal simply an architectural
constraint of IMA=E2=80=99s inode-based appraisal model, or an intentional
part of the security model?
- Is command-line integrity expected to be provided by another subsystem?
- Have there been any discussions around a concept of =E2=80=9CIMA continui=
ty=E2=80=9D
across kexec? By continuity, I mean preserving the appraisal invariant
across the transition so that every accepted target kernel
re-establishes equivalent enforcement.
- If policy continuity was not intended, what threat model gives
appraisal of the kernel and initramfs its intended security value when
their execution environment can be weakened through an unauthenticated
command line?

Thank you for any historical context or guidance on the intended design!

Thanks again,
Danny
