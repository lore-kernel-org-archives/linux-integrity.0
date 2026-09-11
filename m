Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEA36F917
	for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137773; cv=none; b=CddudAoN1szJL/FL7Myr6QNKBj/A2/lg9StbpIY0eU2o5+5Z64+GJpBUAHKrDKe+wOOsTZaiEzDv3NL7NCXmdxUC3XMKY59lC3Abfuw9Dy5VR70xmEiSag/yggzoNjTfzRpyJNumrVF4f9g6f5sQZzTHGlInn1ypUl3/spvTxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137773; c=relaxed/simple;
	bh=vyJh04de2eQI9xDXQLk2SsoY9d27ljdKRQo9PLvYs3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmK7SSwcXM8pC7upPYSz9YOJIR/BMhja0/t/gcPVIn/dKWeiwpU0ptzLeo9fMV3nhnUWSeCExYydfaL5mkriUaMjChgEgocV5aMIQ6NMh/njeYAdJoZrTYAfp1fUciBkAzcxvSbW3XFXIAgJwCBrmulsqGgwGMoBQz4uOqii1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry9/DkDa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry9/DkDa"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so11084065e9.1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2026 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137769; x=1789742569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=Ry9/DkDaFZ4TdwpnSd2qNFVelkgZf0I+sK/vUSrXGJVDvUzGWKFLqdb8UxWJFtIRyd
         QGt2zLsY13XYCfEcx00KmUUPRDrGz+NYn9CJmX9yUyb6hq7gEJz42IC4MRCnwIaEcpdW
         tQUujaQLqeUNnfCJTTcjYm7FSljCpemBd6+PukhbHVRJ4Q4stj3C5SASxuwEvbjV0Osg
         /Q9Xgj+v7KR2zVR2teJezj0miqoZCcV0EC/BLQEfUdpZPOknI1tMHRR4RQUQMW5zLmKr
         P4KyxRefgvqyrABexKeT1gw6lYCx5pucDAHN4oMpIUKFHJiBPNydC9j33pcTbhnipiQE
         DZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137769; x=1789742569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=mhrb+lOFWNiF3AkdsOhN7Kjn6+/N+q4kttNfvWkdMLDyYbEqKpM/inGcG6Pe2Lsqhb
         KjaE7+9HTFpsR+SEnORQoiibaPk9/Sjw3FJ/i33jHPTHAZ8lVm96YaH/mR0LyMqDjHkS
         qeEUfuJ2nzZuDMDmH2bPAES/Mf+gU6fjqGAfCITa65PNAexrS2CWIbOiLdPptYzqISwj
         zPwSGT/89lf1EVVxoOmTHX2HB/KNHQ6TZuIhjkIWXj4goyHvMOWJ1FKA7gBoJ06l5G3T
         8UGpPhm7cJKa1SVsjPEZnfjNmhPMQO3btCC3ZPwzMJ2Up5onI5EXedCKITKE+wrxXb2A
         YKgg==
X-Forwarded-Encrypted: i=1; AKwUvBx50PT3g0DAscYcfYtJ4cmBZLdddgTRGYkx56uPObakOfdi2JzJ7echjQ/lKfTyl8vHYFOUNNamtN1Iy83yqt4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZFmmyZk9cuXRUaBLZ6+CzXmMa2NY/TPlAYk8dmtZLNbRYpkwH
	EyNvruw6SM0T2j0EM1ljy/N1z8x7qNdGF83L88g9J4o+Uqm8VzDes6OMIyyriJNCwxk=
X-Gm-Gg: AYBFou1yFgxxX6FhnJJnNy9eLKCodjm9jOUUuDQtY6Hu7l9n+qlgTPIBgv5P2SXRqMM
	oBYkykkrnLLUHA1m4Po2f/19u40MPzhE/mnNG5hMGaqgLcWNCjVmaQWUO7vdiTDbwtaYOWOyaBa
	druanvwljd/7HICHqGfd4p4NlAoginYBeMAc3xx/B6PZlbijc5dWicP+SSHEObuWQ5EEFgw8bDE
	u0WZueft8YDFhJ3Pvntp7vklo4X8ArGwhyV+KISBRUWH9nWoXAI7D2Ynzg1E3lQq9ypdNunkR5i
	ANEaNLOVgA7jbmewyamboEG4SB/pQwNhHK2sYJSpCCiqO54Xf8kj6f10PRssybjsbA11g+JzpFQ
	3AIMb/qjkT1pwtJ5Z7L/kJcGEZoiyvt4S5MG+4tT8/2LSNdKYp8HQ89dpe3iuKzi/7nwZXAJwJh
	eRfV02BUbiWXjUlQKCffFYc2puh45dIGw1D0waIFpLLWZchft01C6U3kdQEs7B4eoTGGKCDIKEu
	VwSmg==
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id 5b1f17b1804b1-49e619bd068mr62359435e9.17.1789137768683;
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] s390: Remove the asm/mmu_context.h include from asm/elf.h
Date: Fri, 11 Sep 2026 16:40:34 +0200
Message-ID: <20260911-module-include-elf-v2-4-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The asm/mmu_context.h include was added to asm/elf.h by commit 146e4b3c8b92
("[S390] 1K/2K page table pages.") in 2008, when the new macro
elf_read_implies_exec() used disable_noexec() /
current->mm->context.noexec. Commit 043d07084b53 ("[S390] Remove data
execution protection") removed that macro in 2011 and asm/elf.h no longer
needs asm/mmu_context.h.

Several s390 files currently depend on declarations provided indirectly
through asm/elf.h -> asm/mmu_context.h:

* arch/s390/mm/mmap.c: check_asce_limit() -> asm/pgalloc.h,
* arch/s390/kernel/processor.c: enter_lazy_tlb() -> asm/mmu_context.h.

Add the missing includes to these files and remove the asm/mmu_context.h
include from asm/elf.h.

This is a preparatory cleanup for adding the asm/elf.h include in
linux/cpufeature.h, which would otherwise create the following cycle:

linux/pgtable.h -> asm/pgtable.h -> linux/cpufeature.h -> asm/elf.h ->
asm/mmu_context.h -> asm/pgalloc.h -> linux/mm.h -> linux/pgtable.h

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/include/asm/elf.h  | 1 -
 arch/s390/kernel/processor.c | 1 +
 arch/s390/mm/mmap.c          | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index bb63fa4d20bb..e22e3ab25760 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -170,7 +170,6 @@ typedef s390_fp_regs elf_fpregset_t;
 typedef s390_regs elf_gregset_t;
 
 #include <linux/sched/mm.h>	/* for task_struct */
-#include <asm/mmu_context.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index e33a3eccda56..76b2c7478c6e 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -27,6 +27,7 @@
 #include <asm/param.h>
 #include <asm/sclp.h>
 #include <asm/smp.h>
+#include <asm/mmu_context.h>
 
 unsigned long __read_mostly elf_hwcap;
 char elf_platform[ELF_PLATFORM_SIZE];
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index ef7bfc87758c..8206f347e00e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <asm/elf.h>
+#include <asm/pgalloc.h>
 
 static unsigned long stack_maxrandom_size(void)
 {

-- 
2.55.0
