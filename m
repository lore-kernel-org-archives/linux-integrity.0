Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8203D3CFD
	for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356054; cv=pass; b=o8YI8Knvt5BiTnMrYTN0auETzNn46jfUnX2zrVwJJqkbPy18SxGIOf6iajJGfsq72TRI1xa5Q9nnzJ7g6hmQf5V7sa6bvdCGh3Y7ntwlUL6gOOYqhKMY3oLZf+oIRIYgjd6jamNdmSHPY7lXXBHP693NsU+830zP4KFX5G95gUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356054; c=relaxed/simple;
	bh=Z/QlDjEqmTsvd8hmVsRhjPJAPZKduCsAshcn9SEcHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doB00YcFjj7ylLJudIwQbZmFthcVCptYRF+dGxjiR6xT6BegRZieWJHUSR00Zj3ZDurFMmmlqYwOFnPiqi38BQqLHbjutcby4IljdEfpIWJpWI+mJRw7fjSd/VdmbgSrUCiAQVYchgyZQkI+mj0u2iPV2++mw2AEHgWhCJsEue8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JQ7vBslB; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JQ7vBslB"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so5145585ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 25 Sep 2026 10:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356042; cv=none;
        d=google.com; s=arc-20260327;
        b=OKJQoEwC5DjiZ7MkUMrCzu97RqUQXTokDohlptzSVVgp3ZXhCRuiSVr/wgmCFHlyi8
         ggCm18XwImPK9K7Ejwgxz8sjCEj/Qd9xJdYEEWZPCiieEC8glb+ov00Ax4GzoFD165aw
         HIGxQKLDU/76cyy3euFEILANiSuuJEhef+/JPnh2ez7SvkTME2VHXYlOcQ1GuDY4pf2Q
         T6nAdfNs5oHTsvMyRhwcw11FnCVWoK8qf2GKGETyDysPd9Vnw7slAz7ix1HSzOzBk2bL
         Bu/Bcqp9hJFWlHylUbtZ+Mu38k23jPRWu5ayZ/t3bzFTzoQ90Csk4ZGd2n81gWzNKs8t
         ooeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        fh=gMi+OcLHqscG1wL0QinSF1twbzSCiglvcz/3ZsyRwho=;
        b=I+GUPJ12sUW/YNjf5ovXFcXqpXcYBRrh91xroADofaq1RFeqQeYxAMDQEsVQkHww12
         yF9tIdB9xmPcAWpvnklV+8KemLKi1DcDpU1UF5F0F48o5xNrENUG2+k0r/zYa5MYwS0i
         ycPhSytBHMDsDzG1rvZA8bZCEeB4z00AiX3Zv8jHghjK6eBr3rb8wTu+sF2u5tA7Gmpf
         NVjnQ9/KocFowQne7ogog+Um6Mr0RhxhxMJsoCmubzzhUSepknLjJPLCNgSSgZV6AxMh
         fhYI01ZLhLr9TJB3kN8iEcH/w1mu5msuQVrGb0X0/8oRsUloV0gnQ3g+rzMpBjCwRvmg
         fSdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790356042; x=1790960842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=JQ7vBslBA75Oz3vhccuiegu2ZSCVFqSF0HyjC/3/vNzOkrP+yD6f4D4JjYMSYAoFrr
         wlg7Wmn6oEu7SXRotz0a67VZfHRO6XibZ9ZQ2iaB3D1nQj3Xnbu+DnvAmLPuwuabcTJk
         PXz37aU1zp89S9iK0/x3WEyWrQZ8hNLRiSYpSLIsFe52Q0ZtYHr08wUrk94pc3ENWlQd
         J+Tedgfpmw+/PX5h3yjumGEOqc+s3rcWYPx4Hn4luwZxasnr3NVcHxFxvCE/jfitgeBw
         +jOt/CmP2fD13Y486VYHbVYAPN3U4OMa+qtVuZhbWJD5jm5g1hu0o/Zq9FL93oXYU7V4
         vv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356042; x=1790960842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YwzIASUiQRwU6GfvzkJObDJseuyBEMVP7g4XrNm/58=;
        b=WjBwhpY80ep0BWAwIDl6XqKnObXnY6sYV+3qy49IVOQME885IjWMd3g3ImIry/d3c1
         5wa1GHWjJTlZkIavWwgaqFoxNenojp9/lGUeN4pfkZT2ljqg/m55wndDX1y2BeLCwSPP
         /jZGUeTfMMhpnmNRCpClSJb1SQVV6hkbgSii08L6T5onFP2uVuW1Ygf86tAj1k8DPbtf
         84NYYRdm2lG9q3NzBiCF5gCE5iTwT766J+ihNVM9wtbo8bS0gN1E+Nq7nT2fkd4K5jsL
         CcYniu+fdpV6UoznSNNizJMfvpwP046ot/24GfIbkPOKmqTQXa3ej7Tpm0CgiQ07pay6
         RfSQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4yQ19hGJV98BBaeuZn0xE4vJk/CtZX1m0VGIPksE/mymUktFIXulfEpRdHC3ELmNL68gsqoKkhYruGvzs8mw=@vger.kernel.org
