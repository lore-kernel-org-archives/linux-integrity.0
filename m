Return-Path: <SRS0=GfCd=NF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8CC46475
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1468820848
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 16:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1468820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeJZB0v (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:26:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbeJZB0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Oct 2018 21:26:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PGjtf6129305
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 12:53:14 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nbhmq09ek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 12:53:14 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Thu, 25 Oct 2018 10:53:13 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 10:53:11 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PGrAUt17367094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 16:53:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E591BE053
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 16:53:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8840BE04F
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 16:53:09 +0000 (GMT)
Received: from [9.2.202.77] (unknown [9.2.202.77])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 16:53:09 +0000 (GMT)
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
Cc:     linux-integrity@vger.kernel.org
References: <1540193596.3202.7.camel@HansenPartnership.com>
 <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
 <alpine.DEB.2.21.1810240303560.8524@jsakkine-mobl1>
 <1540366456.3008.8.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Thu, 25 Oct 2018 12:53:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540366456.3008.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102516-0004-0000-0000-000014A46190
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009934; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01107851; UDB=6.00573822; IPR=6.00887934;
 MB=3.00023907; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-25 16:53:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102516-0005-0000-0000-00008947FFE5
Message-Id: <01b5419f-3539-6edb-d4fb-874422f81919@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=583 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250140
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/24/2018 3:34 AM, James Bottomley wrote:
> so we'd have to derive the RSA EK primary (which can take up to
> 60 seconds)

Just FYI:

The TPM vendors seem to be caching the two standard EKs during
manufacturing.  When the TPM detects the EK template during
createprimary, it quickly returns the cached value.

This optimization is not required, but it is common.


