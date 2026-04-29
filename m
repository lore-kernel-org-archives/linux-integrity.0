Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD4392C26
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494080; cv=none; b=qXtlDMsToQXfDCGP4TP9QDuNVLbiQo5q7xdkC6MWk5irZhxW2kNUkFVMrmoOb33cd4zrLAAG3726/VTGf5HUkjD+fNGldON2EaJo0EHQUIDcM2vQTzHjm2zvyxULV4j5aBLvKxqaW5CUYvdrqFGW/tzxrxyJFwarSk4F5Brkycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494080; c=relaxed/simple;
	bh=Hi9+5wl4X3zr6veyOzswPZsdaP7Ftg87VOBr/scYRI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ2tjdyQQdyY9tHRbvIPkG5btOMerq2yUPHW1qY47RpvyYXfYAhTjbRyuwkv2NELkwrT2DGPvB9XqAlxq8yT2r/OWxv9FPCCWPAjymDQoBSg4GroRvTFscNBOvXhnKB9liwwleYF1WCkoG46GVmaqJqPCmWNhs7NSVUoA4rWrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0IGY3bO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0IGY3bO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgpXV0XD/L9Lon/zQKVBQQOe2oAymra5Ek6TYl4piIo=;
	b=S0IGY3bOYlh3s9hbDO+KoEIEUUC/YldHxJde6qpLcDJRnrfM4/HizoaT2e6isJBm5BPPzV
	9qSCyO46ynFFTAtBeDDBw+oZi09KdcMiIHOHGifikcSywM//31qHsJWU+ANaKUy/y17gYM
	Z8+HdgpdD99Luuxcq31MRQahntQOs6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-mZfJuuYiPnugEwqbwJo6NA-1; Wed,
 29 Apr 2026 16:21:13 -0400
X-MC-Unique: mZfJuuYiPnugEwqbwJo6NA-1
X-Mimecast-MFC-AGG-ID: mZfJuuYiPnugEwqbwJo6NA_1777494072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 173E61956094;
	Wed, 29 Apr 2026 20:21:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6F4419560B6;
	Wed, 29 Apr 2026 20:21:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKLATO2823312
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:10 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKLAdf2823311;
	Wed, 29 Apr 2026 16:21:10 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 08/10] dm-ima: Handle race between rename and table swap
Date: Wed, 29 Apr 2026 16:21:06 -0400
Message-ID: <20260429202108.2823261-9-bmarzins@redhat.com>
In-Reply-To: <20260429202108.2823261-1-bmarzins@redhat.com>
References: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

a device rename could happen after do_resume() removed the inactive
table that it was swapping to out of the hash cell, but before it was
made the active table. In this case, the table metadata would still
have the old name. Update the swapped table's metadata to avoid this.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index f563c4381489..47af99c9b79c 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -373,6 +373,19 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 		kfree(md->ima.active_table.device_metadata);
 		md->ima.active_table = context->table;
 		memset(&context->table, 0, sizeof(context->table));
+		if (md->ima.active_table.device_metadata) {
+			/*
+			 * A rename could have happened while the swap was
+			 * going on. In that case, the saved table info would
+			 * still have the old name. Update the metadata to be
+			 * sure that it has the current name
+			 */
+			struct dm_ima_device_table_metadata *table = &md->ima.active_table;
+			fix_context_strings(context);
+			dm_ima_copy_device_data(md, table->device_metadata,
+						context, table->num_targets);
+			table->device_metadata_len = strlen(table->device_metadata);
+		}
 	}
 
 	if (md->ima.active_table.device_metadata) {
-- 
2.53.0

