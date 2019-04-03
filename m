Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8CC4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D542133D
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 19:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usTJOsXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCTcn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:32:43 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46730 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCTcn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 15:32:43 -0400
Received: by mail-yb1-f202.google.com with SMTP id w7so11973ybp.13
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h6Y/7Y8GsseFaZqhMVhdlsOA3NmSGXnyRKbOkLq8Y1U=;
        b=usTJOsXP4E7YXp0ic2Tbpwtcb9nSTKFWYTMZrNYM76W58rvducAbcZOLvP3LyKDAdQ
         o3ezbq/h4iUUzcY9vNsxzus5gdfLoFhwPQlfoO8bGm7SefcoSsJUdseC77eRLHgTquOj
         c2OAyI2d/vV9bOHX69gP6+nvX13QCzXhQKTQ21Bx1ixUsjdom8uXxDErssOI+4FlURHL
         LhPAy3r3cAFae86K+6X/AVP6TU6cWb9zbXKgjbHZKxfjqNKBJvB+GabxqqjUypxDiKpi
         mS1+m0pH4yfenDvPhasmpd9fwnyNktpTroQT+kteNoP61ZauEcayyXmRwHLHbSvFnzvY
         xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h6Y/7Y8GsseFaZqhMVhdlsOA3NmSGXnyRKbOkLq8Y1U=;
        b=lV79GViGxGHZ4UssnAoLgox6Rr/hCKdu+6ZQPn53rgafe23KZkLvf8Dpse0QpEorl0
         iznBX3QxLQHTkl1UdVDXMarQRVG+NbpLlgnsOKIsbYe4/nns/4OpF3/I8IHPaNR3MDne
         ECjIYop3+CRPSDqIL3Tl0j6xOUC6Am/holCTOqHky2XVmWlaBy2GgIq+tIcuX0Nr8fvo
         K4JfYqeco+lr7ZZY6mYBLiqJIn4DdGsvNXJkCzOOMXviRSkCSxsxZR+YQAUKn6nKmS5S
         c/fUE0Gz7XHLpIDhyFWxG48iSYB+pdq+Kl54iUYSG430USaIt4oYWOuObcyM97fe4AKq
         KJIw==
X-Gm-Message-State: APjAAAXb+aiBc3DC6W4s5SyPt6YGfIHAMpKyZnp61jR0nboa8oaHvlyP
        7skWO5GOrXPQTfi8mYkWhW/DSJxR2zIkG7P1KD11VYHUrbbPSysCh8O0OF6o9B9lzui9q3NH80I
        //X6DkgO/il6bpzq5yh8nQZIJoJE7jbpZ19SpiOmeojz1Wbs8CAAVsIYPCwZAQu1ubu+/mxnzop
        cd3I5TUaJQsIue0FV7xNc=
X-Google-Smtp-Source: APXvYqx3mK+sSYpLvwl1JEgFUVPgKdzbhMR5OMoW0hjIucTjbFZEL8oto5sPQDdbTNx94YyHcIAd3Ntbj8gmOBV7lTC9Ig==
X-Received: by 2002:a25:d995:: with SMTP id q143mr431380ybg.88.1554319962870;
 Wed, 03 Apr 2019 12:32:42 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:32:37 -0700
Message-Id: <20190403193238.145204-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] efi: Include tpm_eventlog.h after asm/efi.h to avoid memcpy breakage
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        tweek@google.com, Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

769a8089c1fd2 (x86, efi, kasan: #undef memset/memcpy/memmove per arch)
disables the KASAN version of certain memory calls in the EFI boot stub.
tpm_eventlog.h references memcpy, so must be included after asm/efi.h in
order to allow 769a8089c1fd2 to take effect on its declarations.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/libstub/tpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index b6e93e14fcf1..777c1e82495a 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -8,9 +8,11 @@
  *     Thiebaud Weksteen <tweek@google.com>
  */
 #include <linux/efi.h>
-#include <linux/tpm_eventlog.h>
 #include <asm/efi.h>
 
+/* Must be included after asm/efi.h in order to avoid using the wrong memcpy */
+#include <linux/tpm_eventlog.h>
+
 #include "efistub.h"
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
-- 
2.21.0.392.gf8f6787159e-goog

