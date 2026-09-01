Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26384252B7
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280355; cv=fail; b=d2Ev93SIXiTSIiSSFvxDsh0jrAWqlV3NqGss5bb3uftGlQRfU2pWQ4eZ3cRRds7rlWASJ4lfwOdeN0rvaSG1M9KA2mZLFXNxng7CvfzilqvxnDAxT884r2ULn1XuXk7+kTrMwjBG1y9ovDYaRK9j8EhT2mP4JMmyC76vT/57DO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280355; c=relaxed/simple;
	bh=tVJ/46wBurDquQR3n12I2U/nHVS7IQ005oGmr7D0dYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEb5je7tIVXQpcTQ7EtCerq2jNh4cC2CjrYAVIPN6CH4RXfZIfolg9qKXPexRvFQ9S/RXiBVa66BboRhKHtgmHGEatEkyxTe24L95+PwpMH62W/BzQ+1iCAyv2azx/WIMoJN+RTSIvSSBDmpM2QZxtqk5evPMn4jzxyzrGLImOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y631lBYk; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y631lBYk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoyS94VlfxTp9pcUg+Ekch3+gTfxuFixogHf2Q8JU3xjWV6Koiz8BUnLpU75pHM6FHI0oPdf8Eo7m1+zy2aIVBs5ITc9wN/gbcknf4FEmV0A7FlVZ8LOEQ8DSbpczsKlJQwoFdX+3/0n6EB0UZZZ9FJKmmi3xwld7G/ZelrTpjyGmVGBRs3P9iIaaURiqNQx5n4SU7IAGNmUIClsTBkZCHpMe45Et9tT9uCWZxcZOB3wkb3IAJ7PdNUJqPtYG1FsUrsf1hmZHf/S/4T7vVK69s0nuHobvK8/XsR+8FL9dDPf470s4ecOwqLDKWfaWGn6HCbzhQIFcQVdKBbQ9boE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NC6QnNiHnrYuGm+jdvHK3jsqb4AV6l357orNM5+ZYQ=;
 b=sZypl4dCTcEiJEzM6WbLNULg6KPwXnxaQMgXcnOTjVvo3UJerAbzDwCzMor0L8ajgGs45i31yJgarVi0qjox0JkLkGkpGI0Kz5KpKnn8dkK35y+PuaIdKvhVd/EXzU7CCYcjuMgY1u/+tMDclW3/hsyltsmaQmaJVGOuS2jUSlroOnht95qCvwfzPSDv3d/6nJuwyoOkrnk3tdG1k4HQHoNcOUkxZvavRS7WorHDQhU6AiacF9CkTRIFyHjX2O1Se7n8URtzKidpSl6OCVZHTzcDSbxVLWqWuFmV8XFZWacQy4okkEl3hddbnXC0TTrG/t9zPwg8TayljMRfArp93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NC6QnNiHnrYuGm+jdvHK3jsqb4AV6l357orNM5+ZYQ=;
 b=y631lBYkHrIwO3TyTbYldKB2u4X95SIjXcgAM4YAXLokvXFf6dW6nPOZgw/EvGTnthTLTBk0YQKmaWRuugNOyjbDJIfui9t1vdDPVtIH2FE6LUiaClEGL6XALtM6LijkX+0rmEOmF8SeHcsT7Kz4Fl2aw3PT3jnI8XfechDgatw=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:32:29 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::78) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 16:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 16:32:29 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 11:32:28 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-integrity@vger.kernel.org>
