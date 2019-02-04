Return-Path: <SRS0=H4GS=QL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9072C282C4
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BA2082E
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtFl+2QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfBDVdM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:33:12 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:53027 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBDVdM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Feb 2019 16:33:12 -0500
Received: by mail-it1-f202.google.com with SMTP id o205so2212492itc.2
        for <linux-integrity@vger.kernel.org>; Mon, 04 Feb 2019 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/tnYts0JET+2W8zZ9xSXJp/BiKM0JyyiMHvrhuDlP7E=;
        b=FtFl+2QOD3oJrwhFFbDYRd8jM6d9+9+RrAUp/Ay7shaZEXOcLXMmjK/Np10mEDNLat
         /zuRKsE5UaBoMpq+KqIbd93IuaXr4LoPxF23NecbwbukJ2VuTy+/shoV4EkM9ORDpZAv
         Zq4Ov48YWzLDhTw9U/xoYygtduCsBVfyJfLmDoTFtrTXs3YvtNuDgUst4rxPBIdHGbuf
         IR0FOgswS5kHJHq0pdNp9dfVtt0cuQ0ZgwarTGkhCqWojJvsbzuvRtDaHBetdgXbDvCe
         992DDSenL768CZSBZQ5L94msEaLIcTv8uqxlrWJdG0CYA3CRNRBenHqqoPvSjO67Cas+
         hiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/tnYts0JET+2W8zZ9xSXJp/BiKM0JyyiMHvrhuDlP7E=;
        b=hdvbn9963HBYaKLmNRKTz/F91L4IpwfEOJA6Dp0Cv46CqTqE9a1NdLDEOEnsf+060r
         d/lWTyjE2tCQruT53nF8+SdSAs9itdbSSCHCXWfnfvBwxiixV7dwVJ24aqndGhcbqQIX
         GCxS52V1hRhWbDpA8u+MlIWAzjeibqqTDc+SoAYxwAqRpvEad1isewCMXRStQUUeBEjq
         BK748oL1bhFVfTtLwtv8VfXOf2ezM78Qrh+8s50HccGT637GT1xjvdN1AvWqGVIhjs/X
         7E/Mkeq9vjA5/eeLaDIWSx1uWw5DYkzqXmwEpymvn4c/lwRDKyqFdcTOkLBvtwS5CrTa
         /peQ==
X-Gm-Message-State: AHQUAuZOn1FNZCij2PiY0cFJfPiaUDo1WJAqzDbPYIXI5Mirw80TJsdq
        F1Eo2coYaJhgePPzp0kmKwFXK1b4Vt6qTx1ZTujzO29ikm0G8FYY2rk55At0FW1OxWG3pymSg46
        7gWqV0nRAC2iCEHJKDItqEyS4PpaQXl/4Y+GnQLu1c6GP8OqwpkMZLSUMWPGyOQB79SfonY2JhN
        yfSmBhoRxAVy30S1978gM=
X-Google-Smtp-Source: AHgI3IYUtt029r/Rp1FFNGkiLE0xql+JhEs8rdVNuTAMfsRJatmgjC+BL9YwePi3w/MiXKzf9fAHtTJK2Iy6UkSRv/fPxg==
X-Received: by 2002:a24:4e83:: with SMTP id r125mr954896ita.6.1549315990927;
 Mon, 04 Feb 2019 13:33:10 -0800 (PST)
Date:   Mon,  4 Feb 2019 13:33:00 -0800
In-Reply-To: <20190204213303.131064-1-matthewgarrett@google.com>
Message-Id: <20190204213303.131064-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190204213303.131064-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH V2 1/4] tpm: Abstract crypto agile event size calculations
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
 drivers/char/tpm/eventlog/tpm2.c | 47 +-----------------------------
 include/linux/tpm_eventlog.h     | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index d8b77133a83a..89a8b1c10939 100644
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
+	return _calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 81519f163211..b1b8350c238f 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,4 +112,54 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+					struct tcg_pcr_event *event_header)
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
2.20.1.611.gfbb209baf1-goog

