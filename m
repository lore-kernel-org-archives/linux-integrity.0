Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907479;
	b=B7H2qBTPxspeGFAZbVSLojhpB8iPNS8v8zqxcxKTgO21Bq7Ah3MDPW6k7v+9kC3hMPEy
	 eXdPtuLZ3Zkm1R3a/Hg0/JMFPHt1A0TrZVLdsT2fr2vNtUDzRLYCsbZZk4oIt3XNsmJ9i
	 Wd0+sheOxgiLuZb8msoFSFIOu9V3juXE4b5rcYq470ooq15u26JNQYPTaLxyKiqN1S0wm
	 5RTAZsU1Vqc4+cRJ9Z9MZ8FqIC/CXdgz1WtPlAGBUY8uyrhmTg7uNdVQpRfm2E7dANgO7
	 HYJ58ysF2RtYTaseXypM/KV+ME5GpfuesKygQDZxUv6r6Vp47zntUSAvUnEv8OOQiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
	b=Nls1rKc7Aul6FH2NKR9DGlI17FIzNsTj1+IIJhGi3opDfD6iZpTNvF08YztqsctISIJh
	 D6gw3z+SXPZB6rDqYqbOs0nfNogFlcyydPUCA8MZRPIpqhZQpflsmxgj1i8wW5nk+yCAb
	 Yg7CQn6shgcuzhfrOKZm2VzLL+O85VsyWuh17bus6DRN41wJsxZNF7C78o2ANgzH3V5SB
	 NcruDRUYpJvfRnhgMhzKv8elsBjwcMkB1Vcvu5xu330mUMg7vr6C8ygclzGZOAg2YZrEc
	 Xy+AE1SEYVGm996wXwkApLyHPV79ch0Bw8ZdpkQxwzRu3TgzlWp0oMjJLaGgQqfbmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168E607B96F
	for <linux-integrity@vger.kernel.org>; Thu,  5 Nov 2026 19:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2168E607B96F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36d6765756fso2917251eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 05 Nov 2026 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793907477; x=1794512277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=cPl6L7vv4IdiTxomRsfBZyJX59O6aKePsnYBsOL+Il0TM2e7QZLMYUoor5RewSvnv7
         vLLbLRMSyMW/YKWH7JVRt+VA8awqGEfSTnb3NSI212h84khTjynO2iw5mzK2nVh11z5d
         EZ6tC6WQcQkAThRjYpVZDYHpM0IHCup/ssjDItaCiUmXD6fNSzFXuqyMXfcjXo9Y3C18
         AjZA2LqCbQEPJQKpzTHX/9JMW5k+59UhN0TUOXzSYbdIuRgq6YZLqhp3MfDyp1FFBB4n
         21C0wHgHpp9aOnGvecq21MbiLJ846BIuczpuDUnGu78BBlZgT6V+04NGwiDJ3uZbl2e6
         YlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907477; x=1794512277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=0ZA5CY4LpofPN3sfKsJLLS+K5zVIa3pSOqNCKxz8TQVondP6NkEgHyD9/ne1d9Upql
         KSfz9FSs4/cJShtv0TClxyW+pK7EDrhH2CH0zqnMjdGlUnn2DbsrGgRilh58NyW+RDYh
         JL4v2zzQEXmzKZ9qkCoVRhhYUUBUiTRYkIeDCXLnIZLdUnYTImJlD76iLULOzkXBH0W5
         04cmrapJu9pLJiceB1x5yWQY6Nu15R0xQ5eWtBs7Oa+P9ih+vE+my6as1X8xyXVz0Llq
         19MsbY6gRr4tzbEjGvyM/yZvQl3R+dss/hdKr2FRkcAH7426X85jxDcIR2X/xxOVfBMA
         aM6w==
X-Forwarded-Encrypted: i=1; AKwUvBz9TxSgjB/cole4NWlSs98hVaIyLe5eVhu5EyNdqgZKXvao5viNmseZaGzxPS8UgBaFi/+Zrv4SFEew4BTicZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/INYBdKBCKu+ZV4WGkQ0DsStkneS//9WHKYDFPoZLHHVmrHn85
	HwtwT52NTHvA2AFW7nbVEJ/bWWqMWiHfShHvTAGitEmtFBpRiNjq+JgcPcT4kYo7KQ==