X-Gm-Message-State: AFuF++m+5eH3LN8wkxBBdpE4fbD49I+n2Nrz2C7PpQSqqtrd0WZyKSyY
	bYCfuhl/msBV3Oz/hkfLXnB0OPXJgLf4TO6OHLu1uywv+FZlR2bgraQs0KM8u/4sjjloEM7NMC/
	w5ersw/bXQ87r1AQgXZdPbAH2IcUyEq/2DLhJO2C7
X-Gm-Gg: AYBFou0rznRuuYUO1sEpIKCFSX+KYbtLuSyZ6edUvYf1uJDIsfKN9tLUWI7d3Cl5FUi
	gkQpSNSATNkPIyoZn6uLnuQ4lR6Bsvefp36F5A61f+nv1l1+yOMYntQz0Ot1JtpL5wkLiZfFzJP
	2AkebpL23PC3vGPZKuK+qOJUoR0h9qFvt1pypZ5aCUunsUf7Nixj3eKTVR2IgWIbZEcFE+eFZcH
	cVR900R6bGYU6pei71sUftLGuEEpd9UycmY7Z642drJnjATBiC7GYzGgEEmIhULhCn2tYSs8D0n
	c5o9Qwp4YSE5n4+W6ebrRzhdO1lpkwZU5HKCKm14cG7bw6GwkwV+H6pITGeE3GXRelW/9JhAzUx
	h5XoC73WyxIDlSA3sIGA8tw==
X-Received: by 2002:a17:902:d48d:b0:2df:99e6:9448 with SMTP id
 d9443c01a7336-2df99e695bbmr12902675ad.61.1790356042370; Fri, 25 Sep 2026
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924104831.1081137-1-caixinchen1@huawei.com> <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
In-Reply-To: <20260925-zahnersatz-hielt-lerche-141893658522@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Sep 2026 13:07:08 -0400
X-Gm-Features: AclHuK-PYyMWIn_xv6i13K6lF_3RP26uUOO_mtAnUMGHNcMrV5ydBitx8qn_ri0
Message-ID: <CAHC9VhSeXmOHvioZ12aVmnOtpP52-G=K_jS3K0fTSiCrDHStPw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
To: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Cai Xinchen <caixinchen1@huawei.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, jack@suse.cz, dhowells@redhat.com, code@tyhicks.com, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	miklos@szeredi.hu, amir73il@gmail.com, senozhatsky@chromium.org, 
	chenxiaosong@chenxiaosong.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, casey@schaufler-ca.com, 
	nanx95726@gmail.com, djwong@kernel.org, daniel@iogearbox.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, exfat@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	xiujianfeng@huawei.com, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > This series adds two new Landlock filesystem access rights,
> > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > which control access to file and directory metadata such as inode
> > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > support" series [1] and follows the coarse-grained grouping discussed i=
n
> > that thread [2]: instead of separate chmod/chown rights, metadata
> > operations are grouped into one read and one write right.
>
> This is mostly fine for me. @Michael, for the fs side of things I would
> give you a stable branch vfs-7.*.shared.landlock.path that you can pull
> once this is ready.

This is in my queue, but I haven't reviewed the changes yet.

@Christian, I'm guessing you will merge patches 1/12, 3/13, and 4/12
since those are the VFS changes?  Once you have a branch for that, and
we have all the necessary ACKs, I'll merge the LSM changes in 2/12,
5/12, 6/12, and 7/12 and then Micka=C3=ABl can merge the Landlock patches.

Are we all okay with that?

--
paul-moore.com
