Return-Path: <SRS0=cxAU=VY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE96C7618F
	for <linux-integrity@archiver.kernel.org>; Sat, 27 Jul 2019 03:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DD5217D9
	for <linux-integrity@archiver.kernel.org>; Sat, 27 Jul 2019 03:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfG0DTG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 26 Jul 2019 23:19:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44670 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DTF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 23:19:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2279272CC6C;
        Sat, 27 Jul 2019 06:19:04 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id CF37B4A4AE8;
        Sat, 27 Jul 2019 06:19:03 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima-evm-utils: Never exit with -1 code
Date:   Sat, 27 Jul 2019 06:19:00 +0300
Message-Id: <20190727031900.7140-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190727031900.7140-1-vt@altlinux.org>
References: <20190727031900.7140-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change main() return code from -1 to 125 as -1 is not really valid exit
code. 125 is choosen because exit codes for signals start from 126.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index d33a91e..e0a835f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2100,6 +2100,8 @@ int main(int argc, char *argv[])
 				break;
 			log_err("%s\n", ERR_error_string(error, NULL));
 		}
+		if (err < 0)
+			err = 125;
 	}
 
 	if (eng) {
-- 
2.11.0

