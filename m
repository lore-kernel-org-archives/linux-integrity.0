Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795014678;
	b=22ff8Cr3Vmq+pz4OxeEBdn6vgnXh/0WvBFbp9HrRE6BV86Fz6s59xF6GPfoLLzYfOY7f
	 +Eb5/vG0lwIbfjF4nuqmCjyNiPl+1UUw0TkNB7fzGsB4S5H1x4MBDm0SLSRSxp15rOIyr
	 EmWnBKgMZnmStoPDrvx9mRTRzF8yt1AvcwqKPo7iIBv2JBaiPSWEw6BKbXtzbPRECo/1D
	 vcxKLbwaYM6cKr+hb6qNz7w9fj2L2cMMCJaH2dyVcobOlu6gD8tTK+PNSdXGyOxBkS9G4
	 HVOXJxyr0BZFF3Yj8V6VypaFCHA+SfqjAAAmr23tnHqbua+P7nCU+aNMwA2IRH66wOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014678;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Authentication-Results-Original:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Qe8MdJaJ4Fr4+fGPQtb9uonGhiJU4RubB5X3sWaupkA=;
	b=AMnpZmJija5m5AM501QSID9+sru/o+QunbaOMwakAWyPKWxMTARbd3eWsJjeY9PxLUpU
	 OjSJcJWotUTy0JjR/Ad1TaybO0olqrX5Aq3TsC6kBqRizAJfi5PTECapluaODa6oKJ3K1
	 SHhxsKKv+kX5aX2YBRDu2mrPbYrlnUz9t6O4grE9hQRsCwIyx7dVT4cc98HCbNuwCq4YF
	 M111ezLJzbO64sg0Aba9Fjp4k4hwVHi3jG8/HSDqwSvurgJUcDRTcdUBseJ9TSJMj/7Sr
	 T+Uk5fV2SaOPBHaZx0ICJ6X8XhlSx5hmzLcMCfnyUlfhYTULRzyrpobXEjuT0Fj754w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ginzinger.com;
	spf=pass smtp.mailfrom=ginzinger.com;
	dkim=pass header.d=ginzinger.com header.i=@ginzinger.com header.a=rsa-sha256 header.s=selector1 header.b=42WsC2Wp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.122
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020122.outbound.protection.outlook.com [52.101.84.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991E606A31C;
	Wed, 18 Nov 2026 15:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C991E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ginzinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ginzinger.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ginzinger.com header.i=@ginzinger.com header.a=rsa-sha256 header.s=selector1 header.b=42WsC2Wp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6B9n6I6T5wT8LvyGIirbAPmgZVN+F7VdBY6tGoo5M85FdALQvfLhbC4yX1llIrvx5VJHMkN8xwTzeLqb4xHiE0LtXyjQTo1E3SCXM9l2VN37952PkWn9PsReYbn+7jMUpVddQvr98+7H7CnLaQEStiRe6NDfGjXSwIsE3lK+jczqIkszxsCMN3ht/RftqGoxtoS17a9t1p7ntawX0S+aowe7tFARPPuxTk0S3lmiDFk7+HDOkSn4T6/5+Lubucl85T94Vw+eQ7Iv1Rqm0Ct8bVYk4xEfHDpuLNkrbAEhQBi4F42xuRgZru5my8eH5QpypZv3RBZFPs1jqE722oESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe8MdJaJ4Fr4+fGPQtb9uonGhiJU4RubB5X3sWaupkA=;
 b=kiLMPv0eOm7Suw5eitGkmxrZCELKuFe3VXN8yJEAC76rW4vWTEJGogfaE8DAeFU4RsRzIOxeJyDIDunxPPaX5jEM9HX2yB0sYPUwFmgO5+plrKFmjRLRippzW8b+BSj7MwNqlR7btkPL8IiequfcQ2j8vgRUMS7azqei2rs/4l3QI0GRlAWqtYvYOPmrsFagZf8LFIBPvRELS5yhRIWVvpPY0IYNIOcmTVGGSfGijoNe1P9z/iFDgi63/8xcd/8pzepHZkJO8+lUi/6gDpWH/Yaml4MnyE1/D7B11FquHr3Rx1qmSwh3tKPshetrBzpjBgyEy8eqhdHDmY6kF6cMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmx.de smtp.mailfrom=ginzinger.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=ginzinger.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ginzinger.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe8MdJaJ4Fr4+fGPQtb9uonGhiJU4RubB5X3sWaupkA=;
 b=42WsC2Wp02I+bovdsOuBpWDbwSFg3vLh83gkOHM5y2Tu1E0wrhgL0vpPmvLaULlPVpPRpgH66XC5wVEFh8/cPbvHgR/AQ2OO8BsmAiyyQncLmbtj9P2UeeVbPK/gJMO3T+/Zj/IH6j1pM8R04fGu+3xpDlbwQIwmLaIvXEjNy3hItRbHLMVvQWoZXm94ntZ/zFHwQACUgQcR6GCuBH5dPYJGaRgzY9pzDFKYWjc2xxioYyJ01adRK4FRRrWBHta0B2g4L/M0FbGj4oOcNYZQ08DFfpw3bRT9hPuVz1csd6IKB6trciGVM9S2RtSmW84o+l13KJ2YX3F72CmVpU1fIg==
Received: from DU7PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::11) by PAXPR06MB8483.eurprd06.prod.outlook.com
 (2603:10a6:102:2b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:11:10 +0000
Received: from MA3PEPF00000403.eurprd04.prod.outlook.com
 (2603:10a6:10:50e:cafe::71) by DU7PR01CA0033.outlook.office365.com
 (2603:10a6:10:50e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:11:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=ginzinger.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ginzinger.com;
Received-SPF: Pass (protection.outlook.com: domain of ginzinger.com designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MA3PEPF00000403.mail.protection.outlook.com (10.167.241.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:11:09 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.68) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 18 Nov 2026 15:11:09 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=ginzinger.com;
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 (2603:10a6:20b:756::23) by AS8PR06MB8243.eurprd06.prod.outlook.com
 (2603:10a6:20b:348::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:11:06 +0000
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b]) by AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:11:06 +0000
From: Henri Roosen <henri.roosen@ginzinger.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
CC: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin.Kepplinger-Novakovic@ginzinger.com,
	Henri Roosen <henri.roosen@ginzinger.com>
Subject: [PATCH 1/1] tpm_tis_spi: add reset handling for SLM/SLB9670
Date: Wed, 18 Nov 2026 16:10:29 +0100
Message-ID: <20261118151029.1259673-1-henri.roosen@ginzinger.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0115.eurprd09.prod.outlook.com
 (2603:10a6:803:78::38) To AS5PR06MB10652.eurprd06.prod.outlook.com
 (2603:10a6:20b:756::23)
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS5PR06MB10652:EE_|AS8PR06MB8243:EE_|MA3PEPF00000403:EE_|PAXPR06MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: adcf8088-8143-490b-a2de-08df45862d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|376014|52116014|366016|1800799024|18002099003|261009220027099003|261009223027099003|261009221727099003|261009221227099003|261009223327099003|38350700014|11063799006|56012099006|261026140227099003|10067099003|261021123027099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info-Original:
 EazbQoSpLLs1pgcWhzRvaDpf9afdHnRygNmY0q9DcqyoqxTdGu0jFDHs1DprVnVv8Lfy3I2G6UkbP4wYJymW+RUHUUz1Sjes/NeVJX1O2ZjioGu26j+VoQkQONuAwIVy/8vyH88T5rtywcCtDVF+u5CES0MGUJyKksdY9PpH4M0Y99hHBttxFw3/cS4KESJp8n+QYZ93rfJGh+YqDv0Skz2CmtasEwS1FrMwsIgJQmLyX+kAOn3vLO5t0nZSJnFU+cU/fhFv/RMEb3BR6zredKf2r0J/9f9cXyTAJxY200A9X+31POMmkwlLIMB1lSu2EWhRXwnkMr/UQNLsInKZpAJx6LonwoO+l3wH6g0rTt/rAFKr9LialRa7aBmT0leRiSQhZG1wLZnIxbcUCPpoW+hK8001t9a6q1aD+qc0qE6O8P23l2i6T01oS6mgVWPbf1hEmsieuH3ABrxpz4GN0dRY/W2airC73l9t2BpkUSR6zew+u9rR4/hZRhDHSQAYGfwLxaLBPQuBedX+aJ1fPiZMKg6MoiYSthkp3Ctwci1tEYxYOdMk9s2FDfaREDiadOT2WWcUEEwA3TXxoovoNZOnCoMGYLLdBuKFCOGjAajIO5lhd4ihUBKHyeFgu+l1mNVneBfxQ55trpkZdtnPzSgqNyzcrsNelZdRFrGTsSc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB10652.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(52116014)(366016)(1800799024)(18002099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(38350700014)(11063799006)(56012099006)(261026140227099003)(10067099003)(261021123027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: c7CjCVyq2tH+dNDj8dRBjswXGdZYtVOsoL9rFkyh8sBhG5BdaE/gS+YlkyPyfeL7av4xrkHu35+QoZW7loUVE9t7um8qD2cr8oH9v1TrKgERi0zyYrLx9Xe5AC9G8knHArqzEgAa/zsY1BHus1N4UQUfcmQhnYNkzDrIvScEqLjxWZR1A+k3uxQqJ1eSnD2JV+iQXXr2cXc24nodDnbMbd8wXWqRahXV31GZ7WEmoLFqP0SFD/8T/JpCKPdvL9HwZS5pxyqLLMqu5HlpD2N9jzpTrg5AEJCuKz4Z1bSItVB8owAMooqvTPV+EmXFU+9IahGYMSZMwdf4fQILsPzJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8243
X-CodeTwo-MessageID: 2656bc8e-06c4-4d9a-b01b-88eec1731d23.20261118151108@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1d3a85c6-e78e-4c38-c75c-08df45862b60
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|14060799003|35042699022|376014|18002099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|13003099007|11063799006|56012099006|261028144727099003|261022105027099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022075727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	8wy6IbwiaP09gvhgwx8LFZW/qii5JBOGoeb4KhCtTmrBkaf24+DJO7i6LGDP7rXzQnDM49W4mdhPDZXSVRjQUM74P/iwPPBShkJCUVhI8oSTjkyC89PrDkmdqvD7t/erMFRa3FLWmk472BTwcEgyIxndmkT36QeO3EGJRHSR9v7Rdu5A2SuurEHhlXUrFKpgEKiS/40SA7uPbX58dUiEnhqqL+zyErXSsqZfkA3k6RxEy55nByxTR4VdvLkiRJdiRLKF4jj5a/iWMesnbjozJdDP05uv3XLSF3HTZMngAmZNAX17v57FQoEgzPxjWOzj31vBjvlimxSDZbzAom0b4Vs2iUNzdIhJCE63VFGibrAcvLsDfAdyifL33rUm5YQFHOozQTddQF9wk4lMKh4GLtAWKDXwDK92P6c+v4wI1Iip05fs15HVQ5nc8lSFb+P83mOzp30Uh8MgbID4+gXGj+Wt/un/P/dFcUR2OkdNrErnILQ/83hhTm2Pey9fWSuoLhacLQgyq+gjuH7HqeNVhyLI/kYa0lUsZoznmKdasS1g9q2hZeQgFcx/JgleockSABLXpDu6F23FIlARQP1CQXJZO/lok78XSThvXobsCy9GqRSNwYPVunLLNp03/R/dvhRp1YxuTnHwymRaEdpEINW+j2d4AhNtAKp2s636SMo=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(14060799003)(35042699022)(376014)(18002099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022075727099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wdi+QnPcnL9xa66Md2Nx9YDfPR8w5lFrzvaDkEOyLHjg4lCex9YDbTZ6GVfOGYTOVJX+Fn2xjv1A3pxtW0qOdSZOWbeUOJwFGtLgyVjwfUYqMWzj94voeSrTWQ+uUbVfNHKO9dIpcAp9iw/Pd6wyJ3ukJV7E0ESxavkTDY+tRfGBAX4bIXK2JP1XC6/sa2hfKMa3Y/Hui3VOP6AdZsA1Vnhopyiv75gYc0yZ9viMa7OfZS3oHmheFVilckjjhOMlD5XUZBG65zbIM4X6XRiW6WxcY/c6I7pHa52e6xe7iphjlCdC/eCvCmezU0NvLdPnPFecmfZigt3/tu1dqXjhygk1zdlIA0R5djpOZdOL6YrgJdmvAD5ObWFeSM/iPHZ3a1Wu1ktQigWCm0mFjXjRC8CoQDG/C8slZ0JmEZy41MGPRp2cEPckeFXwl7bTlar4
X-OriginatorOrg: ginzinger.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:11:09.8497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcf8088-8143-490b-a2de-08df45862d73
X-MS-Exchange-CrossTenant-Id: 198354b3-f56d-4ad5-b1e4-7eb8b115ed44
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=198354b3-f56d-4ad5-b1e4-7eb8b115ed44;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8483

On an i.MX8MP board, the SLM9670 could not always be successfully
probed at boot time. The first call to tpm_tis_read32() returned with
timeout.

This turned out to be related to no reset-line handling of the chip.
Although a reset-gpio was provided in the dts, the tpm_tis_spi driver
didn't use it.

This patch implements reset-line handling for SLM/SLB9670 when a
reset-line is provided and uses the timings from the datasheet [1].

Tested with SLM9670.

[1] https://www.infineon.com/assets/row/public/documents/30/49/infineon-slb=
-9670vq2.0-datasheet-en.pdf

Signed-off-by: Henri Roosen <henri.roosen@ginzinger.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis=
_spi_main.c
index 61b42c83ced8..8ed9344041c1 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -22,6 +22,8 @@
=20
 #include <linux/acpi.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -39,6 +41,10 @@
 #define MAX_SPI_FRAMESIZE 64
 #define SPI_HDRSIZE 4
=20
+/* Timings from the SLB9670/SLM9670 datasheets */
+#define SLB9670_RESET_ASSERT_US 2
+#define SLB9670_RESET_READY_MS 60
+
 /*
  * TCG SPI flow control is documented in section 6.4 of the spec[1]. In sh=
ort,
  * keep trying to read from the device until MISO goes high indicating the
@@ -287,6 +293,24 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
 }
=20
+static int slb9670_spi_probe(struct spi_device *spi)
+{
+	struct gpio_desc *reset;
+
+	reset =3D devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(reset),
+				     "failed to get reset GPIO\n");
+	if (reset) {
+		fsleep(SLB9670_RESET_ASSERT_US);
+		gpiod_set_value_cansleep(reset, 0);
+		msleep(SLB9670_RESET_READY_MS);
+	}
+
+	/* call generic probe function */
+	return tpm_tis_spi_probe(spi);
+}
+
 typedef int (*tpm_tis_spi_probe_func)(struct spi_device *);
=20
 static int tpm_tis_spi_driver_probe(struct spi_device *spi)
@@ -320,7 +344,7 @@ static void tpm_tis_spi_remove(struct spi_device *dev)
 static const struct spi_device_id tpm_tis_spi_id[] =3D {
 	{ "attpm20p", (unsigned long)tpm_tis_spi_probe },
 	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
-	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
+	{ "slb9670", (unsigned long)slb9670_spi_probe },
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
 	{ "cr50", (unsigned long)cr50_spi_probe },
@@ -331,7 +355,7 @@ MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 static const struct of_device_id of_tis_spi_match[] __maybe_unused =3D {
 	{ .compatible =3D "atmel,attpm20p", .data =3D tpm_tis_spi_probe },
 	{ .compatible =3D "st,st33htpm-spi", .data =3D tpm_tis_spi_probe },
-	{ .compatible =3D "infineon,slb9670", .data =3D tpm_tis_spi_probe },
+	{ .compatible =3D "infineon,slb9670", .data =3D slb9670_spi_probe },
 	{ .compatible =3D "tcg,tpm_tis-spi", .data =3D tpm_tis_spi_probe },
 	{ .compatible =3D "google,cr50", .data =3D cr50_spi_probe },
 	{}
--=20
2.47.3

