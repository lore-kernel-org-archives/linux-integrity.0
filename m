Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515CC433E0
	for <linux-integrity@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BC5206D4
	for <linux-integrity@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbhAORbq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:31:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56856 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbhAORbp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 12:31:45 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 687B420B6C48;
        Fri, 15 Jan 2021 09:30:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 687B420B6C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610731830;
        bh=axPbEa6PnZm+iW25Zsi9IlEECBFRe6hBfmO2Ulu9IEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jf5B9mbOV5Z9FseEFixwYoYT/sNPZ5VkfqSOIKX7Wxxb9AhFYZty+z0EHderu5hsO
         Q0FbrBbSam7UfegH2wIKa7xQINuS9tmb0xkcOkg9PB81roGo2LGW+AA3EgUIL3fqq2
         0nNAIysgt1rH6iOnFkvlf9vgxHXlYh1eXm2WkQ5E=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
Date:   Fri, 15 Jan 2021 09:30:16 -0800
Message-Id: <20210115173017.30617-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115173017.30617-1-nramas@linux.microsoft.com>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

create_dtb() function allocates kernel virtual memory for
the device tree blob (DTB).  This is not consistent with other
architectures, such as powerpc, which calls kmalloc() for allocating
memory for the DTB.

Call kmalloc() to allocate memory for the DTB, and kfree() to free
the allocated memory.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7de9c47dee7c..51c40143d6fa 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->arch.dtb);
+	kfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
 	vfree(image->arch.elf_headers);
@@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
 			+ cmdline_len + DTB_EXTRA_SPACE;
 
 	for (;;) {
-		buf = vmalloc(buf_size);
+		buf = kmalloc(buf_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
 		/* duplicate a device tree blob */
 		ret = fdt_open_into(initial_boot_params, buf, buf_size);
-		if (ret)
+		if (ret) {
+			kfree(buf);
 			return -EINVAL;
+		}
 
 		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
 					     initrd_len, cmdline);
 		if (ret) {
-			vfree(buf);
+			kfree(buf);
 			if (ret == -ENOMEM) {
 				/* unlikely, but just in case */
 				buf_size += DTB_EXTRA_SPACE;
@@ -217,6 +219,6 @@ int load_other_segments(struct kimage *image,
 	return 0;
 
 out_err:
-	vfree(dtb);
+	kfree(dtb);
 	return ret;
 }
-- 
2.30.0

