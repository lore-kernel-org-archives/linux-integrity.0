Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF94C433E0
	for <linux-integrity@archiver.kernel.org>; Sun, 21 Feb 2021 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066D064DF2
	for <linux-integrity@archiver.kernel.org>; Sun, 21 Feb 2021 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBURuS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 21 Feb 2021 12:50:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45016 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBURuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 12:50:17 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B9C1209FACB;
        Sun, 21 Feb 2021 09:49:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B9C1209FACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613929777;
        bh=uowamsTjjBmMe5j3A2qccc9BUbwhw6V4WJQpcy/trZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9QM+Q0squHzUnX0IO4IAQVIzngh7X4sSHuEbhcajLDTRqrHQ8HYyx72Ww4t1F3su
         yLjl9R5RO1Z0NpBcV7SlqP7yvh2TkfTL4Gwr2raSuAKFpsmpXibdR5FaSiYlz9KTHN
         AKxkOHNDdsspO1JUTPoQfMJnCxIA4mU4kxgkY3l4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, sfr@canb.auug.org.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v19 01/13] kexec: Move ELF fields to struct kimage
Date:   Sun, 21 Feb 2021 09:49:18 -0800
Message-Id: <20210221174930.27324-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ELF related fields elf_headers, elf_headers_sz, and elf_load_addr are
defined in architecture specific 'struct kimage_arch' for x86, powerpc,
and arm64.  The name of these fields are different in these
architectures that makes it hard to have a common code for setting up
the device tree for kexec system call.

Move the ELF fields to 'struct kimage' defined in include/linux/kexec.h
so common code can use it.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/kexec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5f61389f5f36..0208fe8f8e42 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -305,6 +305,11 @@ struct kimage {
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
 #endif
+
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_sz;
+	unsigned long elf_load_addr;
 };
 
 /* kexec interface functions */
-- 
2.30.0

