Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394614;
	b=15rge5dXBM+wKjPgXdeZCrifbSSdS+QxdynvD2TtjCMsh2UVLsJ/FdOJRgeEvI760HTl
	 nBOK55GHWL+gQ/Ul4UzOBg0/4WPuPld6JUNLFSb3g+cJNeZ9qjVBO4xtXAHsVhUhOe6BK
	 ZSU9tYSbZ7VbrIyJTqCqxjqdClLoSssgMMXErshYAJavzGLzOJWSBBjwroGoVKn0AvA2o
	 dXcA3U/m/q6y65hjFM5GwFIrdEV8+Yyw13/YEWivSKDujHR0uL+iCP0IHyqZuglJdDwUV
	 RhljVKxvb1mUPEZBmaEUpc9TXLrJMNTtBqomfplLbM0E2v8ys+ficbvhmgTWsc00kSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
	b=Mney9eFa7Zhzxi/I4w1M920H98D7U4kmRTxWZYgpK/B5RZAGkZGVWUP628k2VCOXsfAt
	 2/l/ZEgRbgYi4cNHZK5oIs0HHMWKROwvKh/Fx9bLKZ7DQUicbakCtIU08oLGNcF45dzOm
	 0puNlgPgzh5131Cckj6BRTaR1e8naktF/pEESIkJU+YEqCRvajbda/hHwsUsa0Ng7f1b6
	 qB6znTT5Xa8jAtGRNdy0dBuslIMll2O/GTcMaIFg3xtH7mpYvZFJdKvJPMD+5wOyCEDsI
	 +PQGVPc1ecnRxf0L9VtbzjezJZHxBFIQ/h4nGB3u44+0QJZSPRQghpyrNbeLusikGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=B6OxYaPZ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148A606A322
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8148A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=B6OxYaPZ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1967041eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793394612; x=1793999412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=B6OxYaPZEXwX6eoD+yW3EG1Z/aoR1wyJRu4TE4FSCahc+bucN39o4+UyIYNc//eoxq
         3AcMNiHX1YdVCG0JlXDO6SHAbELtk3m16sUwzoIa5yTV6PaQBwAFokrVt/GomfMjh0CG
         LNLxgaJ1ED8y4/JyL+Bv824IYiqAUKbMIhPn5JMFdWlmqIFEmK53cFCRoy+VS8c4hkdk
         Rm7C4kIESvyvjdWmxZHog5JoSDxK68Vn4HYyOVYFirHvaYyR8msmZ/pK+bzJR39G+UzI
         IgcB5o2OasU7kgri+nF56auhkUhIcbDembm5pZujnktYRC2SY7No0rYe+BaKvO2kGg0Q
         sAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394612; x=1793999412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWFHdhsqkiSrahXyVyHuACAJn5u+mkpktpUzIjfAX54=;
        b=nzDdFqx3ff8wIfTdJiChLAE1MU1oh/1oS+RjSoBk2lFmJXBS4qec3Q2QTyI4huseZe
         O8cLXYAhBjQxOpdYDvVB4aZHUI9/oH7Gxi/Ipj/r9Lh/o8CcMdvooj4KODTBseJFjh4U
         baIIbcyJ9df07NxA56BcnRyfDJLx+ZoOt9grHzn1TuP5a41/9c3/efbzfT126zrS8tuX
         6VO/8T7oiHrwnJ58DDPRQwKGol18dyBOGxT19D4uxKHEX3eyer4tILZnjqkOPzn6MsLl
         OnQbsVnbWBm6937pk0tWSSKYouHrPjbgZtlBtgeqzS1xNAEy7kkKhWMNX4Vh2x2RacW/
         zqYw==
X-Forwarded-Encrypted: i=1; AKwUvBwL+2ecOrC+5n73aXUoDq8fMZpaqfhzcRWC0ly5omW6Ym5zvoMdaTsPA5LU4RAm7IB1qnThV6ZoCcDeZUY3s3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUcIRTmhdVmbiKq9v/Mu916I+ABnZG8qUmgY7buDgHzyQB9Ydt
	3wBCCJeV1EHSm5pEAFsBmXUK9wnubWm/ASO+LCBpzIpDSPftrGWmaSWp0XpLxy/Smg==
X-Gm-Gg: AYBFou06+sccFLf76L6ag8f32pHGeX8MI8P2E/9WP+4LhOFuRRzyTgwMrxHilupI47j
	nTTNy2DCRR/cJ60ClWD/6fhHuPowIGmrT4wQ4jSZjtDSphOFsbmV/KxxUUQjSin3as+mAn1hgh8
	pV1YgXlC/Aq+pRRtisiDFzp7CzEwCsfRtyQt//gDTvQqwLVVzU23hqLHlwbvWKo0oxJkjE0VMeU
	VD56o8q4wfRW3DjW+WLsDBWzPyCRBHhAI9IT4+TVVA9oiFYCZh0bm44pb2KzbbviqLmmPNBYN0f
	mLw/Not11WCl7obkM6Un0TBrALW3zwUlvF14Wm1hdWUm3vIKTWAKZokUeM6QTP715m7gVK1yfe1
	IqXeGvmM4i9F6TikFwoBqA9O6nzA4NYKbBd1dq5xv7WXY47gHPQN5y8B+8pWgZzyVh0K/tSg7Tp
	Ou/UEh4SAiGJZIxqRgIkqTneFuoCS/SF9TY+i8bTIfMgkbon6KrbbJDeFhVdERuRcPLlEk0edpz
	SrZ+P9xbmTdX3wilDe13eXQUGl+nGB0I6lh9FGnJxRQsA+212IoU8wmz7vK+MZBJ7JZazwYVHwh
	oto0AFmJKA/B8Ain+BJJ4khhR3KtDZPG+vNjrYL5gv92xYnV1Rc7dhP58tOJGKeYyTCs2wyaSkk
	wJURDofIDV/6T93WJBtszBuM=
