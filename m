Return-Path: <SRS0=MPPW=S3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A4C43218
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47AF20685
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Apr 2019 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDYTfr (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:35:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfDYTfq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Apr 2019 15:35:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PJXsMJ115121
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 15:35:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3hbxmr15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Apr 2019 15:35:44 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 25 Apr 2019 20:35:44 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 20:35:42 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PJZf1B17629230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 19:35:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BE65AE05C;
        Thu, 25 Apr 2019 19:35:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED119AE05F;
        Thu, 25 Apr 2019 19:35:40 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.220.75])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 19:35:40 +0000 (GMT)
Subject: Re: Can we enforce "IMA Policy" based on file type
To:     Kavitha Sivagnanam <kavi@juniper.net>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
 <1556193529.3894.94.camel@linux.ibm.com>
 <BYAPR05MB3975DDC3D6C74DD292BA7216C13D0@BYAPR05MB3975.namprd05.prod.outlook.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Thu, 25 Apr 2019 15:35:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB3975DDC3D6C74DD292BA7216C13D0@BYAPR05MB3975.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19042519-0052-0000-0000-000003B215FD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010994; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01194306; UDB=6.00626153; IPR=6.00975135;
 MB=3.00026597; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-25 19:35:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042519-0053-0000-0000-000060A3F03C
Message-Id: <65efdd39-832d-2877-599d-110c98f1212d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=842 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 04/25/2019 01:07 PM, Kavitha Sivagnanam wrote:
> Mimi
>
>>> Another option would be to extend IMA by implementing the LSM
>>> security_sb_mount hook
> Yes, that’s exactly the feedback I was looking for.
> I know that there is no existing support as of today.  But wanted to know how we can add support this.

Adding this support shouldn't be too difficult. You can start from IMA 
policy code in security/integrity/ima_policy.c.

And just a reminder, please keep your responses as inline/bottom post.

Thanks & Regards,
      - Nayna

>
> -Kavitha
>
> Juniper Internal
>
>

