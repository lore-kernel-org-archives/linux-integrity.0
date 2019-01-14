Return-Path: <SRS0=QOPP=PW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EBC43387
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C120659
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfANUcZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:32:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbfANUcZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 15:32:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EKSpPV129904
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 15:32:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q10px1yvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 15:32:23 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 14 Jan 2019 20:32:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 20:32:18 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EKWIEw5832986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 20:32:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECA7CA405B;
        Mon, 14 Jan 2019 20:32:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 121A6A405C;
        Mon, 14 Jan 2019 20:32:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 20:32:16 +0000 (GMT)
Subject: Re: [PATCH 3/6] ima/ima_boot_aggregate: Fix extending PCRs beyond
 PCR 0-7
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, zohar@linux.vnet.ibm.com,
        pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Mon, 14 Jan 2019 15:32:06 -0500
In-Reply-To: <1546827989-43569-4-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1546827989-43569-4-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011420-0016-0000-0000-000002456DF3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011420-0017-0000-0000-0000329F8187
Message-Id: <1547497926.4156.198.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> The boot aggragate calculation should never touch PCRs beyond PCR 0-7,
> even a PCR extension really manipulates out-of-domain PCRs.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Thanks!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> ---
>  .../security/integrity/ima/src/ima_boot_aggregate.c       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index 67be6a7..98893b9 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -93,11 +93,16 @@ int main(int argc, char *argv[])
>  			printf("%03u ", event.header.pcr);
>  			display_sha1_digest(event.header.digest);
>  		}
> -		SHA1_Init(&c);
> -		SHA1_Update(&c, pcr[event.header.pcr].digest,
> -			    SHA_DIGEST_LENGTH);
> -		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
> -		SHA1_Final(pcr[event.header.pcr].digest, &c);
> +
> +		if (event.header.pcr < NUM_PCRS) {
> +			SHA1_Init(&c);
> +			SHA1_Update(&c, pcr[event.header.pcr].digest,
> +				    SHA_DIGEST_LENGTH);
> +			SHA1_Update(&c, event.header.digest,
> +				    SHA_DIGEST_LENGTH);
> +			SHA1_Final(pcr[event.header.pcr].digest, &c);
> +		}
> +
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
>  		if (event.header.len > MAX_EVENT_DATA_SIZE) {
>  			printf("Error event too long\n");

