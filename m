Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B784AD4AD
	for <linux-integrity@vger.kernel.org>; Wed,  2 Sep 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377705; cv=none; b=VHx9/daTYrcG0EqQpBa1e1IA/Vd7oK6/Lc2lU2kHK1euIIBYrMlo4vfgFeRo8F1WkpQ8fMIV8xq5M4VBqkbfS7XtoN0LWAEWmxTEimLN/98ZIrwJW/1IFcswHuoyAmv8V+btx4XESZ3kJF7FuZVQITOlqKjaK2WjNSBpU6ODfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377705; c=relaxed/simple;
	bh=7XijPLwz3cHBxl1YFk+E8vu/tL68tteh4h0gxiMHTNc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EMfD2YIAUN4u98/SuyTzIws/pxp7iqkjJDhjruLVtN1kCbFT6GJ+fGjw2qmyvk2tOmRKqU+gBtChSHyEGpQvEbbBGNU6IkXWIW3qx/ErZJR3CIHt7yM55kVuI1gS9gPOw9/diixh7GD8eV52Y/EsO1g9uDPmTxlrDnkzYB4/wC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BV7gy4RE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BV7gy4RE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-910317dc2e9so6207006d6.3
        for <linux-integrity@vger.kernel.org>; Wed, 02 Sep 2026 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377691; x=1788982491; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIdNMxFvwqrPz4tpIyv6StSQNKP9oc9jkPpYrkixADU=;
        b=BV7gy4RE6mNsBcwGoHwPA08TpJtomce4ubJTHTGxEy+jWSTN05t73kB+0KwsSljsDc
         hH73iiZ8u2P4PmFXaqUuIhnzoW+cNjekqQX+NhTc5TnoPw6ff96beUDzr7x/Yn12kjg/
         Ba08IEtSw0o12aasLwOnmXneP38F9DYcE/O/1rtYVbs7noon+Wgzxkp29stDil2RjkCZ
         eN+KFM6gFf+pY77JiKR2aJhnCOBRa+genAtxHNSpWkYCW0qfdDNI++LpT5nw9qeAb/bX
         tTo6qdJIKBn1Te0rI49nouCh5Zf/g5L3WazDoa47tK90zIUHHurUSb/UIMVFRQFuU7FR
         MI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377691; x=1788982491;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIdNMxFvwqrPz4tpIyv6StSQNKP9oc9jkPpYrkixADU=;
        b=FPOYTtBCrYDU7uNhImFOcZkLyqk6REfdfHiJ5/+bANy1+sNLD935QoP/VEyK151ZnJ
         2Mo29pMJMnIb0P9eu9PVMULY9vE9uk5hdQ84BGBY6WVFh9yqT3XagGo+hErcN+f3H/yR
         8hpIlkCOQa1xJiNLV6hqF8uvrtHRZmrfTwJSqM/e3tHZhh8I8qgD46lgbaeiZaKV+xw0
         h4O5dXNNOj//Yze23t53lDM/JV4VEQ3Tr/spbWs6+CdpxaFcqJvTYydedw/klCQ2H9+n
         Hb5dvKSlThnUe0nPgAetZxkWWZwiyPRKvxGuGZpDOn63Uf2CqaCF8AYeM9PNkVTPkyBZ
         BS2g==
X-Forwarded-Encrypted: i=1; AKwUvBzjQGjDkqGzDOS0bp+kgDNWaI9/BzagslDpovXbHiaONvE50v+oSa2OAsVq3CDoUnIX6YEw3+queL+bWJAwJa0=@vger.kernel.org
X-Gm-Message-State: AFuF++mitXGPgXjmy46DO8D0/1TMyLkLm0uSe8zKTGbwBSZx8R5Q/egR
	H/ZxfKGxj/ek9StWoIhX96khe+2znvM3L3f+YN3+PoXsOu9wA8OgIl8cw8iLQbL1Cg==
X-Gm-Gg: AYBFou0SXMcQBRNoAjiJfTQP2RuOYqQrTH4akzOzwudjPn3rNg10Iel4xTVI6LAuTGE
	Ip8f+UVqPTEOAPiXnU0ZT6irLg5C72z8pZGfpysb169LVtWmGUyiVnXoG8PYP4bd2BRcA7Tw2GG
	efeiv8bAMl/jBrPeVoaDCLg38/FWC7C4HCPdrSWoP53tdybUX27rRwoXpCDqbm/xvMTFddcwX4O
	yeb0rN1Nua6quSXTn8dpsfzOHSoL1nu56NSEwVUn4QEuIiLAyKO6NgZScRqp9/xgf8y1kc4b2V5
	7uZ+hG9mJSAZQoSOkx7f6+i7t7rrwu5eF0BEAFzz6wgVD9ZxAsh0Easy07E+yrME6dovY8G5ZQQ
	XP/n/Sw2FG+2DFwe76i/zrs3DOe8Ur1J4jHO/auzwQUMikvOWBGilJQQtlR766Z0qsEAw5wrj2o
	974c2PxBxEkUNU3Uq8G6S7o6SeT02/TF2N7iqEIZRhAVHgGGZ5qZRdocGC3jc4b7C8B97BBQSHD
	47R7qKFiAFKcrqpyPi/d0qP6iVXWbKgOg==
