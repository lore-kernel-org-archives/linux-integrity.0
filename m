Return-Path: <SRS0=opix=UY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49FC48BD6
	for <linux-integrity@archiver.kernel.org>; Tue, 25 Jun 2019 20:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333CE2086D
	for <linux-integrity@archiver.kernel.org>; Tue, 25 Jun 2019 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561493636;
	bh=+A8kslJHW27NDdIFi7+iCBJaMHuSt9MpoOrdUYPdCYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YOqiNH+0Ag7ejYw1e5IiF8j/OzCfNcS3DBrWu1WqoZ/xfJuLaFNF+UmFVuBkIPrqI
	 e0VD/GI1cFGT0lz/Pntmvcx+K0Ya2a0emX+FZuWK7BvdFsBI0Pdp1O7TixoQgX16pk
	 /uxDOvKrx6pw9FDXKXibJCF6HOjtOa/mwJaWrlio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFYUNu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfFYUNu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 16:13:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.24.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067F4208E3;
        Tue, 25 Jun 2019 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561493629;
        bh=+A8kslJHW27NDdIFi7+iCBJaMHuSt9MpoOrdUYPdCYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMCLl0PFhJPyATqhiS/MBnteSDZoFOtFe/8PptE6znBX92m3v8uZXSrNAxTvMYnKH
         bdR+H4HmyIcDHrwqFYISVEt6I6k3JXcKWI9ORFLtCmCvVzEsTMjkwgRA9ULXgn+aFh
         AP7om9XgDfvXBC7XblRLKcAGUgZkn35wj2eUyD7Q=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v7 2/2] fTPM: add documentation for ftpm driver
Date:   Tue, 25 Jun 2019 16:13:41 -0400
Message-Id: <20190625201341.15865-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625201341.15865-1-sashal@kernel.org>
References: <20190625201341.15865-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds basic documentation to describe the new fTPM driver.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/security/tpm/index.rst        |  1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..15783668644f 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -4,4 +4,5 @@ Trusted Platform Module documentation
 
 .. toctree::
 
+   tpm_ftpm_tee
    tpm_vtpm_proxy
diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
new file mode 100644
index 000000000000..48de0dcec0f6
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
@@ -0,0 +1,31 @@
+=============================================
+Firmware TPM Driver
+=============================================
+
+| Authors:
+| Thirupathaiah Annapureddy <thiruan@microsoft.com>
+| Sasha Levin <sashal@kernel.org>
+
+This document describes the firmware Trusted Platform Module (fTPM)
+device driver.
+
+Introduction
+============
+
+This driver is a shim for firmware implemented in ARM's TrustZone
+environment. The driver allows programs to interact with the TPM in the same
+way they would interact with a hardware TPM.
+
+Design
+======
+
+The driver acts as a thin layer that passes commands to and from a TPM
+implemented in firmware. The driver itself doesn't contain much logic and is
+used more like a dumb pipe between firmware and kernel/userspace.
+
+The firmware itself is based on the following paper:
+https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
+
+When the driver is loaded it will expose ``/dev/tpmX`` character devices to
+userspace which will enable userspace to communicate with the firmware TPM
+through this device.
-- 
2.20.1

