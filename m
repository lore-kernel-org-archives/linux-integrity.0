Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B9C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE37C21850
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aiomrBgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfB1ABB (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:01:01 -0500
Received: from mail-eopbgr690138.outbound.protection.outlook.com ([40.107.69.138]:12016
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbfB1ABB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 19:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9exthXpSlIIWrSmXDaJcYNsx3Ny9BDmSjW3+GApgLY0=;
 b=aiomrBgS1eFSBY4gT6iHii5Gym6S+CeMevDGg3qRj9YLqtNimbLguRrxkAkzmq3tcFoKoB9qG1GEyiBJZjv8NKpgQ32el9uWU33drNMmWX2nQdv7ptuxWpyGXnAyoI9nKnzF8z2P25nRqa/Z6ydjEijYncfv8GG0/lebYthVIaA=
Received: from MWHPR21MB0751.namprd21.prod.outlook.com (10.173.51.13) by
 MWHPR21MB0511.namprd21.prod.outlook.com (10.172.95.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.4; Thu, 28 Feb 2019 00:00:57 +0000
Received: from MWHPR21MB0751.namprd21.prod.outlook.com
 ([fe80::519:bdef:693e:ac61]) by MWHPR21MB0751.namprd21.prod.outlook.com
 ([fe80::519:bdef:693e:ac61%5]) with mapi id 15.20.1686.003; Thu, 28 Feb 2019
 00:00:57 +0000
From:   Jordan Hand <Jordan.Hand@microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [DISCUSSION] IMA Signature Measurements
Thread-Topic: [DISCUSSION] IMA Signature Measurements
Thread-Index: AdTO5+uCjRXn1sSWQPSawW4lvgYSAAABYT2AAACccEA=
Date:   Thu, 28 Feb 2019 00:00:56 +0000
Message-ID: <MWHPR21MB07518C72F310CC9F8ECB683CF0750@MWHPR21MB0751.namprd21.prod.outlook.com>
References: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
 <1551307229.10911.100.camel@linux.ibm.com>
In-Reply-To: <1551307229.10911.100.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jorhand@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-28T00:00:43.0819084Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f12f10a8-0574-4537-8e1d-2dc84d55d4b0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:9:3e07:7f03:969a:9b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8741af68-6f80-4c8a-5566-08d69d0fd0b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0511;
x-ms-traffictypediagnostic: MWHPR21MB0511:
x-o365-sonar-daas-pilot: True
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjIxTUIwNTExOzIzOmNsUXhRS2hKQVRmTkF6TStIRHVGUG9tWXJt?=
 =?utf-8?B?d1Z3VUVVYUZGZ3pYS0FlZGxPaDErY1BQeDdWSXVFNm96N1lxdCtkNVJ1YjNi?=
 =?utf-8?B?WlZLVFE3SzlsWkl1dGNydFVXY0Exakh2THkxYy9NcVQzUWdpZ0V3anZFUlIy?=
 =?utf-8?B?bWw3Y3l3cGJ2dHpQc3JYd0VQdkJFN2laTTg4ZFVYa3JLZnFLVEpFUUFyaEww?=
 =?utf-8?B?bjRrNDR2cGdSZnVxVFJLOTNmU05oak1vSytyUGpSc2FFMy9sK3IvZkRndE9W?=
 =?utf-8?B?ZG95SENIWXQ2d2JlcUN4dDl5dHF4K3hEeGZzeGNNa21zQkN1cUFhVVJGbWFn?=
 =?utf-8?B?TmZoNDdVVjNvQ2c3NUZ0Y2JzMnlMWTUySmQvS2lnc3dKYVdXOWpMbUxoV0hI?=
 =?utf-8?B?U0NTS0RPQksrYjMyV3FmbGNZM1NyczNWZmtYWkVBM0pEQjE3KzVqNlhOS0tF?=
 =?utf-8?B?UWs1SE1XZThCa1dNUkJYQWw2ZmNiRXZPUjhjL2hPdWNkS2RBdkFjOTI2ZnFm?=
 =?utf-8?B?T0RoV2M3SzBwMDRydk1qM2wyNWVmeFNoSmorTVk1STBQSXBYTzIzcE9sN1V4?=
 =?utf-8?B?TkZxaGtVbkIyWWxkSitMUmdXWTFqRDY0dmd5ZWh6dHZaZitDV3JhQW1FdWQx?=
 =?utf-8?B?THRMaGIrbkErWUtiY0dGa0xTaytmZXJrTk05T3FySC9lYVVkSUY5TjcycG45?=
 =?utf-8?B?T2dGdDNkRTQ4MVgzdUxkUFpXOG9ocE5ncDZYMUNLT1VCbXA4c0RreHhxcGJM?=
 =?utf-8?B?OCtRWUx2YkdXUUxuam5wMXhKd0I5SFJpdjNpanVMRFRwalh2Nit2clhKOStx?=
 =?utf-8?B?SU9hNENTWnlLZ3NJL0NmQVF5dis5Z3d6OGlFdDhnSW5YeHFFcDd6eCt0RkFJ?=
 =?utf-8?B?WUJUNy9mZ3RMNCtxbGYvRS9CS1VpM0xzdDYvRDZ2b01nNkJHMkVISjEvNjRS?=
 =?utf-8?B?dUM5d0E0UGg4OCtSS0RWREZ3eHF1cGRtMEZCTHBFcGQydkk5anYrei9Sbzg3?=
 =?utf-8?B?Sm5HRnJpc2JsZGlTbEtidlhobEoweGFOUHpMSWEzUGhCeVByMjg2UXZsa0Z4?=
 =?utf-8?B?RFlvaHJ6KzhXSkpPRzcxb1VoVlJTOVV4Q0NqOGJmUW1mVFVxNURkMEZjR2sr?=
 =?utf-8?B?VThSanBVRHJFY3AyaTVYNTZYVVlYV0tOSXljdHJHYjJkM0lBMmhsNTdEZkVr?=
 =?utf-8?B?VDNEMytadjl3V0N3eUZxdVhNL3dZRklwYnk5aTlBTDJUOTkvQ0UyYzhtQkJQ?=
 =?utf-8?B?TUtBS0Z4NE1laHk4TWhWUHhOWHpCMVlZOFlnbGJLWU5tbjVDSHJPbTRVNkxQ?=
 =?utf-8?B?ZTRLeWNxb0FEL0VZeVU3QmlLWmFXS0ZBdzh4YWkyczRzc3pzUWYzRms3SDRu?=
 =?utf-8?B?YmpuRTY2ZFVZeHBKU0dzUjV4ZWVEME5oVVg3T2x6bnhIZTluUzErZGR4UERw?=
 =?utf-8?B?Z25tcW1DUHBoY2ZETjZpK3dmYVFnaWgrWUE5SzJiOVhHTnJ2VnRNUWNrbWk4?=
 =?utf-8?B?bHV4Y2FRNVhxTnhuWENRNVpnV3ZnRGl3WUNzazUrZ1VScWl6TGp0SUpwZnMw?=
 =?utf-8?B?MVV5UndTQmErWHBtOURVRjQySndBQkp0YThJNmNUV1JrNG43SUxBMDlZNFFG?=
 =?utf-8?B?OHdOZ1lMK2IwZTRNb2dtb0N5NVNXdW5JeWFqUkpGZDcvL2ovTUJjZ0RQc0tk?=
 =?utf-8?B?T3BoMGRTb3VmOWk2YWNBcUE4L1dQQlkxbWRTdXRtcWdNbUhpM1JlaU5BeCs5?=
 =?utf-8?B?MFVVbXZWOSswa1hZV0ZBc0NhVWxuYnNtNTlLMk9RQktCVC9FU0pYTjhjVkxR?=
 =?utf-8?B?T2pyTWZzYnJrdHBuRTZVWllSQ2pVY2VFdkNtWlZobmErWnc9PQ==?=
x-microsoft-antispam-prvs: <MWHPR21MB0511D63B64EB3F4A53285FB8F0750@MWHPR21MB0511.namprd21.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(476003)(2906002)(105586002)(106356001)(7696005)(5660300002)(186003)(99286004)(2501003)(8936002)(86362001)(8676002)(10090500001)(81166006)(256004)(14444005)(71200400001)(71190400001)(8990500004)(68736007)(86612001)(6116002)(97736004)(81156014)(53936002)(7736002)(478600001)(305945005)(229853002)(6246003)(72206003)(55016002)(6436002)(6506007)(33656002)(22452003)(316002)(76176011)(14454004)(74316002)(486006)(46003)(446003)(11346002)(52536013)(9686003)(25786009)(6346003)(10290500003)(102836004)(110136005)(561944003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0511;H:MWHPR21MB0751.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jordan.Hand@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xIhxc1ikI5+wixc8uzMeS0gK6XstEk47PxGdbKJDrqbMLLW+Eb0fzK9e1Kvn8OItIkv2nMohCZnQdiGZIt/Piq0+h1anV8kE7gA6j573Y8ryHNneqMWClIBCLWm6PAqcJf1ZKqMXepgUqrs1bHqhCG9okLeVQcf2VqSaDplMQXGEbT0jXW+1dgYEcdpHvxnOrobcEK8j1PNZMztEngtrcdVKFn6uGV5+m/TYx6xe78QVrui0/Yk8NTagpwZGP83WD32MnraSI4h3lRYmdN3i0ThP1qssC8/uFVcHNc6+qRvsJi+LZXv+5/lIVNiamUc7BCkmMRnTl4O+Bp8z+p2BLwn4mucCYyXiR/uAmt4yQhrhY5O5zmv4IcxnjwXfmHH28MfaUTdMzlRX1GaiaQ3x2rrTwujHXheoDxfK+ouJAu4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8741af68-6f80-4c8a-5566-08d69d0fd0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 00:00:56.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0511
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Pk9uIFdlZCwgMjAxOS0wMi0yNyBhdCAyMjowMiArMDAwMCwgSm9yZGFuIEhhbmQgd3JvdGU6DQo+
PiBIZWxsbywNCj4+DQo+PiBJIGhhdmUgYmVlbiBsb29raW5nIGludG8gaG93IElNQSBwb2xpY2ll
cyB3b3JrIGZvcg0KPj4gbWVhc3VyaW5nL2FwcHJhaXNpbmcgaW4gc3BlY2lmaWMgc2NlbmFyaW9z
IHN1Y2ggYXMga2V4ZWMuIElNQSBoYXMNCj4+IHNwZWNpZmljIHBvbGljaWVzIGZvciB0aGVzZSBz
Y2VuYXJpb3MgKGkuZS4gc2V0dGluZyBmdW5jIHRvDQo+PiBLRVhFQ19LRVJORUxfQ0hFQ0spLiBX
aGlsZSB0aGVzZSBwb2xpY2llcyBkbyBleGlzdCwgaW4gcHJhY3RpY2UgaXQNCj4+IHNlZW1zIHRo
YXQgSU1BIHRyZWF0cyB0aGVzZSBmaWxlcyB0aGUgc2FtZSB3YXkgaXQgdHJlYXRzIGFueSBvdGhl
cg0KPj4gZmlsZTsgaXQgd2lsbCB2YWxpZGF0ZSBhbmQgbWVhc3VyZSAoaW4gdGhlIGNhc2Ugb2Yg
aW1hLXNpZykgYmFzZWQgb24NCj4+IHRoZSBJTUEgc2lnbmF0dXJlIGluIHRoZSBmaWxlJ3MgaW5v
ZGUuDQo+DQo+b3Igc2VjdXJpdHkuaW1hIGNvdWxkIGNvbnRhaW4gYSBmaWxlIGhhc2gsIHdoaWxl
IHNlY3VyaXR5LmV2bSBjb250YWlucyBhIHNpZ25hdHVyZS4NCj4NCj4+DQo+PiBJdCBzZWVtcyB0
aGF0IHRoaXMgcG9saWN5IGlzIG1vc3RseSBhIHBsYWNlaG9sZGVyIGluIGNhc2UgdGhlcmUgaXMg
YQ0KPj4gZGVzaXJlIGxhdGVyIHRvIGRvIHNvbWUgZGlmZmVyZW50IGJlaGF2aW9yIGJhc2VkIG9u
IHRoZSBmaWxlIHR5cGUNCj4+IChjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBhbmQgdGhlcmUncyBh
bm90aGVyIHJlYXNvbiBmb3IgaGF2aW5nIHRoZQ0KPj4gS0VYRUNfS0VSTkVMX0NIRUNLIGZ1bmN0
aW9uKS4NCj4NCj5Qb2xpY2llcyBhcmUgZGVmaW5lZCBpbiB0ZXJtcyBvZiBob29rcywgTFNNIGxh
YmVscywgYW5kIG90aGVyIGZpbGUgbWV0YWRhdGEuIMKgVHJ1ZQ0KPnRoZSBGSUxFX0NIRUNLIGhv
b2sgY291bGQgYmUgZGVmaW5lZCB0byBtZWFzdXJlLCBhcHByYWlzZSwgYXVkaXQgdGhlIGtleGVj
DQo+a2VybmVsIGltYWdlLCBidXQgaXQgbWlnaHQgbm90IHJlcXVpcmUgYSBzaWduYXR1cmUuIMKg
RGVmaW5pbmcgYSBwb2xpY3kgY29udGFpbmluZw0KPktFWEVDX0tFUk5FTF9DSEVDSyBhbGxvd3Mg
c3BlY2lmeWluZyB0aGUga2V4ZWMnZWQga2VybmVsIG1vZHVsZSBiZSBzaWduZWQNCj53aXRob3V0
IHJlcXVpcmluZyBhbGwgZmlsZXMgdG8gYmUgc2lnbmVkLg0KPg0KPj4NCj4+IEkgd2FudGVkIHRv
IGdldCBmZWVkYmFjayBvbiB0aGUgcG9zc2liaWxpdHkgb2YgSU1BIG1lYXN1cmluZyBhDQo+PiBk
aWZmZXJlbnQgc2lnbmF0dXJlIHR5cGUgZHVyaW5nIGtleGVjLiBJbiBnZW5lcmFsIGtlcm5hbCBp
bWFnZXMgYXJlDQo+PiBzaWduZWQgYXMgUEUgZmlsZXMsIHdpdGggdGhlIHNpZ25hdHVyZSBlbWJl
ZGRlZCBpbiB0aGUgZmlsZSBpbWFnZS4NCj4+IE5vcm1hbCBrZXhlYyAobm90IHRoZSBJTUEgcGF0
aCkgdmFsaWRhdGVzIHRoaXMgdHlwZSBvZiBzaWduYXR1cmUuIEkNCj4+IHdvdWxkIGxpa2UgdG8g
dXNlIElNQSB0byBib3RoIGFwcHJhaXNlIGFuZCBtZWFzdXJlIGJhc2VkIG9uIHRoaXMNCj4+IHNp
Z25hdHVyZSBpbnN0ZWFkIG9mIHRoZSBJTUEgc2lnbmF0dXJlICh0aGlzIGNvdWxkIGhhdmUgYSBL
Y29uZmlnDQo+PiBmbGFnKS4NCj4NCj5UaGUgaW1hLXNpZyB0ZW1wbGF0ZSBjb250YWlucyBhIGZp
bGUgaGFzaCBhbmQgYW4gSU1BIHNpZ25hdHVyZSBmaWVsZC4NCj7CoFRoZSBmaWxlIGhhc2ggbmVl
ZHMgdG8gcmVtYWluIHRoZSBmaWxlIGhhc2ggb2YgdGhlIGVudGlyZSBmaWxlLg0KPsKgVGhpYWdv
IGlzIGN1cnJlbnRseSBhZGRpbmcgc3VwcG9ydCBmb3IgYSBrZXhlYyBrZXJuZWwgaW1hZ2UgYXBw
ZW5kZWQNCj5zaWduYXR1cmUuIMKgSGUncyBkZWZpbmluZyB0d28gbmV3IHRlbXBsYXRlIGZpZWxk
cyBuYW1lZCBkLW1vZHNpZyBhbmQgbW9kc2lnDQo+YW5kIGEgbmV3IHBvbGljeSAiYXBwcmFpc2Vf
dHlwZSIgbmFtZWQgIm1vZHNpZyIuDQo+DQo+WW91IGNvdWxkIGRvIHNvbWV0aGluZyBzaW1pbGFy
bHkuDQoNCkFoLCBJIG1pc3NlZCB0aGF0IHBhdGNoIHNldC4gVGhhdCBzZWVtcyB0byBiZSB2ZXJ5
IGNsb3NlIHRvIHdoYXQgSSB3YW50ZWQuIEknbGwgdGFrZSBhIGRlZXBlciBsb29rLg0KDQpBcyBh
biBhc2lkZSwgaXMgdGhlcmUgYW55IG1lY2hhbmlzbSBmb3IgbWVhc3VyaW5nIHRoaW5ncyBvdGhl
ciB0aGFuIGZpbGVzIGluIHRoZSBrZXJuZWwgKElNQSBvciBvdGhlcndpc2UpPyBBcyBhbiBleGFt
cGxlLCBJIHdhcyBsb29raW5nIGludG8gbWVhc3VyaW5nIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5l
IHN0cmluZyBiZWluZyB1c2VkIGR1cmluZyBrZXhlYy4gSSBzdXBwb3NlIGF0IHRoYXQgcG9pbnQg
aXRzIGdldHRpbmcgYXdheSBmcm9tIHRoZSBwdXJwb3NlIG9mIElNQSB0byBtZWFzdXJlIGZpbGVz
IGJlaW5nIGxvYWRlZC9leGVjdXRlZCBvbiB0aGUgc3lzdGVtLg0KDQo+DQo+PiBBbHRlcm5hdGl2
ZWx5IGl0IGNvdWxkIGxvb2sgZm9yIGJvdGguIEkgdGhpbmsgdGhpcyBtYWtlcyBzZW5zZSBiZWNh
dXNlDQo+PiBpdCBtZWFucyBmb2xrcyBjYW4gbWFrZSB1c2Ugb2YgSU1BJ3MgbWVhc3VyZW1lbnQg
Y2FwYWJpbGl0aWVzIHdoaWxlDQo+PiBzdGlsbCBzaWduaW5nIHRoZSBrZXJuZWwgaW1hZ2UgaW4g
dGhlIHNhbWUgd2F5IHRoZXkgaGF2ZSBhbHdheXMgc2lnbmVkDQo+PiBpdCBmb3Iga2V4ZWMuIFRo
aXMgYWxzbyBtYWtlcyB0aGUgc2lnbmluZy9wYWNrYWdpbmcvaW5zdGFsbGluZyBzdG9yeQ0KPj4g
c2ltcGxlciBmb3Iga2VybmVscyB3aXNoaW5nIHRvIG1ha2UgdXNlIG9mIElNQSBhcyB0aGV5IGRv
bid0IGhhdmUgdG8NCj4+IHNoaXAgd2l0aCBJTUEvRVZNIHNpZ25hdHVyZXMuDQo+DQo+Rm9yIHN5
c3RlbXMgd2hpY2ggc3VwcG9ydCBQRSBzaWduYXR1cmVzLCBkaXN0cm9zIGRvbid0IG5lZWQgdG8g
cHJvdmlkZQ0KPsKgYm90aCBQRSBhbmQgSU1BIHNpZ25hdHVyZXMuIMKgUGxlYXNlIHJlZmVyIHRv
IHRoZSBJTUEgeDg2IGFyY2hpdGVjdHVyZSBzcGVjaWZpYw0KPnBvbGljeSBiZWluZyB1cHN0cmVh
bWVkIGFuZCB0aGUgSU1BIGtzZWxmdGVzdCBwYXRjaGVzIHRoYXQgSSBwb3N0ZWQgeWVzdGVyZGF5
Lg0KDQpUaGFua3MsIHdpbGwgbG9vayBpbnRvIHRoaXMuDQoNCi1Kb3JkYW4NCg0KPg0KPk1pbWkN
Cj4NCj4+DQo+PiBJIGtub3cgdGhhdCBjdXJyZW50bHkgSU1BIG9ubHkgaGFuZGxlcyBJTUEvRVZN
IHNpZ25hdHVyZXMgKG1ha2VzDQo+PiBzZW5zZSkgc28gdGhpcyB3b3VsZCBkZXZpYXRlIGEgZGVj
ZW50IGFtb3VudCBmcm9tIGhvdyBJTUEgY3VycmVudGx5DQo+PiB3b3Jrcy4gSSB3YW50IHRvIGdl
dCBnZW5lcmFsIHRob3VnaHRzIG9uIHRoaXMgcHJvcG9zYWwgYmVmb3JlIEkgc3RhcnQNCj4+IHdv
cmsgb24gdGhpcyB0byBlbnN1cmUgdGhpcyBpcyBzb21ldGhpbmcgdGhlIGNvbW11bml0eS9tYWlu
dGFpbmVycyBhcmUNCj4+IHN1cHBvcnRpdmUgb2YuDQoNCg==
