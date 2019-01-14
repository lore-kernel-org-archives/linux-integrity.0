Return-Path: <SRS0=QOPP=PW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD69C43387
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 20:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430AF20659
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfANUdp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:33:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfANUdo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 15:33:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EKT9dA176248
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 15:33:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q10rrsuyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 15:33:43 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 14 Jan 2019 20:33:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 20:33:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EKXcmk6554106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 20:33:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27617A4040;
        Mon, 14 Jan 2019 20:33:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54735A4057;
        Mon, 14 Jan 2019 20:33:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 20:33:37 +0000 (GMT)
Subject: Re: [PATCH 2/6] ima/ima_boot_aggregate: Don't hard code the length
 of sha1 hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Mon, 14 Jan 2019 15:33:26 -0500
In-Reply-To: <1546827989-43569-3-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1546827989-43569-3-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011420-0028-0000-0000-0000033926F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011420-0029-0000-0000-000023F6474D
Message-Id: <1547498006.4156.199.camel@linux.ibm.com>
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
> Instead, use SHA_DIGEST_LENGTH.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index d85d222..67be6a7 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -42,7 +42,7 @@ static void display_sha1_digest(unsigned char *pcr)
>  {
>  	int i;
> 
> -	for (i = 0; i < 20; i++)
> +	for (i = 0; i < SHA_DIGEST_LENGTH; i++)
>  		printf("%02x", *(pcr + i) & 0xff);
>  	printf("\n");
>  }
> @@ -94,8 +94,9 @@ int main(int argc, char *argv[])
>  			display_sha1_digest(event.header.digest);
>  		}
>  		SHA1_Init(&c);
> -		SHA1_Update(&c, pcr[event.header.pcr].digest, 20);
> -		SHA1_Update(&c, event.header.digest, 20);
> +		SHA1_Update(&c, pcr[event.header.pcr].digest,
> +			    SHA_DIGEST_LENGTH);
> +		SHA1_Update(&c, event.header.digest, SHA_DIGEST_LENGTH);
>  		SHA1_Final(pcr[event.header.pcr].digest, &c);
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
>  		if (event.header.len > MAX_EVENT_DATA_SIZE) {
> @@ -116,7 +117,7 @@ int main(int argc, char *argv[])
>  			printf("PCR-%2.2x: ", i);
>  			display_sha1_digest(pcr[i].digest);
>  		}
> -		SHA1_Update(&c, pcr[i].digest, 20);
> +		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
>  	}
>  	SHA1_Final(boot_aggregate, &c);
> 

