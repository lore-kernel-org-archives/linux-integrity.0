Return-Path: <SRS0=Ujs8=BB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E9BC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97279206F5
	for <linux-integrity@archiver.kernel.org>; Wed, 22 Jul 2020 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGVKwJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:52046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgGVKwJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 06:52:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D669ACDB;
        Wed, 22 Jul 2020 10:52:15 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils v2] pcr_tss: Fix compilation for old compilers
Date:   Wed, 22 Jul 2020 12:52:02 +0200
Message-Id: <20200722105202.32507-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

pcr_tss.c: In function 'pcr_selections_match':
pcr_tss.c:73:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < a->count; i++) {
  ^
pcr_tss.c:73:2: note: use option -std=c99 or -std=gnu99 to compile your code
pcr_tss.c:78:3: error: 'for' loop initial declarations are only allowed in C99 mode
   for (int j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
   ^

Fixes: 03f99ea ("ima-evm-utils: Add support for Intel TSS2 for PCR
reading")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
Add also j

 src/pcr_tss.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/pcr_tss.c b/src/pcr_tss.c
index 11b247b..feb1ff7 100644
--- a/src/pcr_tss.c
+++ b/src/pcr_tss.c
@@ -68,14 +68,17 @@ int tpm2_pcr_supported(void)
 
 static int pcr_selections_match(TPML_PCR_SELECTION *a, TPML_PCR_SELECTION *b)
 {
+	int i, j;
+
 	if (a->count != b->count)
 		return 0;
-	for (int i = 0; i < a->count; i++) {
+
+	for (i = 0; i < a->count; i++) {
 		if (a->pcrSelections[i].hash != b->pcrSelections[i].hash)
 			return 0;
 		if (a->pcrSelections[i].sizeofSelect != b->pcrSelections[i].sizeofSelect)
 			return 0;
-		for (int j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
+		for (j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
 			if (a->pcrSelections[i].pcrSelect[j] != b->pcrSelections[i].pcrSelect[j])
 				return 0;
 		}
-- 
2.27.0

