Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F63E0749
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356141; cv=pass; b=hYUZxLdEqffsr/Om7XFfTjg1viADgyIBORdCBnSxH53kfrggWB5G0XPE6QjZKSbHmDdx3hdaNLUXWp66ExAqNkSjKrgD2sGhEQ0tYdq/cUXTJi4Vg0tpzhlmNybeqzicD2Log8MLhaQ0fTqER0iLfM/q/23YTJyNGbAJSnwwHUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356141; c=relaxed/simple;
	bh=MfBd4Ym2nui/DTpFDdJMXTpQc0RYzAMKl94AZWC/FIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0B16asauVvGZx/ZlPwQmideqBYBaZqVNhnUJc76ScWuN18iBNNORL7LAqD/wd2WjX2vRQqzHVPtFhOXK/VuUY0V91ZFzAEoSFARvD7yAtzJLFhUhZQ94xGfnuDJ23BNPEZsxYokMhL1wBuNvaQuJDzyKWKjvkA61WjhvEQqesM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=jbqAlCB5; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jbqAlCB5"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so303795a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 10:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356126; cv=none;
        d=google.com; s=arc-20260327;
        b=s4QDoBbs2pjHy8Kys6ryoDaMpjIcT995u/jAUDxnDEXMj8rw8nkMFBRrDeQw1Rn+FL
         xvCYbqI4I2Atnb/5o5VBx8B/OdL1crH1CENcIZkFXOVRmbgomxdYRbs8H0pa0MMLmEtE
         rmseR5kCeIPhQtJ2Qc8HaUIMqUEosYndAaTFUeLxa1831IgIjZvnYwkqZFbW+6dAQnyY
         mecKtPNkFn9HUZkCsyHFDYy5+LApsBKsv8ldDvDyQFbWmHTFDSdkYsjN1RKBxhpiiEf7
         zwhhou1+Q945gBUbxuUu7DVCu0ybjwByuNkDq3eUN3dv9TmQOnocZqHAT0HxKMms8qn0
         ieJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfBd4Ym2nui/DTpFDdJMXTpQc0RYzAMKl94AZWC/FIM=;
        fh=q20uyMj/YebtVXo7o0nvMqD8Cz3qyx24wQEZsY8uS34=;
        b=n8tVNXg1f4mGkGJDyfM7eCBULqrviK5/uRMdw2j+k2Phiir0pbE3LY4Mafjpk2RRlS
         vY/iU7xiJLOpkWiRVxZn9C1S/6gstKh5j4lU50fV7ViUJ5IgVbn6JTG3SnWYPkxzUEZN
         J04dvgQoJJ54xO+GE0c1gaWL+YtxKmnmlmDfthtvTlyBDdFq6qG2sJbYki6Rw7dw04GG
         tODYedQRBw61C2G7dnRTGj6Em5rAHqUVWl9hRbgCLZ/oO3EKjPOyYQ5bEIoUJaAgGBog
         f0+XwaffER807Mi663QQTf9vP5qLq3adeP6z9H8UdArw5gZDsHL5Ux33ztZm7nqjvcVi
         8Tgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790356126; x=1790960926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfBd4Ym2nui/DTpFDdJMXTpQc0RYzAMKl94AZWC/FIM=;
        b=jbqAlCB53DvfnpFg21fet9wq4mJHQpzkav+mrWcWpQs/NabFj+MTzXu9UAiV6n7qjU
         awwrUa5TfIkq36Xcpe0e9l2De6+J7v5fVdsAnSfQ3Xw+Wv6UaJvoRYHyULEMeB/bmcyy
         HHX/AX0m9kPf8a3vnYaYrmMoV3VdNjO2G7wAft4/VY9Z4zE21lX9gx7/UcyS1HEz7rmz
         KSEa00rwwuQvzFkVE99ktKDAnnTc6+3pohEk4FiOR4pj9C+4HEY9rWH2WN3Rsi2f6kaJ
         kGQRpxSyeG0Rge39J/mBgv60/Wp37pRPwugmgYV25wGAYorGw+221mT3vlF2Nvn+PYL1
         STLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356126; x=1790960926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfBd4Ym2nui/DTpFDdJMXTpQc0RYzAMKl94AZWC/FIM=;
        b=DGIs+GGn+PD9c7mSBQsQQw/COXTLu0ftvuAbmLZGKpB7HBTQjZFqbxXuXo7wQu0/Im
         dP14SW9EZPophW1t5DnEuTU+XXodjcgZVwxC5S3TAtROVswWG9rS2LQQC9XvP8V5tuLk
         TPrQi7YW5HCKD8l2jzgo8+3xehzVImlxp8zj2OxwdtRtVoxE+VV7CwZNcMqyEejLBeaB
         QaRnP1Bm9A5ZKDWtkh4Yp7ocLGsR7xDvfGLEvM73OteKBZ1uYYhrYU9sb2SxPf2qv3IH
         cIyg8FDqf28F/B75ToOJ/Qk7FMD1PlGtT4yQW3xDlq7sTppS/PKWn+/+yaOnAsGnNz5s
         FAPg==
X-Gm-Message-State: AFuF++lSiiqafdeiHDHIHBitOcpfvh4MfbczKA3otyFx+CtATr41Kzyw
	G+Hsbjd1MTXIEzbejP2UxAxsHceeUhVSVvuOjPOjrArUoQ3KVf3zyEiK338hNMo15MTWn195SDM
	TCFoGW6GwwDbsv2mgHPHK7rSBiyKkVtLPiSoia7FT
X-Gm-Gg: AYBFou0I/85KfOVME7mpmH9HaF+2w9APN3Sxvov5FizbnFi0N+t17r2EKIcijFd+CxA
	gQB5bnAWeNLsdGAmAKkXScJ/fq5rE4DVwXKRdQOGDHHP9ChZle3EJ/nWjbwWdg9oWEj7tG6/zCy
	tj/ef3QVEc5aA0NQ0n2ArN/oH7+ycN2NCb9sFbHtzxbIarPZyDBmWjElvv3P2NKPZS44rOSMxem
	XxSI6lS7aFkEHfhdNyhnnEJfajdJ6B/oYxRlnb6xFNAnKt+KLLrl6Qa+qiMyK+hy0z2TNRR1U45
	WcL2BmF8o13MyVqf9f0Em6980GEfRl630tRktPzR2wbY31s0OrtknbBuTqXSUAMOYz83lJ0ULH3
	BT+Lhmmvq591DTmshIaUUShPbOQr7nddMC0DoB8M1jA==
X-Received: by 2002:a05:6a20:432c:b0:3dd:a196:ffd8 with SMTP id
 adf61e73a8af0-3de0e9770a1mr4298824637.40.1790356126115; Fri, 25 Sep 2026
 10:08:46 -0700 (PDT)
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
Date: Fri, 25 Sep 2026 10:08:34 -0700
X-Gm-Features: AclHuK8kZ3OYllvtTErNszw0mURQ6B_lQV1bYmqjjHCZkZbydWCeXJ2oLJw7HE8
Message-ID: <CAFn2k5BejArAcXY4Q0HqoK8ptrBdJLKsJX6VTfmjYsVkRnA6vA@mail.gmail.com>
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
>
> We would welcome proposals for addressing these gaps.

Thank you, Mimi. This clarifies the current security guarantees and
limitations and gives us a clearer direction for investigating a
solution. I=E2=80=99ll continue working on this and hope to follow up with
some concrete proposals.
