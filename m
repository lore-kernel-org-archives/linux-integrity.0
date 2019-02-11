Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B99C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D076621855
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dS7Ow6zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBKVz0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:55:26 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38688 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKVz0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 16:55:26 -0500
Received: by mail-pg1-f201.google.com with SMTP id j32so351822pgm.5
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I+VeB8Az+Nocvg6+eguQHP0NYSyK5E4i4ZWwGITtlnM=;
        b=dS7Ow6zrMtgmOumI0y7BtR0vuOBMzwDLuOU5gwtTfUSAqmgr+sVQ6ki08ypC/5Aktm
         cGVatq1Vjg5YuPj/nfl8s8KRgwDFP4SYaDxiNFl7csMpWYh6LwrqwKPM5SvoYEM9q0i4
         yKYKgCehNWxufQSM9iIV1/YSUeuToz+/PHhuVdWQVqZvpntf83wxzunW0wg/UEmt4vwH
         /e4BqLu9EvINwFe233/sCf3xZycxKG/SDPxINrhxGsguyLs6TkxJcZdld3ZGYfup20aD
         pqY0br/dZXkrBzhuvYVvfXqtktJiaxLrjB72qupELDb6KhSz2ijKx8AwslWG6XEFdQ74
         rS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I+VeB8Az+Nocvg6+eguQHP0NYSyK5E4i4ZWwGITtlnM=;
        b=hA9vrWTXzJocmJLFJMrP0rbtkT4+jLEOIZabmVNwODSCg9wQhUfFJw08dXIRF7Te55
         yKav2moRK3mWrAYoi47LFGLUA31nN7Afp/F4YN0qO2pUBLOdmd38YkV3XWsu+jBvJ1Kc
         Mr+jv6jcdThshLKLCnx3K/2YrT8RRaN1ngZLWMlzf6XUAzTE/52ho+xVYjt25Z99N80/
         wCniQSU8KKTwWsL56/ozFqBlKB6wqp7uZTo2H+nzRiaEsy2JvRnbuZ7KcIXRQZonJO4k
         mC3z6LGAjOJUIp8jooMQ5lg5PsVIsEVJOKeUSeu7KboxxXinqV0rtcl8OTtxRmYVQzra
         slVg==
X-Gm-Message-State: AHQUAuZDwUunM4ThTQhpFFMZUJo8XYk7q5DRvoqD0CgvUOU1WVT5iz/3
        +C0PT439rw2axdtnjNuuhrYkeQZ+eKsLVD9sk1VX5jtoVc0glOEBPuaThUHESgCXn3f58JoaMQv
        1w3bRBSbxUx8wrOJIYl62zwrNEgjCu/WJFkmAPBykFN7n2+BLuHG7CUI9iaHKObXdNBhUOWGcS2
        RIogZhB0YracYaCWVrGcU=
X-Google-Smtp-Source: AHgI3IZSC+p/peaZj123P0ZdOVKAi2jQglhhu1PIloaTnI7Sn7p0ojukSEhHNisg1XvluQ+XoDCm88hrM1xu9kxKny3yrw==
X-Received: by 2002:a63:618b:: with SMTP id v133mr217321pgb.34.1549922125248;
 Mon, 11 Feb 2019 13:55:25 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:55:15 -0800
In-Reply-To: <20190211215518.81419-1-matthewgarrett@google.com>
Message-Id: <20190211215518.81419-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190211215518.81419-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH V3 1/4] tpm: Abstract crypto agile event size calculations
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

We need to calculate the size of crypto agile events in multiple
locations, including in the EFI boot stub. The easiest way to do this is
to put it in a header file as an inline and leave a wrapper to ensure we
don't end up with multiple copies of it embedded in the existing code.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 47 +---------------------
 include/linux/tpm_eventlog.h     | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index d8b77133a83a..dc12e1cbd03a 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static int calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event_head *efispecid;
-	struct tcg_event_field *event_field;
-	void *marker;
-	void *marker_start;
-	u32 halg_size;
-	size_t size;
-	u16 halg;
-	int i;
-	int j;
-
-	marker = event;
-	marker_start = marker;
-	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
-		+ sizeof(event->count);
-
-	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
-
-	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
-
-	for (i = 0; i < event->count; i++) {
-		halg_size = sizeof(event->digests[i].alg_id);
-		memcpy(&halg, marker, halg_size);
-		marker = marker + halg_size;
-		for (j = 0; j < efispecid->num_algs; j++) {
-			if (halg == efispecid->digest_sizes[j].alg_id) {
-				marker +=
-					efispecid->digest_sizes[j].digest_size;
-				break;
-			}
-		}
-		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
-	}
-
-	event_field = (struct tcg_event_field *)marker;
-	marker = marker + sizeof(event_field->event_size)
-		+ event_field->event_size;
-	size = marker - marker_start;
-
-	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
-	return size;
+	return __calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 81519f163211..6a86144e13f1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,4 +112,72 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+/**
+ * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
+ * @event:        Pointer to the event whose size should be calculated
+ * @event_header: Pointer to the initial event containing the digest lengths
+ *
+ * The TPM2 event log format can contain multiple digests corresponding to
+ * separate PCR banks, and also contains a variable length of the data that
+ * was measured. This requires knowledge of how long each digest type is,
+ * and this information is contained within the first event in the log.
+ *
+ * We calculate the length by examining the number of events, and then looking
+ * at each event in turn to determine how much space is used for events in
+ * total. Once we've done this we know the offset of the data length field,
+ * and can calculate the total size of the event.
+ *
+ * Return: size of the event on success, <0 on failure
+ */
+
+static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+					 struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_event_field *event_field;
+	void *marker;
+	void *marker_start;
+	u32 halg_size;
+	size_t size;
+	u16 halg;
+	int i;
+	int j;
+
+	marker = event;
+	marker_start = marker;
+	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
+		+ sizeof(event->count);
+
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+
+	/* Check if event is malformed. */
+	if (event->count > efispecid->num_algs)
+		return 0;
+
+	for (i = 0; i < event->count; i++) {
+		halg_size = sizeof(event->digests[i].alg_id);
+		memcpy(&halg, marker, halg_size);
+		marker = marker + halg_size;
+		for (j = 0; j < efispecid->num_algs; j++) {
+			if (halg == efispecid->digest_sizes[j].alg_id) {
+				marker +=
+					efispecid->digest_sizes[j].digest_size;
+				break;
+			}
+		}
+		/* Algorithm without known length. Such event is unparseable. */
+		if (j == efispecid->num_algs)
+			return 0;
+	}
+
+	event_field = (struct tcg_event_field *)marker;
+	marker = marker + sizeof(event_field->event_size)
+		+ event_field->event_size;
+	size = marker - marker_start;
+
+	if ((event->event_type == 0) && (event_field->event_size == 0))
+		return 0;
+
+	return size;
+}
 #endif
-- 
2.20.1.791.gb4d0f1c61a-goog

