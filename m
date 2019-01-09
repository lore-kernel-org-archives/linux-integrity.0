Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C293C43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A720883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2ZP30NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAIBs7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:48:59 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:38420 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAIBs7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:48:59 -0500
Received: by mail-it1-f201.google.com with SMTP id m128so5671268itd.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DxFYq024RVahqsE1uVuvS4sennzmufeMEdvNHXpV1Oc=;
        b=k2ZP30NCH1/Y0TGsgterb+QaUKKqR10YxI5Ny4VmLRkUfL5dcpujqU3snzMejNldRn
         oBturH2r4W2GJvjBK3TJtHAHjFDRGR37VBPadjxwjIKENjI8pswfZGjdOfr0uYTndQmw
         U73MJDj8Q1mj+BmkB/xvUU6Pn6p+RTWitMjB3xHWSW7eUlWusLw9rfofbwZz7IB4iXkJ
         DfxnGxAR6PbLtyBvF3KGmzULfz2ZqMAMvQtsu5uAPR0ny5+d5gXsYKlyPkmoMh1bTZJc
         3atiWgqlOELNOjjBCePRXqIBxFm9RsknBqdyO5QzZx+4/lPmA+79VurVmFLHaH5CzLSb
         Goqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DxFYq024RVahqsE1uVuvS4sennzmufeMEdvNHXpV1Oc=;
        b=kaRszFP56JvwqFBc9onlJ/U+NLOFoG5Q/i8Gc3ntZZ4EvvPSDMzgWm8+eCZcOamwzG
         5yJoivbJ0InU38vBswCdAZReVvFO1J0CwkrvGka/uGCAIZ81xlRPGNhc3jKRqDSlpQuI
         U+tCcyw0SKrsi/kl+elgh+BR01Re1vlc4IF0wlMCpB/sn2TM+pCBBoPiJ3gQM8+dFuEo
         DWYyQmwk3gbUhi3VjDfyS2akgU6/gMnhO7IHGzAThn10bhCxDmyxug8+KFMSxVgmKY83
         VB/mfQPZE5HyYqlgxrIrBHq3mtAoMGoZ9BgHRKYjYk4XrFfa/Tw0FtrCjxlN+W0xak06
         vOqQ==
X-Gm-Message-State: AJcUukduLehubSHB26gvOtV+neJDUePm1FF8LFlI1k5DwN3+gEmGMlDU
        30gflYFAC/gT+njEqbB303zQSpd3Xav9Cy/ieLUmFMWI/HvaNnORKNCJ3w7eO53+dvqvpwX/TvY
        M5jurvnwNGHgdcXuSx/FqwAZ+mLNtn+D4NAhrviRZgTQ+irBN0mGGKgBVBftwQ22hT1TZJRiPq+
        d22TcM8IpEgZ0bOltQxkQ=
X-Google-Smtp-Source: ALg8bN4MuayjFpFxxcD7f5Gqz2Zq+qfOQkV37We+G8sWhkvb2GKTP+J7dzM6LMgrr4hYWwMe/O/qljrd2PRJ7YY5LBay7g==
X-Received: by 2002:a24:594f:: with SMTP id p76mr3123699itb.10.1546998538121;
 Tue, 08 Jan 2019 17:48:58 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:44 -0800
In-Reply-To: <20190109014847.39980-1-matthewgarrett@google.com>
Message-Id: <20190109014847.39980-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190109014847.39980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH 2/5] tpm: Fix event log types for TPM2
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

These structs are defined as having variable length members, not fixed
size ones. Fix that up and rename them to more accurately describe the
only safe way they can be used, and fix the code that relied on having
fixed structures.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c |  8 ++++----
 drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm2-cmd.c      | 15 ++++++++++++++-
 include/linux/tpm_eventlog.h     | 27 +++++++++++++++++++++------
 5 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 5023f7f284ef..1343179c0a0e 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -37,7 +37,7 @@
  *
  * Returns size of the event. If it is an invalid event, returns 0.
  */
