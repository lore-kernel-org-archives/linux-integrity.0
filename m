Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706504;
	b=oy/eVppiS7vtauAzI1WIgeCv20AOV2yWVCXwuNWZCZO7H9j7t5v34H54jsaCr7QpZrJM
	 0ARO+5Tbh1r6sp2Ne6pD3RoM65W//J4GgbZO8U0RvpB+qmHtc3JEACjEoH3GP/cw1U9qw
	 CLE5g6FpSFTv2kfHlXKp1tQJNIC46LyfjN0hw3gNn7SkHpBZzRu5qBs+K7zy66NbDvznx
	 fUqSjkSqC74ux2gK3ktXBc8BCydTD3zh29JCyPO1Rqda7iScEnvouEMfx2+Titwu+E4Rh
	 BFts52HKFIHUCvo1j9wgyKi+ZlSLECZyabl0C5KsYnUI/bSgoUiEF+NUvSiLr2yToog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aYL6G69BaEJMm4DnAUdFEhty32iIoI7j/HmKyks21b4=;
	b=OKvXL9+GYUkmpEudt3Ueh5Tqlv/IWR1nqAaK8vj8psvrE6Qz8NJBNhT6AjQjaDY2hhZW
	 3ytRVIYaUeMiHSnPZezgoEzKlYxsCiOBmD0AzaY0eHMJvJMpn40qP4Mcdpv+ik/Nh7qjD
	 KazGFBQX+Di6wLOIbQ6t8IruVPJTO85rJSaEcrroK5cn94MAOL8IzHp3g4DU6mhjyeD8K
	 p5Kr7X9msXh599fsSkinwhwDwu8rZPUOTo9vZ94ZzdEPKKL4Z9hZ292wjJV6M4ROIxQG9
	 Y+EF5VKR5aL0qCuTbEZW9zXV8dg4laOFosBYXueXvLI9agpk5eh8g/lp2LaJ15rF9OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPe1l8L5;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4E606A8BA
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 01:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF4E606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPe1l8L5
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ee0533d249so8036545ad.1
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 17:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706504; x=1795311304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYL6G69BaEJMm4DnAUdFEhty32iIoI7j/HmKyks21b4=;
        b=lPe1l8L5XSBpMr0r8PpBNL+l7lGIPCLaMYrzIEk0nMcUR2uHakOa7pAKXLNRASmpm6
         LyJp54eW3SJHzFQ9jmmQU8z817nxhIrzbujKj7In0eHzil+Rnm2EGi+HeFVBIYhbMnjN
         xL0LxOg3pBC80cKcJKhx2UzBvaIyU2JNFW1JxtKMggPSOJ/zw8Yw70UaAZrpoK9FGpr9
         XJ2o4gogRjFSbZjbCx9MvGqmKRD7gAs+sdylWFJSlL+p2BY1snd4eyeOyJk7urGvpXzB
         wLdr8mZt3cpJWuKzn+Mq8grdEh7SX1TTaqB2gNC7vH5QgpLeiDm39NfZfL3TdxxzLrjy
         pyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706504; x=1795311304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYL6G69BaEJMm4DnAUdFEhty32iIoI7j/HmKyks21b4=;
        b=M2py+5sJArZJrD3EqUvOS8FJi4WFMQLFPtzmRlb4cbGVQkyIiDWWylpY8lSf41+tS8
         BGeBjO7fY9m8coQYU7g6HmC//2ejS4bJKfdy0TBbVobjH+llYLkPxUZkT9/vL/YCDIEZ
         c9ZAQEneR18nZQcLtNQOdjkXFaccpqbfHl1g7TZEIAGfrL1TZXGTREZXrVNfomKsoWqn
         MF1iy+4EXdz8wbtn/D79nQsrmm8APRaZCbs97ZWpz6zj19ESxBG9oI42v68nTDt3iLc+
         v3o1f2IgSJdHhyzSiB0T909ZoTMORiYq5oiwntyvQolaaZmRvm79NTMgzVAzT65euRWH
         XY+w==
X-Forwarded-Encrypted: i=1; AL+hErF4shQOFF5+rinjkkZDMOSvZtWbOjf/lfE6yMMu5fwp/n9BsfncoP/kjn1BSt1j9L5607XElOhUAhC33LF10bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GucyORIkiErQ5Pd6zshfZi61lLjHRXAd2/zUdpNsJVT7+gxyG
	qQ78EFvKIFDzBHUXYu6ycW6HTodS86yYAYO6BCT2lmnY5rS2T1li58Nu
