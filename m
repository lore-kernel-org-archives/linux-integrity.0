Return-Path: <SRS0=VzeC=SZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F91C10F03
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FE218D2
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="Oi1xyhIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDWTt4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:49:56 -0400
Received: from mx0b-00273201.pphosted.com ([67.231.152.164]:46928 "EHLO
        mx0b-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbfDWTt4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Apr 2019 15:49:56 -0400
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
        by mx0b-00273201.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NJnsAB024937;
        Tue, 23 Apr 2019 12:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PPS1017;
 bh=TZVHE7KWq72wU+QCTnOUoO0Cne2O13DAoojJhgRSr+8=;
 b=Oi1xyhIhtMQpIBwEWHT17aWaPzB277qE5YnNvAjuk9QbuxEC0aRr/3KIUetC1pZpFfRp
 7Sa9njUlTGGkCu1/AzJ4FURm73xKRmLgaQ7HvMo+tYGZcqHcWfaV+tNQFxng+bGdgMoW
 b0DzmDsrcras6ITsiuWoczwZDkHoojS/nrCEFXQdpjJoKivH8mak+IZ1kQK976VxuKtH
 gatopI/fpCL69/X8XfR02BiWv/yRjo9rrq5NgPwhviK468ob/TSrPGgfRkVzzU35SA6o
 wgcLMEp8JmkqmkWGNjm8l+n67w+2qpA+fTEqSqE6fT0NuV7zEECdbSOW3lM47xxDlFaQ nQ== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-00273201.pphosted.com with ESMTP id 2s23hxgm5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 12:49:53 -0700
Received: from BYAPR05MB3975.namprd05.prod.outlook.com (52.135.196.21) by
 BYAPR05MB5671.namprd05.prod.outlook.com (20.177.186.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 23 Apr 2019 19:49:47 +0000
Received: from BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6]) by BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6%4]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 19:49:47 +0000
From:   Kavitha Sivagnanam <kavi@juniper.net>
To:     Matthew Garrett <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Can we enforce "IMA Policy" based on file type
Thread-Topic: Can we enforce "IMA Policy" based on file type
Thread-Index: AdT2+ZPYS9gcleWrTmSmlo578nvD1wDBMSAA//+pXgA=
Date:   Tue, 23 Apr 2019 19:49:47 +0000
Message-ID: <056F1F8D-92B7-4796-A496-8D64BABBE4B4@juniper.net>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
 <CACdnJutoJGm8mJJvgXZqpD7sa+OUxYqHHVyJEeGMu2WrubddZQ@mail.gmail.com>
