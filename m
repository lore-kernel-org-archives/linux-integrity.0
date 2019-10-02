Return-Path: <SRS0=/H73=X3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D33C352AA
	for <linux-integrity@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F421D81
	for <linux-integrity@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzK2Kr+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfJBREF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:04:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35650 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfJBREB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:04:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so7752684wmi.0
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ba3w9kcbGuMtfRQk+/aw/wvXJx7RCk+NpcTgMqWmzhU=;
        b=wzK2Kr+8eqFEvQyxP/6nAjwnHPAGzZ8Pr5KF1g4HtEl208yl3hYOPNrU07OMhhzVWi
         MJKwplxNEH4QgfCZUR4dvDzREYAmCwTg8QcRqVIc+N86yPlchCpdJwH64aDYPis9zk8m
         TdMyTqaPHvXe6DL+R17NO7Ew8ajZCG6HeEYnB+26TI7BCFOg37ZX69Ifm9cCZnNvptFv
         dh27JTl0lOOYsJXWAQYHiDsnQ/ysVdZ3EghjNhZgsmHbWK3V+X6gAGNnlR3zit/Lp1L8
         mebYi0KthRj672fvFN5LuLKZYDX6z4czZY0Slv+AbT5SR4PFSvdKM/FhltbeInqz6vfK
         msew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ba3w9kcbGuMtfRQk+/aw/wvXJx7RCk+NpcTgMqWmzhU=;
        b=SP0fKEqkZs2W1yRE31BH8KNiQAfkyyVRNor0049y49l/xqXHux7PK9v7QWt/QJ54aT
         2jWvRhfJnqfgwb64lmMao3nZJa6rQZ85JbevHnx/XGsr5WuhmiZDLLwLpVWFimEV94c1
         a29uaZPixSOl10dau+RI8UpwvvgPgUyUFHt4GKVbCmZqUKBcb/NczVt1OfjmtzV0lnWj
         i/afCtFMHvo2smmPWmzaa5i6SuIxfZuFgkMYF8tsT69MTuZLGH0S828/LJklfKOXzun+
         IqkTXbZ2+LefQWDtk+iol3JP66Q2bR5EbZZUgRLfC7nqi2534vitfU7A0do4VeD9htdW
         7Vfw==
X-Gm-Message-State: APjAAAWfrTJ67t9RZipASv3SX/Q2KlHEKCWXoJ6LTiYzbgJMCimLLpmE
        bKJ+uRkO18OIyjrCv5qKCu+WbA==
X-Google-Smtp-Source: APXvYqwXbGLwgYQFbrU4EXNJ7vjxZWidobcE/CUTFY2F3Qa/HMp0yBUXkU17d/wY4mHe9PxlJXUcgw==
X-Received: by 2002:a05:600c:2115:: with SMTP id u21mr3610780wml.168.1570035839244;
        Wed, 02 Oct 2019 10:03:59 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:58 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 7/7] efi/x86: do not clean dummy variable in kexec path
Date:   Wed,  2 Oct 2019 18:59:04 +0200
Message-Id: <20191002165904.8819-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

kexec reboot fails randomly in UEFI based kvm guest.  The firmware
just reset while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
a good place to clean dummy object.

Drop efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index c202e1b07e29..425e025341db 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -917,9 +917,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
-- 
2.20.1