X-Gm-Gg: AYBFou3r366Nihq8LCDu5t7M/AwqAUyoegXq2hE28hQY0LkVbH8BlzmTYgCfDUGvGBn
	zy4O0NJacfl8sXANtfT/RbSCYzYxSHYpfSOzPFi/1ETd6hXS/tZMXPTnbf8EiV22gzNeZigiyQ1
	taPGExTJpP1ENhwopK+gCH93Z54zAztaYfWspBOmxjaA423+i3yKL6kU5RzitY5XI8T9mEYRk7i
	O+iUUug7W7WTV01Ec1h58is8/pcfy1jYUy4UWYVymu3pOvZIJ18QxpCzUrZNI11cvijZ4b7XHCp
	/NkCCZKSd/t+8FUwc/qNb2Bmgs08G6gzU742s1Exuf2wvTiPrtDXeVJ1TkquB7rV0XxmrgcO8Zw
	vedWVaqHVURUTSDvQkZeEQmtaaMqRgIOFIu9+b7ZtmaIYl9YIDD3gF0g6PqieVBXKacRTRSaj8s
	tk8MpOu7yZFZy/r94uDKDXw9QsteUdQyehiZ3WuRqs2R8bLKBU+lELEx13OkZlQ66VF84bSmUpD
	kvx1n2kT4I0kthxIOmb0cZUNROGw2F+YWBBs/jCVHHxzJguyG4cieylXxj4mWOL6zKit1x6kj60
	1FLN3pl4JNijd6JiCekaAID5IoJ8fpmwu7S0DoyV69qmtVFx9sOrWNU14iOrFdjDeR+FN9Lqsl6
	GH+5wN+4fncBk3uPFRTnBproIjJZrri1dCh3XEvHQ57HCIkjrVvBLolXxP4HHNeSEV9zoZH2IP/
	7w1lVuTG5zwbQJetBW7uQbJIwusRR0SRDYZeZveBMa
X-Received: by 2002:a17:902:cf04:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2ee0e0b161bmr68606555ad.58.1794706503817;
        Sat, 14 Nov 2026 17:35:03 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75dde9sm23671935ad.22.2026.11.14.17.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:35:03 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rachelmenge@linux.microsoft.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v3 4/4] tpm: tpm_crb: Use cached tpm2_acpi_start_method
Date: Sun, 15 Nov 2026 01:34:56 +0000
Message-ID: <20261115013456.212141-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115013456.212141-1-sidchintamaneni@gmail.com>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
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

Replace priv->sm and the local sm variable in crb_acpi_probe() with
tpm2_acpi_start_method across tpm_crb so the cached global serves as
the single source for the ACPI TPM2 start method.

