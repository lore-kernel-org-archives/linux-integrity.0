Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084939CD0E
	for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2026 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154664; cv=fail; b=TRl7kC1mfS48TP34cau4cVZeDCLxSjQqFxACHXOKou146gYJTITEXWkZl8weOfQBPTK/oY5eh79SYknAPxcnowmXopX3weD3y+msuTznFGvO3llHDCyhqXuBM1w0IzR7JiWufLT6eYFiMX9k+ox5N2ehVIlLmL0g19rrAWwW7eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154664; c=relaxed/simple;
	bh=e+XOF/JDU0d70yDhn8lT8fXzgjpAWQaMAWMyCEi4TqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atky3kGvVefmkuomIWDXIjkRMcjbck1XpCUWraz3z/3aXAHKQiSutWLZYWis3NS3md7/Mchv5kRSfdOfxsSyKaCkKg1TZMO3Y8A3BXpVt92r5eO6OM1TiDGOo6MaZeot5M5Dgze4otQaNQycSNILQJBWuzulzw5yczKeHyMs49c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQVyf9JB; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQVyf9JB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrt0PcTDihr9x+jShI/3bWGCEJNtM7hggrhxpCJthaiJje5k/a5pVN4+tIiaaj6Ui6sdxswXvdDCqq+gCjYuKIYJskibE5rfVfP9FIdBDNh8kVkqGw80yTKP/b+kEvEaF92F/PoMq+E4viDVgeaFCE0TVnqT0XqSEl/QmPpEn8+kMamGHlpB5NtydYyt0VSp+ZXIhKlDdn1uqjud9zVeFPVtfMrTugTZ/1KQzCvMeqSzkq34TkiVZ3IJ0OA2GK+r5odvohhr/ZZVnedMxxLID/SjcwkTC31842KvJ6gXvl7nq2HciFWFoMMM47qW1NrAGmZMnRgHwEZvDJ5YkTS6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmjziS0iW3OOh6vxlZjVY7zy9iNwJUzdwOc1z1pbHrE=;
 b=PtV2BfLC62taoy4QTbkUwuG2GhYtqehh0ZL50cBW40bN+gPAjmirN3ilyS32APpdmHvE1S+pp3FrFVfx3Gnj7mGV60cQGmd94lLv0jKvoVHhzdV+d3f27eGxrJgmojqjyJaJWfZDIUKyYV3PkykB9TECYhDB/dEiYM35qKidAbIoq6+x96llODCT88ORvfrepeSc9wsdjLuKmOB0rX5ouOF8WhOJH1SDGtP4y33abzcNYmoUKQ5y6tt61cGCIBYsKNlA4Kw5jHHp7iYqz9fzouFlEEe9pxNl+BPTidMmAezFSFjJ6BcvosAYQBP+z2JVktp+3x0pqK9mTAkjWT1AiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmjziS0iW3OOh6vxlZjVY7zy9iNwJUzdwOc1z1pbHrE=;
 b=pQVyf9JBVlTU/+mu0+2B1woysw84g6gHpnQa5zLKtc1rrb+ltYysro/OVo4ThNr2vX2ij3wupu1NNHf2uLI9cMN9F4qlAj9TIVL0uo7PRoEyccrw9TQiPuElgCHl1xRRcVvVlFYEbA7Xp91OEvNR9OjyLCYcLC0TAhKj9xA4GXc=
