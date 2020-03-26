Return-Path: <SRS0=kYbS=5L=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D043C43331
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Mar 2020 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5877020787
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Mar 2020 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAbjomba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZQ1f (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:27:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44589 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQ1e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Mar 2020 12:27:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so8518862wrw.11
        for <linux-integrity@vger.kernel.org>; Thu, 26 Mar 2020 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUae3Te9riZOBIxfGA3qHc809fSKi8eiW5NIMmtWsyI=;
        b=FAbjombajR+rLaFUaNHhSR7Aeyv8DGJucgaN6JZAl1pIDtDmPJxwaMegbT8ngPnEql
         B+kOcaCwJ5M8CQGnjxseNO/0Ne5pfsMjbW86Xr6MvNHr6fR2BQCVnl+o8b0DTWcP5xVp
         GV2YKnf0PmCRfJZbmMaiHSx3fWIgzs5YSBiAO4ZESg16nAFB73FGwz/swRwW4t71pyPe
         czRzMc71CJeOeZcI0I7F7KhYVvdMxNkjivL6PKAHkkPIkGAz1AChPFBUv+/H47H6A4bn
         SuzVRd9z+BcCks/hw0JYjrcqbRymv7VGLcS3ZMTF6FoqWBuXS1CrxBjwc/l+KhEC1Gk7
         MboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUae3Te9riZOBIxfGA3qHc809fSKi8eiW5NIMmtWsyI=;
        b=iZ3sM1PqH/GnTGIM/YqsedA4QrRfAycLVbxtO4U0TJxEQ/IOhR0szgvai0dh2FiQgm
         b7/TEkV0cAPdbxInMlgc24jHOgfURXa03NgUGeynIK9RY8xQhBg29eK6XpI5qqHc6EjT
         UZZB00ApgwN2aj07QCCbUtewH+Ht9dsQZfESCCg/3mErg1RLE62E1Z8nOSqBPI2HetAl
         8yNDuXjbUZb2l2SC68IvyeXOieZF2voqJVgLFZPvCSrLgYLWcAHEYMHpSxtL8cr/3G22
         KxX23NVcLBNpGFeVjSrgLyjdHjNs5NnXlyLFRpmA8wv7tBDpQ2BXraSol4MaPP+jYG6y
         9/1Q==
X-Gm-Message-State: ANhLgQ0pTMOPREyO8LOwTs7h0zpUoUrojCj3J1S/waoHkW95w/uVjXhJ
        jBFfO/hwKCTG0VljQMkSC+C4iUPj7/E=
X-Google-Smtp-Source: ADFU+vsJx75Zaywe+7XKpusGT8RabTr0G893p86EReNWBWnCv4uVk6+spAtyGs43qab7RtsbxknFCg==
X-Received: by 2002:adf:916f:: with SMTP id j102mr9768788wrj.335.1585240052167;
        Thu, 26 Mar 2020 09:27:32 -0700 (PDT)
Received: from lothlann.rup.mentorg.com (nat-min.mentorg.com. [139.181.32.34])
        by smtp.gmail.com with ESMTPSA id n2sm3973192wrr.62.2020.03.26.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:27:30 -0700 (PDT)
From:   dbaryshkov@gmail.com
To:     linux-integrity@vger.kernel.org
Cc:     Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] evmctl: support verification of portable EVM signatures
Date:   Thu, 26 Mar 2020 19:27:23 +0300
Message-Id: <20200326162723.3716670-1-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

EVM signature code checked explicitly checked for signature type to be
EVM_IMA_XATTR_DIGSIG (0x03). Allow it to be either EVM_IMA_XATTR_DIGSIG
or EVM_XATTR_PORTABLE_DIGSIG.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b02be8b1507a..b3f6f65523ef 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -824,7 +824,7 @@ static int verify_evm(const char *file)
 		return len;
 	}
 
-	if (sig[0] != 0x03) {
+	if (sig[0] != EVM_IMA_XATTR_DIGSIG || sig[0] != EVM_XATTR_PORTABLE_DIGSIG) {
 		log_err("%s has no signature\n", xattr_evm);
 		return -1;
 	}
-- 
2.25.1

