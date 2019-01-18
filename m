Return-Path: <SRS0=DQCd=P2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F4DC43387
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5020850
	for <linux-integrity@archiver.kernel.org>; Fri, 18 Jan 2019 15:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfARPfD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:35:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbfARPfD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jan 2019 10:35:03 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IFUfH6011869
        for <linux-integrity@vger.kernel.org>; Fri, 18 Jan 2019 10:35:02 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q3fuwmm7a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 Jan 2019 10:35:01 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 18 Jan 2019 15:35:00 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 15:34:57 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0IFYuuc25297126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 15:34:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FE7112062;
        Fri, 18 Jan 2019 15:34:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56F09112064;
        Fri, 18 Jan 2019 15:34:56 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.136.27])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 15:34:56 +0000 (GMT)
To:     Dan.morav@nuvoton.com
Cc:     linux-integrity@vger.kernel.org, gcwilson@us.ibm.com
From:   Nayna <nayna@linux.vnet.ibm.com>
Subject: device tree "compatible" string value for Nuvoton TPM 75xxx
Date:   Fri, 18 Jan 2019 10:34:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19011815-2213-0000-0000-0000033FDBE6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010430; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01148298; UDB=6.00598227; IPR=6.00928601;
 MB=3.00025188; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-18 15:34:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011815-2214-0000-0000-00005D05A139
Message-Id: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=538 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Currently, the kernel supports "nuvoton,npct601" for Nuvoton TPM 2.

I was wondering what will be the compatible string value for Nuvoton TPM 
75xx models.

Thanks & Regards,

      - Nayna

