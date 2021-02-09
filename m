Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B2BC433E0
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Feb 2021 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E640664E54
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Feb 2021 18:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhBISiq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Feb 2021 13:38:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58422 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhBIS1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:27:40 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3AEB20B57A8;
        Tue,  9 Feb 2021 10:22:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3AEB20B57A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894956;
        bh=PnWEGNNzgiW0doZLICdkrW7n+C1gbwjORBQQKJctZn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrWXqrJu4mrjIj8liYoQseEYG4GfDqWnwaW+Yssy+klJObhLv57miFcR25gMZi46I
         mm57QjH2B/vDNBP0grtdG10dOALHAmB3tJqnyTsZfarR0tZxzjg4K0dtl0O3uDmDNB
         nC29DRbE0tz3+FHOP+rrch56nJZvbfR/jHk2tOH0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
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
Subject: [PATCH v17 10/10] arm64: Enable passing IMA log to next kernel on kexec
Date:   Tue,  9 Feb 2021 10:22:00 -0800
Message-Id: <20210209182200.30606-11-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC, if CONFIG_IMA
is enabled, to indicate that the IMA measurement log information is
present in the device tree for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e17351e4f3..8a93573cebb6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1093,6 +1093,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC if IMA
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
-- 
2.30.0

