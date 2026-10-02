Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6244E1C81
	for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2026 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965114; cv=pass; b=J73dKAqoe+EulRuyApJALRe9cVAV4wu5HC/dQaOB0I8N474qZmlWtNHRBcLGyQGHqDged2vJBbhMqTyLi2yFH11SaKo60Qh16RnmyRQV2FAX5TwnDClgCdJecDYgGmX/SnZYzt0lPItoqSw/o6TwvMc6QfjcsA3V4WH5LhaHTBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965114; c=relaxed/simple;
	bh=AzCNK1iZZZMgeE4mb4DSDDaOJSiRjs9k8zg/pJZMGQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdO/CWVHKwdZQizGrkPPfd/5a17R9T7Q/QYC91b7JBRP3D/8BZUjnh3FNGaVa2iy9kcIxILN5S7hVYgvxqTFZMHQkJrSvCvE1tbFqjFdmyPi1nIZPK2dH8s3BH1zyhOhA5aX5Ugf3Hdd4ddBqAwqcP1d2bobOPBGTw35OZSYL4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=QjDuKkg0; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QjDuKkg0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e2e0f3dd40so5863945ad.3
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2026 11:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790965110; cv=none;
        d=google.com; s=arc-20260327;
        b=Gvj0mch7gOAIc+S9tb0s8BMy2T3qQRQ+jiVZ9CTCJOSe/A50PrhqxewnfNk2t1lqLF
         ACjaJOYUX2FczEP2RSxfw0DLOr/ABtvnDY6XOYPtdDXI/GbTIAsU80zqzEQBCZ+lSEWr
         wJsscXXhxjLtartKXez29uOhXi8vRAz5im3u9IMQy8TGucxo04WeRnSn91GnbItOK+XZ
         hTN91sSCgoFeOBc/RzuZrlXf4RYfph12KVJITQLkTOqHbFPT1V91QN6FXnsCsifZWe8a
         t3CW0wTCcIVPfauY/c3EXGhALK5NjZw3Y9/x/xaH3/St95K6X7p+afshN/EyFq6qzFnJ
         eQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AzCNK1iZZZMgeE4mb4DSDDaOJSiRjs9k8zg/pJZMGQU=;
        fh=q20uyMj/YebtVXo7o0nvMqD8Cz3qyx24wQEZsY8uS34=;
        b=Yg89ILf9cochWpr/nhdq9OQcFPw2OUh/+D5e7cRjYjA6rp9PEEoLYX+2MNtX6JTyTo
         C8iDipQdNso+4Zm4jvRXpGmfnUHicqKcqP+g7ivuZH9aBYJuHgbhjXkZPlyCmsEtfN6r
         zimHAVwzMx7heFjaa0DRLO84XKX6pmiWzIkGQ0mVJgeK3Gxd2wuCwWOXFHd3cge+AtGO
         kkLIlQK9wMkP4kpig9uI4d5MoxAbVHxn+iXUyteVLXadgAVt+GHslSFWySZVZ06w+Wvx
         +aY1zQo2GPlVRpJxzEk2cz8qdNPxjHjE0ZT0m8g6JjEupOA2R8RJPMmtc9NeP1laS/T7
         gqNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790965110; x=1791569910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AzCNK1iZZZMgeE4mb4DSDDaOJSiRjs9k8zg/pJZMGQU=;
        b=QjDuKkg0hD6NryrBQn5TsXxP0avPZZhelOEzVE0JVVmTE9osZawhDsESdeEdELLbH0
         3LmmqI7BdbggaGbwvkCmZXp1nsuOWEvSDv/P7eS0Fz0X0+KAglqn4Ev/1dQxw3FZO9tM
         5s1csOg1+yswb32g1ZBvtvTABr0aG4cOrYL9ybfTY81WEc5cpQZ9j56dDiz77QwWdxLR
         OiqW5K6AiuBnzPBB2EFkSZTHF0zfVrOhEJCVuw2ZJZg8HdoGmrvxw78sI40/zqZEe7WR
         kx3pEtBP5qUzdfXaNxapC8DHBq8RAXJYiywzkeY0CiN1p7d44y26BdVXJrC74PoxAhTz
         RQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965110; x=1791569910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzCNK1iZZZMgeE4mb4DSDDaOJSiRjs9k8zg/pJZMGQU=;
        b=RrVRX6VpfRULBk2RbvGpZlfukNHwyWVGiAF3ZTBEWfbCLt4CzwpJIo2j+ZVq2ooYyx
         74SVlbk6QYXmSBJrsi3IK2IeayC4rC4eIlm57vKZJKXSqbsUK1KCU358riWQYHCyyB3v
         wOV5RL9txjljIcJ9U2EjJ/K1/wa6tNILz3nNxxCGNuw22m1MHRkrBpzXFiLz0SX7Jvmt
         1s+GBdhxW/qFLLDwIFHS1epUaANd7EA6dh2x55dzvhahFxsGsALwFgayW//OU46XT1ox
         Pz07rbFbp8B8k5zGc4Qxe0fV63MfJS0/8shv4LZJ321gDgNSIxHQS2FxWQka+lKJsCrv
         f/tw==
