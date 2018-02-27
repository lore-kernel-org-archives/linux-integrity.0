Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46107 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeB0WRa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Feb 2018 17:17:30 -0500
Received: by mail-qt0-f196.google.com with SMTP id m13so528676qtg.13
        for <linux-integrity@vger.kernel.org>; Tue, 27 Feb 2018 14:17:29 -0800 (PST)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 2/2] security: evm: Constify *integrity_status_msg[]
Date: Tue, 27 Feb 2018 19:17:00 -0300
Message-Id: <1519769820-20365-2-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Note: This is compile only tested.
There is no gain from doing this except for some self-documenting.

Signed-off-by: Hernan Gonzalez <hernan@vanguardiasur.com.ar>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 826926d..7a968fa 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -30,7 +30,7 @@
 
 int evm_initialized;
 
-static char *integrity_status_msg[] = {
+static const char * const integrity_status_msg[] = {
 	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
 int evm_hmac_attrs;
-- 
2.7.4
