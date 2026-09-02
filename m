Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F33955C7
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377707; cv=none; b=EAGPyGfwC7mnuoprN0oA9IHEcycXX+I02xIsDWxZfm9DcjnEj7xw1z5Yh4P+FDzNBmQq9RogB/9FFj6Tg2jh9wJYknfFg1EQIK1avGR70Qn8hH+1svG9uD5/gF8OMAI9Q0QGZZ0tnk9NSKr8vnkw7lTsXgizZ7+AHcvQMofjO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377707; c=relaxed/simple;
	bh=dINnaKckdfOT2F94x9t7jziPlS9yc2iyV99WUJZti5k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=exA94m2BKluKuBeS7oYUyEEaiywLgvZYB/OVb6fJp4pXqNizs06ziJzgG0b6fQ9SJ/S+wJ/YXWCLCQTVjaPFnnUrPFmliiViFPIzxJ0Y7kgCmQf54ONKZaobr64PxMh5juRqdNY4DLKG9rjcYW060YNDDo8FWOyyUPQwAlGNY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mp6gh/qJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mp6gh/qJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90cc39e06bdso16550776d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377692; x=1788982492; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=183/fvO/by+DRdIa2ztu9BBJ4pI2bMZEyG+Jxipy0sA=;
        b=Mp6gh/qJ9PlBzkbFBngWPcHLug6aL4CVpoMoBhP+8cG8UE9y85GoduQoqIih5YgyNl
         SvWVTiaBA/qyWMiONrZyvM0SY6wAjBbacAFAI4GP+egbp+jJYuipoqAOwzb682f32Yt1
         fBk0GiCRl9Z4HsaMpBNG+78y26N5SSpIM/AOYae8IP4AZNWGUSbhW260XHN+LyULIoky
         tTLV/D4i/SUONQC9eRCfWI3RnwTzmbOnuTetb2uBIXo13sa2mXOch1rXBMVA132fBrCs
         m5HvTYka9FeVwWTn1jP+9TIgCrYp74rb/+grmmfh1kSjT9kNCRgOlwiR9+mH/Zta7Csw
         WhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377692; x=1788982492;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=183/fvO/by+DRdIa2ztu9BBJ4pI2bMZEyG+Jxipy0sA=;
        b=Nwu8Tu51ye0ra9p+yc4hLXGZ7/Vqs0OnUcenMx9ueJNft5nukMoD05PLpJkWpZXClY
         BDdVPcye/5Om18x8gsm5W4BUBuiQkPmn6NoV2M7rvV6Rog/2Lr+3gZh/qV1sK/APXbwH
         HPNFrnKJlKozeDl86OIPIVAGaZUM6bslNaWJ4ke5iM3XgiVwOnQSrvXjMs5VORNYQAIR
         x9ixhQMyZ9CZGUmbPpcU2aj/0zV5LHxiDKFZMyQJDu6Y+eTAet6vVayGiuVBMQA7izti
         vSgsYizZHm9is3TsAFSxql0k3l+DwAwPE5AjbZQfiNutIDCP0Qrtt9SldLHXsCY4FoHN
         79Gg==
X-Forwarded-Encrypted: i=1; AKwUvBwfERfjbWP5sZrawiTwKdKbxlRlbBjnOQ+zVf6XhQyX29voMFmy8SJhxkpKO0mKl48gzjj6jztV8AI8PPTfz6g=@vger.kernel.org
X-Gm-Message-State: AFuF++lG28K7uk+VXkgxLn2QxOCBpcnymAGDhk3kcsLuQ/ENBasR1/jk
	c9SCDGHBG4GCPYNMuM7XePo+amVLOBLVJdWaAn13V/fwuQMqIr5/CFe086nfg7n2qg==
X-Gm-Gg: AYBFou0rO2oy/1km+ZWU9LTLbvpjpkdt+AoQi2FPH+NYp6Enaxv7ppSbZ1jm6YSliON
	fndAChf1IeVKlz02zsLyuUbK683BgVnWhUVg24CRpGCwkH29sXPWa+lDzRDqYOCQ6m8XYU+fOUJ
	hzU9Lpci5GfLzdeKY2O9IA5mNIsQ1EHoIdVDjp9Fpd1bOw+m8JEWpBkR85Kve2OPBdH1H29YEIS
	UXvYDCHTpxrt2siwZDbjRfF4ihjmDodUgljNy/fp9p7KfmC6+eUg7oUEVVG8oAiPMfa2hAcN+u3
	0h1oPDLUg6dkKWrENbGhMFjd6a7Rk5LhtcePu2l9C4StjyMrumtdkHtkxZdEwJwSo4hzKWPlwOz
	ToKCj3pyhWfo2wtGH4ewwt+3D6RhUHtgHzUG7HnJnyFGTgqFnrCvA6oByBCi70hjLPrS/EBYkB3
	ld2ySVBpYg89RP0QJFkR+zxS150d41ti4dznH+grjTES/VMtGuC7EbP3tRiX6ZV6pwquUvRMuco
	YRsKtPPwT+lWXsmaE97324YvvCsgviYNA==
X-Received: by 2002:a05:6214:2dc9:b0:90e:8022:b66a with SMTP id 6a1803df08f44-90eca50ecaamr99641606d6.22.1788377691985;
        Wed, 02 Sep 2026 12:34:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec8099sm25284386d6.30.2026.09.02.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:51 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:50 -0400
Message-ID: <32dd145d801e472375c21d582023ed40@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 17/27] fs: port ->tmpfile() to pass const mnt_idmap
References: <20260901-work-idmap-const-v1-17-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-17-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  Documentation/filesystems/vfs.rst     | 2 +-
>  fs/bad_inode.c                        | 2 +-
>  fs/btrfs/inode.c                      | 2 +-
>  fs/ext2/namei.c                       | 2 +-
>  fs/ext4/namei.c                       | 2 +-
>  fs/f2fs/namei.c                       | 2 +-
>  fs/fuse/dir.c                         | 2 +-
>  fs/hugetlbfs/inode.c                  | 2 +-
>  fs/minix/namei.c                      | 2 +-
>  fs/overlayfs/dir.c                    | 2 +-
>  fs/ramfs/inode.c                      | 2 +-
>  fs/smb/client/cifsfs.h                | 2 +-
>  fs/smb/client/dir.c                   | 2 +-
>  fs/ubifs/dir.c                        | 2 +-
>  fs/udf/namei.c                        | 2 +-
>  fs/xfs/xfs_iops.c                     | 2 +-
>  include/linux/fs.h                    | 2 +-
>  include/linux/lsm_hook_defs.h         | 2 +-
>  include/linux/security.h              | 4 ++--
>  mm/shmem.c                            | 2 +-
>  security/integrity/ima/ima_main.c     | 2 +-
>  security/security.c                   | 2 +-
>  23 files changed, 24 insertions(+), 24 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--
paul-moore.com
