Return-Path: <SRS0=tKLo=PF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29270C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 28 Dec 2018 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C034820675
	for <linux-integrity@archiver.kernel.org>; Fri, 28 Dec 2018 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SeLRLINy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeL1TZR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:25:17 -0500
Received: from mail-eopbgr710103.outbound.protection.outlook.com ([40.107.71.103]:59809
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbeL1TZR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Dec 2018 14:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qlb7YJYFkt/ZuKpEt1QxuWTbNZ5DTyRFxd8AztCGNQ=;
 b=SeLRLINybVgzZvl3e3KVpK3IDR1uiauszev/lQ2C5YuUH0TlIhnZ9AAagGCOz5sZQqTXlMwwJorib+FhUvC/sObBhX9iWUhDyMM/GMJR7R/QDF8m4qy7VpJhq40MuvN9N5jmKtbZqYJ2w+1LHeJx9HbSxFkXOG51rwfgeySJXOc=
Received: from CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1495.0; Fri, 28 Dec 2018 19:25:12 +0000
Received: from CY4PR21MB0631.namprd21.prod.outlook.com
 ([fe80::f80e:25e7:c88f:e560]) by CY4PR21MB0631.namprd21.prod.outlook.com
 ([fe80::f80e:25e7:c88f:e560%8]) with mapi id 15.20.1495.005; Fri, 28 Dec 2018
 19:25:12 +0000
From:   Jordan Hand <Jordan.Hand@microsoft.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: [DISCUSSION] IMA measurement log format
Thread-Topic: [DISCUSSION] IMA measurement log format
Thread-Index: AdSe25xFv/iAZ6N9S12eCCnkdRom0w==
Date:   Fri, 28 Dec 2018 19:25:12 +0000
Message-ID: <CY4PR21MB06311ED50B5A02F94AF307B0F0B70@CY4PR21MB0631.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:1:b594:c693:a247:35b4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:MrXTYBmxXjE7ghRRnk5vTcmxuV9+LL07wj37pMAIFiHYO8bFP6foYRwIEIheicMjSM+u9qQg5LZcmf70GODAPZHiRrtVsXhmKFNPib7gp0M0Jqso3PAcEWSyIs5ULq514NeRYj74Jp+Hr4/q+C6p9IRP0VjEE0h8hsSXqiI/WzuHahaUIqqBcar7PC9Jg6hapsPBIILkNBQCL4IfdQbqW5Qv8T/1TjCabcrm47mVxgCCCSccCn3jHkE4Tm4FoJ6pjgaU/0hmt9G2svU+kQnZeq0j/8EmH8U24Qhxx8tvLiA3H0VWBIPHw4VG4AnLIGrZUcHzbOQsupA8XrSYHBnxEeMwjXrjP8HuFBAmuaNmt5iaPnK/T9e2xgqijErFCQWtOhpJwGPBLQ5iOjnghLGEajtfiUP5aUrhgmlCiRb+2QpjEnul2S5QZlCFbo5u6tm1qlI6iQv0nIi744NnK42OEA==;5:YOFK/Cj3RLTeEwcnJkz0g6JVY6qp7Zz4bF5wAWoSbOz5wyay9yKy8isigiqWAGdX6znwKsn74Ur6xGrW0vK63AP1hPpDEfPElIedlxjgOlvVEZ60oeR7VYBPTpbQWVZ9Bie9hKf8LczlM37Fx5UrGrHuVJyV+EcndbyvQX60CadoEeY4lJuNkrRu8lltf22lr5LhYahLbxm6tm6Zna/w/g==;7:P+9yrMDhwo2DVsFHtshp7LriXfN9N8Q2eKCfid35ACjd/5TV5TLWdvXs9rQqryUT6fEtqDZa5gbYO1uCLkolIpKJeZ85aDpzT2vHpXwZ8/nEJCZLoLL9DhRlHWLxxP6nXBOoCuSeWtYvWW5fj8FMQQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b27edbc5-6a2d-4898-5f8c-08d66cfa300b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
x-ms-exchange-purlcount: 1
x-o365-sonar-daas-pilot: True
x-microsoft-antispam-prvs: <CY4PR21MB0759393D3A58DF71D7F864EFF0B70@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(2018427008)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(476003)(10090500001)(74316002)(86612001)(68736007)(2501003)(7736002)(5660300001)(256004)(8990500004)(14454004)(316002)(6346003)(186003)(6506007)(305945005)(72206003)(99286004)(46003)(22452003)(81166006)(966005)(102836004)(33656002)(81156014)(486006)(478600001)(86362001)(14444005)(8676002)(10290500003)(7696005)(71190400001)(105586002)(5640700003)(2906002)(25786009)(55016002)(2351001)(71200400001)(6916009)(8936002)(6436002)(9686003)(97736004)(53936002)(6116002)(106356001)(6306002)(12290500005)(15398625002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0631.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jordan.Hand@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7uOsIaz89kB01v+56oJn/6Yqtcl/9XJObsyNhO3QoiB2nm3IsyFjQV20Z51n+qhwgQTqHyESiQS+nQc7DzW5neOGw7DlF56ikWZmR/e5jF2Tmoq40o0ugTpOmg61LcZu6AZMtXUZ94s0dbkjwn6ygtW0cFQuhDFBMnOwxJ93p3b8GRyQfyX+1ylKgZxd8fe3pmtpD/eISYQFW5w8pZTEdcDeaAL50CH9YR1YT8Il6NvdnQNNM7XWvJNOuGHbgrzo5YPw5pjq/GL0EJsZR/xkdGcsVSS4punPxL53bi6MK3Cwg2sypFcLgxWoaw51n7kd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27edbc5-6a2d-4898-5f8c-08d66cfa300b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 19:25:12.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi folks,=0A=
=0A=
I have a question about the format of the IMA measurement log (/sys/kernel/=
security/ima/binary_runtime_measurements).=0A=
=0A=
The current IMA format uses the following structure:=0A=
=0A=
struct ima_template_entry {=0A=
	int pcr;=0A=
	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */=0A=
	struct ima_template_desc *template_desc; /* template descriptor */=0A=
	u32 template_data_len;=0A=
	struct ima_field_data template_data[0];	/* template related data */=0A=
};=0A=
=0A=
My question is, why does the IMA log not use the same log format that is us=
ed for PCR events in the TCG EFI spec? This would allow the same parser to =
be used for binary_bios_measurements and binary_runtime_measurements, while=
 still maintaining all information captured by the current template format =
simply as event data.=0A=
=0A=
Here is the EFI structure that is logged for each event in binary_bios_meas=
urements (it is similar the structure used by IMA but different enough to r=
equire different parsing).=0A=
=0A=
typedef struct {=0A=
    TCG_PCRINDEX PCRIndex;=0A=
    TCG_EVENTTYPE EventType;=0A=
    TCG_DIGEST digest;=0A=
    UINT32 EventSize;=0A=
    UINT8 Event[1];=0A=
} TCG_PCR_EVENT;=0A=
=0A=
From the TCG EFI Spec: https://trustedcomputinggroup.org/wp-content/uploads=
/EFI-Protocol-Specification-rev13-160330final.pdf=0A=
Note the above structure is for the TPM1.2 speficiation. There is a slightl=
y different crypto-agile TCG_PCR_EVENT2 structure for TPM2.0. =0A=
=0A=
I feel that, when possible, it is best that the kernel keep continuity with=
 other components which will be measuring events into the TPM for ease of p=
arsing when these logs are used for attestation.=0A=
=0A=
I understand these may not be trivial changes (and log format changes may b=
reak existing applications) but I would like to get some thoughts on why so=
me of these decisions were made and possible ways to get more continuity in=
 Linux system attestation moving forward.=0A=
=0A=
Thanks!=0A=
Jordan=0A=
=0A=
=0A=