X-Gm-Message-State: AFq9FYItvDaluqOx4w9f+Kfew6cT9Zjavm9ALEYegQK0MwgP9Mn3L4yU
	lvi7kcYtE/0XKb3k3kZ+T9EFoMTEqy7VmrPV8eU4LFPQ4D47m6rSbfWOvhiRdl5vq5NNn34jZk4
	CIVF0RgFsq2Bs/FFPDjx4S2fJySKsOgkh0eWRL6+q
X-Gm-Gg: AYBFou1829VfqWJPLcn3GJBaC0TeISq4FyI2phTB6uYL0XwPch+0CRUZTXh6lyQVH1s
	n1UVdowaIzxLsM/mRyWYGHYBJe3mx1KU2tywGy7+nT6mybe8cynjG7Ncdf2tjGMHhraSm36pMNv
	Cf5Nv4brnTwxc9qQMDq0+2H9S/CkMAHggeiTurEvtqG782ijl5Xr8eFZEPqG+lJVE+2oGpCkkUy
	ZaOce/9FdQ8bLR3gyyKmRnR2M9hcFeB3jMwkaWd2q7+g733c+PT1/A9E8ZuCWy0UP71LTLr7C8f
	C3hXvyx2BAStpvzNvs8pS+v/h0UqWrSvucp4Nvap5H99x/MffCsJWD4HEiJsV4DF4oyH6f3UcPS
	JwoiTNdnr6bPMa4EQwPI43C3Ndx9oqsiWo8jCEnWNHgY=
X-Received: by 2002:a17:903:2283:b0:2e3:cac:3870 with SMTP id
 d9443c01a7336-2e5106190f0mr2823675ad.40.1790965109292; Fri, 02 Oct 2026
 11:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5AwOoHesnqB42kpfAGx0Wf-CtQbpU3px7LMj8PeiACvZg@mail.gmail.com>
 <55d240d39dfbdac4d034380dd02f78838d09f061.camel@linux.ibm.com>
In-Reply-To: <55d240d39dfbdac4d034380dd02f78838d09f061.camel@linux.ibm.com>
From: Danny Hu <dannyhu@arista.com>
Date: Fri, 2 Oct 2026 11:18:15 -0700
X-Gm-Features: AclHuK_T2suUujGSiqOSvIaIE944gg0eWdco1vb_cfb6G47OEzym-rVHGm7IQ8w
Message-ID: <CAFn2k5Cj1wTZQsPm4HoSRWZx7gJ4tYoQYhmSPBZc_0qkY5HK4Q@mail.gmail.com>
Subject: Re: [QUESTION] IMA: kexec appraisal and the unauthenticated target
 command line
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	Pierre De Abreu <pierre@arista.com>, Julien Gomes <julien@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> The lack of KEXEC_CMDLINE appraisal is an architectural constraint of IMA=
's
> inode-based appraisal model. The kexec command line is a plain buffer pas=
sed
> directly to kexec_file_load() via syscall. Unlike the kernel image or ini=
tramfs,
> it is not a file. There is no natural way to associate a signature with i=
t,
> whether via xattr or as an appended signature. This is not an intentional
> security decision but a consequence of how IMA appraisal works.

Would appended-signature appraisal for KEXEC_CMDLINE be a reasonable
extension, or is it deemed out of scope for IMA? I see code comments
stating that buffers can only be measured and not appraised and
recognize that IMA was architectured to appraise file backed objects,
however, it appears technically feasible to use ima_read_modsig() to
parse an appended signature from the cmdline buffer. The signature can
then be verified by existing modsig verification helpers, and excluded
before validating the terminating NUL and loading the cmdline.

I understand this would require extending the current appraisal path,
policy support, and error handling. Are there additional architectural
reasons that would make this approach unsuitable?

>
> The threat model concern you raise is valid =E2=80=94 a caller with acces=
s to
> kexec_file_load() can supply an unauthenticated command line that weakens=
 the
> target kernel's enforcement state, even when the kernel and initramfs are
> appraised. This gap is real and currently unaddressed.
>
> IMA continuity across kexec has not been discussed. Appraising the kernel=
 image
> and initramfs does not guarantee the target kernel will enforce an equiva=
lent
> IMA policy after boot.

I agree that appraising a kernel image alone does not guarantee
equivalent IMA enforcement after boot. However, the deployment would
be responsible for signing and trusting only kernels that implement
and require IMA continuity. It would also need to exclude older
trusted images that lack this support.

>
> We would welcome proposals for addressing these gaps.

An idea that does not involve signing the cmdline is to preserve IMA
enforcement across kexec. The source kernel could hand over its active
policy, which the target would restore during IMA initialization. To
ensure the IMA subsystem has initialized in the target kernel, we
could imagine a CONFIG_IMA_REQUIRE_ENABLED that ntroduces a readiness
flag that init_ima() would set only after initialization and policy
restoration. An unconditional check in kernel_init_freeable() would
panic if the flag remained false, indicating that IMA has been
tampered with.

If the inherited policy appraises /init, initramfs signatures and
xattrs would also need to be available before execution. I saw the
earlier initramfs xattr proposal (https://lwn.net/Articles/788922/)
but it seemed never to have merged, so it will likely need revisiting.
This idea would prevent weakening IMA enforcement across the
transition, although the problem of broader cmdline authentication
still remains open. Would this be a reasonable direction to
investigate?

Thanks,
Danny
