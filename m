Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9AC55ABD
	for <linux-integrity@archiver.kernel.org>; Fri, 13 Nov 2020 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C278722259
	for <linux-integrity@archiver.kernel.org>; Fri, 13 Nov 2020 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HpZNGZDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMTWu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 13 Nov 2020 14:22:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48824 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMTWu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:50 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E5D1D20C28BA;
        Fri, 13 Nov 2020 11:22:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5D1D20C28BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295369;
        bh=uej5A9Bt/DcEbGvxCXLB2iLdqfL43rb052LPiyeGlyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpZNGZDgo70gTzk7yw/Jp8K8eSSU+pZ2Hl7QhOxMV57mcLGgDcIBhoinL/8ZBfJCE
         ALwkTFTmtmR9N2laCHq/R0l6l3s8cGTXAh2uef1CBIHYJ5YNThe3QuOquEglOf5gCJ
         1+q5zZQdVDnEKD0cZ0GyAJDTO08/z7mmG3c+W/BM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v9 1/8] powerpc: fix compiler warnings and errors
Date:   Fri, 13 Nov 2020 11:22:36 -0800
Message-Id: <20201113192243.1993-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The function prototype for the functions defined in ima.c for powerpc
are given in the header file ima.h. But this header file is not
included in ima.c resulting in compilation errors such as given below.

arch/powerpc/kexec/ima.c:56:5: error: no previous prototype for 'ima_get_kexec_buffer' [-Werror=missing-prototypes]
   56 | int ima_get_kexec_buffer(void **addr, size_t *size)
      |     ^~~~~~~~~~~~~~~~~~~~

The function parameters for remove_ima_buffer() and
arch_ima_add_kexec_buffer() are not described in the function header
resulting in warnings such as given below.

arch/powerpc/kexec/ima.c:111: warning: Function parameter or member 'fdt' not described in 'remove_ima_buffer'

Include ima.h in ima.c for powerpc. Describe the function parameters for
remove_ima_buffer() and arch_ima_add_kexec_buffer().

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/ima.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..a36c39db4b1a 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
+#include <asm/ima.h>
 
 static int get_addr_size_cells(int *addr_cells, int *size_cells)
 {
@@ -103,6 +104,9 @@ int ima_free_kexec_buffer(void)
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
  * The IMA measurement buffer is of no use to a subsequent kernel, so we always
  * remove it from the device tree.
  */
@@ -131,6 +135,10 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
  *
+ * @image: kimage struct to set IMA buffer data
+ * @load_addr: Starting address where IMA buffer is loaded at
+ * @size: Number of bytes in the IMA buffer
+ *
  * Architectures should use this function to pass on the IMA buffer
  * information to the next kernel.
  *
-- 
2.29.2

