Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BC4825D4;
	Fri, 16 Oct 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.75.33.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168745; cv=fail; b=OLPU8jbGWIMaqObT/IGQa5vAjCUyC0/tZiWVYJ0ABjmoJwXQBsQsA2/T8lKYeo9UNwq/P9MjZO3Ar8HkGer3h3taPGdRIRxre9uDFFZPZhiC6pIhlgkUB0NuDLijsbW0lzzJXnoEhC2h/NYdH5QzvM63mG0QhWVXbaCD7BwvPIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168745; c=relaxed/simple;
	bh=PBugvBdLHBFbCo+/ZRAM/oneW3fEmp3EhUJBeUGm39E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bd8P5ALaOFwpPi+Rp2M143ua/MsEbFjrcdJKdhCNNsFIKVspjmFnez/ZlPjAMv07vcCA51xd/ElV/D0VS5NXrIoTF9wXyZo4XzZlht4Lcvf/nlvGTBMDblI6YivFGfbL85kmsQAVd3eGfL14gjPIj07GXmix0vY/3SXa/iy1EGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=PP6wK3MJ; arc=fail smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="PP6wK3MJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792168744; x=1823704744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PBugvBdLHBFbCo+/ZRAM/oneW3fEmp3EhUJBeUGm39E=;
  b=PP6wK3MJQ6udFx4f8tjfs3lTgPxlLLWEEuFboDUuF5SE1mqQZ52zATNi
   TRx1mWQmzJD0RZ0d/LINzIZdQI2zDgu3NjFcsbcOaN7EYz11m/JaQUlUM
   htuTF4xYZvrMchmMyl+1AcxYtmmruaqjfM4SrF9TkreFS0L0vhTHgtw8L
   khSMjgsV6SLD9oZzllAqa6T9CkpF85rguke/AdOYA3VuLr02t9XI7UZyY
   1tAwIh2Zqnbrl+yf0N0oDEdMNhDoSoWPcPdwtL4hvHEmHwAu/iPwblqac
   v8bthBFm6JBXFngb6Nwq7N/NPN8Jk1jBTmCadDFUcFEdzNk6PxV1DerVd
   g==;
X-CSE-ConnectionGUID: 2atOz7fSRq6zNhOmmQtlNg==
X-CSE-MsgGUID: dpYIodaASXCkj+senlRP2A==
X-IronPort-AV: E=Sophos;i="6.27,162,1787011200"; 
   d="scan'208";a="21285671"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 16:38:59 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:7591]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.13.72:2525] with esmtp (Farcaster)
 id 47342587-f374-4919-8ec9-1cda8885a95f; Fri, 16 Oct 2026 16:38:59 +0000 (UTC)
X-Farcaster-Flow-ID: 47342587-f374-4919-8ec9-1cda8885a95f
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Fri, 16 Oct 2026 16:38:58 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53
 via Frontend Transport; Fri, 16 Oct 2026 16:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGZFjptW20pjAHCK3GcigKb9YzBqVV1LhfMMmfNPVwjMV9AZf32FPAKyhiQhz/tiB3Phg5GBMqrQ2I4JC/k32kkuRT1lrotURG7l/DyJzewYl8ousibpqYJtueP52e//yABWaueI6o1ANJyXqXH/+kdqg4Z1HLVgtPjrhiPg7jRzYxX1urF4z2B0UJVGtNpMfDKhd5AoNZv64YZ9L2PDsWwThtXRGNPTvretqLwAU1CBQCWCjvqimQkwGkYxTrNU2Fs+YwMMRnBEdoHdr50lfwyNvFnex34kkBTEcB9gPTeCnWZxHf7+AFOm8UWibJOxMzHbRnvv9OBn2hg9P4ZvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBugvBdLHBFbCo+/ZRAM/oneW3fEmp3EhUJBeUGm39E=;
 b=kzbTx2RaSN3vwA6VKfDhml0ChSw/WLmWvAyPY0Ea1NXgr/tV949QrIq7JQ9zYDf31dMvznDkeWojTpArXScU5kC7wEdw9sqKod84xO4gZ4Oc5rvlbUZR0B4a9IkguN/mOFT7UplmzblComdOTk9e4l0JO5AoiJTZFHJIpDsV4gb+S2MhjT0iepRUb1qN7RheUtbuH3clszaPpCva2snT0+k77peuWE+B3NmL51C+9l7O6SCAJi+zdwCmGflggvjNKtWHwuUr5z9cdje0MeXpZfWXV22HBTV2Cbx28n91mCKRq4y/ZXzDmQHJGaJxDQ33qJqGcSy5ZrTExul9nTmnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:20d::13) by FRSP281MB6238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 16:38:56 +0000
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d]) by FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:38:56 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: Jonathan McDowell <noodles@earth.li>, "Kanagaraj, Surendran"
	<surenkj@amazon.com>
