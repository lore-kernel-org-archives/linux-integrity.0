Return-Path: <SRS0=nfu5=RC=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3BCC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86820818
	for <linux-integrity@archiver.kernel.org>; Wed, 27 Feb 2019 22:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="loU5aVpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfB0WCV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:02:21 -0500
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:41024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfB0WCV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Feb 2019 17:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV0cImQ22jrcPrRiSCPOu+y+atVT7+evinmdG0Yp61k=;
 b=loU5aVpKgZ18J1DhNpSBX0Xo8jd0ONs6tPDxPA0mGeYWZx9RqUTLBY4154XZq6rN1MYmf3bqb0utjazTF0uTsZunQ0B+c5gYxW5/XiMqn9a25nn18UuGXk+9l+VlgQl2b1TkBD92UYC7zPoe4wiQXODHI/IVdfEGHhTDRiLT0vM=
Received: from MWHPR21MB0751.namprd21.prod.outlook.com (10.173.51.13) by
 MWHPR21MB0783.namprd21.prod.outlook.com (10.173.51.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.2; Wed, 27 Feb 2019 22:02:18 +0000
Received: from MWHPR21MB0751.namprd21.prod.outlook.com
 ([fe80::519:bdef:693e:ac61]) by MWHPR21MB0751.namprd21.prod.outlook.com
 ([fe80::519:bdef:693e:ac61%5]) with mapi id 15.20.1686.003; Wed, 27 Feb 2019
 22:02:18 +0000
From:   Jordan Hand <Jordan.Hand@microsoft.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: [DISCUSSION] IMA Signature Measurements
Thread-Topic: [DISCUSSION] IMA Signature Measurements
Thread-Index: AdTO5+uCjRXn1sSWQPSawW4lvgYSAA==
Date:   Wed, 27 Feb 2019 22:02:17 +0000
Message-ID: <MWHPR21MB075192F589A7AA4E8B89F8B9F0740@MWHPR21MB0751.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jorhand@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-27T22:02:04.9489991Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=447d0b53-a7c6-4153-89ae-ddfb41761162;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:9:3e07:7f03:969a:9b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de647cd8-6871-4110-b583-08d69cff3d63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0783;
x-ms-traffictypediagnostic: MWHPR21MB0783:
x-o365-sonar-daas-pilot: True
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR21MB0783;23:/8g9/jHZhancxUAQultc+64qbaQWTV3P2y4Ukia96?=
 =?us-ascii?Q?WsqeOmDIxcIG27LGClTdTM5ixro9VeyqQomPgYzbPtFIEZciFRjwK2ny237G?=
 =?us-ascii?Q?SFqgnzhxKYPLZskUJIJZ3Rfio1MtnKVdKwY4YCmbxqgPNJVSQek13SnvEh1J?=
 =?us-ascii?Q?eE8vMCWsWgaGC6spLXMk2mYFs+4W/HflFzJWH9TVdT45Ex/CccilZseP3hbv?=
 =?us-ascii?Q?OfGZgJyzCt7CIX9QzS4Sk69p6RH0mgDSrBnye8AjeaAr282ue4ucpabPFC2W?=
 =?us-ascii?Q?ZglIu2HgN+kNsHKFkelUdOHW/WqWe5t/LgQD1v/1XryU3k+0BUVBz7C7IcmZ?=
 =?us-ascii?Q?cFDjMw+9wnB2Rq2gjQwZd7BbZ/FgLHzfMSF30GhEvlr+dpycgSfMMWk6pgYp?=
 =?us-ascii?Q?sURMqhMDclA88BipXwL2sPGFKtP1471Z1oD7cdnVh4BvvKabKDU1BY+BRyR9?=
 =?us-ascii?Q?6n6n3l8fVQ1o8bnB+lydC9ZscwzQxsEtSkGmfEoV+3FFZjue/0ISPx5awq+i?=
 =?us-ascii?Q?sB6yN0l65NHbXcfCzGjnrzB/7flqc688QzsjfI+o8jDWqEYEwx85iKFd62qN?=
 =?us-ascii?Q?jX16wxMv+75W3mz5DwKYCWr/cnYP64XRpgJGjAqgtWZqi4eBkg93gwUJ0aV1?=
 =?us-ascii?Q?0u2D6uflTnKnPPJrdwFp9ovzU+PXIo6JXa6c2dqifNgysO2VeG2v6S5H0FcV?=
 =?us-ascii?Q?f3gkp7+qv0VnziWiJSREkJSVZgk6CtbkgZtsstNYF3vZIl3x/ZFgANV7mrVY?=
 =?us-ascii?Q?2WIqKiOoVzWwpwpjxxQ6c+ywIenN+EM0SVOTxkueIucHi5zLf945Om5g//g0?=
 =?us-ascii?Q?Kn2n4JgVXnc1MCx57SAgWZ6NZPa6Mjcd0bSW0n0h6aqNg/FEwYI7mJSgql3p?=
 =?us-ascii?Q?1f30/wYajlDNDcaQhGPv/UKJg9NQU58j3q988KuLWxv+OmGE60rEh/L18Pjy?=
 =?us-ascii?Q?ocpQxU5W0M53fVj13o8ckcx4X/oGDQfBnQp9tXymJHdJ4+aFbyQXHf3Tc6bt?=
 =?us-ascii?Q?8N/tJGKF9mQ2AkVSvh+dh4H5dcaTqLXxscEkiADl4qXg09ZLAaf4mYqAjoPS?=
 =?us-ascii?Q?NJ9uWX4SGPYuIjZMZDjuSDKdxZShvKoR5ZTtr+G2mECn6GCRcoY+vScfk+ga?=
 =?us-ascii?Q?eLt8r/tt1+Rz+OkX+Mme8b+ewB4sXJMEHoSGygwOW/3T6ccjLavqrq6kCA6T?=
 =?us-ascii?Q?TPM24LZetIPlyWX/elSOZOsMWwg9/fNV9sYQ0n0jP8fsDRDIakIcL4IymjA/?=
 =?us-ascii?Q?bc/vG+wkPRi1aZFOTIYLJ9hCGv4IoJnqrEtEK3LEAQOrxgg9JGX7UKU65IJq?=
 =?us-ascii?Q?fZ6eNts/Sx9igJvxZu5D/88cdJk0q5NhKUpsaEvlevZ?=
x-microsoft-antispam-prvs: <MWHPR21MB07836C1D284D8B64D93B1D97F0740@MWHPR21MB0783.namprd21.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(14454004)(561944003)(2906002)(486006)(8936002)(476003)(5640700003)(55016002)(81156014)(8676002)(46003)(6346003)(81166006)(10290500003)(22452003)(316002)(8990500004)(53936002)(10090500001)(97736004)(9686003)(478600001)(5660300002)(6116002)(72206003)(6436002)(52536013)(86612001)(186003)(305945005)(74316002)(2501003)(2351001)(99286004)(86362001)(7696005)(6916009)(68736007)(71190400001)(71200400001)(4326008)(14444005)(25786009)(33656002)(106356001)(6506007)(105586002)(7736002)(102836004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0783;H:MWHPR21MB0751.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jordan.Hand@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: adkUi0tITd6ESjbmljHLNPFDmN5b1ld9d9lhJLWtZST4ttXhJ4boLyTxKky/LRMv4mTMntFbj3KSyL4c1c7+jDDr0WlzdOsCotDHy41LB7ijzVLQU8g9NhEC0HnMQVWh6LgE/wS1ArFWH1RJUVro4Qh8Jyk4IDxT47uVyb6VXcie8xGFFF4e4BGx6wU39i7NrZpG7eeODZlCCUT0liA6AXUERbqZ2yjrM+t0nPbRo38XS6AkPha2D6f4k7Z1rPKuY6iAqL87Gp9TlYQoqDtxKuUJTeZtzdey3gGx2B+HeaP1MW5T+1PVCnGOviMXR5RWRao34Z/PpqEtTvt56rTDprLhLTHDHYw50DJ8N2iBTcEjFy+iAVU5YorK8Ka0IP6lRsTCrUdl4EEf99DtzbKUXXyuDUwg7ZSu7LEtRYDYSzw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de647cd8-6871-4110-b583-08d69cff3d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 22:02:17.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0783
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I have been looking into how IMA policies work for measuring/appraising in =
specific scenarios such as kexec. IMA has specific policies for these scena=
rios (i.e. setting func to KEXEC_KERNEL_CHECK). While these policies do exi=
st, in practice it seems that IMA treats these files the same way it treats=
 any other file; it will validate and measure (in the case of ima-sig) base=
d on the IMA signature in the file's inode.

It seems that this policy is mostly a placeholder in case there is a desire=
 later to do some different behavior based on the file type (correct me if =
I'm wrong and there's another reason for having the KEXEC_KERNEL_CHECK func=
tion).

I wanted to get feedback on the possibility of IMA measuring a different si=
gnature type during kexec. In general kernal images are signed as PE files,=
 with the signature embedded in the file image. Normal kexec (not the IMA p=
ath) validates this type of signature. I would like to use IMA to both appr=
aise and measure based on this signature instead of the IMA signature (this=
 could have a Kconfig flag). Alternatively it could look for both. I think =
this makes sense because it means folks can make use of IMA's measurement c=
apabilities while still signing the kernel image in the same way they have =
always signed it for kexec. This also makes the signing/packaging/installin=
g story simpler for kernels wishing to make use of IMA as they don't have t=
o ship with IMA/EVM signatures.

I know that currently IMA only handles IMA/EVM signatures (makes sense) so =
this would deviate a decent amount from how IMA currently works. I want to =
get general thoughts on this proposal before I start work on this to ensure=
 this is something the community/maintainers are supportive of.

Thanks,
Jordan

(sorry for the clutter Mimi, I forgot to make the first one plaintext so it=
 didn't post)
