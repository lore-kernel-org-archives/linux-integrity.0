Return-Path: <SRS0=s/8x=P7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D5C282C0
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 20:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8321855
	for <linux-integrity@archiver.kernel.org>; Wed, 23 Jan 2019 20:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAWUWh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:22:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfAWUWh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jan 2019 15:22:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NKDT9E038994
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jan 2019 15:22:36 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6vvpp0n1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jan 2019 15:22:35 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 23 Jan 2019 20:22:34 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 20:22:30 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NKMT3m22937828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 20:22:29 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A40892805C;
        Wed, 23 Jan 2019 20:22:29 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D3452805A;
        Wed, 23 Jan 2019 20:22:29 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.211.212])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jan 2019 20:22:29 +0000 (GMT)
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx
To:     oshri.alkoby@nuvoton.com, Dan.Morav@nuvoton.com, jgg@ziepe.ca
Cc:     dana.cohen@nuvoton.com, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
 <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
 <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Wed, 23 Jan 2019 15:22:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19012320-2213-0000-0000-000003439FAE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010464; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150758; UDB=6.00599722; IPR=6.00931095;
 MB=3.00025262; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-23 20:22:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012320-2214-0000-0000-00005D16B5C0
Message-Id: <16c939bd-0b32-71cf-094e-ae3cc0546ad6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=566 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 01/21/2019 11:55 AM, oshri.alkoby@nuvoton.com wrote:
> Hi Jason,
>
> Since the driver implements the I2C interface defined by the TCG PTP, wouldn't it be better to set the string to be something like 'tcg,tpm-i2c-ptp' (as 'tcg,tpm-tis-mmio' for tpm-tis)?
> Any TPM that implements this protocol can use this driver.

It might be nice to have a generic name if it is also compliant with the 
device tree specification.
However, I was wondering if it will not require driver code changes as 
well before this generic name can be used by any TPM implementing i2c 
protocol ?

Thanks & Regards,
        - Nayna




