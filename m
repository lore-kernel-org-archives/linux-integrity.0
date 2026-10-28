Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180728;
	b=03/jLCLbpA5gtYrHsy2K/Yymv574ge1MOYscLZsI1C9qz/IuFZw4sPruIKWSicW4rZ7F
	 z3S2+43IJK3tYDY8AqvyhcXvROhDXY3JCqK3ngCN91z7t8shxJNgAVLm+nv0nINT5vcSs
	 hhTOyQIMCUJ3An6iV1Zbsx0MVsIaFXR6Czlmep3PgwD9B2JNg4s/Fu5ukK8WWoElHChxh
	 ShKbRz8DEqgwcHiXkeS13iyUf64Amw3raUGpVqdEDh5iFR47bsDm4XTOlW2o8oDrh8pRD
	 HgwiE6RRGGCyER0XhunKlDnAMgCVPrWNzwZKwUG/L2co8XThavjoS3GbUO+QidtDw8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nQSVue22JfuRfe7QbPCCWytdcMKPPahjBQIzR2I7fRE=;
	b=dPXx1Ke+nTawdvjVL+ClFUjeVl6GD3e28hZbxgFuVofubIRX9q50eqAVc4an/2I8QctF
	 krqDEQKa7+gzggDy5EJOLNKzDboROG5ZycaEVInrjaHSAxIVkjJBKPcWenXBbwnWtXBhh
	 HT/ls/Qh0eEVe8Ap8OnkM+IFfRBraKr7JhsSYDK69hT76WTu2H5MjupuVhLuWagTwW7Jo
	 42LzL+ZgocvaM6/CynlVL7P+KodT05MXNR7LEvWgZzSnvmepx8s5+0yKKiLyPLEuPgrEh
	 smKaZ1lCIaWouosknrZEA1VKGpZZwS9ybjKWTdzyYUlimXtLCRU9ijbpuhGRXeynShA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMHotoVx;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB0606A31D
	for <linux-integrity@vger.kernel.org>; Wed, 28 Oct 2026 09:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CB0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMHotoVx
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e09aa5264so363307f8f.2
        for <linux-integrity@vger.kernel.org>; Wed, 28 Oct 2026 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180727; x=1793785527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQSVue22JfuRfe7QbPCCWytdcMKPPahjBQIzR2I7fRE=;
        b=uMHotoVxO0t/VdyZy3UkWFC6sTzuIAYKwc55rVuXbV4v3la+IpZqUGhWOhsfYtjJkK
         NhRSNsOLElwRX4WuJVY64Fd+Dhgv1nnH5JdOpTJgPJe7P9IW06fWoZ73t5iGcZinZZMS
         YJjcbYiD8hVx/SQOw5UrO2DfcFdRGMt12Q4g2DbixQfB4WfsFjDmpt+XlZGKCQPVK57l
         ES2qO3tXbiV004udPcGaHlamvbjOjNELbwPtTkSZrRuEaBUMoZufJHTJcSA9z2EtVL/+
         6F0gbnuWZnw4409iFY7jAUfCGcDHfCzZoLVUBQl8PUzthI8okuQDMr2nLKvFf3rnZMXs
         yxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180727; x=1793785527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQSVue22JfuRfe7QbPCCWytdcMKPPahjBQIzR2I7fRE=;
        b=aFbkZwjygxeWi7BT9AkzZBU1HDlFEAsfAI9kvU2UF5T3XPO1Zebxu4tl0RYsTiHslh
         FOnL9QyvzDpCa6IZFkWmCscXYX/CySid+nz8HOgFIaIXGJHfwxTG8h6spbEEZ/YG2kFr
         3/nE9YpujOh7+n4PRZxSrXVH6QBCrcTTHE6vfISd/cDYGxFImMmKqaNXLtx6pJ0xR2pj
         nR9ED3tievkFw9zMMWgV3Gn6thjDC4KoDZRt3ZVzh08pm1gZmBtIEh8idroT8mTI4Kte
         Ahmp6uckTke+RpgQqJc35WfHnayqdoQee4Gkmzh+F+Ufz6Rf6aSNogsNVDYG3to0EJ4G
         Di3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwkG4Z7/U1LkbHpbUECOnLo9aaVsUbthmmf2DsSNZY2a7ew1AiWRoFWHtw1pICqRXImhcDv0bRLZzk0O1JuLik=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoDyIiiqNRZ/suO/Pp3fbKKCfhXIW15v3kgIbYqAaiw7L54sUc
	0oCyzGDCdlAGbmF5kQU0X6ELFfvw+t9L5VaHlMtHqElkhrEVN3Wty7JT