X-Received: by 2002:a05:701a:c907:b0:185:33ab:4d55 with SMTP id a92af1059eb24-1ac5f1810d2mr4226717c88.29.1793394600810;
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm9471777c88.21.2026.10.30.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:00 -0700 (PDT)
From: Danny Hu <dannyhu@arista.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Victor Kamensky <kamensky@cisco.com>,
	Taras Kondratiuk <takondra@cisco.com>,
	Tianxing Zhang <zhangtianxing3@huawei.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhoushuiqing <zhoushuiqing2@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	rob@landley.net,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	erosca@de.adit-jv.com,
	alexandr.lobakin@intel.com,
	jim_baxter@mentor.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v5 0/4] initramfs: add support for xattrs in the initial ram disk
Date: Fri, 30 Oct 2026 14:09:39 -0700
Message-ID: <20261030210944.2143778-1-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims at solving the following use case: appraise files from
the initial ram disk. To do that, IMA checks the signature/hash from the
security.ima xattr. Unfortunately, this use case cannot be implemented
currently, as the CPIO format does not support xattrs.

This proposal consists in including file metadata as additional files named
METADATA!!!, for each file added to the ram disk. The CPIO parser in the
kernel recognizes these special files from the file name, and calls the
appropriate parser to add metadata to the previously extracted file. It has
been proposed to use bit 17:16 of the file mode as a way to recognize files
with metadata, but both the kernel and the cpio tool declare the file mode
as unsigned short.

This v5 revives Roberto Sassu's v4 series posted on May 23, 2019
(https://lkml.org/lkml/2019/5/23/415). The github issue tracking the
revival of this patchset is here
(https://github.com/linux-integrity/linux/issues/11).
This revision incorporates unpublished changes
from other contributors that can be found in
(https://github.com/linux-integrity/linux/tree/initramfs-xattr-v1-devel-v1)
and adapts the implementation to newer kernel interfaces. Compared with
v4, this revision adds an IMA deadlock fix for restoring security.ima
xattrs during initramfs unpacking, switches to a Kconfig choice for
metadata type selection, and updates gen_initramfs.sh to pass source
paths to gen_init_cpio for nonregular entries, allowing their xattrs to be
read from the correct source object that will be included in the archive.
This revision also includes various improvements to error path cleanup,
debug output and tool documentation.

The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
separate files instead of a single file. Given that files with metadata
must immediately follow the files metadata will be added to, image
generators have to be modified in this version.

The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
all files have the same name. The file metadata are added to is always the
previous one, and the image generator in user space will make sure that
files are in the correct sequence.

The difference with another proposal
(https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
included in an image without changing the image format. Files with metadata
will appear as regular files. It will be task of the parser in the kernel
to process them.

This patch set extends the format of data defined in patch 9/15 of the last
proposal. It adds header version and type, so that new formats can be
defined and arbitrary metadata types can be processed.

The changes introduced by this patch set don't cause any compatibility
issue: kernels without the metadata parser simply extract the special files
and don't process metadata; kernels with the metadata parser don't process
metadata if the special files are not included in the image.

From the kernel space perspective, backporting this functionality to older
kernels should be very easy. It is sufficient to add two calls to the new
function do_process_metadata() in do_copy(), and to check the file name in
do_name(). From the user space perspective, unlike the previous version of
the patch set, it is required to modify the image generators in order to
include metadata as separate files.

Changelog

Changes in v5 relative to v4:
- Rebase onto vfs.all
- Add an IMA fix to avoid a deadlock during initramfs metadata restoration
- Use u32 metadata record lengths and reject records smaller than their
  header
- Improve debug output for binary xattr data
- Cleanup metadata buffers at the end of unpack_to_rootfs() 
- For CONFIG_INITRAMFS_FILE_METADATA, replace the metadata string prompt
  with a none/xattr choice
- Fix resource cleanup and format specifiers in gen_init_cpio
- Update gen_initramfs.sh to pass source paths to gen_init_cpio.c for
  nonregular entries (slink, dir, nod). Modify gen_init_cpio to
  properly collect xattrs from the source object. Without this change,
  xattrs will not get included for slink, dir and nod.
- Add documentation of xattr option in usage() for gen_init_cpio

v3:
- include file metadata as separate files named METADATA!!!
- add the possibility to include in the ram disk arbitrary metadata types

v2:
- replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
  (suggested by Jann Horn)
- replace ksys_open()/ksys_read()/ksys_close() with
  filp_open()/kernel_read()/fput()
  (suggested by Jann Horn)
- use path variable instead of name_buf in do_readxattrs()
- set last byte of str to 0 in do_readxattrs()
- call do_readxattrs() in do_name() before replacing an existing
  .xattr-list
- pass pathname to do_setxattrs()

v1:
- move xattr unmarshaling to CPIO parser

Danny Hu (1):
  ima: skip algorithm availability check until initramfs unpacking is
    finished

Mimi Zohar (1):
  initramfs: add file metadata

Roberto Sassu (2):
  initramfs: read metadata from special file METADATA!!!
  gen_init_cpio: add support for file metadata

 include/linux/initramfs.h             |  19 +++
 init/initramfs.c                      | 140 ++++++++++++++++-
 security/integrity/ima/ima_appraise.c |  25 +++
 usr/Kconfig                           |  19 +++
 usr/Makefile                          |   3 +-
 usr/gen_init_cpio.c                   | 216 ++++++++++++++++++++++----
 usr/gen_initramfs.sh                  |  15 +-
 7 files changed, 401 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/initramfs.h


base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
-- 
2.51.0