X-Gm-Gg: AYBFou2N4Zdgbt9AjDLk+b2Ea24syHtdIQw/PmCQiyISL8lLqsy6Cu7KXkyRv5PP2KD
	ywu/Qj6EPhXMQoB3Hi63sjpO/hT8lBLZdolTpFkuh85XhRWxXenfBuimkgunrJS1WPxxkFZe9K3
	SdkokB9si19eIaiVkPnY829uh4Xf7gDLRYmGgthMN6BvcEHNtJ+tgLDYjgGSV0zHNLVvf6QiBK8
	vPkP/Cok0ruZrpAiFqGiuNwtMZRkq1rb08nXbCXJve/iV4l4eop1TAjmnS4rk4FNi/t9B7YMO1A
	yOrFrpD5Hap456LmS2QEHEQcOW2/tFSjMm+F+NpvgRAu9RchqXtokyR33Q8ceG/ENRtSqUJXJqR
	wjG45tCnxTolV0/VyVVy6h6iC9Vr8ZZtb9MnHGQrIb/eDWctn244WbaXMS8vKvwpkiGZuWGk+0n
	lhaU2VxxCuSK9V7VbtYxhmiKAQLOKrHtMWlfSMhMtgaar6HgT6CfJuipznuVkphs7EQSQlG6mNn
	nPECOhKVFJPMqpOWyyTPmzP87fBnANSw6JSuGW/E+tYNy4ZTjHpeZ4oR9/jcuFdWsdx2wasOLU0
	9GNBj/JXDHUp7zbLV70/y7CHMVjTu4Dr/lih6OgF0u0LNm/CNd8BQjTC+xgssGnV9m2OHfQVdgJ
	5QAjP3QQDqZkA5rvwI/juCy0=
X-Received: by 2002:a05:7301:6285:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36f76f0e752mr142560eec.38.1793907476899;
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f72ec8a02sm326134eec.11.2026.11.05.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
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
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	alexandr.lobakin@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v6 2/4] initramfs: add file metadata
Date: Thu,  5 Nov 2026 11:37:41 -0800
Message-ID: <20261105193743.2654656-3-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261105193743.2654656-1-dannyhu@arista.com>
References: <20261105193743.2654656-1-dannyhu@arista.com>
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

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch adds metadata to a file from a supplied buffer. The buffer might
contains multiple metadata records. The format of each record is:

<metadata len (ASCII, 8 chars)><version><type><metadata>

For now, only the TYPE_XATTR metadata type is supported. The specific
format of this metadata type is:

<xattr #N name>\0<xattr #N value>

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

[sassu: removed state management, kept only do_setxattrs(), added support
        for generic file metadata, replaced sys_lsetxattr() with
        vfs_setxattr(), added check for entry_size, added check for
        hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
        before do_name()]

[zhangguangzhi: fix checkpatch warning EMBEDDED_FILENAME in
                include/linux/initramfs.h]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Tianxing Zhang <zhangtianxing3@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Signed-off-by: zhoushuiqing <zhoushuiqing2@huawei.com>
Signed-off-by: zhangguangzhi <zhangguangzhi3@huawei.com>
Signed-off-by: Danny Hu <dannyhu@arista.com>
---
Changes in v6:
 - Document lack of support for POSIX ACL restoration. The main use case is to
   restore security.ima xattr for IMA use. POSIX ACL support is out of scope
   for this patchset
 - Check xattr name and value lengths to ensure they are valid and do not
   exceed the limit
 - Compare metadata header and record sizes against the remaining buffer
   length to avoid pointer arithmetic overflow in bounds checks
 - Use the kernel u32 type instead of uint32_t

Changes in v5:
 - For debug print in do_setxattrs(), use print_hex_dump_debug() rather
   than printing the xattr value as a string
 - Use u32 metadata record lengths and reject records smaller than their
   header

 include/linux/initramfs.h |  19 +++++++
 init/initramfs.c          | 103 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/initramfs.h

