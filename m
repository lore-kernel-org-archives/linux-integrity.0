Return-Path: <SRS0=cQvz=YL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62320CA9EA9
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353F21852
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436810;
	bh=Jrncc+KwxtewoaMxgGEJEbpoZW9yORUclvwsXtwbsCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iydeybYc/mUtKGTFgZUa46vPpM3gz0vVvTv12h9iKecOTU7Bh3lvCIAHD9nu1bhw2
	 UQaRArBMRuCQ45F1NY86o14RVRKUv7MMHodbE4dYvAbBraSVG9So8Lde6+uPa2Ee00
	 dHvOzNGZ956SPIEdHomu2NRs9Ad9jsPSOh2xsLv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbfJRWJx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389373AbfJRWJw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4129F222D4;
        Fri, 18 Oct 2019 22:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436592;
        bh=Jrncc+KwxtewoaMxgGEJEbpoZW9yORUclvwsXtwbsCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwCdpmlc2FQSRURtRvOLY4ZsQ3aPHfajEn+JcVLL/T0gm/SfBjqOhWAsg9OcjgrLj
         ugQf83qJ4iu7cSi1OghBnZQjTD4Qtt038f75hXn1GlshYXUO4JMVw1RsK8GUVKCfjw
         MTrs6DOj4emIAMVTcEO6XtFhAJN3MwAU0LlX5uzE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 18/29] efi/x86: Do not clean dummy variable in kexec path
Date:   Fri, 18 Oct 2019 18:09:09 -0400
Message-Id: <20191018220920.10545-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

[ Upstream commit 2ecb7402cfc7f22764e7bbc80790e66eadb20560 ]

kexec reboot fails randomly in UEFI based KVM guest.  The firmware
just resets while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of the efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode() is not necessarily
a good place to clean a dummy object.

Drop the efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Matthew Garrett <mjg59@google.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Talbert <swt@techie.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Link: https://lkml.kernel.org/r/20191002165904.8819-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a0e85f2aff7d8..b6669d326545a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -896,9 +896,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
-- 
2.20.1

