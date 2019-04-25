Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B5C43218
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C3206C0
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 17:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="PF+KjGc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfDYRHg (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:07:36 -0400
Received: from mx0b-00273201.pphosted.com ([67.231.152.164]:43602 "EHLO
        mx0b-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbfDYRHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 13:07:36 -0400
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
        by mx0b-00273201.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PH4XcE008547;
        Thu, 25 Apr 2019 10:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS1017;
 bh=CQgRR9XBZcA3PCBXp1zWVRDHrTLRqWbsoILXo69sbWU=;
 b=PF+KjGc90KHKWT7HUO1OEQCBfz5sEQAb4/0XfCA3Tw5OFs+S/4mhSDgIM/UZD/LKElwT
 Fsz+SUlhqcfuK3HFUQcj6RTh56pH2ULd8f90nj8Fw4mL5bxZUvBifkGvkckKpx7tW5gK
 T5/hSbbonY9RKLIrLbFdHje7ehFQFfbSo/SGWwhlLxVXwfolRR6UoaIElxNfR7xWijaF
 bTMomagzQKbKGeMEXJ9UopJab7tGMdigg5+9BphTrK2CMMTHTDueMieSDBXrPwZOu6jc
 oBSFx8TqVlwwtDHipA8MxrVj2WJe9kA4XRHeXDcLfVhMjpdtQbXkq1Ma3/FL0QDu3clF zw== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0b-00273201.pphosted.com with ESMTP id 2s3cftgfqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Apr 2019 10:07:32 -0700
Received: from BYAPR05MB3975.namprd05.prod.outlook.com (52.135.196.21) by
 BYAPR05MB4615.namprd05.prod.outlook.com (52.135.233.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 17:07:30 +0000
Received: from BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6]) by BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6%4]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 17:07:30 +0000
From:   Kavitha Sivagnanam <kavi@juniper.net>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: Can we enforce "IMA Policy" based on file type
Thread-Topic: Can we enforce "IMA Policy" based on file type
Thread-Index: AdT2+ZPYS9gcleWrTmSmlo578nvD1wEZKpiAAAqvMnA=
Content-Class: 
Date:   Thu, 25 Apr 2019 17:07:30 +0000
Message-ID: <BYAPR05MB3975DDC3D6C74DD292BA7216C13D0@BYAPR05MB3975.namprd05.prod.outlook.com>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
 <1556193529.3894.94.camel@linux.ibm.com>
In-Reply-To: <1556193529.3894.94.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.1.100.23
dlp-reaction: no-action
msip_labels: MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Enabled=True;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_SiteId=bea78b3c-4cdb-4130-854a-1d193232e5f4;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Owner=kavi@juniper.net;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_SetDate=2019-04-25T17:07:27.4866520Z;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Name=Juniper Internal;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Extended_MSFT_Method=Automatic;
 Sensitivity=Juniper Internal