X-Received: by 2002:a05:6214:4601:b0:8f0:3b2c:a9c8 with SMTP id 6a1803df08f44-90e9f25c224mr108760886d6.12.1788377690538;
        Wed, 02 Sep 2026 12:34:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ef0f57fsm25004716d6.47.2026.09.02.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:49 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:49 -0400
Message-ID: <f12155b3bc5ca8d846bf822b35f6b857@paul-moore.com>
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
Subject: Re: [PATCH 13/27] fs: port xattr to const mnt_idmap
References: <20260901-work-idmap-const-v1-13-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-13-54ccd48e100b@kernel.org>

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
>  Documentation/filesystems/locking.rst |  2 +-
>  fs/9p/xattr.c                         |  2 +-
>  fs/afs/xattr.c                        |  4 ++--
>  fs/attr.c                             |  2 +-
>  fs/btrfs/xattr.c                      |  6 +++---
>  fs/ceph/xattr.c                       |  2 +-
>  fs/ecryptfs/inode.c                   |  2 +-
>  fs/ext2/xattr_security.c              |  2 +-
>  fs/ext2/xattr_trusted.c               |  2 +-
>  fs/ext2/xattr_user.c                  |  2 +-
>  fs/ext4/xattr_hurd.c                  |  2 +-
>  fs/ext4/xattr_security.c              |  2 +-
>  fs/ext4/xattr_trusted.c               |  2 +-
>  fs/ext4/xattr_user.c                  |  2 +-
>  fs/f2fs/xattr.c                       |  4 ++--
>  fs/fuse/dir.c                         |  2 +-
>  fs/fuse/fuse_i.h                      |  2 +-
>  fs/fuse/xattr.c                       |  2 +-
>  fs/gfs2/xattr.c                       |  2 +-
>  fs/hfs/attr.c                         |  2 +-
>  fs/hfsplus/xattr.c                    |  2 +-
>  fs/hfsplus/xattr_security.c           |  2 +-
>  fs/hfsplus/xattr_trusted.c            |  2 +-
>  fs/hfsplus/xattr_user.c               |  2 +-
>  fs/jffs2/security.c                   |  2 +-
>  fs/jffs2/xattr_trusted.c              |  2 +-
>  fs/jffs2/xattr_user.c                 |  2 +-
>  fs/jfs/xattr.c                        |  4 ++--
>  fs/kernfs/inode.c                     |  4 ++--
>  fs/nfs/nfs4proc.c                     | 10 +++++-----
>  fs/ntfs/ea.c                          |  2 +-
>  fs/ntfs3/xattr.c                      |  2 +-
>  fs/ocfs2/xattr.c                      |  6 +++---
>  fs/orangefs/xattr.c                   |  2 +-
>  fs/overlayfs/xattrs.c                 |  4 ++--
>  fs/pidfs.c                            |  2 +-
>  fs/smb/client/xattr.c                 |  2 +-
>  fs/smb/server/vfs.c                   | 24 ++++++++++++------------
>  fs/smb/server/vfs.h                   | 20 ++++++++++----------
>  fs/ubifs/xattr.c                      |  2 +-
>  fs/xattr.c                            | 22 +++++++++++-----------
>  fs/xfs/xfs_iops.c                     |  2 +-
>  fs/xfs/xfs_xattr.c                    |  2 +-
>  include/linux/capability.h            |  4 ++--
>  include/linux/fs.h                    |  2 +-
>  include/linux/lsm_hook_defs.h         |  8 ++++----
>  include/linux/security.h              | 20 ++++++++++----------
>  include/linux/xattr.h                 | 20 ++++++++++----------
>  kernel/bpf/inode.c                    |  2 +-
>  mm/shmem.c                            |  2 +-
>  net/socket.c                          |  4 ++--
>  security/commoncap.c                  |  8 ++++----
>  security/integrity/evm/evm_main.c     |  4 ++--
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/security.c                   |  8 ++++----
>  security/selinux/hooks.c              |  6 +++---
>  security/smack/smack_lsm.c            |  6 +++---
>  57 files changed, 135 insertions(+), 135 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM, SELinux)

--
paul-moore.com
