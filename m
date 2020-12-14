Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9AC2BBD4
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Dec 2020 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612CA224B0
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Dec 2020 19:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440695AbgLNTZh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:25:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58080 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408895AbgLNTTt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:19:49 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4446920B717B;
        Mon, 14 Dec 2020 11:19:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4446920B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973547;
        bh=U9SFoFnrKB6yJdXcKoy5C6qRgYO8WV/9FKB7w82j7vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lstkHkM7GAkBX9SHHbu3rz2wDU9BODPBK/xOATBAi5cc/RB3rO9JLjCvgVcioNeEu
         Wx+3iRyQ1/4lCySHRWqMM4Qhywa7lWcZXKcEau4/p7NLyRgVoyQNXeqpKb8kI5eQTq
         VgMZ5HowLZvlC0WPWoc9sz42yafoDa956eRIMno0=
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v11 1/8] powerpc: Fix compiler warnings and errors
Date:   Mon, 14 Dec 2020 11:18:47 -0800
Message-Id: <20201214191854.9050-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