x-originating-ip: [66.129.239.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 710a982b-3e02-4a94-b9b5-08d6c9a0806e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR05MB4615;
x-ms-traffictypediagnostic: BYAPR05MB4615:
x-microsoft-antispam-prvs: <BYAPR05MB4615434FA90AC1366BF068B5C13D0@BYAPR05MB4615.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(13464003)(199004)(189003)(14444005)(55016002)(256004)(2501003)(66556008)(102836004)(68736007)(97736004)(110136005)(26005)(9686003)(3846002)(6246003)(316002)(229853002)(25786009)(33656002)(186003)(86362001)(476003)(6116002)(478600001)(99286004)(14454004)(7736002)(8936002)(446003)(76176011)(7696005)(305945005)(73956011)(6436002)(5660300002)(74316002)(71200400001)(52536014)(11346002)(486006)(71190400001)(6506007)(53936002)(53546011)(8676002)(76116006)(81166006)(81156014)(66066001)(66946007)(66476007)(64756008)(2906002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR05MB4615;H:BYAPR05MB3975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: juniper.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vsnXNFyQ4JcbIVW5LDXarbZU2gSuG9vz9ORGpj/LLM6Hk73LDjE41Ec8CE+xeG0UEgQV3N7ATxQTOibUIP5imhaLj12IiGijszb2rdvL3bK+bPPZ0mD1hVgmUgyyPF1QXAva/AawAf2G7qD8dneaClGp7uIi491xbtCMp9Oob12a1y4xCcy20ns8UKI3HGXPTKDG3O6RdK2PWMN4KsG2cEAq1oJZWjoSBo1u2jWA94oy97jV6NG/0nSi4wTbcEL0tDbGNSZ8yceZI6aVfNyknqUnqEgu2vx0NEa5yV8/00k35S5o5R/I/CumU+NigMzrzxKWjSNnu9A+XdDI+1MFVzxppVP/WEGmOMAumaE4b1NGYEkysxCvX3y2GbWp6MwZi9YKHvdS1BUcsV2vGporNhF5WzmkFKzl5XPJsr4KJiY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a982b-3e02-4a94-b9b5-08d6c9a0806e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 17:07:30.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4615
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TWltaQ0KDQo+PiBBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBleHRlbmQgSU1BIGJ5IGltcGxl
bWVudGluZyB0aGUgTFNNIA0KPj4gc2VjdXJpdHlfc2JfbW91bnQgaG9vaw0KDQpZZXMsIHRoYXTi
gJlzIGV4YWN0bHkgdGhlIGZlZWRiYWNrIEkgd2FzIGxvb2tpbmcgZm9yLg0KSSBrbm93IHRoYXQg
dGhlcmUgaXMgbm8gZXhpc3Rpbmcgc3VwcG9ydCBhcyBvZiB0b2RheS4gIEJ1dCB3YW50ZWQgdG8g
a25vdyBob3cgd2UgY2FuIGFkZCBzdXBwb3J0IHRoaXMuDQoNCi1LYXZpdGhhIA0KDQpKdW5pcGVy
IEludGVybmFsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaW1pIFpvaGFy
IDx6b2hhckBsaW51eC5pYm0uY29tPiANClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyNSwgMjAxOSA0
OjU5IEFNDQpUbzogS2F2aXRoYSBTaXZhZ25hbmFtIDxrYXZpQGp1bmlwZXIubmV0PjsgbGludXgt
aW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IENhbiB3ZSBlbmZvcmNlICJJ
TUEgUG9saWN5IiBiYXNlZCBvbiBmaWxlIHR5cGUNCg0KT24gRnJpLCAyMDE5LTA0LTE5IGF0IDIx
OjUyICswMDAwLCBLYXZpdGhhIFNpdmFnbmFuYW0gd3JvdGU6DQo+IEhpDQo+IA0KPiBJIGFtIHdv
bmRlcmluZywgaW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgSU1BIHBvbGljeSwgaWYg
dGhlcmUgDQo+IGlzIGEgd2F5IHRvIGVuZm9yY2UgYXBwcmFpc2FsIG9uIGEgZmlsZSBiYXNlZCBv
biB0aGUgZmlsZSB0eXBlLiDCoFRoZSANCj4gZmlsZSB0eXBlIHRoYXQgSSBhbSBpbnRlcmVzdGVk
IGluIGVuZm9yY2luZyB0aGUgcG9saWN5IGlzIGZvciBTcXVhc2hGUyANCj4gZmlsZXMuDQo+IA0K
PiBXZSB3YW50IHRvIGNoZWNrIHRoZSBzaWduYXR1cmUgb24gdGhlIFNxdWFzaEZTIGZpbGUgaXRz
ZWxmIGJlZm9yZSANCj4gbW91bnRpbmcgaXQgYW5kIG1hcmsgdGhlIHBhcnRpdGlvbiBhcyByZWFk
LW9ubHkuIFRoaXMgd291bGQgYWxsb3cgdXMgDQo+IHRvIGhhdmUgdGhlIGZsZXhpYmlsaXR5IG9m
IG5vdCBzaWduaW5nIGV2ZXJ5IGltbXV0YWJsZSBmaWxlIHdlIGFyZSANCj4gaW5zdGFsbGluZy4g
QWxzbyB0aGUgaW5zdGFsbGF0aW9uIHByb2Nlc3Mgd2lsbCBiZSBmYXN0ZXIgYXMgc2V0dGluZyAN
Cj4gZXh0ZW5kZWQgYXR0cmlidXRlIG9uIGV2ZXJ5IGZpbGUgaXMgZXh0cmVtZWx5IHRpbWUgY29u
c3VtaW5nIHByb2Nlc3MuICANCj4gVGhlIHNpZ25hdHVyZXMgYXJlIGdlbmVyYXRlZCBhdCBidWls
ZCB0aW1lICYgd2UgYXJlIHVzaW5nIHNlZnRhdHRyIHRvIA0KPiBzZXQgdGhlIHNlY3VyaXR5Lmlt
YSBhdHRyaWJ1dGUuDQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0byBhY2hpZXZlIHRoaXMgd2l0aCBl
eGlzdGluZyBwb2xpY3kgKG9yKSB3ZSBuZWVkIA0KPiBlbmhhbmNlbWVudCB0byB0aGUgY3VycmVu
dCBJTUEgY29kZT8gSWYgd2UgbmVlZCB0byBlbmhhbmNlIHRoZSBrZXJuZWwgDQo+IHRvIHN1cHBv
cnQgdGhpcyBmZWF0dXJlLCB3aGVyZSB3b3VsZCB3ZSBzdGFydD8NCg0KQXMgTWF0dGhldyBpbmRp
Y2F0ZWQsIHlvdSBjb3VsZCBkZWZpbmUgTFNNIGxhYmVscyBvbiB0aGUgc3F1YXNoZnMgZmlsZSBp
bWFnZXMuIMKgQW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8gZXh0ZW5kIElNQSBieSBpbXBsZW1l
bnRpbmcgdGhlIExTTSBzZWN1cml0eV9zYl9tb3VudCBob29rLiDCoFRoZSBJTUEgcG9saWN5IHJ1
bGUgd291bGQgcHJvYmFibHkgbG9vayBzb21ldGhpbmcgbGlrZToNCg0KYXBwcmFpc2UgZnVuYz1N
T1VOVF9DSEVDSyBmc25hbWU9c3F1YXNoZnPCoGFwcHJhaXNlX3R5cGU9aW1hc2lnDQoNCk1pbWkN
Cg==