-static int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+static int calc_tpm2_event_size(struct tcg_pcr_event2_hdr *event,
 				struct tcg_pcr_event *event_header)
 {
 	return _calc_tpm2_event_size(event, event_header);
@@ -50,7 +50,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	void *addr = log->bios_event_log;
 	void *limit = log->bios_event_log_end;
 	struct tcg_pcr_event *event_header;
-	struct tcg_pcr_event2 *event;
+	struct tcg_pcr_event2_hdr *event;
 	size_t size;
 	int i;
 
@@ -91,7 +91,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 					 loff_t *pos)
 {
 	struct tcg_pcr_event *event_header;
-	struct tcg_pcr_event2 *event;
+	struct tcg_pcr_event2_hdr *event;
 	struct tpm_chip *chip = m->private;
 	struct tpm_bios_log *log = &chip->log;
 	void *limit = log->bios_event_log_end;
@@ -135,7 +135,7 @@ static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
 	struct tpm_chip *chip = m->private;
 	struct tpm_bios_log *log = &chip->log;
 	struct tcg_pcr_event *event_header = log->bios_event_log;
-	struct tcg_pcr_event2 *event = v;
+	struct tcg_pcr_event2_hdr *event = v;
 	void *temp_ptr;
 	size_t size;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index d9439f9abe78..33abe5406d38 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -488,21 +488,37 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
 	u32 count = 0;
-	int i;
+	int i, size = 0;
+	void *tmp, *digest_list = NULL;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		memset(digest_list, 0, sizeof(digest_list));
-
-		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
-			digest_list[i].alg_id = chip->active_banks[i];
-			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
+		for (i = 0; i < ARRAY_SIZE(chip->active_banks); i++) {
+			int digest_size;
+			struct tpm2_digest_hdr *digest;
+
+			if (chip->active_banks[i] == TPM2_ALG_ERROR)
+				continue;
+
+			digest_size = tpm2_digest_size(chip->active_banks[i]);
+			if (digest_size < 0)
+				continue;
+
+			digest = (struct tpm2_digest_hdr *)(digest_list + size);
+			size += sizeof(struct tpm2_digest_hdr) + digest_size;
+
+			tmp = krealloc(digest_list, size, GFP_KERNEL);
+			if (!tmp) {
+				kfree(digest_list);
+				return -ENOMEM;
+			}
+			digest_list = tmp;
+			digest->alg_id = chip->active_banks[i];
+			memcpy(digest->digest, hash, digest_size);
 			count++;
 		}
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f27d1f38a93d..178c47763d0c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -560,7 +560,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+		    struct tpm2_digest_hdr *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
@@ -584,6 +584,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		       u8 *cmd);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 		      u32 cc, u8 *buf, size_t *bufsiz);
+int tpm2_digest_size(int algo_id);
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a6bec13afa69..c91a0c1ef192 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -226,7 +226,7 @@ struct tpm2_null_auth_area {
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+		    struct tpm2_digest_hdr *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -1027,3 +1027,16 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+int tpm2_digest_size(int algo_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (algo_id != tpm2_hash_map[i].tpm_id)
+			continue;
+		return hash_digest_size[tpm2_hash_map[i].crypto_id];
+	}
+
+	return -1;
+}
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index b43bd2ea8bab..6363c8b08908 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -108,20 +108,35 @@ struct tcg_event_field {
 	u8 event[0];
 } __packed;
 
-struct tpm2_digest {
+struct tpm2_digest_hdr {
 	u16 alg_id;
-	u8 digest[SHA512_DIGEST_SIZE];
+	u8 digest[0];
 } __packed;
 
-struct tcg_pcr_event2 {
+struct tcg_pcr_event2_hdr {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
-	struct tcg_event_field event;
+	struct tpm2_digest_hdr digests[0];
 } __packed;
 
-static inline int _calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+struct tcg_algorithm_size {
+	u16 algorithm_id;
+	u16 algorithm_size;
+};
+
+struct tcg_algorithm_info {
+	u8 signature[16];
+	u32 platform_class;
+	u8 spec_version_minor;
+	u8 spec_version_major;
+	u8 spec_errata;
+	u8 uintn_size;
+	u32 number_of_algorithms;
+	struct tcg_algorithm_size digest_sizes[];
+};
+
+static inline int _calc_tpm2_event_size(struct tcg_pcr_event2_hdr *event,
 					struct tcg_pcr_event *event_header)
 {
 	struct tcg_efi_specid_event *efispecid;
-- 
2.20.1.97.g81188d93c3-goog

