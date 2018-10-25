Return-Path: <SRS0=GfCd=NF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F8ECDE46
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43FC20824
	for <linux-integrity@archiver.kernel.org>; Thu, 25 Oct 2018 19:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43FC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeJZEIo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:08:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbeJZEIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Oct 2018 00:08:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PJK3m8096170
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 15:34:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nbkj99k57-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Oct 2018 15:34:37 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Thu, 25 Oct 2018 13:34:37 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 13:34:34 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PJYXgn26673330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 19:34:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D20FBE04F;
        Thu, 25 Oct 2018 19:34:33 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3074DBE054;
        Thu, 25 Oct 2018 19:34:31 +0000 (GMT)
Received: from [9.2.202.77] (unknown [9.2.202.77])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Oct 2018 19:34:30 +0000 (GMT)
Subject: Re: Proposed change to tpm driver tpm_pcr_extend
To:     Monty Wiseman <montywiseman32@gmail.com>,
        linux-integrity@vger.kernel.org,
        "David (GE Global Research, US)" <david.safford@ge.com>
References: <CAMHw8A4VfDf9s9RsYKhc0-fp7=twepsG0t-cwZe-rYWHubF1SA@mail.gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Thu, 25 Oct 2018 15:34:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMHw8A4VfDf9s9RsYKhc0-fp7=twepsG0t-cwZe-rYWHubF1SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102519-0004-0000-0000-000014A477E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009934; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01107905; UDB=6.00573853; IPR=6.00887988;
 MB=3.00023909; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-25 19:34:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102519-0005-0000-0000-0000894858C0
Message-Id: <442debb9-e9bf-ad41-22cf-3de1b5f9db8a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/24/2018 5:35 AM, Monty Wiseman wrote:
> Option C:
> This is a viable option and may actully be what the caller wants. There actually
> is no rule the all banks must be extended. In fact when "sealing", the
> caller lists

Doesn't not extending a bank open the platform to attack?  Even
if one caller is sealing to one bank, other applications may use a 
different bank.  If that bank was no extended, the caller could extend 
counterfeit measurements and subvert an application.

IMHO, for PCRs that are doing software measurements, the rule should be 
that all allocated banks should be extended.

> the pcr banks they want to seal to. (While is it technically possible
> to provide the
> TPM2_PolicyPCR a mix of banks I don't believe this practical as only
> one expected hash
> is provided as input. We should consider this option.

I'm nearly sure that one can run TPM2_PolicyPCR with multiple banks.

1 - The input parameter pcrDigest is optional.  It permits the caller
to check for correct PCRs early in the policy process.  For example,
it could avoid an unnecessary digital signature or password prompt.

That's why policies should be constructed with policypcr before terms 
that require external input.

2 - The spec Part 1 describes the pcrDigest calculation, and I
don't see anything that mandates only one bank.

