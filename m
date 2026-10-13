Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022083.outbound.protection.outlook.com [52.101.66.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B4078E0
	for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903139; cv=fail; b=dEeuCKMpXgkD7G0Q/VhX26OusX8gk4HDX9DGTdm6Ail3qMHj6liD3o6lsEsEp/lkzGE2SLcv9iD3w0nwjJIrjbgw8tJAY/MNDdpvAiF/veoWrlz2IaBMid7fsnXhgLYsRKPs7H6E0hGhpXg0Lf4+9EEOFeqeYMpJsV6GuP9IVvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903139; c=relaxed/simple;
	bh=gVi723DULjQ7VIKKJ58yIXOJiUf8DAbQ0Jz0Flo0lJA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NLA32yQtFeoZ/iRZM2jY9wkr/LAByAHHRPlM32PRGwl2Mgo5CXZ2bHcxBV2HCw0nefYghILICT2kqPQXG/cIKHjgRutofL/X/mLEGqcoww55DaeA1CF0DS6DQoSQQN3OhhAw0M7etemevlHi3KIgCM/6jLQ9yiP11sF7Ezk3wyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Y1HdCWlt; arc=fail smtp.client-ip=52.101.66.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="Y1HdCWlt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJByaFwniiN5+4i4d9u8ISuEzSW+z8I/dNfCtMt4c5nSblNKK1QL6DPWSjeAn1jvILqMrabsaok0OnlIwcUmuta8jRaFv/Vc2g6w5wWV1vld1Q6JhcpAZ28Ly6rcH0yoB/j0Et8Dk0Rv2iBm7jjeGvMO2j9NlOc94yw+efWPUdDVDDNyRSOwihatMWVhoS1gVDnTo5URIvdCidEkbOUZQ0YZvBnaP52KQPhONpDoqQsdVpR/9m8BQ87ZiV8WcGCqv0K7vyj5H5yuDBpRsaQjQw3crnsN5CwT29r9ubi2lwyWdPj7jKqjbd2LzUryk6DPRil/0eHdpMoUsNf252ngjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC3KGMLOvcKjkwJgeY9qZe8YItrwuOkD+o9f4N5XhBo=;
 b=eA61ZTf+gk/6Ozz86ZGNzr9Fb3CRXccACW+qTG36hqFDVO72HVvEwXxXghdvuMQWcrhJrquqEZmBWe9nXoPtid2SoT13uZxQ8uVRv0VyX5PpK4dsTRJucP71Aw2DXRC2KBTB6PhE3npqSKUAAjisdOCb8wqiL+FTg437IwSsIZ0apOxRF6y37e2x+LputCpoDhQ+WPGBdqAM9Nlmwd7fa5vtUoIDhCcnkImZZVYmSPuXUs55MaCgtDKFubGzQhrVCzwc1x7fWxx8oOVyxRl11Zze93CcnGuU9H9SGNr1opL+OKJD3UqPceCKvP0cQhISyqpg8uDZBTDJelbo8g9/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC3KGMLOvcKjkwJgeY9qZe8YItrwuOkD+o9f4N5XhBo=;
 b=Y1HdCWlteXUnmQa3Qw9p0rWVaH2RYDbW7MEMDBOE9mu0O4Xc4GQ9ith7T7JX/TCOhymM0XewIlynS8DvdwlaTDhsM1NJ30L1C6RadrIFRT+EYX+WfK7CDxMiKcvboEXXUKGvnaEYUusPoUtL7v9CRt5vbKsg1b7i1GA5xNaZYY8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by BR0PR05MB527643.eurprd05.prod.outlook.com (2603:10a6:2c8:46::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 14:52:13 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:52:12 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v3] ima: recover number of violations after kexec
Date: Tue, 13 Oct 2026 16:46:45 +0200
Message-Id: <20261013144644.134912-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077DD.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::41c) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|BR0PR05MB527643:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ffa8e2-bf4e-45a3-1494-08df293990bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|786006|366016|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WhvIp074xmwK+PfyJrjLHfZ8IUXmJb/zoJcTRG2akptw8a7pALLKV7YcJUuu8o60kilIluyJ3yxtayrXi6d2XBROiSCVQgnPHbjGSwnADALIpJu/oCInP1Elfw/c5hlOfKrdleQLEDKPr/QSY0jgQnd+UC81jgMyFPM2dv7s4mOnf7QPc+VaxhxjNVCXo+RX7W6cbWDNPuK2nZjnc21oAh3q8vJoW9d2D6nqX39pxLX528OBfvOqXRjohoSb2aLoZLTsuN9u9ipC8u0QAsoKEfJOUhyY+flFR6FkNam0r7UYuOMdtZNDsnyDy2W0ISRLTeB9vOfK/2HtxSLnqbdTmOj6hovBvU389ynmRyzkAK/oRF0AL5zwgib3jjGLiS0dZ8Zx4Vj31IpHFRmmcLrcSHcId0FGD/RCF069AGiNjhQGnI0wA4ns6AiAfHZvdbGulX11PbZqZ4AX1nrqjq2C8Kj0TUA9cW9nvT9RavhR9RI/BZp0CAZ6+TRGfSKlppvf+ZE2v3o7RhSqjn7lAaYgbl7Z66qRSfZGkKqptkFwUvMWbByn8Frgr+3k3qRKjyLzeGl1FIbR8WPXYNesVL10GAMg+gXxWKpGWZ3aVKIFbq/26BCqeNn0Fl8W5WMXVoz5Nust5uxV8X094c32ru22y51/iEhn52Mb3o3NKu3LybE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(786006)(366016)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/86K86LNQfRQbhu9he+ypO0Qggwg//kF8bXUNhfNY3y7pNb2GBXaa4R/vqzU?=
 =?us-ascii?Q?Lf+BnT4vj777gx/j/X4hscTrpen/OLG13uzEsmm/SuC/o3SEAc+fzjHA8XRq?=
 =?us-ascii?Q?lb7zwGev+x/PKHdCAXmm3D5Xd66CDhXkCUkGdNq3X0rO8gbLXroTYLLtXcpT?=
 =?us-ascii?Q?JnqJmIdhre1nAQozuQB8DzcOcNyYj7N6Z3sMXyPkpixoodIpSgvQlQxpNCDT?=
 =?us-ascii?Q?eVRRBFjrT3IZcjOqFdODV9NedjBi3tpk3lPAZOAB1/dcdSzhGkTPrPBH3zUc?=
 =?us-ascii?Q?KplEn0oklf0ecZ4ymeXrnjhr4HVCyIe733gb827iv78201yDyphDzcKSN8N0?=
 =?us-ascii?Q?ksscl8hdFzBvSLd7UTWERNmKxblu7R8akgIsosXpEi/iBOpM34Yv3syH10AG?=
 =?us-ascii?Q?UPDFg76vMujEpqTaWFZhdsthPOqlGKDH8R8G5Uv0NL8ywZBCPyZaqWxKxWP/?=
 =?us-ascii?Q?bLCH9LusqIpYCgQuwenkDLGwtZ7MmWDBRbqPmk29IrGNBRLWmKKSlrectoVm?=
 =?us-ascii?Q?4Fqv+0W7qiUgs/8rooSlDlV1jqBQs5GwgxQTBdaz1mBaJ7/i74YcWxo2k3dy?=
 =?us-ascii?Q?IzxdyyCWYeGri+RsDE2oG2ZxRYCEE5DyBg2HHd8IJACB3p0M9iQU8CFxaqq5?=
 =?us-ascii?Q?/iKV6ZM3hxhV+ezHgBgqjMJXUTveA7dD11Fxluts6BYtGaOeohnc/QExAyTh?=
 =?us-ascii?Q?QjI0FJHNDSUJlqwqlVex8h5mcjI9wm4IO3JTGSTCQWsepSGtrhQY97ed2K18?=
 =?us-ascii?Q?vjYVUVVGKRmZHyMYbRHLx8O9H4sH4oEKT6jP6/QG7qG606sQRETvKSjtDJFo?=
 =?us-ascii?Q?bQJ4vyBe7vDVcXyzLlkbZ7dLPz7mXLu6GWDkC61tQ9+0ORGjIExlcCi4Rc0T?=
 =?us-ascii?Q?w0S+6bCJhFDQDDwjTbXyOsrHevYsN49fwwjrDzLDFAcV9PGiWeKazEZP530t?=
 =?us-ascii?Q?D3Q88WzfJc5iVQr8oBWgx4NFqwf+Ou4zY3J3IhMrMaxAx8hyiIO4Z+D4c0Gh?=
 =?us-ascii?Q?w98ddCJHRvkudEoILeyLsr915bUvHcUDHgdcg9CkAaQOuGVXbJ8xsfrohq6b?=
 =?us-ascii?Q?jlwbjS3KeLlYXDkB5K0UISDsm7rlvCYfeE/NguAEb+dbXL4jjPX97pnHNqYH?=
 =?us-ascii?Q?IuSzQY2DFA/j6gHkZtkn4gASpp6uXDkNDOgkJn8ZxBNdrD/q20VprrqUHHIz?=
 =?us-ascii?Q?T+XvgAdfPS9NgD15J59HHaBMTJSL6eDrzYvPzDDZH3jegX5a9X3fzIrMjVIJ?=
 =?us-ascii?Q?mvHOthGz9trxF800M/3+kagUjSXKUPDe30v4DYM+ObjssvPRDv7kHvxWBncs?=
 =?us-ascii?Q?Bi2Bgh/s460tIKQS3voEWVPn7sFuHHWUsrKZBcUftbwvXwQPdyz6zjoOVFIC?=
 =?us-ascii?Q?OYM6kpEjqARPRaaghYdt7N62Fgc7WJtkbLXawXcbbq1TjFI2TXZP+vT+4D5H?=
 =?us-ascii?Q?aVg6WD7J+uEy2ni8/ioveh32ZfmOsu0sANvXpTymmpSQfUCZatygzwW9zJc8?=
 =?us-ascii?Q?G4uTWGYYUwQ7thB/9z3GOexDUPq4m38bcxWWuGhqHxb0zSrICuzZfNAKnoZp?=
 =?us-ascii?Q?/obX6n6YVMQfCJrQ4kK84z175e+cI6TeJrAJYn+LJ1Do4UIGxlGGfK1Mhb91?=
 =?us-ascii?Q?MSP2A+N7yUJLQqr9kYfCX2AlZdpBaDOtI9nvpBBealkCbHA2o1wVXXTA/bnA?=
 =?us-ascii?Q?Kqw6XLrY0AYDK5ocfChRA1xJqQBveAY8VoULzvBAvaEOAlCN+M4P19PFFyqT?=
 =?us-ascii?Q?j2nWMwiIOg=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ffa8e2-bf4e-45a3-1494-08df293990bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:52:12.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db9ZVNYSZLDOLAGVMzZflcm+HlnqUKQnaPGf5GJW06IRRFiSqS1FkKUU4EOgVWBfiqjcRDBDYVT2l0PDd/O2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR05MB527643

When recovering the IMA measurement list after kexec(), currently, the counter
of violations is not restored. This causes a mismatch between the real number
of violations and the value reported by the <securityfs>/ima/violations file.

Restore the violations counter during the IMA measurement list recovery. This
mechanism does not take into account false positives. A legit all-zeros hash
is treated as a violation.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Closes: https://github.com/linux-integrity/linux/issues/13
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---

Changes in v3:
- Reworked patch title and description.
- Reworked violations number recovery mechanism to not check for false
  positive case.

Changes in v2:
- Reworked patch description as suggested by Roberto.
- Added descriptive comment as suggested by Roberto.
- Moved from ima_algo_array[i].digest_size to ARRAY_SIZE() as suggested
  by Roberto.

---
 security/integrity/ima/ima_template.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573fb41e..daa897ccaf58 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -524,6 +524,13 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 				ret = -EINVAL;
 				break;
 			}
+		} else {
+			/*
+			 * If the template hash found in the kexec buffer is all
+			 * zeros, record it as a violation. Note that this can
+			 * be a false positive.
+			 */
+			atomic_long_inc(&ima_num_violations);
 		}
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :

base-commit: 1dc317438308c79cf90a6f14d3e4116347ea3716
-- 
2.52.0

