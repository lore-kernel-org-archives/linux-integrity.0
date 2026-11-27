Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748401;
	b=BHzjJ7TtvW3kUyAY0oPYeoHdqrzI0tFVq6J9DD/5YBkwAA3vWI1aRdiCG34FVsWJy/yy
	 eOLOkB856OhSGYICErNq7DYVSdWhr3QVna7sWi6MX2TtJVPaRY4J498w8geZInTKzWOu3
	 tz5TMejdRdxLvV065VsppjyZB3iq+1LI58zxVu/cVApIag9sTKMhxiVUkYK5brAToBU9I
	 AsfD6IZXwhhwGSKRBmU/3wdsv6En0zRgHfqmARFekd4GqzFppfnBFcTNjWoeWt5Jp9XZf
	 fjycunsp7vATGPTE77hULvdHFBFUzOGNJbjVXRlx+1NYr/ntIJjt900U+RLokpVQNjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748401;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=xHWWO6o99kjU2TzReE8Vn7pFee8z3fLYhbzMLKyNUlc=;
	b=Qjy7Kwb60L83+q2n171LIUiX+qhtDtt8zajru45IXW0FA3KT+Eitj5U88p0UvGZYiHBy
	 fnAxGKB3ShX2POdBVa9HNHMHbMFNSK92MO+ZBi5OvyxEYIy6TWjvLIaU7C5JNiv5Uzsci
	 uezcrl0i3PxBbyBLu9fbDrduOwPUvJcmetN+7ah8r96bciSf7UkgGs/xmIEl/owB4GI2c
	 stYo9W1o9B9tizKPgBHIyyQgsnnC0clrJP2OuDM4u/L9eKSBppGHll6E3fvAg3oO6e+FG
	 4fw+/C2rrIcoU34OvzRCv19QN0TRcxqqHsuQcUy1Hpkvcbz1x9xr7Ipj++xTzJYEZAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XB+hU1TG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E4606A329
	for <linux-integrity@vger.kernel.org>; Fri, 27 Nov 2026 03:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 892E4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XB+hU1TG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHWWO6o99kjU2TzReE8Vn7pFee8z3fLYhbzMLKyNUlc=;
	b=XB+hU1TGxEp0y5aAdOoxWuXsKRR0C/7wlZd4uwJJU6zud2RGOwTdaw+J7bx832PqVyO79r
	Tds42gJBPPSF3H+4bNLgMqu1LA4fkXoa6kELuKV0NCwGmhuFH2MuGJyfhh1JhFem+Np2aS
	Wj3ISXkvNg75ayvhzVarT+h/t9lIhLQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-nX4TE-hdPRS1qYNP4mdjcg-1; Fri,
 27 Nov 2026 02:59:55 +0000
X-MC-Unique: nX4TE-hdPRS1qYNP4mdjcg-1
X-Mimecast-MFC-AGG-ID: nX4TE-hdPRS1qYNP4mdjcg_1795748394
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A321195608C;
	Fri, 27 Nov 2026 02:59:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00503180197D;
	Fri, 27 Nov 2026 02:59:53 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 6/8] ima: add the 'd-modsig-list' template field
Date: Thu, 26 Nov 2026 23:59:09 -0300
Message-ID: <20261127025912.1383750-7-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The 'd-modsig' field holds a single content digest, so it can't describe an
appended signature with more than one signer, let alone signers using
different algorithms. With that, add a 'd-modsig-list' field that records
an entry per signer as the following length-value table:

    <u32 count> x (<u32 entry_len><entry>)

with the entries in the order of the signers in the 'modsig' field, so
entry i describes signer i, and following the already known d-modsig
format:

    <hash algo>: <digest>

for a signer that signs an usual digest, and:

    <signature algo>: '\0'

for a signer that signs data directly (eg. ML-DSA). The idea of adding an
empty entry is to keep entries aligned with their signers in 'modsig'
field, easing verifiers work.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/security/IMA-templates.rst  |   3 +
 security/integrity/ima/ima_policy.c       |   3 +-
 security/integrity/ima/ima_template.c     |   6 +-
 security/integrity/ima/ima_template_lib.c | 103 ++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |   4 +
 5 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 4ec0440b27f1..161aed3da8b7 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -72,6 +72,9 @@ descriptors by adding their identifier to the format string
  - 'd-modsig': the digest of the event without the appended modsig or a signature
    algorithm name followed by an empty digest (<signing algo>: \0) when direct data
    algorithms are used, e.g. ML-DSA;
+ - 'd-modsig-list': a list of 'd-modsig' of each signer when multiple signatures are
+   present and which may use different algorithms
+   (field format: <entry count>[pairs of <entry length><d-modsig entry>]);
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature, based on either the file's/fsverity's digest[1],
    or the EVM portable signature, if 'security.ima' contains a file hash.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dc1d93aa768..bb68f78fdb0e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1242,7 +1242,8 @@ static void check_template_modsig(const struct ima_template_desc *template)
 	for (i = 0; i < template->num_fields; i++) {
 		if (!strcmp(template->fields[i]->field_id, "modsig"))
 			has_modsig = true;
-		else if (!strcmp(template->fields[i]->field_id, "d-modsig"))
+		else if (!strcmp(template->fields[i]->field_id, "d-modsig") ||
+			 !strcmp(template->fields[i]->field_id, "d-modsig-list"))
 			has_dmodsig = true;
 	}
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 16154078fd70..584f970e553e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -50,6 +50,9 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_buf},
 	{.field_id = "d-modsig", .field_init = ima_eventdigest_modsig_init,
 	 .field_show = ima_show_template_digest_ng},
