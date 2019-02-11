Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFEDC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5655C218D8
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="OVyUnpsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfBKQAI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:00:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40197 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbfBKObq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25-v6so8915994ljk.7
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMY2b0yuZLADsWMepCfTCrgliMG6UcFslUIJuZiM5zw=;
        b=OVyUnpsa/Oq8rmPDNntBJeRK5hj15KI+IQQ0FUvMSYPbHOvBKI/YFoppyZkxRdSu35
         vvbWjzz9RanSA0vEl+I+i8a+7uoq00eZW0I21a5Mn+2Ukjx1gmjj0RWk2mckxDOgIVUQ
         hpaIgtvUvNB+Zp6fE0chytLBaClSVXQurLeYtt6Iq2Iukvjl9LJAM8p9srP8WzByDm3s
         2RVbSunurGHxJChx0HqBPWxvWz+IvEXFgrLl0vRqesoN9MXv3zivwOw+Os4XGGZ/TJFV
         1snaS62I6FVmMjPZrOyB7Dqow26Ey90i6pZAa1YwSZU1y4abgNLfAdvtXEMfVhk3zl31
         pdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMY2b0yuZLADsWMepCfTCrgliMG6UcFslUIJuZiM5zw=;
        b=OE2/Rqz6Xd1XFtSDVgUA4Y8dTeKcLGfE7Q7cXMEKwZ95mpOjuyQBmqCUsYjeQSbA4Z
         I0b61WPoQNJW52kVpxl3jBGoepGQwyvkhu1X3DESQLbKNTVDTrQGEsqqUnOgQ8VerIUC
         sD1IdMEY1Ple0nq2/2awAuOwQs2m/FvSPRPadSf2+dkLusZNWAHa84yVwZXbw5xJvkz+
         IVpllVS1tpo2nf0vnTlc6Ot89o0BiSMU6tJHL7JR+xV6a/TICAgzjCoJv5NF0lI+kzpM
         irLJZplv8Mv2CInjqF+0xdUC6aDb3qxb/DRFZ5eb1YMQ8gbiY/yX1Lf893W3mDFes+Tw
         NhpA==
X-Gm-Message-State: AHQUAuZ6i9Buc5drvGUbTTz+dveEFKznMwWtJEM1P6AhCEY144g2sLjl
        EayfbTjeyrDMgrO8+OqdkSkPbg==
X-Google-Smtp-Source: AHgI3Ia5ScBEaXINb/FbxiIJo7geXhDMU8sTzu85n2SzKfpxAwQjwSfmMdodwFHXuCfkU93bmG13lA==
X-Received: by 2002:a2e:9249:: with SMTP id v9-v6mr4775498ljg.164.1549895504147;
        Mon, 11 Feb 2019 06:31:44 -0800 (PST)
Received: from bsz-kubuntu.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z6sm2322373lfa.87.2019.02.11.06.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:31:43 -0800 (PST)
From:   bsz@semihalf.com
To:     linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, ard.biesheuvel@linaro.org
Cc:     tweek@google.com, mingo@kernel.org, hdegoede@redhat.com,
        leif.lindholm@linaro.org, mw@semihalf.com,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 5/5] efi/arm: Retrieve TPM event log at efi_entry
Date:   Mon, 11 Feb 2019 15:30:52 +0100
Message-Id: <20190211143052.3128-6-bsz@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211143052.3128-1-bsz@semihalf.com>
References: <20190211143052.3128-1-bsz@semihalf.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Bartosz Szczepanek <bsz@semihalf.com>

Add efi_retrieve_tpm2_eventlog() call to ARM efi_entry() function.
There's no reason to assume that TPM2 EFI structures are not available
on ARM architecture.

Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
---
 drivers/firmware/efi/libstub/arm-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..d3af12ec32e4 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -197,6 +197,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
+	efi_retrieve_tpm2_eventlog(sys_table);
 
 	secure_boot = efi_get_secureboot(sys_table);
 
-- 
2.14.4

