Return-Path: <SRS0=Mnqf=NX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA05C43441
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957B422419
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957B422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeKMEHI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:07:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbeKMEHI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Nov 2018 23:07:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACI4HQk112282
        for <linux-integrity@vger.kernel.org>; Mon, 12 Nov 2018 13:12:46 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqc45yq4c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Nov 2018 13:12:46 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 12 Nov 2018 18:12:46 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 18:12:43 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACICf7P19923054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 18:12:41 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 798E86A047;
        Mon, 12 Nov 2018 18:12:41 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05576A04F;
        Mon, 12 Nov 2018 18:12:38 +0000 (GMT)
Received: from [9.124.213.182] (unknown [9.124.213.182])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 18:12:38 +0000 (GMT)
Subject: Re: [PATCH] Apply on top of: tpm: dynamically allocate active_banks
 array
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Kenneth Goldman <kgoldman@us.ibm.com>
References: <20181109092925.2908-1-roberto.sassu@huawei.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 12 Nov 2018 23:39:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181109092925.2908-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18111218-0036-0000-0000-00000A5A32B5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010036; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116460; UDB=6.00579002; IPR=6.00896569;
 MB=3.00024130; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 18:12:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111218-0037-0000-0000-0000499D3014
Message-Id: <1d2e39fe-4bfb-4644-d216-f962c168668e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/09/2018 02:59 PM, Roberto Sassu wrote:
> This patch checks if a PCR bank is active (at least one bit in the
> pcr_select mask is set).
> ---
>   drivers/char/tpm/tpm2-cmd.c | 44 +++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 533089cede07..eba8f8d00a09 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -854,15 +854,20 @@ struct tpm2_pcr_selection {
>   
>   static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   {
> -	struct tpm2_pcr_selection pcr_selection;
> +	struct tpm2_pcr_selection *pcr_selection;
>   	struct tpm_buf buf;
>   	void *marker;
>   	void *end;
>   	void *pcr_select_offset;
>   	u32 sizeof_pcr_selection;
> +	u32 nr_possible_banks;
> +	u32 nr_active_banks = 0;

The TCG Spec uses the term "allocated" and not "active".  For 
consistency, I think we can also use the term "allocated". For example - 
nr_allocated_banks and *allocated_banks both here and in struct tpm_chip.

Sorry, it took me sometime to be clear on this else would have mentioned 
previously.

Thanks & Regards,
     - Nayna