In-Reply-To: <CACdnJutoJGm8mJJvgXZqpD7sa+OUxYqHHVyJEeGMu2WrubddZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.18.0.190414
x-originating-ip: [66.129.239.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ded4d375-a53a-4f3f-532f-08d6c824d750
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR05MB5671;
x-ms-traffictypediagnostic: BYAPR05MB5671:
x-microsoft-antispam-prvs: <BYAPR05MB567171C4606FC602DC2C46EAC1230@BYAPR05MB5671.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(189003)(51914003)(199004)(446003)(305945005)(11346002)(6512007)(7736002)(83716004)(2616005)(476003)(6246003)(86362001)(14454004)(486006)(81166006)(6916009)(478600001)(25786009)(81156014)(53936002)(8676002)(71190400001)(4326008)(8936002)(71200400001)(6436002)(82746002)(4744005)(73956011)(76116006)(66446008)(66556008)(36756003)(5660300002)(64756008)(66476007)(68736007)(97736004)(256004)(102836004)(229853002)(2906002)(316002)(186003)(3846002)(6116002)(76176011)(26005)(58126008)(6486002)(66946007)(66066001)(99286004)(6506007)(33656002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR05MB5671;H:BYAPR05MB3975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: juniper.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XU5LEAFzY5OpnkaUBMYW7OGLy4auEOiZJIFyIRZj3kuOoCipS8E+U+881oVqueEqyuj2qkEBxs9FzX/8j+ygZeaSuQZekzs5J6M5GQOzRDqyZb0W+PuSd+9ML+fg+1FPPt/fA8I/Qytu8fh0wCsA/1/iEyAN+7iYCl/lSrgH+LnHkr6QQIesZUSCp33QU8ixDht6CNPY6jwlkXC0hbGhCveopyJXU9dU7n/Y7P1KsWfi8Lpg0AB9Y1FTKbUMnJ/I29cP+PeJ2jq5a2ldSC3ihXMCu/gE0bC47e8DG2SSbu7n705zL2l8zqthkzMaEnvLYM8gjsikXWl+4sV7nNlZQ9ywOAdwcxqq3I/cZlhmERJ/Lv+qq9OkybnQmMg8ogLtxTP3zzvAGjOXTLGInuCUbDAs9/LNQ5LNjyg07aOxZK8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CD1A2FBD0255045B3E2B1F5659D45DA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ded4d375-a53a-4f3f-532f-08d6c824d750
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 19:49:47.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TWF0dA0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZS4gWW91IGFyZSBwcmV0dHkgbXVjaCBjb25m
aXJtaW5nIHdoYXQgd2UgZm91bmQgb3V0Lg0KRXZlbiBpZiBJIGFtIHVzaW5nIExTTSBsYWJlbCBm
b3Igc3F1YXNoZnMgZmlsZXMsIGl0IGNhbiBvbmx5IGVuZm9yY2UgSU1BIGFwcHJhaXNhbCBvbiBm
aWxlcyB0aGF0IEkga25vdyBhYm91dC4NCkl0IHdpbGwgbm90IGFmZmVjdCBhbnkgbmV3IFNxdWFz
aGZzIGZpbGVzIGZvciB3aGljaCBsYWJlbCBpcyBub3Qgc2V0IHlldC4NCg0KDQrvu79PbiA0LzIz
LzE5LCAxMTowMCBBTSwgIk1hdHRoZXcgR2FycmV0dCIgPG1qZzU5QGdvb2dsZS5jb20+IHdyb3Rl
Og0KDQogICAgT24gRnJpLCBBcHIgMTksIDIwMTkgYXQgNTowOCBQTSBLYXZpdGhhIFNpdmFnbmFu
YW0gPGthdmlAanVuaXBlci5uZXQ+IHdyb3RlOg0KICAgID4NCiAgICA+IEhpDQogICAgPg0KICAg
ID4gSSBhbSB3b25kZXJpbmcsIGluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIElNQSBw
b2xpY3ksIGlmIHRoZXJlIGlzIGEgd2F5IHRvIGVuZm9yY2UgYXBwcmFpc2FsIG9uIGEgZmlsZSBi
YXNlZCBvbiB0aGUgZmlsZSB0eXBlLiAgVGhlIGZpbGUgdHlwZSB0aGF0IEkgYW0gaW50ZXJlc3Rl
ZCBpbiBlbmZvcmNpbmcgdGhlIHBvbGljeSBpcyBmb3IgU3F1YXNoRlMgZmlsZXMuDQogICAgDQog
ICAgTm90IGRpcmVjdGx5IC0gdGhlIGtlcm5lbCBoYXMgbm8gaWRlYSBvZiB3aGF0IHR5cGUgYSBm
aWxlIGhhcy4gSWYgeW91DQogICAgdXNlIHNlbGludXggb3Igc21hY2sgdGhlbiB5b3UgY2FuIGxh
YmVsIHNxdWFzaGZzIGZpbGVzIHdpdGggYSBzcGVjaWZpYw0KICAgIHR5cGUgYW5kIHRoZW4gdXNl
IHRoZSBvYmpfcm9sZSBvcHRpb24gaW4geW91ciBwb2xpY3kuIFlvdSdkIGFsc28gbmVlZA0KICAg
IHBvbGljeSB0aGF0IHByZXZlbnRzIGFueW9uZSBlbHNlIGZyb20gbW9kaWZ5aW5nIHRoZXNlLCBz
byBkZXBlbmRpbmcgb24NCiAgICB3aGF0IHlvdXIgdGhyZWF0IG1vZGVsIGlzIHRoaXMgbWF5IG5v
dCB3b3JrIG91dC4NCiAgICANCg0K
