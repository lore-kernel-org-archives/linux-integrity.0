Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4939CCF8
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377703; cv=none; b=FTNEMvPoJDm4HYec2Eigf3p+VQRy8vmHbd7A8hrW56/dxwxzpYN7B9bH+62lEDhCJp5GevmC+VetyNbPPmxUkGjnTlwGt6fUBeCr5SPm1N3M84dwKmkfiJDTXScLqdzq+qqVC8cKcRWTAdBJmLp9KIphH2TDR9O7nEOa6Y632sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377703; c=relaxed/simple;
	bh=eh+it0zb54ufEP/JnblEMEpySL7Prj/F5s/H28111ro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=j1MLcAXLoIrG+Cz1fp3TuGDZBoh9mLR3anVAykkproFI9MH2VQL7Tdue0hQn5HgYWn6udgEOMECAKjrBbeWNDxi/aaAHI/XqhytHhTMQL0ribRR6Sz4ylyIXI/3JLINz69wthRz6zACnXlx6OZ63Wzh3COODamVDbT/IOCuYUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BApmi94N; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BApmi94N"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e8535619bso16013326d6.2
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377687; x=1788982487; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=BApmi94N0haia63+fWtF0lO8gtf7CPbnhyiBUjO2IH+nYwAJb4uJXYRK7Cr6JJKpFk
         YxGptCgPyiA1YZmnPhS3FOGlqVAlbkwTb/eVF5NtLCuLuSICFUx37nq/Nns4yNA2zgH0
         CFYc13B4d2J1cC4nKVeZUp+yNmFJrn0DoYd6ScYOlVDpCIQWM8wV9IJ51HJQi6KW+GVF
         nI2FzCFnKFMfXHpWkki8P6hmZ4q8a2BhC/Xez0+PIPWLa+R4Uc0B91tXHiwfcP+6AsP1
         FRMH/M4HjtVOxsSROaRN5mJYZjmLY8FnTjlOzEo1VRpzChFgoAHEReRUhVrJL43U/Yma
         Kkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377687; x=1788982487;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=AelV+rOIn6VnaOhd0gjb9G+4jWxApooEfS941kVxKlxLyyEBf0BP9Dosmr+pw9kC9v
         D71gJ0CtstN87/q45u/EDjy3IAwqrOadiefSsH4LRjlm6bCZzic9icCpENGXH81sEYbd
         iK3//dVmsRGskeWYogamUQsV2olMcVjDJ161DHZKBylZhJhylfT81aub+gXDE8erq/9b
         wDNYTaHICkVLygFXa/leR3k/OS54hMg3W55VFaGTgc74mU2q7ebyEc4fI6Yupm5TiqZ7
         61sE9Y1CaZDSCXSUXnE6JGj0k2B7s7LqL6YCqacucMpNVVuTbVSPlrKTXjQLRLr2mIOr
         W1JA==
X-Forwarded-Encrypted: i=1; AKwUvBwq41Hwfpia+/lbJvz/AAkgqMjnBkeJLLat2iT/HxkgPQfGqLAQD325CJu00CBjaeyDHqS7Fhk3HjYsDdkBa4k=@vger.kernel.org
X-Gm-Message-State: AFuF++m1OxV3TkLRawfdxL70AObMAc2bnMunF3EMKutjlJVFFzyMNTtT
	7ocY1ZAqEWmbmSTpcqdvehCbRsGY/YZosTFJQEY3TNv6fsUu5fLgrWoCy+m8vLx23g==
X-Gm-Gg: AYBFou2QxlHIA7KFnKZSKPFAqDNDUfoaYgMY7WH+bR5kWLPSHHH14AiqpZ6BALvCuZk
	v57rLZa+t1jUBDpdmE/92891X7xexEYTAnez1zMHlwhp4HGBZFfhROKXzQY5uzxGqwvS9Iykt61
	sgdNYtf5QKTo4e+oI2wlt2KpSAQgmYnmsyB0E0TuW8PKu3y30EKjqZq8ACt0miN3BO4klQiB8Do
	yzsGTNfpLibTVLQQ8WkdjKm5j0cquxK78Sp8tKQVVt52hJyiOA2D+oumTeTUNlTStytxsqyEiJX
	fW30YOyBBA4AtPs689fjPBEkUzp27yMed4PqJvf0KLTw6T7Rzsx0CKElJuc7YEt3vyCmWTkrBCT
	Yn4+ldVy6UBe4FRWZcTfmDbEw27wl3geIPHdM0rb1pV0eGb30dnc0O2+NykDYIGNOpGdftLIwj8
	9GnHhx1YjLn1TwDmwXRR2CXES2Un5tCI7lUh7bX+x4z83m6hj9F8lFtSEbuSQmVcdUxH1CsavL8
	Qk8/zZ6+Zf07cYhHvMG65zJZoG1JidDDA==
X-Received: by 2002:a05:6214:e85:b0:90e:7de2:d81f with SMTP id 6a1803df08f44-90ebabbac8emr90744936d6.20.1788377687526;
        Wed, 02 Sep 2026 12:34:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm25176366d6.2.2026.09.02.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:46 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:46 -0400
Message-ID: <e266759fa7a20e9620b16c1b5a717744@paul-moore.com>
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
Subject: Re: [PATCH 11/27] fs: port acl to const mnt_idmap
References: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>

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
>  fs/ntfs/ea.c                          |  4 ++--
>  fs/ntfs/ea.h                          |  2 +-
>  fs/ntfs/namei.c                       |  2 +-
>  fs/ntfs3/inode.c                      |  2 +-
>  fs/ntfs3/ntfs_fs.h                    |  4 ++--
>  fs/ntfs3/xattr.c                      |  4 ++--
>  fs/posix_acl.c                        |  6 +++---
>  include/linux/lsm_hook_defs.h         |  8 ++++----
>  include/linux/posix_acl.h             |  4 ++--
>  include/linux/security.h              | 16 ++++++++--------
>  security/integrity/evm/evm_main.c     | 10 +++++-----
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/security.c                   |  8 ++++----
>  security/selinux/hooks.c              |  6 +++---
>  security/smack/smack_lsm.c            |  6 +++---
>  15 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM, SELinux)

--
paul-moore.com
