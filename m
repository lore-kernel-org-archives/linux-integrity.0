Return-Path: <SRS0=Wd89=NG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1329ECDE44
	for <linux-integrity@archiver.kernel.org>; Fri, 26 Oct 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456120848
	for <linux-integrity@archiver.kernel.org>; Fri, 26 Oct 2018 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=blancco.com header.i=@blancco.com header.b="AJ5+b18F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1456120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blancco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJ0CkL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:40:11 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:18688
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeJ0CkK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Oct 2018 22:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blancco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFpHNHQLTXD866qxQKVmeiaS+I2H+qPLOC7cEZXJNxU=;
 b=AJ5+b18FOhRaxbyjVqoNvEqrnWSHDWVbEchPYmWKeUTIbgKQXPEQ2on2NS7BD452e0GrwQRkvpzWqSdiv94ATAoA04U5EYkLWd+aJLXImoNBxjSOuAwzm1LHV7y5Fd4e0m87Pucc/64qNW6OAHoZRw0sWdc/a5GjQ69NErz4JAM=
Received: from AM3PR05MB1409.eurprd05.prod.outlook.com (10.163.60.11) by
 AM3PR05MB1314.eurprd05.prod.outlook.com (10.163.7.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Fri, 26 Oct 2018 18:02:08 +0000
Received: from AM3PR05MB1409.eurprd05.prod.outlook.com
 ([fe80::18d8:89f3:10e1:783a]) by AM3PR05MB1409.eurprd05.prod.outlook.com
 ([fe80::18d8:89f3:10e1:783a%7]) with mapi id 15.20.1273.019; Fri, 26 Oct 2018
 18:02:08 +0000
From:   Victor Gonzalo <victor.gonzalo@blancco.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: PPI TPM2 commands
Thread-Topic: PPI TPM2 commands
Thread-Index: AQHUbUw9QeadpprAXEmI8hkmdeTkkQ==
Date:   Fri, 26 Oct 2018 18:02:08 +0000
Message-ID: <AM3PR05MB1409B0601A0E9DA351623E519EF00@AM3PR05MB1409.eurprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=victor.gonzalo@blancco.com; 
x-originating-ip: [193.64.185.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR05MB1314;6:kSW0K5GAWIQbf7qA8YEWR9XZJcDwiEOS5FeZplo/3SCJlaay5/SJP2X1eKYTaA9JeqZHYbPf7ssfrr8RxRoqdc/uMpi2LYzfpbiBQxEqux2tAxAdKv4v1gP1bl2IObq5DPx8Qlb5PHG7Llqarfu3tcvzJR109nZQPM6fo1FrMlRAYxx0MbNfjefFPjqZKk1Wk1SJ3nXz6oac8PPFrDdVZ/8Rv8x1lDorBCxH5eplneljmaYSBhNctyU9ggxKtF/5xd2cfTHf3z3jciYHQYKGo42aAfLzSJvjsUzxjB1MkhwBNj7woXuQ/V9tkwVNPkWB/LiMQNCI4CUQos1GTR2aanW0ml5fP3qJRX0y+gxBbSl0LGgqrbMLExQ7BPdl7a5Mo6Jgr5CUIY5pCEOSyKgf7JpFW2xvFvv2Pp1Z6w+sbfp9EVy7mAudDYCJSPC1qKQY7dzeBU4HBd4c6+vE/560VA==;5:b9VJecQT3PkNx3RnzUH0W3usLpeScMU0a3fArQySdhyeUTv7IIULaTzfdzz4bdTCtnIrBPJZ0WaL9A0gSmeAUZeEU/TVrMDlPvK19uKctGOYKTrmTGgJfUVVVhABQ9bJ3nd1JLjMrgN39Pyfs90e+Z/OCGFkB0fcpidozwzG05Y=;7:jDz4S3T8xPJXqsscUWeB1Vtgf/wiJi2swo+YCsBkpD1agcL1uTO2wUVuTGGEPsiw1Q4G5K4T3EYUX8yViWHuJ0hw765+uXm457XNENczJX7Wrv6SVYZKFlAT+9/olUh9gbNHhldlmJVc/Z9E8Xipdw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55b63f3c-9b5f-4315-6a59-08d63b6d2541
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR05MB1314;
x-ms-traffictypediagnostic: AM3PR05MB1314:
x-microsoft-antispam-prvs: <AM3PR05MB1314FA03259B5A6DD44B4F2F9EF00@AM3PR05MB1314.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR05MB1314;BCL:0;PCL:0;RULEID:;SRVR:AM3PR05MB1314;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39850400004)(136003)(189003)(199004)(106356001)(6506007)(7696005)(99286004)(86362001)(14454004)(6436002)(2900100001)(478600001)(558084003)(25786009)(316002)(5640700003)(2906002)(256004)(71200400001)(71190400001)(66066001)(9686003)(486006)(44832011)(55016002)(8676002)(305945005)(7736002)(81156014)(6916009)(74316002)(3846002)(6116002)(5660300001)(2501003)(53936002)(7116003)(81166006)(2351001)(5250100002)(476003)(105586002)(26005)(33656002)(102836004)(68736007)(186003)(8936002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR05MB1314;H:AM3PR05MB1409.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: blancco.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SW+arkVDdh2hCawyk3rJKIAw+SUU2zsgVfz3MrxHyj/yjnZpAef1ONRPWdEBgmwz5qXGXTZQI8HTRbuwu8g1eXna20bDK5u66k4zbK4MGwF4y2S7bHTBYSMAewmONMfHj0OQXlWWf26hM236koMAlE9RgurQtXrJsK+a0M5zWdG6wsIOW6+VVqXSUcc+p5giJGFYkv59BcRBVB+v82ZO7HJI//dwP9d5az7QsJAdF+V3sZUN/PaCZ12amgeFs+qhLCsoDHF/a9eKUPsPSg5VH78F0T6TZ/kZoOslHqSx0YgowBh9UWd6PSBSJfQGg9C2RHmuABaekGLJ52D+uBtQwHfdik1GmKUwZrjVWkhYHkU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blancco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b63f3c-9b5f-4315-6a59-08d63b6d2541
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 18:02:08.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 601c5171-61ff-464a-bfbd-63e54b4c0e39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR05MB1314
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello
=A0 I'm trying to issue TPM2.0 PPI commands (operation > 22) with no succes=
s.
Is there any known issue with it?

Is there a reason PPI_TPM_REQ_MAX is set to 22? Could it be set to 127 so w=
e can check in
tcg_operations which commands are implemented or not?

Thanks
-V=EDctor Gonzalo