diff --git a/include/linux/initramfs.h b/include/linux/initramfs.h
new file mode 100644
index 000000000000..9b3839dc88a1
--- /dev/null
+++ b/include/linux/initramfs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Include file for file metadata in the initial ram disk.
+ */
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+#define METADATA_FILENAME "METADATA!!!"
+
+enum metadata_types { TYPE_NONE, TYPE_XATTR, TYPE__LAST };
+
+struct metadata_hdr {
+	char c_size[8];     /* total size including c_size field */
+	char c_version;     /* header version */
+	char c_type;        /* metadata type */
+	char c_metadata[];  /* metadata */
+} __packed;
+
+#endif /*LINUX_INITRAMFS_H*/
diff --git a/init/initramfs.c b/init/initramfs.c
index ebddde9c8f0d..d206624d1160 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,7 +10,9 @@
 #include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
+#include <linux/initramfs.h>
 #include <linux/kstrtox.h>
+#include <linux/limits.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
@@ -22,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/umh.h>
 #include <linux/utime.h>
+#include <linux/xattr.h>
 
 #include <asm/byteorder.h>
 
@@ -189,7 +192,7 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata unsigned long body_len, name_len, metadata_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -264,6 +267,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 }
 
 static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *metadata_buf;
 
 static int __init do_start(void)
 {
@@ -365,6 +369,103 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+static int __init do_setxattrs(char *pathname, char *buf, size_t size)
+{
+	struct path path;
+	char *xattr_name, *xattr_value;
+	u32 xattr_name_size, xattr_value_size;
+	int ret;
+
+	xattr_name = buf;
+	xattr_name_size = strnlen(xattr_name, size);
+	if (xattr_name_size == size) {
+		error("malformed xattrs");
+		return -EINVAL;
+	}
+
+	if (!xattr_name_size || xattr_name_size > XATTR_NAME_MAX) {
+		error("invalid xattr name length");
+		return -EINVAL;
+	}
+
+	xattr_value = xattr_name + xattr_name_size + 1;
+	xattr_value_size = buf + size - xattr_value;
+	if (xattr_value_size > XATTR_SIZE_MAX) {
+		error("xattr value exceeds size limit");
+		return -EINVAL;
+	}
+
+	ret = kern_path(pathname, 0, &path);
+	if (!ret) {
+		/*
+		 * POSIX ACL restoration is currently unsupported.
+		 * vfs_setxattr() rejects POSIX ACL xattrs with -EOPNOTSUPP.
+		 */
+		ret = vfs_setxattr(&nop_mnt_idmap, path.dentry, xattr_name, xattr_value,
+				   xattr_value_size, 0);
+
+		path_put(&path);
+	}
+
+	pr_debug("%s: %s size: %u (ret: %d)\n", pathname, xattr_name,
+		 xattr_value_size, ret);
+	print_hex_dump_debug("xattr value: ", DUMP_PREFIX_OFFSET,
+			     16, 1, xattr_value, xattr_value_size, false);
+
+	return ret;
+}
+
+static int __init __maybe_unused do_parse_metadata(char *pathname)
+{
+	char *buf = metadata_buf;
+	char *bufend = metadata_buf + metadata_len;
+	struct metadata_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+	u32 entry_size;
+
+	if (!metadata_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		int ret;
+
+		if (bufend - buf < sizeof(*hdr)) {
+			error("malformed metadata");
+			break;
+		}
+
+		hdr = (struct metadata_hdr *)buf;
+		if (hdr->c_version != 1) {
+			pr_debug("Unsupported header version\n");
+			break;
+		}
+
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtou32(str, 16, &entry_size);
+		if (ret || entry_size < sizeof(*hdr) ||
+		    entry_size > bufend - buf) {
+			error("malformed xattrs");
+			break;
+		}
+
+		switch (hdr->c_type) {
+		case TYPE_XATTR:
+			do_setxattrs(pathname, buf + sizeof(*hdr),
+				     entry_size - sizeof(*hdr));
+			break;
+		default:
+			pr_debug("Unsupported metadata type\n");
+			break;
+		}
+
+		buf += entry_size;
+	}
+
+	return 0;
+}
+
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
 
-- 
2.51.0

