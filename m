Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F4302163
	for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814858; cv=none; b=QCp/3pQuvV2Yh0OD6j6iJqFCDLEwawV492E5aA8xiTDHOd5pDqp46K/WheupnFebh/lJJft5oi5q8Ayz05jCtiHvoyaVLn1NFNZOJUTJ82ZaVrMOhyyu6wLa6UPKkhghM/E+1qArpnkUNOk8oy6B8YaOegZVzugQd7JKMgqRpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814858; c=relaxed/simple;
	bh=58J+e+qzOqSL8rLq819iM9p8hX+gCfzoDVUQTirsvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq8nf3wLebQzTEZyvAyImA8oabmAiOysrulJdKPuiCHPfVijBbpYYqzDTOCnKGm/ESw4BqRZxifVUOag67fyhgHAYxV4XxDNoNycaKRsuDYAJ6f8uE7Ri1GH8yudXB20/8gnIQ2ZYW9vhyKxMZ4a7jXk31KkWlJFINM5ocA0aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpZDhoWP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpZDhoWP"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cce22e029cso34428166d6.0
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814856; x=1782419656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=ZpZDhoWPKMWpdhZAt8MJSKrpVWP33cTDKaLOR8NEm9junQifEuiYa61pJ5oKMbbDUp
         42KlQxUeHhddXxpPPL9P1duAU4scCVYsf9Fv7rU3/GthpI/WNmrIVWvBONGMBsDmatKx
         9pmj94Sw9dU5HEm0wqLwGiSYEfF/PvlCwC97ckbrUYXu7AtWeIuQdJtx42WNlmaLrw7d
         zgOG/03uEJsvIoAfkBVVZG1S6pcC6/hKSd5wun/hlHCOOqb885aiX/JzgcJxPOMCXMc3
         SBBF0xL/wmhsbV9oTsLOSFhom3l53/qIZn056E6zi+qFXQVjmzHM55+LIqbAFSK1CsxM
         Ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814856; x=1782419656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=jkUh1sPHohXh0AePns77hnxWt5oyNZmen5cPlb46bI+AAfFaOblJLV6asYaedVOD7u
         EBVJC2Fi1PjoxGNlyYpAeh2WJTugLq3N7D3oh3M+3YCTUHTeprX825MXG4slEZo0K9H6
         6iYVskOfj1SWfmPsm2f1ZgU5KjEQx9s5k9pDlYOCd15ZsIiy9N2zp9OvF9JcSsPfpAdQ
         Q8/Fm6sk2l+mb/YkGELAQAQSDy+lW34jj+Irbuef78LKvYM4UQnHfOSQuPr4riLK390G
         fq4OEg4JgkThO+g19dbjkNsIbaV2jxRqt2oAdoKA5XSBs/tLsPFqYkB+XpQAgsFYaFtf
         zxGw==
X-Forwarded-Encrypted: i=1; AFNElJ990eikm+n+3OX6Jj/snMc8r3QEKToS1HAnibgkudVlP5XXhlhi6q2gSh5YtiuwStsnpX8nLMhecQifUf3kF+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dgQF3j3IY5xSDNJeygN8cGb1ea2+rQ1CFN2zmCDUBV8tgOzU
	WGPNv87HNAQIOeAhD8Xoq59hD0lTZRwQ3+NcPTmMgXH4bt/YTmhnOgyx
X-Gm-Gg: AfdE7cked+pCrzXBKG10+ZMzXqBZJuyOg+JV38vH+RjiGg3Aggi8neCg10q7G0nNla7
	nnkjHKRl8PyQmOW6gAQtejNu1XaIqMU80y5c0ypNlqnYso73xsMFeMpvP+3VrEXvu9EZOTi7j9L
	KsqKbge81JfUmR0rrE/nynK8xlhlOdAag90lPz0Oe8q60n/4VSBfS2AYZt3QucOU3WShWazduHq
	Xn38GUuW6H1MQIuknPrZ9IpIa1RL+hA+W2L+xf26ZLpDsl3DZ7bXbT+yyQtTeiITE1ObFS1Jx0n
	5gvHdm4MnLB2l7RioQkOESk5BbjXSE2XZ/V/yWcrvKT8981/swiR9+nYg+bTKI0jMc1rOARoTr8
	pUAcrC+9OGvaMk010xU64rkagtto98zl5HBGnTqv43roFGUJJeabhVSAR8aZ1Bpq8SnpIui7Ou2
	yAObkquiFWu1fNnwJ7lb97hseIDm6ISrlOracZLwPdORua1HFmajDf6+6fNDRPC5+vYDcrVwQco
	1Xdc2kTcQ0/MzaPFaCCv+p32Q==
X-Received: by 2002:a05:6214:dc1:b0:8dc:939d:b03d with SMTP id 6a1803df08f44-8de4c76b7c5mr8335506d6.16.1781814855698;
        Thu, 18 Jun 2026 13:34:15 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:14 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 18 Jun 2026 16:34:09 -0400
Message-ID: <20260618203411.73917-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

Link: https://lore.kernel.org/all/20260503211835.16103-1-dwindsor@gmail.com/ [v2]

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 106 +++++++++++++++++-
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 ++-
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |  10 ++
 kernel/bpf/trampoline.c                       |   3 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |   7 +-
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 ++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 17 files changed, 306 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0

