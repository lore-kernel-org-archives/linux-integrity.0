Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E131108
	for <linux-integrity@vger.kernel.org>; Sat, 16 Dec 2023 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GU/bb5Un"
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA10920B3CC1;
	Fri, 15 Dec 2023 17:07:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA10920B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688860;
	bh=F9K7Rc9TpRNNFu6bus4pmdllRgh3199Skv9ZQY0T4F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU/bb5UnCHXdTAijfRo8dmDKT43lYFPcnqtovspj7ZNB1YY9gROuyuNHlcAw+r1ea
	 04V9ylonliFf4XvbMBBVYQF6iRGns4+rJoRYHaMt/zyk+ufpXOZdkauKukoDbhfX7a
	 VdB1rTanfcAYntWkGGDcnO1rvsdJ+/WSOZBJ+fH0=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v3 4/7] kexec: update kexec_file_load syscall to alloc ima buffer after load
Date: Fri, 15 Dec 2023 17:07:26 -0800
Message-Id: <20231216010729.2904751-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement function kimage_file_post_load() to call ima_kexec_post_load()
This ensures the IMA buffer allocated at kexec 'load' is mapped to a
segment in the next loaded Kernel image.

Modify the kexec_file_load() syscall to call kimage_file_post_load() after
the image has been loaded and prepared for kexec.  Call the function
kimage_file_post_load() only for kexec soft reboot scenarios and not
for KEXEC_FILE_ON_CRASH scenarios.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bf758fd5062c..ee38799ff1a3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
-- 
2.25.1