+	{.field_id = "d-modsig-list",
+	 .field_init = ima_eventdigest_modsig_list_init,
+	 .field_show = ima_show_template_modsig_list},
 	{.field_id = "modsig", .field_init = ima_eventmodsig_init,
 	 .field_show = ima_show_template_sig},
 	{.field_id = "evmsig", .field_init = ima_eventevmsig_init,
@@ -95,7 +98,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template)
 
 	for (i = 0; i < ima_template->num_fields; i++)
 		if (!strcmp(ima_template->fields[i]->field_id, "modsig") ||
-		    !strcmp(ima_template->fields[i]->field_id, "d-modsig"))
+		    !strcmp(ima_template->fields[i]->field_id, "d-modsig") ||
+		    !strcmp(ima_template->fields[i]->field_id, "d-modsig-list"))
 			return true;
 
 	return false;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index a2aeaae83065..eeb636155798 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -200,6 +200,40 @@ void ima_show_template_digest_ngv2(struct seq_file *m, enum ima_show_type show,
 				     field_data);
 }
 
+void ima_show_template_modsig_list(struct seq_file *m, enum ima_show_type show,
+				   struct ima_field_data *field_data)
+{
+	struct ima_field_data entry;
+	u32 count, i;
+	int parsed;
+	void *p = field_data->data;
+	void *end = p + field_data->len;
+
+	if (show != IMA_SHOW_ASCII || field_data->len < sizeof(count)) {
+		ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+		return;
+	}
+
+	memcpy(&count, p, sizeof(count));
+	if (ima_canonical_fmt)
+		count = le32_to_cpu((__force __le32)count);
+	p += sizeof(count);
+
+	for (i = 0; i < count; i++) {
+		ima_parse_buf(p, end, &p, 1, &entry, &parsed, NULL, 0,
+			      "d-modsig-list");
+		if (parsed != 1)
+			break;
+
+		if (i)
+			seq_putc(m, ',');
+		if (entry.len)
+			ima_show_template_data_ascii(m, show,
+						     DATA_FMT_DIGEST_WITH_ALGO,
+						     &entry);
+	}
+}
+
 void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data)
 {
@@ -524,6 +558,75 @@ int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 					     field_data);
 }
 
+/*
+ *  ima_eventdigest_modsig_list_init - add the content digest of each modsig
+ *  signer to the template data.
+ *
+ *  Unlike 'd-modsig', this field describes an appended signature with any
+ *  number of signers, which may use different algorithms. It is a table as
+ *  follows:
+ *
+ *      <u32 count> x (<u32 entry_len><entry>)
+ *
+ *  with one entry per signer, in the order of the 'modsig' field, so entry i
+ *  describes signer i, and with the pair <entry_len><entry> repeating <count>
+ *  times.
+ *
+ *  An entry has the 'd-modsig' format, see ima_modsig_digest_entry().
+ */
+int ima_eventdigest_modsig_list_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data)
+{
+	unsigned int count, i, err_count = 0;
+	int len, rc;
+	size_t buf_len;
+	u8 *buf, *p;
+	u32 val;
+
+	if (!event_data->modsig)
+		return 0;
+
+	count = ima_get_modsig_signer_count(event_data->modsig);
+	if (!count)
+		return 0;
+
+	buf_len = size_add(sizeof(u32),
+			   size_mul(count, sizeof(u32) +
+				    IMA_MAX_DIGEST_ENTRY_SIZE - DIGEST_TYPE_NAME_LEN_MAX));
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	p = buf;
+	val = ima_canonical_fmt ? (__force u32)cpu_to_le32(count) : count;
+	memcpy(p, &val, sizeof(val));
+	p += sizeof(u32);
+
+	for (i = 0; i < count; i++) {
+		len = ima_modsig_digest_entry(event_data->modsig, i,
+					      p + sizeof(u32));
+		if (len < 0) {
+			/* Keep walking signers' list, even on failure, to
+			 * maintain allignament with modsig.
+			 */
+			rc = len;
+			len = 0;
+			err_count++;
+		}
+
+		val = ima_canonical_fmt ? (__force u32)cpu_to_le32(len) : len;
+		memcpy(p, &val, sizeof(val));
+		p += sizeof(u32) + len;
+	}
+
+	/* Like 'd-modsig', don't measure if the list has only bad digests */
+	if (err_count < count)
+		rc = ima_write_template_field_data(buf, p - buf, DATA_FMT_HEX,
+						   field_data);
+	kfree(buf);
+	return rc;
+}
+
 static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data,
 				     bool size_limit)
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9f7c335f304f..cf3d453d4c37 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -23,6 +23,8 @@ void ima_show_template_digest_ng(struct seq_file *m, enum ima_show_type show,
 				 struct ima_field_data *field_data);
 void ima_show_template_digest_ngv2(struct seq_file *m, enum ima_show_type show,
 				   struct ima_field_data *field_data);
+void ima_show_template_modsig_list(struct seq_file *m, enum ima_show_type show,
+				   struct ima_field_data *field_data);
 void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data);
 void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
@@ -44,6 +46,8 @@ int ima_eventdigest_ngv2_init(struct ima_event_data *event_data,
 			      struct ima_field_data *field_data);
 int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 				struct ima_field_data *field_data);
+int ima_eventdigest_modsig_list_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
-- 
2.55.0