Subject: [PATCH v2] tpm: Call cmd_ready/go_idle for each command transmission
Date: Tue, 1 Sep 2026 11:32:15 -0500
Message-ID: <20260901163217.2749911-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 10030513-0a69-47aa-9886-08df08469d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|3023799007|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	2lAX0bhXRhOuccPOZv71xKp2KpVRFOkSsl2DQxGgucg2IofupDtq+NcxpzQ5LWu/FO4JoIF1z/OAE8AaGlAl+R0g+jWqsQaprtDcgh/8Yl9nXmXG+HZoiOTH/r4ZY7wBAiA6RbklYm7Yg5GoVbDptwJVID9Wq0/4GYBML0c6tLIagcf+GX+BHArDdp8DdGYnxb7fGE+q4pCJIjv23e/W5/1u4PX/Qidp4W0EtxdcTImfG0aUeCf8cjE/sSURWFazOgbUxNqa9HRVoc38ZDxZKbWemf6VjW+CMj+tKoGlG8Z98TjSQ7pRviRih4k66qUu+bjFuuvpL395W2YQY1MSYweWpja8Dn9yUCHLfx36rqpBSFVDiCl5qpFjkyXQnSyGpyOnXgEdrbaM9VWbNRqOu1W5yooTVG3nu8UkChzVQwFo9tM1+MUA9K81KbZCPjGvaXmchPZsAFsR/CKV0eO9Sln5fRZhjDfCYJbXH3hnm5Fag0zdkd+mykMSc6jr6CEO8vK9JwE2UsjvKYGv7TQzMKbWs6ISOrlGvpSCh9+odftsyFXPHknYDkzRKRPOFbDjByIBnllW9PBTk5SRYUzNPOkeuyJhc+5gzUSiTt6Hkpvk35eC4gcTWd9yOTAWebW0gDgIgPZRHGpvr9fcCPenvhzclbtcqEcIWk0PexqVaMTzd5q75iz+eqihFgFjqLooyS2iR3h2exDHNO/kfQGIQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(3023799007)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lVWlKb+nYFtwa8l7vjl6PuzPk+eLP1551uAdwlS+XTx3jS2Dn/iebyhf5OdGlUW/qyTwr9AtZnMDZOqdt0XFK4t66akymOiOIpCadMMuKAYBSlreN09RNQtdmpobW/sBwYtS4HshIgt7whlAqAaON7Y1fkzp1qL2osNw22Jb+ykZm1GAVdTt262C5AiFTO5SPdYGmjXorizfuq3l75a5aT1NCqkJblnjzmkQMfnTkpXzMvUsycYS88Hq6zkr8WF92emGx0bChI1lBpwLU2zr+iILOnHJjYE2Sv+vcEwrEa+FGsaP2QCAjtJ09CBS0ZGAvNeed0Ws0O1DI8YmobqqtPH5ZTvvw3/HsDOnV3pEnsRFv+c1rB8/74bvr46qhbuUd8oVYONg/3ywd/bdTe9C0YWJVAKq2PFOHJheg4l9KXPLEIjdaNNrN6Dop+2UO5MB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:32:29.4156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10030513-0a69-47aa-9886-08df08469d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Some TPM implementations, particularly fTPM using the CRB interface,
require the TPM to transition through idle and ready states for each
command rather than once per session.

The current implementation calls cmd_ready once during tpm_chip_start()
and go_idle once during tpm_chip_stop(). For fTPM, when multiple commands
are sent without per-command idle transitions, subsequent commands timeout
as the TPM is waiting for the transition.

Fix this by calling cmd_ready before each command and go_idle on all exit
paths in tpm_try_transmit(). For TPM implementations that don't require
per-command transitions, the callbacks return immediately based on the
start method.

Remove the now-redundant per-session calls from tpm_chip_start() and
tpm_chip_stop() along with their helpers.

This resolves timeout errors during TPM initialization on systems where
BIOS has already performed TPM startup.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop redundant calls
 * Update commit message
---
 drivers/char/tpm/tpm-chip.c      | 24 ------------------------
 drivers/char/tpm/tpm-interface.c | 26 ++++++++++++++++++++++----
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 12b7394b34bdc..0be5dbfaa72eb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -66,22 +66,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
-static int tpm_cmd_ready(struct tpm_chip *chip)
-{
-	if (!chip->ops->cmd_ready)
-		return 0;
-
-	return chip->ops->cmd_ready(chip);
-}
-
-static int tpm_go_idle(struct tpm_chip *chip)
-{
-	if (!chip->ops->go_idle)
-		return 0;
-
-	return chip->ops->go_idle(chip);
-}
-
 static void tpm_clk_enable(struct tpm_chip *chip)
 {
 	if (chip->ops->clk_enable)
@@ -116,13 +100,6 @@ int tpm_chip_start(struct tpm_chip *chip)
 		}
 	}
 
-	ret = tpm_cmd_ready(chip);
-	if (ret) {
-		tpm_relinquish_locality(chip);
-		tpm_clk_disable(chip);
-		return ret;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_chip_start);
@@ -137,7 +114,6 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
  */
 void tpm_chip_stop(struct tpm_chip *chip)
 {
-	tpm_go_idle(chip);
 	tpm_relinquish_locality(chip);
 	tpm_clk_disable(chip);
 }
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b3..c5b5b5ba41821 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -113,12 +113,21 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
+	if (chip->ops->cmd_ready) {
+		rc = chip->ops->cmd_ready(chip);
+		if (rc) {
+			dev_err(&chip->dev,
+				"%s: cmd_ready(): error %d\n", __func__, rc);
+			return rc;
+		}
+	}
+
 	rc = chip->ops->send(chip, buf, bufsiz, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
 				"%s: send(): error %d\n", __func__, rc);
-		return rc;
+		goto out;
 	}
 
 	/*
@@ -152,7 +161,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 		if (tpm_chip_req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
-			return -ECANCELED;
+			rc = -ECANCELED;
+			goto out;
 		}
 
 		tpm_msleep(TPM_TIMEOUT_POLL);
@@ -168,19 +178,27 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 	tpm_chip_cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
-	return -ETIME;
+	rc = -ETIME;
+	goto out;
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-		return rc;
+		goto out;
 	}
 out_sync:
 	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
 
+out:
+	if (chip->ops->go_idle) {
+		int idle_rc = chip->ops->go_idle(chip);
+		if (idle_rc && !rc)
+			rc = idle_rc;
+	}
+
 	return rc ? rc : len;
 }
 
-- 
2.43.0