CC: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Breno Leitao <leitao@debian.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "Kudrjavets, Gunnar"
	<gunnarku@amazon.com>, "Levinson, Josh" <joshlev@amazon.com>
Subject: Re: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Thread-Topic: [PATCH v2 2/2] tpm_crb: Raise durations for Amazon NitroTPM
Thread-Index: AQHdXSglwjNytGL1u0KE4h5gonGGNbcAXDyAgAADHoA=
Date: Fri, 16 Oct 2026 16:38:56 +0000
Message-ID: <56bd8d2f-bf22-4a56-a845-674377b086fa@amazon.de>
References: <20261016043733.30589-1-surenkj@amazon.com>
 <20261016043733.30589-3-surenkj@amazon.com> <atJQgXYkFjcQROb6@earth.li>
In-Reply-To: <atJQgXYkFjcQROb6@earth.li>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB744463:EE_|FRSP281MB6238:EE_
x-ms-office365-filtering-correlation-id: af97e439-ac73-4f73-197d-08df2ba3f8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 84g8eWzZG9agQk2Sp4nrrMNk2CBMzDOmUTmEtcR9o52RhXw1dWZf9mtZh/Tubv3pzS5wFeM55qQetezFNciBYP8m1cdJuVHCfAtikxR6RkEDEwJ2heyIMgvmZ7TgxDK0vRVb3elgpgCZgxmk+5Qs/28XjuGQfzj5NKkDPJpIoP5DR9D9c9ko60V2YHv/rNi51WMW1LgK0SMWoKPJW4V9qoxga6RwovYmD+imOOMo9eZNHcuWFuBYhOb0BjmHG7iFyTXDboGynZhOsOX+8qZrqiHRv8wNE6qOwM7ZjmHcq9zswzZ95iUKSQw9WUlu8BDaVQS96Ql1X9pd/RFkuxC+qBcuH3p18v83lTiAmUA+HPVpYBsKxYgqC7va6e0lM1Cm7X7O7i/5FcdbQ1y9QJWFMZoPikk2Y7J9AFE2tbxyfGUfayjYaJN6eAirVLp7/KXNsiltyf1tcyMc+H7ltTQTrYzfOQ6RTt5wZRQn9iWzZ5em6/vgUO+9+mqS6aq7/mpksV1KtSdj9ZolUFHVHm4TQmm5s1JNe7hIJhRWjPv4Ekt0F+E/F0YPtZfhUlQFdFOXe44e3mwlswyXo+dJItvV6hutP7isUVyk3hTAFBQob0RgXeOvraQxbxtyXGy0TDW9rHnDykf8wOqwJ9+UshZJmivN6Asog33u/JTR0xZxR1FJre6NBbKgxRPffzJkBw0SCNd5pLSMTnmf31ZwGuRuYwsmFN3huZuIhDvW780/oKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnZZZDJqZ2ZlcGdObHdGVkVySWlGZUl3ZU9Dc3ZGVTRXWTZkV2xuN2Q0NkUz?=
 =?utf-8?B?L0NTUDg4ZytrWlN6UkdmK0N5MHlrRWFIUGZnai8vSkhYQmc3SER1amRYT2xT?=
 =?utf-8?B?ZHdZQmJobUtEbVJxcW9IOTFXTmN4NUl6US9Na095OEhKelE5ejZuTENRemh3?=
 =?utf-8?B?NTZMUkhxNm1kUlMwQ2pWR1ZTSTZRRXRjS1RudTYwTG5HcGtuNjMyMWJWVDR5?=
 =?utf-8?B?dmRGQW9CRWkvbzNRWVQyVHJFS1NoQ3RpaTBlUzl1YzVNZ3MzZ3pwU2ltdUhi?=
 =?utf-8?B?cis3MkRFRGlTSlZIRWFJQWdTeXVVSE5SR3BJekc5aVdGa3ZSY2NyeVdZdnpX?=
 =?utf-8?B?eWRkb2J1bEcyeHVJZ0ZwVFdaK2VtdnNDTmpwQ1pVNkRyRzMydlFSYlBKd2lv?=
 =?utf-8?B?UVdrcDVHc2ZOU2hCVHRRUThLOW1jU1hxUHNHSjBrakExUm8yQnMyKzdhdmJy?=
 =?utf-8?B?WlEwUU1pV1U3MHFjWWhwQzRjMHhPVmVKVE8wSHNud3NKRVVFSVN4RzM3N3By?=
 =?utf-8?B?T05ramIxK3BNV2ZyQ1o1b3ZveW5rWHUrNzFMN1dycGx5SDkyQ21RY0RGell6?=
 =?utf-8?B?WjlyRWJ5cDNCdkk2UEs3M3F2cEx3aWVFTkxTYk1EeE5jbmpRdFRXc1RranlK?=
 =?utf-8?B?TlNFSU5rdDdyTDFNY0VjM2dBelFaNzFieGx6RU9Fa2tyS3poc3lkVGttVUdF?=
 =?utf-8?B?SU0vK1U4Z3hDUHN2ZVJUTHRCWUZRbGlyeVgvQ2pueGtEUjk1L1Zlc0VvU3Nq?=
 =?utf-8?B?WEI1N01FQkx1MFZIR0toN3RUWXdRYjgvQk9jNzZrSkRLdHNxWDVlWkptWlg5?=
 =?utf-8?B?THNqSTFuUXFFd3NrVTh4Y3dzVyszRWhJYmRNTU9tb0o5R3VSaDBCRTM3Q0ZL?=
 =?utf-8?B?b1daYU1ydG9YUU8xUFlTeUszRWFzYXh5YzVMcDZyRm5tcnZ4WDliWEpibDZX?=
 =?utf-8?B?RW9KWS9lSjZNMURFZG81TlZpeHpMQ0lTbU1NK3AxRTk2MWhHZHFhckYzK0Ir?=
 =?utf-8?B?U281cVNEWW9jMEhySDl6ODNSdTg3YTU4d1V5NDkzSmdvWkVDRks3aFJlUlVL?=
 =?utf-8?B?SDQvc3JiaXpaT0srb1FMZytOTDhyZ1FsZHErc3gwN1dUcENLckNPQVJ2TFhJ?=
 =?utf-8?B?clZRbUFjR3pIZ0RhZkVuMTRRSU5vNmRJZlNnbHQrL0l2Z1FyeUZkMVdoTGd6?=
 =?utf-8?B?dTlaY3pKbklrUm83ekpGNHk5RHlDY3oweW9DYnVqdVphVzlScWRHT1AvZ1FE?=
 =?utf-8?B?ZWswODJ4VHprYi9UMVA0aEswTzNzOUJIM0NicFFwdFRiUzBlVVRWZUROekZh?=
 =?utf-8?B?UHdiSVVJa0F5RVpPek42blhIMnY1Y3BQQUpoVjFrUFphbHlPL2pJUUxpSEI2?=
 =?utf-8?B?NmlGRG8rK0QwWW00aENNa25Hdk9BN3NiVmp0VThrSkx0dkJUK0FCTGJWOFNn?=
 =?utf-8?B?V3pvSGdNMWFFdzZBWVVtSlZIM3hsczFSaFRud1FRbXp1Y0puODBEOEZweTZh?=
 =?utf-8?B?ZnhuOTBqa0hoMHI1T010VHpaR0ZmYUNGYXZrY1B0MVduZzkrakwyM2tOQVdR?=
 =?utf-8?B?cmhGVUNsRUp6bjBNSFVZSkVGZGpFZWNnMXZHNXF4a0hwWHV5ZmVPK2pQUjRo?=
 =?utf-8?B?WjhvR0Voa1c5amdVeDVqSWE3dUpUakd3WkdyYmFkMkt1ZWRIMHpMamFLT04x?=
 =?utf-8?B?MUtnNnpBTG45WFpwdXFRbmRIOEZBS21ZSGdRZjk3c2s0WDlZU25tVHg0WGZ4?=
 =?utf-8?B?bjc3eW44UDZ4M2VaTS9LRjV6a2VqL2hYYVZBeVhlT3BPWjZibXNMSTJZcE5v?=
 =?utf-8?B?Zml6VytsdlFTYjR0czZLbE9zRDE4UzJ4bG55MXpsd1FqV1dKakdzcE12OFlV?=
 =?utf-8?B?VjB0Sy9UN0JuNU5XZTBrUlpCVVBvVFBqbDNrc2pab0V3QWVTL3FtTHFycEFw?=
 =?utf-8?B?dGQ4TllnZnQ2ODJVYzlHdzZHdlhvc043MWhVaEIwZGpyQ2lGVFhQOFR1REYr?=
 =?utf-8?B?SDVBdDU2YWRpTGR3QnZtRWI4UnFWNU0zNTFDYVBHaW4zQk9vaU5XUzV4ZlAw?=
 =?utf-8?B?Z2NGUDJjU3BOdWJNbEM0TkZQcVpPV2I4NWt6QXNCb0pDaDFwcm14WlM5U1Zj?=
 =?utf-8?B?T2FpVGwybVVJbnAyMjVuUU9yK2xyNS96bkpGdExlL21MMU9USm54UVNOaS9s?=
 =?utf-8?B?VEV1dERzK0g2ZGw0a1BGQUJrN3ZZSWxKUHZPazArUVFKVXEyaHRLT3NpRXVa?=
 =?utf-8?B?akZ5RTVVbW9tdFVPZWdpTTlyc3VpemlaUnhlVmJLd29Gc0lvd0UyRGtDSDN5?=
 =?utf-8?Q?cMD9dTbg9qSYoVUFUu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEED023C849A6444B70083B423E3C415@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XdJ3GY6qTZBrcLqt/BDan2v+VEK09SWXbCg3hI4Daq3yyWnJJ5OHdhTreMhuJLxvUEELcATDQgkb1JU1pz9BwG+1AFLPdvWpgvjDpmaPg+pKzpLYK/tby+hqutYvm5dtn2/s1NjIhaAj+ZCW2QdNQF45x+x2sVoJdyD5EeI7+6I81EdNReNE/mg+YLhVVnpnuG/OKhjTxV9HswEzW9QHdZf0OPcu2SmWg3SUqiFLdsfvKTOOteongvzmskzNz/P/H/b5uIENYqoEm2m1cIm+AmauGu346I95xVybW8x3OdDxptvmua/DQqzjkmP4TcRyP02jF+4UdnByxnYMBe59HA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af97e439-ac73-4f73-197d-08df2ba3f8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 16:38:56.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HY2QOWV5LHzQrySSvQpoWFrXl8CXmdj5z9t4LW+O9NGMjO6gJpaBKRptVzxsSzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRSP281MB6238