Check tpm2_acpi_start_method at the start of crb_acpi_probe() and
return -ENODEV before mapping the ACPI TPM2 table when the table is
absent or uses ACPI_TPM2_MEMORY_MAPPED.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 82 ++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 4749a9183726..8585c73fb25b 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -98,7 +98,6 @@ enum crb_status {
 };
 
 struct crb_priv {
-	u32 sm;
 	const char *hid;
 	struct crb_regs_head __iomem *regs_h;
 	struct crb_regs_tail __iomem *regs_t;
@@ -138,11 +137,11 @@ struct tpm2_crb_pluton {
 /*
  * Returns true if the start method supports idle.
  */
-static inline bool tpm_crb_has_idle(u32 start_method)
+static inline bool tpm_crb_has_idle(void)
 {
-	return !(start_method == ACPI_TPM2_START_METHOD ||
-	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
-	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
+	return !(tpm2_acpi_start_method == ACPI_TPM2_START_METHOD ||
+		 tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
+		 tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
 }
 
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
@@ -166,7 +165,7 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 
 static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
 {
-	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
+	if (tpm2_acpi_start_method != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		return 0;
 
 	if (!crb_wait_for_reg_32(priv->pluton_reply_addr, ~0, 1, TPM2_TIMEOUT_C))
@@ -204,12 +203,12 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
-	if (!tpm_crb_has_idle(priv->sm))
+	if (!tpm_crb_has_idle())
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
 
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
 		if (rc)
 			return rc;
@@ -258,12 +257,12 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
 {
 	int rc;
 
-	if (!tpm_crb_has_idle(priv->sm))
+	if (!tpm_crb_has_idle())
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
 
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
 		if (rc)
 			return rc;
@@ -303,7 +302,7 @@ static int __crb_request_locality(struct device *dev,
 
 	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
 
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
 		if (rc)
 			return rc;
@@ -337,7 +336,7 @@ static int __crb_relinquish_locality(struct device *dev,
 
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
 
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
 		if (rc)
 			return rc;
@@ -530,18 +529,18 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 	 * report only ACPI start but in practice seems to require both
 	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
 	 */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
-	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER ||
+	    tpm2_acpi_start_method == ACPI_TPM2_MEMORY_MAPPED ||
 	    !strcmp(priv->hid, "MSFT0101"))
 		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
-	if (priv->sm == ACPI_TPM2_START_METHOD ||
-	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
+	if (tpm2_acpi_start_method == ACPI_TPM2_START_METHOD ||
+	    tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		rc = crb_do_acpi_start(chip);
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
 		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
 	}
@@ -622,7 +621,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	}
 
 	/* Seems to be necessary for every command */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
 	if (len <= priv->cmd_size)
@@ -638,12 +637,12 @@ static void crb_cancel(struct tpm_chip *chip)
 
 	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
 
-	if ((priv->sm == ACPI_TPM2_START_METHOD ||
-	     priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
-	     crb_do_acpi_start(chip))
+	if ((tpm2_acpi_start_method == ACPI_TPM2_START_METHOD ||
+	     tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
+	    crb_do_acpi_start(chip))
 		dev_err(&chip->dev, "ACPI Start failed\n");
 
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
 		if (rc)
 			dev_err(&chip->dev, "FF-A Start failed\n");
@@ -762,7 +761,7 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 	 * Pluton sometimes does not define ACPI memory regions.
 	 * Mapping is then done in crb_map_pluton
 	 */
-	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+	if (tpm2_acpi_start_method != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
 		INIT_LIST_HEAD(&acpi_resource_list);
 		ret = acpi_dev_get_resources(device, &acpi_resource_list,
 					     crb_check_resource, iores_array);
@@ -804,9 +803,9 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 	 * the control area, as one nice sane region except for some older
 	 * stuff that puts the control area outside the ACPI IO region.
 	 */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
-	    priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA ||
-	    priv->sm == ACPI_TPM2_MEMORY_MAPPED) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER ||
+	    tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA ||
+	    tpm2_acpi_start_method == ACPI_TPM2_MEMORY_MAPPED) {
 		if (iores &&
 		    buf->control_address == iores->start +
 		    sizeof(*priv->regs_h))
@@ -938,25 +937,21 @@ static int crb_acpi_probe(struct platform_device *pdev)
 	struct tpm2_crb_ffa *crb_ffa;
 	struct tpm2_crb_pluton *crb_pluton;
 	acpi_status status;
-	u32 sm;
 	int rc;
 
 	device = ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
 
-	status = acpi_get_table(ACPI_SIG_TPM2, 1,
-				(struct acpi_table_header **) &buf);
-	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
-		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
-		return -EINVAL;
-	}
+	if (tpm2_acpi_start_method == ACPI_TPM2_NOT_ALLOWED ||
+	    tpm2_acpi_start_method == ACPI_TPM2_MEMORY_MAPPED)
+		return -ENODEV;
 
-	/* Should the FIFO driver handle this? */
-	sm = buf->start_method;
-	if (sm == ACPI_TPM2_MEMORY_MAPPED) {
-		rc = -ENODEV;
-		goto out;
+	status = acpi_get_table(ACPI_SIG_TPM2, 1, (typeof(buf->header) **)&buf);
+	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+		if (ACPI_SUCCESS(status))
+			acpi_put_table((struct acpi_table_header *)buf);
+		return -ENODEV;
 	}
 
 	priv = devm_kzalloc_obj(dev, struct crb_priv);
@@ -965,7 +960,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
 			dev_err(dev,
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
@@ -978,7 +973,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
 		priv->smc_func_id = crb_smc->smc_func_id;
 	}
 
-	if (sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_CRB_WITH_ARM_FFA) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_ffa))) {
 			dev_err(dev,
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
@@ -999,7 +994,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_pluton))) {
 			dev_err(dev,
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
@@ -1014,7 +1009,6 @@ static int crb_acpi_probe(struct platform_device *pdev)
 			goto out;
 	}
 
-	priv->sm = sm;
 	priv->hid = acpi_device_hid(device);
 
 	rc = crb_map_io(dev, priv, buf);
@@ -1038,7 +1032,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
 #ifdef CONFIG_X86
 	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+	    tpm2_acpi_start_method != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
 		dev_info(dev, "Disabling hwrng\n");
 		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
 	}
-- 
2.45.4

