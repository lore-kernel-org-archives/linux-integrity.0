Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D7C07E9C
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Jul 2021 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF1D611CB
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Jul 2021 00:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhGMAwD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:52:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53372 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhGMAwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 946E020B8016;
        Mon, 12 Jul 2021 17:49:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 946E020B8016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137353;
        bh=aw5g78XGdnlDL9hjUC/z7H7Y6XLewH4fs+vPZt4W4Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAHudBVFBr07KrZuFbJxknJLczk6VtGJg3/zzPZyfi6NckAnR17R4EsPzyZ6Km6wc
         ziSCWo6Yy+s4l2BgggVXqcv1yxTecEjumyUc/wbtRgLldvIB1lOuYg487rvpwtuHC1
         XJRYJK3dsmuCk+3OHpNyix60NBHHuuR9dI2N141Q=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 5/7] dm: measure data on device rename
Date:   Mon, 12 Jul 2021 17:49:02 -0700
Message-Id: <20210713004904.8808-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A given block device is identified by it's name and UUID.  However, both
these parameters can be renamed.  For an external attestation service to
correctly attest a given device, it needs to keep track of these rename
events.

Update the device data with the new values for IMA measurements.  Measure
both old and new device name/UUID parameters in the same IMA measurement
event, so that the old and the new values can be connected later.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm-ima.c   | 49 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h   |  1 +
 drivers/md/dm-ioctl.c |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index b1e1cf6bb4e7..36f99848825a 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -664,12 +664,61 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	kfree(device_table_data);
 }
 
+/*
+ * Measure IMA data on device rename.
+ */
+void dm_ima_measure_on_device_rename(struct mapped_device *md)
+{
+	char *old_device_data = NULL, *new_device_data = NULL, *combined_device_data = NULL;
+	char *new_dev_name = NULL, *new_dev_uuid = NULL, *capacity_str = NULL;
+	bool noio = true;
+	int r;
+
+	if (dm_ima_alloc_and_copy_device_data(md, &new_device_data,
+					      md->ima.active_table.num_targets, noio))
+		return;
+
+	if (dm_ima_alloc_and_copy_name_uuid(md, &new_dev_name, &new_dev_uuid, noio))
+		goto error;
+
+	combined_device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN * 2, GFP_KERNEL, noio);
+	if (!combined_device_data)
+		goto error;
+
+	r = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
+	if (r)
+		goto error;
+
+	old_device_data = md->ima.active_table.device_metadata;
+
+	md->ima.active_table.device_metadata = new_device_data;
+	md->ima.active_table.device_metadata_len = strlen(new_device_data);
+
+	scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2, "%snew_name=%s,new_uuid=%s;%s",
+		  old_device_data, new_dev_name, new_dev_uuid, capacity_str);
+
+	dm_ima_measure_data("device_rename", combined_device_data, strlen(combined_device_data),
+			    noio);
+
+	goto exit;
+
+error:
+	kfree(new_device_data);
+exit:
+	kfree(capacity_str);
+	kfree(combined_device_data);
+	kfree(old_device_data);
+	kfree(new_dev_name);
+	kfree(new_dev_uuid);
+}
+
 #else
 void dm_ima_reset_data(struct mapped_device *md) {}
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
 void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
+void dm_ima_measure_on_device_rename(struct mapped_device *md) {}
 #endif
 MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
 MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index a17ae953dc67..b1cf014d538d 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -51,5 +51,6 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
 void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
+void dm_ima_measure_on_device_rename(struct mapped_device *md);
 
 #endif /*DM_IMA_H*/
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index b07c19037c7c..e45f6c6ef84a 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -485,6 +485,9 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 		param->flags |= DM_UEVENT_GENERATED_FLAG;
 
 	md = hc->md;
+
+	dm_ima_measure_on_device_rename(md);
+
 	up_write(&_hash_lock);
 	kfree(old_name);
 
-- 
2.25.1