Received: from SJ0PR13CA0158.namprd13.prod.outlook.com (2603:10b6:a03:2c7::13)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:37:36 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::4f) by SJ0PR13CA0158.outlook.office365.com
 (2603:10b6:a03:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:37:36 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:37:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-integrity@vger.kernel.org>
Subject: [PATCH] tpm: Call cmd_ready/go_idle for each command transmission
Date: Mon, 31 Aug 2026 00:37:21 -0500
Message-ID: <20260831053722.1879772-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: ad000fe8-24d2-4e5c-6d22-08df0721f687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|11063799006|3023799007|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5hzyuOrX+xdtbuhC4MiFO9g9Ga6nvpTTzpcbVXBN2Rs9RMCSa6N+IVieofYAdQkW9LhiWZ0g8PF0FT4COEv5vwipOuBS/idewUKfHzUyk23n/m2t9dbFxVo1UgQI4X4Xu9RIZS+r+lN7WlIYGHzPgq+CBjV3QjBoYgs1weiLTTz+XRinaD6Y5qTpWl9tePkjHfQz/j967ygUvToiRl4gnYgytbQ40HPQ2nR6rj9wuig0pLVLqLsfrtbugAhqN3lTBiwjbxDOcI64NRaJ3EVJc0tjUkpVVDjqZ9dQ1hgyPM4QxoKtAuQFxQr6kEXToNd+HDOQFgdXmSZPwcmyKNyjQ4JDaI7OpUx5XRWx3LAbYjcmUQeuvXeG7Qu4auQqNOAb7w2jqc7/GigTuz9R/X6Bf36d4mAlnw+eOqYkbA465YNkuaXeMXsofrMIYctIoCgMB+19061wONK0cM9WZ/VETK7UIbTbZPfZSWWgQijyQDGGvCccsAmXqcznxAPlOrUd5SLhLZZTCCH9ltLezbHp0KfrtDlWbj+6Yznl00o/9wMKJgBcPbzE0Xx9N9yESWRD4BqfxLopp+tNoUwA2ilPFzhHseSRWSuTDF2AJHFWnMhVnz+b815l5KEo5yQHaORjjTxF0eLv6B/YcT9pWg6IJE7MtAWH1LpFVFpNzOOiCBrihbqnGLw2OgeXICQki45wehrMeOek0kchSgPCYekDcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(3023799007)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xxcut4yET3CkVwC3LSksYMrL1nJcUJi5evjP3d61n/sLJHwJgfSKVK6nvpxidVHdzsalIuDZX5RtwCNj3Tlp5QZGMaPNMe2UntXHy0dEi5Fy2lLgbHsf0xe2BF7+mg11A8PUKL8Jb/KR8lYkiNkKXDtn+lPkNGnUlEBmGsYTI7WWAeBSeloXgGjy+L/2P1A6O2x8eA+ZkQojvHrmp+p9bZXd1gO7oT03R/M/1/OEtb5abnynJfdAiHOTzn95NJW3TqibzNqGlx5raY1DnaNqAv7vVIxNP//C4K6Zha6zwXVWjXnSRy57hnb3LcDeueqTbTQB97a3cgFB54YEffcgbj7IzeiRBI44OHqosLw+uwVTypzChU89SeUf/1Xm0vKobf4TEA4FnbY3IuYayNMlBUDXVnbjyXb8iFFUTi95/Ano4WF3hYoUXvPBUR/D6NK2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:37:36.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad000fe8-24d2-4e5c-6d22-08df0721f687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

Some TPM implementations, particularly fTPM using the CRB interface,
require the TPM to transition through idle and ready states for each
command rather than once per session.

According to the TCG PC Client Platform TPM Profile (PTP) specification,
the CRB interface includes an idle/ready handshake for power management.
Software should set cmdReady to transition the TPM from idle to ready
state before sending a command, and set goIdle when finished to allow
the TPM to enter a low-power state.

The current implementation calls cmd_ready once during tpm_chip_start()
and go_idle once during tpm_chip_stop(). During the startup sequence,
multiple commands are sent between these calls (self-test, get
capabilities, session init). For fTPM, when subsequent commands are sent
without transitioning to idle after the previous command completes, those
commands timeout as the TPM is waiting for the idle transition.

Fix this by calling cmd_ready before each command transmission and
go_idle after receiving each response in tpm_try_transmit(). For TPM
implementations that don't require per-command transitions, the callbacks
can return immediately (as many already do based on the start method).

This resolves timeout errors during TPM initialization on systems where
BIOS has already performed TPM startup, as the kernel can now properly
communicate with the fTPM during auto-startup.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b3..a98ddca876152 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -113,6 +113,15 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
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
@@ -181,6 +190,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
 
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

