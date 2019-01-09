Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1DC43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5320883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCqR6TYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfAIBs5 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:48:57 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34610 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAIBs5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:48:57 -0500
Received: by mail-qt1-f202.google.com with SMTP id u32so5313755qte.1
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iol3z4VOW6917X90lpq+9GvwFXobBSIwuijvJwU/GVo=;
        b=KCqR6TYXjFqRpGjBAsfCsCHHiCt/FmvaaXBEEktkQG0/DhjzS326uQkpcgIS7caAQ2
         JztROdy8xB1o7xOWvuN42IjrVubpjFR4SQpOtVdMVt5XPYCpa5oE/6tWCATdJsjbriBJ
         jkuvHkDPyTeTIys6KuDSUfqXyGJ5kV50LUgCx6EQM2pXHf55Cx3sZax4HOaRzgBBx2KI
         bTrMiqiZdN8tcSemVINTDMADJIneIMLaNFhJAd4XHyiwPk588X/zXj//O+8hTd0uXBqI
         fzgylC8Df4Azu/aRtTg5nVZ/fHJc+khR3ynRVsbc5ux8aEPhENVtyP0hMuISCnJ129hM
         PDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iol3z4VOW6917X90lpq+9GvwFXobBSIwuijvJwU/GVo=;
        b=CkyS4oVwsAtLQDfJkI7jjC2F6IYeNZw0kVs2bSIvpRf4weThhM9MzPTA0ANgaezOPW
         c/hFRUhoAqEo6gWulPYtYaIwpkP+cEi58jwvfq9DONiw9QsBZh5RAvRuBSvSH7BJ5K58
         +j3nClxQxjcid8WD06J5aVC/nTaQy2PDPdlhRGXHlONShrzulvHgZR+GxZFIhQOY7z4u
         7te1/K9o7SMp6yP1aJpzFmi6qZLyg0RddKjxUqskp9DcGzxEGDv0Gd9uS5PgdFmXfr9P
         zFAHyoOYET+V8MutjvA7vGSwCY/nggi7b0gPjXauJ5SygfO0j/79MITETfzwjXFAWH2G
         T9TQ==
X-Gm-Message-State: AJcUukfByCWo4xv7i+c5NcXvVMXosxaYDVGnW7JMbqIpfjPORJaijvli
        KIaVtJjRHz9iISoci6YpXAh7ZZ137UnQRYhvw8/I8uee8o/a6Gwd44mRlGQFBiJEschwrSSrk4t
        lq/L+/VhCF/IalE1GqNJoKN97hIT8XNLTKniWHXYRbEKCouFEQr1VuGLpqURf98i+dPs91Awddt
        6PHBxhSvsnNL5phRv6eYY=
X-Google-Smtp-Source: ALg8bN62irfTJAzi0Ay4cuOV3WevwHkNima9DTUXkDKTgn5aQwBYD0yHDuvCEzEb9goDaCF82fIcWvJlyNsq31y0CYjezA==
X-Received: by 2002:a37:d4d4:: with SMTP id s81mr2767451qks.34.1546998535876;
 Tue, 08 Jan 2019 17:48:55 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:43 -0800
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Message-Id: <20190109014847.39980-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190109014847.39980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH 1/5] tpm: Abstract crypto agile event size calculations
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        Matthew Garrett <mjg59@google.com>
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
 drivers/char/tpm/eventlog/tpm2.c | 47 +-----------------------------
 include/linux/tpm_eventlog.h     | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 1b8fa9de2cac..5023f7f284ef 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
 				struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event *efispecid;
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
-	efispecid = (struct tcg_efi_specid_event *)event_header->event;
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
+	return _calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 20d9da77fc11..b43bd2ea8bab 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -121,4 +121,54 @@ struct tcg_pcr_event2 {
 	struct tcg_event_field event;
 } __packed;
 
+static inline int _calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+					struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event *efispecid;
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
+	efispecid = (struct tcg_efi_specid_event *)event_header->event;
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
2.20.1.97.g81188d93c3-goog

