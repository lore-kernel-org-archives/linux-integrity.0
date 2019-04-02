Return-Path: <SRS0=3Dhz=SE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A965C10F00
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97DF20857
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irdhOPyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfDBV4S (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:56:18 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33261 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfDBV4G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Apr 2019 17:56:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id z14so10783597pgv.0
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2019 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2arIsG/tUSBODeVZx7IuFZx2ONfMcieJcM9WtFlfh5Y=;
        b=irdhOPyj25p21xUXEp9WqiYzCS+PN+hSOPVjqRf/1pMl2yr+Srt+K7/1wUPnJoGYm0
         poW3I8ln2Q54tERGmk/Gaeo0mM71hWfqCx0tzpbnwQ59fBDlEMxigRqlQucX31Ybs0jo
         0JgMgAiRNNLxUfqaX35Y/KFntKmR/yBwecK5W7VLhffmD/TZRyfC+XOYhLf/594xGDaw
         MEMwPwsok0sMsLOFuWvrEPl/Kn0NzTWNEC64KgFaoK6z5NmCVZ0GaWaKoQSpRKtjgu3k
         jtX0IGiLHE//Isvb8+5wBdrWS+W+pAFyC3bXafIEseARTrtGQyeGuyKXfpuVG7jrSUHg
         c3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2arIsG/tUSBODeVZx7IuFZx2ONfMcieJcM9WtFlfh5Y=;
        b=hGG3YP1QkSLgB6VAquErqn0Tntul6Tv2VRA9MkffR00NVMg1N2lOSl6qBVkNJxhLpl
         w02Jge5j5Kiv5iuy0fnw/clb5KxurKdL/Hn9rdPWY+lMzYe6nskLkm93ehpgM0zh1dHT
         3Av4187RxXkhGVhucgHcp3N4YBhyE10aT4FYX78/W576QVHxVKizEPan7+b5NHsz1dlL
         spvfjeOlCdQOA6vwIV/2fMgGlY/pYfrYf4KZ7kd85SHjcpQTrQLd3ByUpPrSqR14CjFN
         AXv9y7EI0SQ9b50X8OfbkUADXFFGCh9PWhQqa1MN5XA3EqgH0xaHHNfVdAVDIsH4AJhB
         wbTw==
X-Gm-Message-State: APjAAAWez4v/doMzxd7WhrhcZR/HSrGeZzeto4LcHGJJJYAWoS55R8+o
        asShEGY1lx1xxJ+ZZARBH1An0FIQJRckOEqxKDjrl0rGS/2uXdp3TyRYu0kZE9HvCa93wD97wzM
        VYHjFQBMp780gbAd37XbtAv0bYgr+iL8xAjjHClzpX6LBJ1jeJW3gQNxmVA+gk1Vi1iTAJ8nNYl
        4Xt0Ln9EWPTGpDsNjYKpY=
X-Google-Smtp-Source: APXvYqyDf5uijU2bb1TFP10+0uBx4zXwelGC8AzwFvArYzNvm6TDP60F9adar3mAL+ydsK93+s7oHZ13Yk2FE3z5G7Jrtg==
X-Received: by 2002:a63:7c01:: with SMTP id x1mr1196450pgc.146.1554242165653;
 Tue, 02 Apr 2019 14:56:05 -0700 (PDT)
Date:   Tue,  2 Apr 2019 14:55:55 -0700
In-Reply-To: <20190402215556.257406-1-matthewgarrett@google.com>
Message-Id: <20190402215556.257406-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 1/2] efi: Fix cast to pointer from integer of different size
 in TPM log code
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

8bfcff4a6a1d9d7226bb63a7da758b82d9ab4373 introduced a cast from
efi_physical_address_t to (void *), which are different sizes on 32-bit.
Fix that. Caught by the 0-day test bot.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/libstub/tpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index b6e93e14fcf1..6b3b507a54eb 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -114,8 +114,8 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 			 */
 			last_entry_size =
 				__calc_tpm2_event_size((void *)last_entry_addr,
-						       (void *)log_location,
-						       false);
+						    (void *)(long)log_location,
+						    false);
 		} else {
 			last_entry_size = sizeof(struct tcpa_event) +
 			   ((struct tcpa_event *) last_entry_addr)->event_size;
-- 
2.21.0.392.gf8f6787159e-goog

