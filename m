Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA08239E60
	for <linux-integrity@vger.kernel.org>; Sat, 18 Jul 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784409164; cv=none; b=C13N7I/PdskftHZOhQDKT1tKcbHrJSCRvi/d8ojCXCqRHTCJ4yFmb5fzTQ0SWSc0ddatgtW8s2LcNeHdc5Vp1ZG3Rr+w4Uvk162zqm89byy2rPY3T03BYQFpyNYoUxvQmzAVrEwygJPSinKSdgLsK/KhERLo9GmY32GZAB0EOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784409164; c=relaxed/simple;
	bh=LxGy/tYK8BUgw19Ra5uaZ5Z048rp47XY/zVlg7ubi+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFn8c7IJMDKJNvXkavGOBg4eXbk4G1SKS/Ytb9J2TKhtKoWV4XUZLuwYzLdYOA96v2CqihElkR64UHJnmcdi94ROeiWkr3QNUUrkQfV5V3gRC0/CJUoncXkgaPaKIp9vA64fJwu4HVlt6Pw28jzaT81D7JzqKUWEK8jkvs7A47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=lHZqAkyy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="lHZqAkyy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9d05so156775f8f.0
        for <linux-integrity@vger.kernel.org>; Sat, 18 Jul 2026 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784409159; x=1785013959; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVGy0sev0QssIzSTWqjH08ibmvVKTeq7MtvW4xlr5Vk=;
        b=lHZqAkyyLwrOKpJ32BlibiNw1cCRmgmcNQOBsgdfNUsNZQS4uxkNfhcva6I6rihGBc
         OHUZdj2VwUnAphNe4T6avnQqcrpAZ88vRxnLuhwD4WEKQ8dGaki9U2mk9kHvowxGRgPZ
         EtIlKSIFSFWC4TXPUMwLEO2yLMcrfZJ8Fq2E2lKQw2phQk5A05IjdkPKh13EaShWQ8Oh
         uWxFql2IQasJPiefmK5sSbGsZETWxeSgaosoyItnGv7kYaNlUwKHHvYtLCa2UIuDZUNn
         Caq3HL/EbhA+YjiF6vkJfcgcXykUiLwDDFGNjdix68wT7HXrZQdk49s/QiFBmdXqxL5z
         T4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784409159; x=1785013959;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVGy0sev0QssIzSTWqjH08ibmvVKTeq7MtvW4xlr5Vk=;
        b=mIRnNahXnbz4Yb5/J5eniYhpf9YH/WD7d1GUrq8/yaQlc3rY6InPP3eAzF5NqU0o+A
         BV/+yMa1Mn8uHn813Iwd1cfuzMgugd6Le+nDHO6urpZy1OsVe+HWWYDDMEZy+1lPDWmZ
         ms9q4XYgNbFq45uVS5RdR6XifvZaQwlBNO8YyDxUEHk2hnM6gCSOEPELp4HrGt/J2ASQ
         Q5FKds6Tg2EuSIdKdX/q0Z4Z2jXtqbl528G+Ixct2ov0W8FGTuPUWLzymzCMezKfVGLw
         y9aJU6/jS4FJn5Tr50R32Xj72xmwWCMEsQNdoBDlPkZ7N20KGG4j/7xfhe/XqCXqptAq
         KT2w==
X-Forwarded-Encrypted: i=1; AHgh+Rp0+UMCmlokrQAc6Ukqcuw5rnz664yX3CkV6NO5HQUsE0razKYUt1Gv5rdA4S6z7i6E+gyOvYZ67kidJqll6HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ETeA8vWM9+CKwHY33zXJiDjyk2Xha61lz42VP+3WacFS6xZZ
	9jvj2O/FVAIlGXtO06CP8m0qrHnXMr/nx8X4xQcNffYsQAMTGqcp492zGZBJ6aFqmpo=
X-Gm-Gg: AfdE7cmyPSeRTCQYhHHudgrUPH/UOkhJ9A75b0q3rY+9sYgkFF4/5O/KKcK1NvZXrpJ
	Hq3EOXT4DrtbS04fNEQXTT7r5pqRwJon3rD91Ky/aRuZ7TVDjXOOxfiOQYovo/aYdGgnoeiJ4sD
	xU44iBUs05cu62dyjL4EWoI+JZo5lU2pf2rbpBtNLuMgOje/5AirsniNoRa+UwHMhtFmC0MFtMM
	87ckXLiRChDQAvGhUjVDRZEQDckzavD8mrWrTs3JUOHXOGDIUqjpzA4OUB9LiUhA1/ajC/Lp1xF
	5bF3e3sZZ4Lc6m3ThSVejmyGIDO+ksajCawk2tgIrHyzi2xnjPoYBEAjsjuH8Ay2VKZTPz/peQp
	2s+IogLsSsfcDS4bAIgAWxLOplauOizXY+voQoX5++tp6XAR2XnKud1mqKEsCouPFNth64JYgmE
	tbxbNEh9xBhCQz31NIPLdLrpRORhvmOybZLf0miuQhOoI=
