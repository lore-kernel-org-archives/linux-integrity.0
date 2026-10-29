Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267749;
	b=bsPPCBiMjAdYbxV7w2wogaisF1lmCHzNqICa4+djBov/Q/o0sMdn8HzHCQqAdMFhSUyz
	 jrRv3P6N+zqSzEYpXSP1rtpPv38oRr8jLz1SO8DFgnEYPQLbOku1qWLohNJN+4ldFtrIP
	 w4CKvPXblH17WKGCUBqJVvY1JjKLSvJw4LVoKcZ0A3troM8CZc+e8Alx4awQ38QCvBa+T
	 IgahFsF/amurgF56rwZ9Tp7QIzYY8anz+NxO390Iqhnuew9SGaXIdjnSy7mPyYvNy+ieT
	 GnteuAbIo1ZXuhm9xZp2qbbVbvdhcAhOZOVJC1vlj1iyxdd+iJvx2/5eQ8atI9yOkvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tm7h+ZdQp+5bG8kSfYA0Nc38x7iz+CnqQnhw3MzPmhw=;
	b=n116dTqwse39DVz9Kq6z3CKsan+FAzc/v/itwloRqzQfk5/T5rj7GGS1gRifYfxiHth8
	 nAspRLhx0c+ASDsNCXEs+Taox+q5HquoF6C9Vhuq7G9OK5sspc+YeKxCVtpqT/2HDBJ77
	 Tlar+IzcAfMH96OkVn9VCxKrERpwbkQeSOp0/p1zWNyz/5qUrymqLbCUp3WnUhqRrQDDd
	 FBf2xFTLelaDyK72bhGt3PeQS/0lF8247rwF0wvG4s3lmxTyAk2drHttjFKWUjvXZoRKu
	 8SuXTEt4CgXiSNagpZkkm0GbwGUjNLPxmpgdY6IoAKdZ8o5qXGwFGEIp9MAh/Ayx8Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAV2817B;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A09606B772
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 09:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A09606B772
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAV2817B
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso17339875e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267747; x=1793872547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tm7h+ZdQp+5bG8kSfYA0Nc38x7iz+CnqQnhw3MzPmhw=;
        b=yAV2817BCZ5MoqZcPdBC7vs5JZpazSQMPRTLw1nzrwi+dfNc2agwBojie/RndbbYF7
         +vecFFR80+ss6Kw4wQVx9wwFPNoeWUkcN2GaRqMlT8xQGw8xPFkhObjJz6Hr5d/V/eiv
         wiTmV7FHg73lsKXfvWqcdtLsunARIDDLBB+HIz/QXMOflqELVWPuP7Hu8ockbRSuurTx
         Zah4oZMzDL+rw/zp7tyKkMW8HEWB2HAU9UeKH06Ehw/Gs6IzawAyIUmwtoLbz+J/tMNy
         u+u5fYkSUseP17t09E8dXJtyMf9sxbfeo0zN3u6nudlnCImlZwH1XKvnMHGldGy2+A9Z
         uGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267747; x=1793872547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tm7h+ZdQp+5bG8kSfYA0Nc38x7iz+CnqQnhw3MzPmhw=;
        b=K2rbKQ2hUdPwqKtwxTgqGV4c42qkvAANL7Bbe4tjtip3w4ISsm4iG5f+sGwcpHkmZ5
         rhYTOp1XdZWpjR37hH+Uftu/2iSGTSgQ/XeFtieowfyKajIg5r8EJB78mLcO2C9XOFsF
         kz7hbNpL84UgiyHsAdbw9+uAgcFnbhQYIdMGhpRWJuHCb33EwfYPCYaPuN/Pi/F7Cx6h
         jrY5ud3A/pC1RqdfcPxBiwePjZXbRruuap83ak/czsoCkczTvV8ST5z7vUZEGyBX7pZu
         ERfEFdOpr3S/bBEEvm/UPVqOMh74Ct5BNH3HHfdTaT8oL1tuRbW15TYrd0VFTb3TO4Xb
         kVRw==
X-Forwarded-Encrypted: i=1; AKwUvBxPbLltawv+vTIlIWAo3y7B/csVMBqj3fCrjJ++n/gAMRa7boEisA08z1hYP0ojnQz49hvfGJZhrHFAxDrnjQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBlGL5D5Oo0vFxAktGSNGI+w1U+DFKxZ/kF6XGQtjxTyYBB+vn
	pGA0G/1VLrg8PW+0D2B+91cgBHNS7LmabsQlYzGQuy6VRWTPJs+v0qhn
X-Gm-Gg: AYBFou3gjUq1pSACUsrESIvV6kg5EMiIHPmj27HcJXloQ4IO/5qDe2/Ph7AYskVIynH
	9NH5uaTIpKRP3Pb4Vd4gQb+LcP8zjmgY5mNz8KF+wMWlXD4t6vYhkESQRADVIfYXFpYUPw3Js9j
	MRUVu48ffAkhTUcPwFzPoZzBtWAaDAhrD0ohtNt+iHDGMw/hR9C1jfVdGM4aJXHVrmXBea8o29n
	hkGz2ek+7+mN+PqhOJVYc4UdZY9u+HOrcfIBagwtCz5NMlRD82Yli0YKqut3svIZjvjMlUHnD9h
	p2IMevfOUEVrJBiyBqE0sQ2i4kEUcwZLGqdW3Aw6pqbwsxkLQFQ2ef2blfOw89lsCaGLV2CXfJh
	IAestsCd46hBsfqHcW4ZgVBEpFG55Lj+nmHLEwwztMQpNrksrjqNAZCZmYd+P5VRI++KKbyBL8X
	wCxMcoPeRxsd+jEtUem+2i0gvnndxnfnso+A2O5y42HmB9j+oH/KqsV8cOrM+B6ZCPJI6IDd2TO
	3qYzhEEE/H5s+9T7gdKDbhWGutlYriET9a4k6XywP81tvzEyEViKSNVlnslbGqayBoy5xccWMtw
	jcsCrLjIn7A0farEMnUjo+uCe1Ok/MlSVTGFV0Ym7HqmJYpe0qyEgTKk9GnO1thzZG7grE4zMQH
	RnIQ7xjY8nDLDbminNiEzYDDiWQPy5niSExsgM8+pB5qWszYIFL5IfvGp9NrBB0ASgfJ8Qw==
X-Received: by 2002:a05:600c:1387:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4a96667b9f7mr107761615e9.5.1793267746803;
        Thu, 29 Oct 2026 02:55:46 -0700 (PDT)
Received: from GLaDOS.station ([187.13.215.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm54492295e9.14.2026.10.29.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:55:45 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/1] tpm: tis_i2c: Add reset delays for ST33KTPM2XI2C
Date: Thu, 29 Oct 2026 10:55:28 +0100
Message-ID: <20261029095528.8073-1-stefano.r@variscite.com>
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

Pull the timings from the matched device entry. If they don't exist,
fall back to the legacy behavior without delays. Update of_tis_i2c_match
with the timings for st33ktpm2xi2c.

Link: https://www.st.com/resource/en/datasheet/st33ktpm-idevid.pdf
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v1->v2:
 - Rewrite the last paragraph of the commit message

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

