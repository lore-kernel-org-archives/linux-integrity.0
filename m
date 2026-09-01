Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63B3264D9
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298661; cv=fail; b=FTQWR/Aij6YwUxW8hFeriWZMA8Hfecu+5Hzd01bM1MAJoaCZbLwNottcSHXAKsXS9UA7LrDcs43ktXO+p9zzJ7rq/fmBCYX+1Cgz2DdPHmucsKHKBNaJBfGokSJ13ljzWQKCYMpwNsCMTTy2Xd3/rNX86iGff3ROYrVIZnFQSIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298661; c=relaxed/simple;
	bh=JPD1eUySXIE2T7y1dxZ/dsuGcq0Aq0m4hPWfxDcKuNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFmT1w9oPfouQCiCnq7YF0V77+8FcpHakX8Kk8qTCjdPRdATxDf2Hvi/MDXyd1ZH5+7gpiI+ZMTFce8cusGt7Kx7jETxSQCoPg742DkfjQ063R3r4NsTHjVHW5Ru22WQvrLZJYj1tV6IONi+Oxxm8OZnxOZMqhaw28E34g5CgN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wjjsdTAk; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wjjsdTAk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5cTVaLFtznNmRzJ31Jr5jW79snZUIa9aidKFxnEkQ7vLHw85kO/mqI5xgjXYNp7A5kUlYxX/7G/tlCCtVwt6n0tfGAdUYbvTtQi/wqzH+dslRQpL13OmEGZn+A6oEa0q4fyWK1bacUCFmYCKSmwyO59Rb486wwAoC7Ot3v5U/4N7ZAUcNYrXzpDHwJQho97mX9U113lvlGU+PsLT2twNBMtqcDXKN2IMxeQwLSmPls2KNwiDg53NGPtf1E5OoS1gQ0emc+xwIy1+3bglf4qMM2pevaDprPJJ55NS40fWmBVc1S9xg8BHzVFnRLt2tXoOsEiqFJ95aDww+Qvv26hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvd+5Fi6F2WttdUr+RiNQNhIAGZm4uI3GqMha/7kPig=;
 b=s3JI8QWR9VsaTNXxRe8PpDaoXVXQXv5djVsLWlkfHMiNVs8VWeEQewC8YN3aDPtb5xdpZjYIz1dGxJ+SCBZc/6rHRClrKFpFqfnN2S35iMuaGUp6TM+5dwsVlAm2iLy1EY/Fn/gM+ztf2qTMwM6uMkKPHXYOp5GvdUBYqYTl4UtXRlW7wsY96/E3lTTNBTFPU0PiP4fBD2fHzgoVRaY/BG2b+1smdVzNeUwXLzYPj+Kp6SHCqKzqTFlOnC5yMHH1ygfRBvtWnYmgPBSs5PMRusd4ICntxMaOA04X39oQZaQFzQOgWh2jETkIvniW1XhnVWg0GeptmikgBgJlP9skqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvd+5Fi6F2WttdUr+RiNQNhIAGZm4uI3GqMha/7kPig=;
 b=wjjsdTAk3jjpz+82lEOuzcyqc7vXpvUAwkBCqm7kQrTc/cZ6F1Nu4HDg+dqNIFzMz552xN9e9YpuVH30KYGWW38UjqnnCydgHD8bdxmE3KiUsn3FE+z6N2UYEjQwYLyQVsbf/1mSCMlCb3nRqu8n5UXKO4DCoYFzmckgxdFWUns=
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 21:37:37 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::1e) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 21:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 21:37:37 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 16:37:36 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-integrity@vger.kernel.org>
Subject: [PATCH v3] tpm: Call cmd_ready/go_idle for each command transmission
Date: Tue, 1 Sep 2026 16:37:22 -0500
Message-ID: <20260901213723.3017371-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: eea5cb24-ffce-4046-2142-08df08713dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	EjCeFTcdMWd5P8oZu+UN8eCsAShNpo1R7WVky+8YOAGMI29I5oOaQuXHO2BuICsms46BYYbWxnmpcTpHlVsEWz1QaYvQ2i8A5jINpVT8Vha9td5sxh8cFTUYKle8RLLyteNmJ5oDxN1qB7YR9L5O8psXY0i67wXtLCzW/fR0P/s424c0WIzVt6UwKj76MwHrt6M8V3UIAY/EQOZls5McYQ+5w4B8pAQs5TsS75tnAVY+Cr2QZuMx9dFbFGLTXKd4xkD+Y20Ah9sUhXEEV7rXPsR6WupWagPmAyiX/mfAmqTllTGVdNKEoagUgHL0B0OMblmhb4MdCMkqvNpaDK7CWBW+kQpCGDibFJ9FBOKK2c4cWx2oauaMOCFCS6Peh/tylON1twBIDZBssAim/Z9ZSvBD/UVh3XHbmwrtY32xi57QyWfQMHlDSEW91ErxBci9emiDBvs0PnRWetMvLeDJunLl32h2xDAmHjvpNfQg8se/ctAVSkMTV8nNL/gURtqZEH7XWhLd9WMAxVdBouiRNpxPuBhBUs2aMbP6A7hFqWLGEott+KPciq/ZVxDZC4wqSL0E+GwPK8skw428/+pBI4ouXUCNMRfa+sG1HFyDuVyIj7aS/C3UEVZ8CDcoiypuk3fnoD945pZ/o63xUJ+Y2lQusbFyeh7eYVxOObxlAFqDi+vf6J17mv8tW4uf68H7mcUdzz6XU8C/TMPniiezEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ni/+zLY1TeIvkXR3kz0LDrkb/rO//tkMiNEuW/rWc6R5XaJMZ+oHCJTNn00Gb65k8gIkiUtIjdTbG7/U/ky6+w3bYp21Cugoign3dIb1m357nCaqxo4J//7MCmtR9D4txpvYFYPQz590UeCJDukk4C+8+ejWYLplRaArfZxGBmOnfBWjnWY/g8rOyBR3F8KAlvO3Us6yxBKp2d8uL5pdHaL74/yE9UYEzq2uu86rIFkaUd32xO/naq2bwJN+VCQRhzoIoirORrR1B7KnuQqJ1yf7x6spdvVpGmIouNbCJdYRSPcoHeshyYtQxCTk4BNndJOeoQmEuz0s+Y9Ckja5PVTdyW3IL7hHQv1vBnl4mnZVaWqU1HZVyCQMMTkb13B+R0MQNwwACweb0BoS86/mjeZeiO1X3TGf4ZFC4tyr1plI2klVQk7w/dzPBJ8qrlft
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:37:37.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea5cb24-ffce-4046-2142-08df08713dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814

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
v3:
 * Use __free() to clean up
v2:
 * Drop redundant calls
 * Update commit message
---
 drivers/char/tpm/tpm-chip.c      | 24 ------------------------
 drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 24 deletions(-)

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
index f745a098908b3..8d434d7fa5bab 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -19,6 +19,7 @@
  * calls to msleep.
  */
 
+#include <linux/cleanup.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -89,8 +90,16 @@ static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
 	return status_masked == chip->ops->req_complete_val;
 }
 
+static void tpm_go_idle(struct tpm_chip *chip)
+{
+	if (chip->ops->go_idle)
+		chip->ops->go_idle(chip);
+}
+DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
+	struct tpm_chip *chip_idle __free(tpm_go_idle) = NULL;
 	struct tpm_header *header = buf;
 	int rc;
 	ssize_t len = 0;
@@ -113,6 +122,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
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
+	/* Ensure go_idle() is called on every exit path from here on. */
+	chip_idle = chip;
+
 	rc = chip->ops->send(chip, buf, bufsiz, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
-- 
2.43.0