X-OriginatorOrg: amazon.de

DQpPbiAxNi4xMC4yNiAxODoyNywgSm9uYXRoYW4gTWNEb3dlbGwgd3JvdGU6DQo+IE9uIEZyaSwg
T2N0IDE2LCAyMDI2IGF0IDA0OjM3OjMzQU0gKzAwMDAsIFN1cmVuZHJhbiBLYW5hZ2FyYWogd3Jv
dGU6DQo+PiBUUE0gY29tbWFuZHMgbmVlZCB0byBjb21wbGV0ZSB3aXRoaW4gdGhlIGNvbW1hbmQg
ZHVyYXRpb24gZGVmaW5lZCBpbg0KPj4gdGhlIFRQTTIgc3BlYyBvciBrZWVwIGFuc3dlcmluZyBU
UE0yX1JDX1JFVFJZIGZvciBhdCBtb3N0DQo+PiBUUE0yX0RVUkFUSU9OX0xPTkcgKDJzKS4NCj4+
DQo+PiBJbiByYXJlIHNjZW5hcmlvcyBOaXRyb1RQTSBjYW4gZW50ZXIgYSBtb2RlIHdoZXJlIGl0
IGVpdGhlciBzZW5kcw0KPj4gVFBNMl9SQ19SRVRSWSBmb3IgbW9yZSB0aGFuIDJzIG9yIGRlbGF5
cyBjb21tYW5kIGNvbXBsZXRpb24uIFdoZW4NCj4+IHRoaXMgaGFwcGVucyBkdXJpbmcgYXV0aCBz
ZXNzaW9uIHN0YXJ0LCB0aGUgZHJpdmVyIGRpc2FibGVzIHRoZSBjaGlwDQo+PiBhbmQgZXZlcnkg
c3Vic2VxdWVudCByZXF1ZXN0IGZhaWxzOg0KPj4NCj4+ICAgICAgdHBtIHRwbTA6IGluIHJldHJ5
IGxvb3ANCj4+ICAgICAgdHBtIHRwbTA6IHRwbTJfbG9hZF9jb250ZXh0OiBmYWlsZWQgd2l0aCBh
IFRQTSBlcnJvciAweDA5MjINCj4+DQo+PiBBZGQgc3VwcG9ydCBmb3IgdmVuZG9yIGR1cmF0aW9u
IG92ZXJyaWRlcyB0byB0aGUgQ1JCIGRyaXZlciwgYmFzZWQgb24NCj4+IHRoZSB2ZW5kb3IgSUQg
cmVhZCBmcm9tIHRoZSBpbnRlcmZhY2UgSUQgcmVnaXN0ZXIuIEZvciBOaXRyb1RQTSwgcmFpc2UN
Cj4+IFRQTV9TSE9SVCwgVFBNX01FRElVTSBhbmQgVFBNX0xPTkcgdG8gMzBzIHdoaWNoIGNvdmVy
cyB0aGUgbG9uZ2VzdA0KPj4gdW5hdmFpbGFiaWxpdHkgdGltZSBhbG9uZyB3aXRoIHNvbWUgaGVh
ZHJvb20uDQo+IEJ1bXBpbmcgYWxsIG9mIHRoZXNlIHRvIDMwcyBzZWVtcyBleGNlc3NpdmUuIElz
IGl0IHJlYWxseSB0aGUgY2FzZSB0aGF0DQo+IGFsbCBjb21tYW5kcyBjYW4gcG90ZW50aWFsbHkg
dGFrZSB0aGlzIGxvbmc/IElzIHRoYXQgYmVjYXVzZSBvZg0KPiBub24tVFBNLXJlbGF0ZWQgb3Bl
cmF0aW9ucyBOaXRybyBtaWdodCBiZSBkb2luZyBiZWhpbmQgdGhlIHNjZW5lcz8NCg0KDQpXZSB3
b24ndCByZWFjaCB0aGUgMzBzLCB3aGljaCBpcyBleGFjdGx5IHdoeSBpdCdzIGEgc2FmZSBkZWZh
dWx0IGZvciB0aGUgDQpzYWZldHkgbmV0IHRoYXQgdGhlc2UgdGltZW91dHMgYXJlIDopLg0KDQoN
CkFsZXgNCg==
