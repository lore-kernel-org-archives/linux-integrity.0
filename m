Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2761C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB68220851
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 22:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB68220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeK1Ja0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:30:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbeK1Ja0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Nov 2018 04:30:26 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARMJCa6040411
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 17:31:02 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p1darka23-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 17:31:02 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Tue, 27 Nov 2018 22:31:01 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 22:30:59 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARMUwGX19464426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 22:30:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE2C112062;
        Tue, 27 Nov 2018 22:30:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC265112064;
        Tue, 27 Nov 2018 22:30:58 +0000 (GMT)
Received: from [9.2.202.159] (unknown [9.2.202.159])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 22:30:58 +0000 (GMT)
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org
References: <1541962653.3190.7.camel@HansenPartnership.com>
 <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
 <1541968191.3190.12.camel@HansenPartnership.com>
 <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
 <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
 <1541972556.3734.90.camel@linux.ibm.com>
 <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
 <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
 <20181118081833.GH5897@linux.intel.com>
 <467833cc47247a55595d72426f46eeac1406eb04.camel@mniewoehner.de>
 <20181119134956.GD8755@linux.intel.com>
 <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
 <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Tue, 27 Nov 2018 17:31:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112722-0068-0000-0000-00000367F2EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010133; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123687; UDB=6.00583353; IPR=6.00903816;
 MB=3.00024359; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 22:31:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112722-0069-0000-0000-00004691DFFD
Message-Id: <010f0d36-66b1-0202-543b-d579db4b2d93@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/26/2018 2:15 PM, Michael Niewöhner wrote:
> Hi again,
> 
> after some experiments I finally found a solution...
> There seems to be a bug in TPM2.0 firmware version (1.3.1.0) included in Lenovos
> UEFI image but they do not provide an update.
> 
> I have extracted the firmware version 1.3.2.8 from Dell's XPS15 TPM2.0 firmware
> update and used this to replace the firmware in my Lenovo UEFI image.
> After flashing this version via UEFI Setup the TPM2.0 gets detected and now is
> fully working. WTF.
> 
> For anyone having the same problem: binwalk, uefi-firmware-parser, uefipatch and
> flashrom are your friends ;-)

Just to make sure I understand it, do I have this right?

1.3.2.8 is Nuvoton's TPM firmware.  It was embedded in Dell's firmware 
(UEFI?).  You extracted it from Dell and inserted it into Lenovo. 
(UEFI?).  Then you flashed the TPM firmware.

