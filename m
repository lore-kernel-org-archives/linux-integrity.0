Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020081.outbound.protection.outlook.com [52.101.84.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6A381EBD
	for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813773; cv=fail; b=f8d14uz+xVXyTTw5M4KHLOzCn2uxyzKFXbI+0Z8E2mLKH98yU5pPvmAyCcVITK/ccyGy62AGYwiK9nUEX9Y/k++xlOcWOlYvl3H1REvLDcUa4jVKeSh2F1pukdBinoAmorw/RxaIuOZsFDdowIyOgAnmrNCwM3YzZT3Mc+GBc7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813773; c=relaxed/simple;
	bh=NVC+dkLePYiXFsIXguMXCvbnc6xRkm1wFQLCrKOy4/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXmaxNstDFD4idCPHEjV5o98D4a/VySjwVnNu0xjl7Xhhy7ZsH5wiKMFRuhpQWtNYD5aCFEcqAC3vbwXWlXzSwTyXqX8n6XeDZFOM3HpER4yAdAOeUQcg8D1oInorhbZoY0WQnx9Y5vWU1Ror5k297LDIZOmWXu5XO13Az/jHDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=YIIruBRE; arc=fail smtp.client-ip=52.101.84.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="YIIruBRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3G1zxUH8Uu3p3lwWWCCX6MBGV9TqB7nUYxQVLagrApAl/XtDCI92yn6DaK0qwCwFVkPW21TZ9aiKoaXHiDbeSAAf7CCBZQ8b2HfIHnnpj2vXaW/WnZTuG6lEMAuAYf474F5VPxofpR5rahUBEy1LWvY/pD2/l/7IFFbGDWuxp8OLvDVKiZLRPmh4BZLO7RvzM1gpm94hbhLEY3fQ3R79kvxaI+9T5X96fOS6qBCmFNgyycNF0O8SANtbP0Rnvv0ykfNmUicqKIeNsN5Zsq/NBe9dlbqthOU3EkLsuppnCZ5gpHxmmpMJ3YtHhDf1WVH2Me1KWa9A8QODBty8KCmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVC+dkLePYiXFsIXguMXCvbnc6xRkm1wFQLCrKOy4/Q=;
 b=fYCCGU3V0XIj3fs8UCzsnYw5VmmB4e7Y+nWdd+JtSITzYWp2040jNlUo7EcEFw540cyNWW+49Z+nSeCtIm16bSEm/OpdZUZSSfI4IUS8F5NiG2hzRH6/p0jyvgXRYT+3wgklyh3/9NZgvrY1IoBicnAjBJlOag7fRma8gwz7jEypvZKFON7YWjOwKJ8B5x/szb1UsqVceuAnIeDs/aU7NWNI0tguhgROfj9D4YKS5PwjhlJ9V+97mnukDlT6nCZMnC3lDBOewCzDs1xH1CJusUv+BueK8nb/DXb6gxgG8/X/Gecg718fs9/QX6bGu4XScOY5bfjgZ0Bbv29Y8BAcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVC+dkLePYiXFsIXguMXCvbnc6xRkm1wFQLCrKOy4/Q=;
 b=YIIruBREJ++XTRzLgc+MNkbsjS1TI3oCv1bM7IJXaeRU5VtNZt4WCXSE3ple+sx66rNCc/M9wWl31852Jnj3QVVr8FRf9fF3WfvfxkB+mswNGYfx+/eWkQoXzUpsvRQDTea1tSHGoTTEZElJS/9LSKp1rsfRf6JQV89gbW8IXnc=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AM9PR05MB8632.eurprd05.prod.outlook.com (2603:10a6:20b:416::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:02:46 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 14:02:46 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v2] ima: correctly recover number of violations after
 kexec
Thread-Topic: [PATCH v2] ima: correctly recover number of violations after
 kexec
Thread-Index: AQHdDUc60+1rA377hkyBs/Zj8+NBtrb1suOAgATXRIA=
Date: Mon, 12 Oct 2026 14:02:46 +0000
Message-ID: <250be108ea37d60a18c71dd41d5aa59feffb3f1d.camel@polito.it>
References: <20260706124454.165706-1-enrico.bravi@polito.it>
	 <ff5d11a80c91f4079de847777cf6b70cf09a7197.camel@huaweicloud.com>
In-Reply-To: <ff5d11a80c91f4079de847777cf6b70cf09a7197.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|AM9PR05MB8632:EE_
x-ms-office365-filtering-correlation-id: dc9f19d7-1b6c-4542-0c5d-08df28697e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|786006|1800799024|23010399003|4143699003|11063799006|38070700021|56012099006|18002099003|22082099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info:
 gMf0l8rDKCBs3kbLwO7kj0LLaA4tDgpKPaezETFF9t7hZLugpGS95wkwo6PfY/ZIIaScNHymTQOEWPh/lGozwrSBJm+2NyMTSGLEA+O+APDF8WVDGzL40981Lp02+qPF9JSa2HJh0ZM/zJGQcBLfvskaLHMc+/4vdzUd7T0IHuo/r+QHlbuQ/i2LU4VY++ubRFLASnkAMDKP6EW5Uh6jwT2cRHG3eqhj1noBO+ozuLCS4bVr7vNlzPwB6QAEBqz+oiXcGwki241B8DuWNYz7fAZHAy65OyfAk1qXF5DwxYptTa4Do/5FZh3A21Hppmf69qfoHNb9OhGStDH5BM6OR0VksK1Yq2gsMHr3Z6UqeAkmF3fWUqI1RrnRylEqVDyYR1e2CIbIwnoosenb2HqWnEwMGkY0i921nlV2wKWfozmeJpP8tCIQoWUdRkuJmMv8DIrsPPm4ayhNHf4CUTXZ7BTDl/FokKNtW/kkH2ozLzost2tI5eKkboAA7YIf8m8qAo0SeRHiFX0AJjjUFerPGGx/FxfAD5OJIZLe1xsr1FbH/Hm1ELjhztyfH4qkBdrDevtxcnfjuGUMFFllylubIzD/tbrnsJgLdfl7KYl28sMta1RmWPmm9oZVYlR8CNoLUmg2ge4ntg9RuF8wVN3kijF2RYdWpLLHPDq9ZAKo7LWxp+0nTVok72RzeprgGd/StVi7WnNxlEXUmBSLl+9FNagePjz70CfnFdqQe7L0Vz0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(786006)(1800799024)(23010399003)(4143699003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NCtIQ1YwNGh5Q3MrbWp5SGFwZHdvTGJyYkovUzdZc2d4elV6VXdlU3piTFdv?=
 =?utf-8?B?Y0lVeksyeE5HOW5jM3FBWDh6djIyLzhuNVVzRm0xNmsrT3JYR0VCdUZ2YVRQ?=
 =?utf-8?B?czdqd0hqSjIxaXBpZElWYVJqUDhUNWNzdmRBc1FKLzhHR0JkcUIyZ0dtOWZa?=
 =?utf-8?B?Y21GWUw3R1gvZEtyWUVLUGZva1FGNUpFMjRYMHI2ODR3ZURMUHJseGlKRkFZ?=
 =?utf-8?B?SnRTWnNuZmRUZDBtZVdyb3czb1FuNW9KdFBWUnFJMkFvaVg1ZFVEcjZqOVRH?=
 =?utf-8?B?bzBteUlCaGVZRU80amkzeTVJTXQ5allOSEZFWkI1Y0d3ckoyRDNudnpZY1dY?=
 =?utf-8?B?cDByNnRMM0ZYaWtGaUtBTWN3cE9iaERpNjJJd0NTUythbjdWU3VQNkQyckNC?=
 =?utf-8?B?aTRjR2QybndXK1hxMFhrbVRCbTNQbVpjOUVzNDNSNnh2S05HWU9QeU5sTFp1?=
 =?utf-8?B?MURGTmpwTExIT0JMRDdaQkFZMHEydENsMFpvUUpkclhCQnQvMTZNb0U3OTZi?=
 =?utf-8?B?UTFOalErTVJqQUwrUDQzM2M4MUdXUGhuOW5NWU1xMzJCNU1rZ2lmczJ0WE1E?=
 =?utf-8?B?QmZPaDE0T3ptTkc3WGtpYkFMRHZmTDBhbkFEVTRWdUxxdEFxWVI3QmRsMERC?=
 =?utf-8?B?RHBjM2JCODd4ZGhvcGhrYmxnQ1FSaFhLK2NOUUVYeXdSRnhqM1Q2VlNQeDBD?=
 =?utf-8?B?bEpQZnppakxzVEl6VGt0QTdYTUZFYUd5NHBTZ2NrcVJZb0pUR2NQenJjQ1RL?=
 =?utf-8?B?UjRUbnhxOW5RQzdEMW5hNHV5TUFHVTNTSkx1NG9rbzhzTm5uNHpwMEpxd2U4?=
 =?utf-8?B?Wm15NnU5bXk5QStPNUgyZXh2MkxWc0k0R25jVzd4RGNJRDZDMHhvWXpMSXp2?=
 =?utf-8?B?MHRXaTFTemZSUDZIdDVTZmRMcXJrck5KS1ZteFhMWU8wRWhjWWd1Rks4R0c1?=
 =?utf-8?B?MDB4cEdYQ2xIeGs5OUJWaEZuUmFBTUtuU0IvdnFyalBVTCttdWkwVjgraWZ0?=
 =?utf-8?B?WGNGaG5oYXJpT2x0YStoZjB1NnpJQ3AzNnRscjE3QTVqR1RMSjRMYUJCUmV2?=
 =?utf-8?B?ZFUrK290SVRTdEFpODlqSlBMM2pOSlhFNEJ4V2NiSXBER2NxSzdoU1lYVHNz?=
 =?utf-8?B?ZTMrcHd1YVlaVXRqWTNrK0VKZFlBeXZKNHN5V2hDeDFWcjQxUG5adFIxdGZu?=
 =?utf-8?B?U3dSN2xEaGVxVTNlaEdCc1JKd09PUnB1Q2VTa1FkaUZ6TTBSRktTcnFIZGhB?=
 =?utf-8?B?NWlDc3I0ZXV2VXA0VmR2TDh4UWY1MktQYXppMUsvZ1Y3eEdJNXowNlVhR1pj?=
 =?utf-8?B?NktxV2NweEw4bjVOV0hrQXU1YnlwVmZXUlpSZjJ0R0pvdDNYMWY0aDY2dllL?=
 =?utf-8?B?cEJ5TkdhRjM2SzhVSUlQM1k3TkZ1VVhTM01UazhHTHQ5OXdtUkNOODFwUEdC?=
 =?utf-8?B?ZWEybEMwaFVEWnB3RVdsaTczd3JuYXZ5VlE3U3ZRZ3JvYU9FemFZWTMwaFdS?=
 =?utf-8?B?dFlFZ013NmRVcGdZemhaRGlhR0J3Qm9IL3dOejJlRmNrVmJndkl1OXhQVGUr?=
 =?utf-8?B?NW5aOTNtOGZybnZlNURHMlJucDhMWWJlZUVnS1BUdXkrNTd0dGlEWUd5Q3pD?=
 =?utf-8?B?NEtlQ291UGo1THZZN1p6RGd5dTZuUkthSkNtR2ZWYTM2Tk90S0tqSlNTWEZi?=
 =?utf-8?B?WjFJYlJzYy9PMzFIVkZhUE0wMDlrM20yK3doT3QzOWNGWm5yVERPMWNMUjJK?=
 =?utf-8?B?M05YKzNCWVJvZGR2aC91bW5tWnM5RU1DUDdBOWtaT041Y2hjVmtFa3FNR3c2?=
 =?utf-8?B?ZXZJbnBPcmFsYS9aR2p3cXk3QUpXaGFrQTVOaW90UXk1UW01b2pSMzAwZ0V1?=
 =?utf-8?B?OGptNE9ueVZ2cjhVL1hqall6NGdTY0p6NDVDUW5QeUVTajNMWjZwdUNKdHNP?=
 =?utf-8?B?NlEwYk1idUFPQ2hicXFNKytLV2ZKNE13MTA2WXlJOGIyb2c0MU9CM0VMc3hp?=
 =?utf-8?B?K25rWUdUUVpBZ0xoTjlDakQ0Y2dVTjIwWE1wU1pFc3F3Q2w2WUN4NXFMYzFz?=
 =?utf-8?B?aXN1VzJhQ283cStBYk9leFh3Vk9ETU10WDNWMFpaaEc3M09sc3pWeFU1dllm?=
 =?utf-8?B?U1J3NXErT0pYQ3Nnd3QzSjNlRlo4clA0WWRTRzlzVlJ6a1pOdGpRcWxmd2dJ?=
 =?utf-8?B?YWExOWpSbkNjVjk2a3BYSVJUUFlaSTBtdnNoRFBwZWFiRkxURUIxdjNLbDFB?=
 =?utf-8?B?S3ZaVFp5aUo4a3EyS040Tk5qY05lQkVRSDZXUmZJaXFoeTA1czY1eVUvZ1JL?=
 =?utf-8?B?Y0lldWlXQnRwRUFzVk9JSzA2b1BxOU5GYlhSemdabmZSbms3ZFJOQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA59A97611D3CB49AE919A4CC4F18BD3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9f19d7-1b6c-4542-0c5d-08df28697e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 14:02:46.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCm6thFb8P6OO3ABYOJmEsmSnIsVyt+MBLIOxSM7e6vULH6O/ndWQDqJZFL2kXFZNV6NfoWAEI1zECoRWnxblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8632

SGkgUm9iZXJ0bywNCg0KT24gRnJpLCAyMDI2LTEwLTA5IGF0IDE0OjA3ICswMjAwLCBSb2JlcnRv
IFNhc3N1IHdyb3RlOg0KPiBPbiBNb24sIDIwMjYtMDctMDYgYXQgMTQ6NDQgKzAyMDAsIEVucmlj
byBCcmF2aSB3cm90ZToNCj4gPiBXaGVuIHJlY292ZXJpbmcgdGhlIElNQSBtZWFzdXJlbWVudCBs
aXN0IGFmdGVyIGtleGVjKCksIGN1cnJlbnRseSwgdGhlDQo+ID4gY291bnRlcg0KPiA+IG9mIHZp
b2xhdGlvbnMgaXMgbm90IHJlc3RvcmVkLiBUaGlzIGxhY2sgY2F1c2VzIGEgbWlzbWF0Y2ggYmV0
d2VlbiB0aGUgcmVhbA0KPiA+IG51bWJlciBvZiB2aW9sYXRpb25zIGFuZCB0aGUgdmFsdWUgcmVw
b3J0ZWQgYnkgdGhlDQo+ID4gPHNlY3VyaXR5ZnM+L2ltYS92aW9sYXRpb25zDQo+ID4gZmlsZS4N
Cj4gPiANCj4gPiBSZXN0b3JlIHRoZSB2aW9sYXRpb25zIGNvdW50ZXIgZHVyaW5nIHRoZSBJTUEg
bWVhc3VyZW1lbnQgbGlzdCByZWNvdmVyeS4gVG8NCj4gPiB2ZXJpZnkgaWYgYSBtZWFzdXJlbWVu
dCBjb3JyZXNwb25kcyB0byBhIHZpb2xhdGlvbiwgY2hlY2sgaWYgdGhlDQo+ID4gY29ycmVzcG9u
ZGluZw0KPiA+IHJlY2FsY3VsYXRlZCB0ZW1wbGF0ZSBkYXRhIGhhc2ggaXMgYWxsIHplcm9zIGFz
IHJlYWQgZnJvbSB0aGUga2V4ZWMgYnVmZmVyLg0KPiA+IFRoaXMgY2hlY2sgcGVybWl0cyBhdm9p
ZGluZyBmYWxzZSBwb3NpdGl2ZXMsIGJ1dCBpdCBkb2VzIG5vdCBhY2NvdW50IGZvcg0KPiA+IGZh
bHNlDQo+ID4gbmVnYXRpdmVzLiBJZiB0aGUgdGVtcGxhdGUgZGF0YSBoYXNoIHJlc3VsdHMgaW4g
YWxsIHplcm9zLCBpdCBpcyBub3QgY291bnRlZA0KPiA+IGFzIGEgdmlvbGF0aW9uIGV2ZW4gaWYg
aXQgY291bGQgYmUuDQo+IA0KPiBTb3JyeSBmb3IgdGhlIGRlbGF5LCBFbnJpY28uDQoNCm5vIHBy
b2JsZW0gYXQgYWxsLg0KDQo+IFllcywgSSB0aGluayB0aGUgcGF0Y2ggaXMgb2sgYXMgaXQgaXMu
IEhvd2V2ZXIsIGFmdGVyIGdpdmluZyBhbm90aGVyDQo+IHRob3VnaHQsIG5laXRoZXIgYXBwcm9h
Y2ggaXMgcGVyZmVjdCwgaW4gb25lIGNhc2UgKGN1cnJlbnQpIHdlIGNvdW50DQo+IG1vcmUsIGlu
IHRoZSBvdGhlciBjYXNlICh0aGlzIHBhdGNoKSB3ZSBjb3VudCBsZXNzLg0KPiANCj4gSXQgaXMg
YSBjb3VudGVyIG1vc3RseSBmb3IgZGVidWdnaW5nLCBpdCBpcyBub3QgdXNlZCBmb3IgcmVtb3Rl
DQo+IGF0dGVzdGF0aW9uLiBNYXliZSwgd2UganVzdCBpbmNyZW1lbnQgdGhlIGNvdW50ZXIgb24g
emVyb3MgdG8ga2VlcCBpdA0KPiBzaW1wbGUgKHBsZWFzZSBzYXkgaW4gYSBjb21tZW50IHRoYXQg
aXQgaXMgbm90IHBlcmZlY3QpLCBhbmQgd2UNCj4gZmluYWxpemUgbGlrZSB0aGlzLg0KPiANCj4g
V2hhdCBkbyB5b3UgdGhpbms/DQoNClN1cmUsIEkgYWdyZWUuIElmIHRoZXJlIGlzIG5vIGFjdHVh
bCBiZW5lZml0LCBpdCBpcyBkZWZpbml0ZWx5IGJldHRlciB0byBrZWVwIGl0DQphcyBzaW1wbGUg
YXMgcG9zc2libGUuDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGZlZWRiYWNrLiBJIHdp
bGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHNob3J0bHkuDQoNCkVucmljbw0KDQo+IFJvYmVydG8NCj4g
DQo+ID4gUmVwb3J0ZWQtYnk6IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNv
bT4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1pbnRlZ3JpdHkvbGludXgv
aXNzdWVzLzEzDQo+ID4gU2lnbmVkLW9mZi1ieTogRW5yaWNvIEJyYXZpIDxlbnJpY28uYnJhdmlA
cG9saXRvLml0Pg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBSZXdv
cmtlZCBwYXRjaCBkZXNjcmlwdGlvbiBhcyBzdWdnZXN0ZWQgYnkgUm9iZXJ0by4NCj4gPiAtIEFk
ZGVkIGRlc2NyaXB0aXZlIGNvbW1lbnQgYXMgc3VnZ2VzdGVkIGJ5IFJvYmVydG8uDQo+ID4gLSBN
b3ZlZCBmcm9tIGltYV9hbGdvX2FycmF5W2ldLmRpZ2VzdF9zaXplIHRvIEFSUkFZX1NJWkUoKSBh
cyBzdWdnZXN0ZWQNCj4gPiDCoCBieSBSb2JlcnRvLg0KPiA+IA0KPiA+IC0tLQ0KPiA+IMKgc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYyB8IDI3ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX3RlbXBsYXRlLmMNCj4gPiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3RlbXBsYXRl
LmMNCj4gPiBpbmRleCA3MDM0NTczZmI0MWUuLmY3NzQ5Yzg0OTlkZCAxMDA2NDQNCj4gPiAtLS0g
YS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jDQo+ID4gKysrIGIvc2VjdXJp
dHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYw0KPiA+IEBAIC00MzAsNiArNDMwLDcgQEAg
aW50IGltYV9yZXN0b3JlX21lYXN1cmVtZW50X2xpc3QobG9mZl90IHNpemUsIHZvaWQgKmJ1ZikN
Cj4gPiDCoAlERUNMQVJFX0JJVE1BUChoZHJfbWFzaywgSERSX19MQVNUKTsNCj4gPiDCoAl1bnNp
Z25lZCBsb25nIGNvdW50ID0gMDsNCj4gPiDCoAlpbnQgcmV0ID0gMDsNCj4gPiArCWludCBpOw0K
PiA+IMKgDQo+ID4gwqAJaWYgKCFidWYgfHwgc2l6ZSA8IHNpemVvZigqa2hkcikpDQo+ID4gwqAJ
CXJldHVybiAwOw0KPiA+IEBAIC01MTUsMTUgKzUxNiwyNyBAQCBpbnQgaW1hX3Jlc3RvcmVfbWVh
c3VyZW1lbnRfbGlzdChsb2ZmX3Qgc2l6ZSwgdm9pZA0KPiA+ICpidWYpDQo+ID4gwqAJCWlmIChy
ZXQgPCAwKQ0KPiA+IMKgCQkJYnJlYWs7DQo+ID4gwqANCj4gPiAtCQlpZiAobWVtY21wKGhkcltI
RFJfRElHRVNUXS5kYXRhLCB6ZXJvLCBzaXplb2YoemVybykpKSB7DQo+ID4gLQkJCXJldCA9IGlt
YV9jYWxjX2ZpZWxkX2FycmF5X2hhc2goDQo+ID4gLQkJCQkJCSZlbnRyeS0+dGVtcGxhdGVfZGF0
YVswXSwNCj4gPiArCQlyZXQgPSBpbWFfY2FsY19maWVsZF9hcnJheV9oYXNoKCZlbnRyeS0+dGVt
cGxhdGVfZGF0YVswXSwNCj4gPiDCoAkJCQkJCWVudHJ5KTsNCj4gPiAtCQkJaWYgKHJldCA8IDAp
IHsNCj4gPiAtCQkJCXByX2VycigiY2Fubm90IGNhbGN1bGF0ZSB0ZW1wbGF0ZQ0KPiA+IGRpZ2Vz
dFxuIik7DQo+ID4gLQkJCQlyZXQgPSAtRUlOVkFMOw0KPiA+IC0JCQkJYnJlYWs7DQo+ID4gKwkJ
aWYgKHJldCA8IDApIHsNCj4gPiArCQkJcHJfZXJyKCJjYW5ub3QgY2FsY3VsYXRlIHRlbXBsYXRl
IGRpZ2VzdFxuIik7DQo+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJCWJyZWFrOw0KPiA+
ICsJCX0NCj4gPiArDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBDaGVjayBpZiB0aGUgY3VycmVudCBt
ZWFzdXJlbWVudCBpcyBhIHZpb2xhdGlvbiBhcw0KPiA+IHJlcG9ydGVkDQo+ID4gKwkJICogaW4g
dGhlIGtleGVjIGJ1ZmZlci4gSW4gY2FzZSBpdCBpcywgcmV2ZXJ0IHRoZSBlZmZlY3Qgb2YNCj4g
PiArCQkgKiBpbWFfY2FsY19maWVsZF9hcnJheV9oYXNoKCksIHNldHRpbmcgYWxsIHRoZSBjYWxj
dWxhdGVkDQo+ID4gKwkJICogZGlnZXN0cyB0byB6ZXJvLCBhbmQgdXBkYXRlIHRoZSB2aW9sYXRp
b25zIGNvdW50ZXIuDQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKCFtZW1jbXAoaGRyW0hEUl9ESUdF
U1RdLmRhdGEsIHplcm8sIHNpemVvZih6ZXJvKSkgJiYNCj4gPiArCQnCoMKgwqAgbWVtY21wKGVu
dHJ5LT5kaWdlc3RzW2ltYV9zaGExX2lkeF0uZGlnZXN0LCB6ZXJvLA0KPiA+IHNpemVvZih6ZXJv
KSkpIHsNCj4gPiArCQkJZm9yIChpID0gMDsgaSA8IE5SX0JBTktTKGltYV90cG1fY2hpcCkgKw0K
PiA+IGltYV9leHRyYV9zbG90czsgaSsrKSB7DQo+ID4gKwkJCQltZW1zZXQoZW50cnktPmRpZ2Vz
dHNbaV0uZGlnZXN0LCAwLA0KPiA+ICsJCQkJwqDCoMKgwqDCoMKgIEFSUkFZX1NJWkUoZW50cnkt
DQo+ID4gPmRpZ2VzdHNbaV0uZGlnZXN0KSk7DQo+ID4gwqAJCQl9DQo+ID4gKwkJCWF0b21pY19s
b25nX2luYygmaW1hX2h0YWJsZS52aW9sYXRpb25zKTsNCj4gPiDCoAkJfQ0KPiA+IMKgDQo+ID4g
wqAJCWVudHJ5LT5wY3IgPSAhaW1hX2Nhbm9uaWNhbF9mbXQgPyAqKHUzMg0KPiA+ICopKGhkcltI
RFJfUENSXS5kYXRhKSA6DQo+ID4gDQo+ID4gYmFzZS1jb21taXQ6IDhjZDk1MjBkMzVhNmMzOGRi
NjU2N2U5N2RkOTNiMWYxMWYxODVkYzYNCg==
