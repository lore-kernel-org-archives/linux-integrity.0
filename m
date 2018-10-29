Return-Path: <SRS0=YknM=NJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375FAC0044C
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 13:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26D2084A
	for <linux-integrity@archiver.kernel.org>; Mon, 29 Oct 2018 13:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B26D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeJ2V5S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:57:18 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:34484 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbeJ2V5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Oct 2018 17:57:18 -0400
X-Greylist: delayed 3520 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 17:57:17 EDT
Received: from pps.filterd (m0048204.ppops.net [127.0.0.1])
        by m0048204.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id w9TC5pjv041513
        for <linux-integrity@vger.kernel.org>; Mon, 29 Oct 2018 08:10:13 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     Victor Gonzalo <victor.gonzalo@blancco.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
Subject: RE: PPI TPM2 commands
Thread-Topic: PPI TPM2 commands
Thread-Index: AQHUbUw9QeadpprAXEmI8hkmdeTkkaU2IP7g
Date:   Mon, 29 Oct 2018 12:10:05 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C00EDA8DF7@ALPMBAPA12.e2k.ad.ge.com>
References: <AM3PR05MB1409B0601A0E9DA351623E519EF00@AM3PR05MB1409.eurprd05.prod.outlook.com>
In-Reply-To: <AM3PR05MB1409B0601A0E9DA351623E519EF00@AM3PR05MB1409.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjY3Njc0YmQtZGI3My0xMWU4LTk2MzUtNWNlMGM1OGE4NGIzXGFtZS10ZXN0XDY2NzY3NGJlLWRiNzMtMTFlOC05NjM1LTVjZTBjNThhODRiM2JvZHkudHh0IiBzej0iODk1IiB0PSIxMzE4NTI4ODUzMzIzNDEzMjQiIGg9Im9Kd01Wb2pxOTJZQlZPNTMzT211VGpSTncraz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-originating-ip: [3.159.19.192]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810290115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Hello
>   I'm trying to issue TPM2.0 PPI commands (operation > 22) with no success.
> Is there any known issue with it?
> 
> Is there a reason PPI_TPM_REQ_MAX is set to 22? Could it be set to 127 so
> we can check in tcg_operations which commands are implemented or not?
> 
> Thanks
> -Víctor Gonzalo

The current tpm_ppi.c driver is a bit dated.
It does not recognize v 1.3 correctly, it does not support commands with arguments,
(23 requires the bank bitmask as an argument), and it limits the display to < 23.
I'm working on a patch, and have successfully issued 23 (PCR_Allocate).

Note that not all vendors implement 23 as it could lock users out of Bitlocker systems. 
My HP Spectre does, but apparently Dell's don't in general. I was planning on 
sampling different systems once the driver update is working.

dave