X-Received: by 2002:a05:6000:2083:b0:47f:5d5c:1ca3 with SMTP id ffacd0b85a97d-47f623052dcmr9245874f8f.8.1784409158800;
        Sat, 18 Jul 2026 14:12:38 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at. [85.127.105.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm15995668f8f.33.2026.07.18.14.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:12:38 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 upstream@sigma-star.at, Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>, david@sigma-star.at,
 upstream+dcp@sigma-star.at, jarkko@kernel.org, zohar@linux.ibm.com,
 dhowells@redhat.com
Subject:
 Re: [PATCH] KEYS: trusted: dcp: fix key_len validation and calc_blob_len()
 return type
Date: Sat, 18 Jul 2026 23:12:37 +0200
Message-ID: <13677245.WldNEQ4yK6@nailgun>
In-Reply-To: <20260718202820.1890313-1-fabrice.derepas@canonical.com>
References: <20260718202820.1890313-1-fabrice.derepas@canonical.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Samstag, 18. Juli 2026 22:28 'Fabrice Derepas' via upstream wrote:
> Two defects in trusted_dcp_unseal() combine to allow a heap
> out-of-bounds write in kernel context.
>=20
> The primary defect is a missing upper-bound check:
> trusted_dcp_unseal() reads p->key_len from an attacker-supplied blob
> with no validation that it is at most MAX_KEY_SIZE (128).  It then
> passes p->key_len + DCP_BLOB_AUTHLEN to do_aead_crypto() as the
> operation length.  Because p->key is only MAX_KEY_SIZE + 1 =3D 129
> bytes, any payload_len above 128 in the blob overruns p->key.  On
> implementations where AES-128-GCM decryption writes plaintext before
> verifying the authentication tag, up to 330 bytes of out-of-bounds
> heap overwrite can occur before -EBADMSG is returned.

Hmm, but this will only overflow p->blob[], which is the attacker input.
p->blob[] is at least 512 bytes long.
So an attacker is only able to overwrite it's own provided input?
=20
> The secondary defect is an integer overflow in calc_blob_len(), which
> computes its sum in size_t but returns unsigned int, truncating the
> result on 64-bit platforms.  This allows a crafted blob with
> payload_len near UINT_MAX to bypass the sanity check
> (blen !=3D p->blob_len).  Due to a second wrap in the expression
> p->key_len + DCP_BLOB_AUTHLEN (computed in unsigned int at the call
> site), the len value that reaches do_aead_crypto() via this path is
> at most 15 bytes and does not directly amplify the OOB write, but
> the integrity check bypass must be fixed.

Since the DCP engine is only found on tiny 32-bits NXP i.MX systems,
I don't consider this a real issue.

> Fix the primary OOB by validating p->key_len against MIN_KEY_SIZE
> and MAX_KEY_SIZE immediately after reading it from the blob, matching
> the validation already performed in trusted_core.c on the Opt_new
> path.  Fix the overflow by changing the return type of calc_blob_len()
> to size_t; update the two blen declarations from int to size_t to
> avoid narrowing-conversion warnings, and update the pr_err format
> specifier for blen accordingly.
>=20
> The seal path is not affected: p->key_len is validated by
> trusted_core.c before trusted_dcp_seal() is called, and the
> blen > MAX_BLOB_SIZE guard provides defence in depth there.
>=20
> Exploitation requires high privileges.  The unseal path is reached
> via add_key("trusted", ..., KEY_SPEC_*) with the Opt_load command,
> which requires write permission to a keyring that accepts trusted
> keys -- in practice CAP_SYS_ADMIN.  Additionally,
> CONFIG_TRUSTED_KEYS_DCP must be enabled. The attacker must also supply
> a crafted sealed blob, which in the typical dm-crypt use case means
> either physical access to modify on-disk key material or a prior
> compromise of a privileged process that writes the blob.

While I welcome the proposed changes as they make the code more clear
and will other tools happy, I don't think it's a security issue.
So the commit message needs rewording.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


