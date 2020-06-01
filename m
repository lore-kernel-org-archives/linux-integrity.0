Return-Path: <SRS0=cypm=7O=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1459AC433DF
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Jun 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6E320738
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Jun 2020 15:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkiIeh2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAPHH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgFAPGx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 11:06:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB3C03E97C
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 08:06:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so8499639lji.12
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+YbCaVZou6iCOy05bPpr7mEUsmeG17nUbE9lvEgb7U=;
        b=rkiIeh2d6vkvTi2USatHPRHws64PNJVkgmJPC8Da3GdqOoRKzpsN21WYGxImGv6HeX
         xgA1gBXIN/Kn71/D6xeNYLSV4Ty2MbiB8bs0lbvYe15J0bKq7QngR0h7E5PbalFAFuoo
         RMX7bJV7HtN9+XjZrTM2/qCB3DfqXNIS/7A7ReNYCAaArxAE3SHC2N5UD7gRdOfg5c2E
         c3tHq7M/+LLbCIS32yyfYXlk8S4jMG1jZPMflUhPu+qncaFi3tO6FtnDRo0ZtC3ofBQI
         ATGqjzchsoZ1mYOsdPQOszStTH+o8JmCSf/jQyctF+NaOgh7JzXYTpYwMQR/I0UHbA79
         xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+YbCaVZou6iCOy05bPpr7mEUsmeG17nUbE9lvEgb7U=;
        b=nGUIN9/r44SQkA3tXy0UFGiyXTNGGHjpEDZEFXbZQ0aHQMbHdmFEm3gHvKfYqyFlBL
         kD85s+IhRx+BDz1Dc3H+CGeKWhJc656V/eVDGhvuXXfTulYn+nvM544C1pwL7Jnkxmus
         cq4PgPBg2uCk7LnInfOyTyP/MgxKi8Ozc/s440PnKnlt8HeMREBWPyApQIQSasLvg+AC
         9GQ7srZxB5TkpaTQL1UnQDjEywEjt3Bn2ByjA+5PuUmNl4wG5ggVQcq3BvYnf2wg+XZh
         co+ug0v3b0K/MIvAWtfqxOc4mLCYjAF1Hq3Q7PZL/xIIz591GM62K8BdFQP3GZlVo0b8
         7/vw==
X-Gm-Message-State: AOAM530Po1tomXsL1N5D35JmoiRDv+TXzm7Ix9VGs8MONCnru7n91Hno
        khObkecJCGvYfBG6C+1IXfX+YA==
X-Google-Smtp-Source: ABdhPJwB9vpIQqSQ5+qvJ9vw5PVDUzC3wOrIJHmZnfPKHC0hapUH7y1wSIB8L1cM2HFpqzViYn8qFQ==
X-Received: by 2002:a2e:9b16:: with SMTP id u22mr3342399lji.295.1591024011598;
        Mon, 01 Jun 2020 08:06:51 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id q15sm4823537lfc.44.2020.06.01.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:06:51 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
Date:   Mon,  1 Jun 2020 18:06:43 +0300
Message-Id: <20200601150645.13412-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601150645.13412-1-maxim.uvarov@linaro.org>
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the evolving use-cases for TEE bus, now it's required to support
multi-stage enumeration process. But using a simple index doesn't
suffice this requirement and instead leads to duplicate sysfs entries.
So instead switch to use more informative device UUID for sysfs entry
like:
/sys/bus/tee/devices/optee-ta-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 1 +
 drivers/tee/optee/device.c                        | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
new file mode 100644
index 000000000000..0ae04ae5374a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -0,0 +1,8 @@
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/
+Date:           May 2020
+KernelVersion   5.7
+Contact:        tee-dev@lists.linaro.org
+Description:
+		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
+		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
+		are free to create needed API under optee-ta-<uuid> directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..6717afef2de3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12516,6 +12516,7 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..ed3d1ddfa52b 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	return 0;
 }
 
-static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
+static int optee_register_device(const uuid_t *device_uuid)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
-	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
 	uuid_copy(&optee_device->id.uuid, device_uuid);
 
 	rc = device_register(&optee_device->dev);
@@ -144,7 +144,7 @@ int optee_enumerate_devices(void)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx], idx);
+		rc = optee_register_device(&device_uuid[idx]);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.17.1

