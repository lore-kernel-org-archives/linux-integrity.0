Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeCGF0h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Mar 2018 00:26:37 -0500
From: Jiandi An <anjiandi@codeaurora.org>
To: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, anjiandi@codeaurora.org
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
Date: Tue,  6 Mar 2018 23:26:26 -0600
Message-Id: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

TPM_CRB driver is the TPM support for ARM64.  If it
is built as module, TPM chip is registered after IMA
init.  tpm_pcr_read() in IMA driver would fail and
display the following message even though eventually
there is TPM chip on the system:

ima: No TPM chip found, activating TPM-bypass! (rc=-19)

Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
built in kernel and initializes before IMA driver.

Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
---
 security/integrity/ima/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 35ef693..6a8f677 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -10,6 +10,7 @@ config IMA
 	select CRYPTO_HASH_INFO
 	select TCG_TPM if HAS_IOMEM && !UML
 	select TCG_TIS if TCG_TPM && X86
+	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
 	help
 	  The Trusted Computing Group(TCG) runtime Integrity
-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
