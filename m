Return-Path: <SRS0=Ggnc=SW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B2BC282E0
	for <linux-integrity@archiver.kernel.org>; Sat, 20 Apr 2019 00:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA53E2183F
	for <linux-integrity@archiver.kernel.org>; Sat, 20 Apr 2019 00:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="ol8+y+DV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfDTAIG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:08:06 -0400
Received: from mx0b-00273201.pphosted.com ([67.231.152.164]:52226 "EHLO
        mx0b-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbfDTAIF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Apr 2019 20:08:05 -0400
X-Greylist: delayed 8121 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 20:08:04 EDT
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
        by mx0b-00273201.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JLjAgI032433
        for <linux-integrity@vger.kernel.org>; Fri, 19 Apr 2019 14:52:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=PPS1017; bh=6Q99PB8kwj8+Uu6cjG+xCv7oDhGKKBm7kHjht2npG1U=;
 b=ol8+y+DVy2trroQaM4bVl5gbeyriXR/9zZntpGwrH2LN2hLrP8AE1xhvJfSHwUCRQ4ws
 E2bnd9P0frJP2q0goqUm6bpD+u7l1ffg5U0fD6UtEf1bi936pQfTXmW5K1r7c1gtiFlN
 Vgr6+QW1wn05mZ8f2R+bw9T/+2PfVa2OlR3ZC12o94C0eiMmNKYODhBYifUrnxz+tDmm
 wPgmcgEt1zgSE/7GJeiWrUdN+Dw4h0ZiQY+iXGl+1xmEwBkYt3lZLVQOKR0N990jJ2ND
 74+k9LTVxM0caMn+rE405MAaPeLGYsIkWJwPTlTP75gtWA11i3XqjAk5MiABJrF9z0xo RA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0b-00273201.pphosted.com with ESMTP id 2ryjv308uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 19 Apr 2019 14:52:43 -0700
Received: from BYAPR05MB3975.namprd05.prod.outlook.com (52.135.196.21) by
 BYAPR05MB5047.namprd05.prod.outlook.com (20.177.230.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.7; Fri, 19 Apr 2019 21:52:40 +0000
Received: from BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6]) by BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::3da4:fffd:35ed:4ec6%4]) with mapi id 15.20.1835.003; Fri, 19 Apr 2019
 21:52:40 +0000
From:   Kavitha Sivagnanam <kavi@juniper.net>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Can we enforce "IMA Policy" based on file type
Thread-Topic: Can we enforce "IMA Policy" based on file type
Thread-Index: AdT2+ZPYS9gcleWrTmSmlo578nvD1w==
Date:   Fri, 19 Apr 2019 21:52:40 +0000
Message-ID: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.1.100.23
dlp-reaction: no-action
msip_labels: MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Name=Juniper Internal;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_SetDate=2019-04-19T20:35:08.3264106Z;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Owner=kavi@juniper.net;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_SiteId=bea78b3c-4cdb-4130-854a-1d193232e5f4;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Enabled=True;
 MSIP_Label_0633b888-ae0d-4341-a75f-06e04137d755_Extended_MSFT_Method=Automatic;
 MSIP_Label_154c1852-7526-40a8-86a6-f35479dab509_Enabled=True;
 MSIP_Label_154c1852-7526-40a8-86a6-f35479dab509_SiteId=bea78b3c-4cdb-4130-854a-1d193232e5f4;
 MSIP_Label_154c1852-7526-40a8-86a6-f35479dab509_SetDate=2019-04-19T18:48:43-0800;
 MSIP_Label_154c1852-7526-40a8-86a6-f35479dab509_Name=Juniper Internal;
 Sensitivity=Juniper Internal Juniper Internal
x-originating-ip: [66.129.239.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d41cc22-3596-42cb-5304-08d6c5115832
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR05MB5047;
x-ms-traffictypediagnostic: BYAPR05MB5047:
x-microsoft-antispam-prvs: <BYAPR05MB50474CA552E8B1E1CC4CA04FC1270@BYAPR05MB5047.namprd05.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(81166006)(8936002)(478600001)(6916009)(53936002)(52536014)(14454004)(8676002)(81156014)(55016002)(316002)(5660300002)(6116002)(66946007)(4744005)(5640700003)(2351001)(71190400001)(74316002)(71200400001)(26005)(186003)(14444005)(256004)(305945005)(7696005)(99286004)(3846002)(66066001)(2906002)(9686003)(97736004)(6436002)(68736007)(73956011)(102836004)(86362001)(486006)(25786009)(6506007)(66446008)(66476007)(76116006)(33656002)(64756008)(7736002)(66556008)(476003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR05MB5047;H:BYAPR05MB3975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: juniper.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: raDE50jAUk9Vz152z1xNCC1xiuCY2w0K+xroIUvOsjRaCGfQAVoKfdxF8J13RZcyXssM5aHMc1F5jaVPAzB65qNu/5zHz0Cugmuy+mskcLQcOJAzMCbvl5QQNGaYtsyjgXDPKtAUNWGstiJYpV/WLq+JlBl9oT2wEijvokdq+byjmabqnxeMDHvsi5Q42caKhklp3Bq4eitwepG7vkBfMJzbNKgsHuHK0VqXu6LJQFcoft2moxC/yUGL9UjRj5wdBOStoTb6SRR1XSLV4wJqnWwQ0vyHl7GQPLNG8902onUZUvDimVz0hMCSubpj4zFXU0Yi1V7KLuauZ6E5myerJ0Zt8WonLTP4XEbyhUNk5cvwG0ZVD02Yr8gEXkEdjQXLe1suD1j2Eu79oIxzCPahr/BFQMd/YIKiYktZY8WZu68=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d41cc22-3596-42cb-5304-08d6c5115832
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 21:52:40.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5047
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

I am wondering, in the current implementation of IMA policy, if there is a =
way to enforce appraisal on a file based on the file type. =A0The file type=
 that I am interested in enforcing the policy is for SquashFS files.

We want to check the signature on the SquashFS file itself before mounting =
it and mark the partition as read-only. This would allow us to have the fle=
xibility of not signing every immutable file we are installing. Also the in=
stallation process will be faster as setting extended attribute on every fi=
le is extremely time consuming process.  The signatures are generated at bu=
ild time & we are using seftattr to set the security.ima attribute.=20

Is it possible to achieve this with existing policy (or) we need enhancemen=
t to the current IMA code? If we need to enhance the kernel to support this=
 feature, where would we start?

Thanks
Kavitha



Juniper Internal
