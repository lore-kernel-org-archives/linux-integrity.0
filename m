Return-Path: <SRS0=uUqS=3M=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3BC33CAA
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jan 2020 07:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D151424125
	for <linux-integrity@archiver.kernel.org>; Thu, 23 Jan 2020 07:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWHtA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:49:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:37324 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWHtA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 02:49:00 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuXEX-000687-Gt; Thu, 23 Jan 2020 10:48:57 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/2] tpm2_bios_measurements_next should increase position
 index
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <3ffb1a2b-261f-7108-192a-d674e8db1244@virtuozzo.com>
Date:   Thu, 23 Jan 2020 10:48:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index b9aeda1..e741b11 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -94,6 +94,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	size_t event_size;
 	void *marker;
 
+	(*pos)++;
 	event_header = log->bios_event_log;
 
 	if (v == SEQ_START_TOKEN) {
@@ -118,7 +119,6 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	if (((v + event_size) >= limit) || (event_size == 0))
 		return NULL;
 
-	(*pos)++;
 	return v;
 }
 
-- 
1.8.3.1