X-Gm-Gg: AYBFou0xvergTVq3fAm+PhP27oTAm09AXpwhwm/q62T/kU0WWNF2VP7VEJE0tglJLPf
	+8ssqx14Oa2jBJERFu07qqMUSUSXEuwKjA69Cl5dmBtKnWbOzV2t8yhtqs48xo+b0RXgscG/YkP
	99/+QVx1hJimX6Wsz11mj9/y4oAkv7V+zMhd1jkRnvNVwSnlQjqz3Fbo8gnZSZqY6oE4dcWyR+q
	yZR0SsKvZ/MKEK+tw6BsDdGFUCX9nNwnEHDQmwfbK/5Lm9IUYB9vVGpe2IDEjaN9/p4MloXtxKi
	jFw/xP5LQeblBMLYkY7waf2/3jib3xcIFxY6oF7kU0sUvJgnaNaSXmHx4g0tOQooHlsxUqgYL2J
	X4LZacWizmJGzQPJx+pMKgYa87FctJ8ezwWZxPJgrf9ZxrODK6+ufIibEzN9MNmn3orZzDdjbkO
	VObleyqUrU7KxzuHKetiL+wE8H4pzaDYjRwW7d5wboBEDZ0sR6iWZ0zZY0O0To6g+YsMXjjUtw4
	x+UxwB8UMAPuLXKKbpo83tCHhIytmhdpORiTJzMldKgWnTt1QJ5Xg/L4/4oJ3pXxRic4RdhtVS9
	Pild4z6sGc4J353mJddv1+rYXfQhs9vt1YZQhM1JuyPjd+TFWS/y5PVhmo7u5C4az+mOoVdXYia
	YNh7SCeKb96BNB0seZP0t1tOYBJ1lkDGezsMeS89xozm1v+w=
X-Received: by 2002:a05:6000:46d4:b0:48e:dee:52bc with SMTP id ffacd0b85a97d-48e5d324c1fmr3314620f8f.0.1793180726495;
        Wed, 28 Oct 2026 02:45:26 -0700 (PDT)
Received: from GLaDOS.station ([187.13.215.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3da7sm28827539f8f.20.2026.10.28.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:45:25 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v1 1/1] tpm: tis_i2c: Add reset delays for ST33KTPM2XI2C
Date: Wed, 28 Oct 2026 10:45:04 +0100
Message-ID: <20261028094504.4256-1-stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
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

From: Stefano Radaelli <stefano.r@variscite.com>

The optional reset control is deasserted without a delay, and probe then
proceeds directly to the first I2C register access. Since reset-gpio
initializes its line asserted, this provides no guaranteed minimum reset
pulse width or recovery interval before communication starts.

Table 66 of the ST33KTPM-IDevID datasheet specifies a minimum reset pulse
width of 1 ms and up to 50 ms from reset release before the first command.
Choose a 2 ms assertion interval to provide margin above the minimum and
wait 50 ms after deassertion, before initializing the I2C guard times.

Associate these timings with the existing st,st33ktpm2xi2c compatible using
match data. Apply the delays only when a reset control is present. Preserve
the existing deassert-only sequence and the behavior of devices without
timing data or a reset control, without adding Device Tree properties.

Link: https://www.st.com/resource/en/datasheet/st33ktpm-idevid.pdf
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index cde0b093ed58..8bcbc84815fd 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -12,6 +12,8 @@
 
 #include <linux/i2c.h>
 #include <linux/crc-ccitt.h>
+#include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include "tpm_tis_core.h"
 
@@ -55,6 +57,11 @@
 #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
 #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
 
+struct tpm_tis_i2c_reset_timings {
+	unsigned int assert_us;
+	unsigned int deassert_us;
+};
+
 struct tpm_tis_i2c_phy {
 	struct tpm_tis_data priv;
 	struct i2c_client *i2c_client;
@@ -330,6 +337,7 @@ static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
 
 static int tpm_tis_i2c_probe(struct i2c_client *dev)
 {
+	const struct tpm_tis_i2c_reset_timings *timings;
 	struct tpm_tis_i2c_phy *phy;
 	struct reset_control *reset;
 	const u8 crc_enable = 1;
@@ -347,17 +355,25 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
 
 	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
 	phy->i2c_client = dev;
+	timings = device_get_match_data(&dev->dev);
 
 	reset = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
 	if (IS_ERR(reset))
 		return dev_err_probe(&dev->dev, PTR_ERR(reset),
 				     "failed to get reset control\n");
 
+	/* Allow an already asserted reset to meet its minimum pulse width. */
+	if (reset && timings)
+		fsleep(timings->assert_us);
+
 	ret = reset_control_deassert(reset);
 	if (ret)
 		return dev_err_probe(&dev->dev, ret,
 				     "failed to deassert reset\n");
 
+	if (reset && timings)
+		fsleep(timings->deassert_us);
+
 	/* must precede all communication with the tpm */
 	ret = tpm_tis_i2c_init_guard_time(phy);
 	if (ret)
@@ -393,9 +409,19 @@ static const struct i2c_device_id tpm_tis_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 
 #ifdef CONFIG_OF
+/*
+ * ST33KTPM-IDevID datasheet DS15011, table 66: tWL >= 1 ms and
+ * tCMD <= 50 ms. Allow 2 ms for tWL to provide margin above the minimum.
+ */
+static const struct tpm_tis_i2c_reset_timings st33ktpm2xi2c_reset_timings = {
+	.assert_us = 2000,
+	.deassert_us = 50000,
+};
+
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
 	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "st,st33ktpm2xi2c", .data = &st33ktpm2xi2c_reset_timings },
 	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
-- 
2.47.3

