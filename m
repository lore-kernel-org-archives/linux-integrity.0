Return-Path: <SRS0=Jbst=P4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15CC26640
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92112084C
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 18:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfATShn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:37:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbfATShn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Jan 2019 13:37:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0KIT0CU124960
        for <linux-integrity@vger.kernel.org>; Sun, 20 Jan 2019 13:37:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q4j2yb22c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 20 Jan 2019 13:37:41 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Jan 2019 18:37:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Jan 2019 18:37:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0KIba2T5046636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 18:37:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 802C211C04A;
        Sun, 20 Jan 2019 18:37:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE16611C052;
        Sun, 20 Jan 2019 18:37:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Jan 2019 18:37:35 +0000 (GMT)
Subject: Re: [PATCH v3 1/6] ima/ima_boot_aggregate: Fix the definition of
 event log
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Sun, 20 Jan 2019 13:37:25 -0500
In-Reply-To: <1547607461-11233-2-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1547607461-11233-2-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012018-0016-0000-0000-00000247FB87
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012018-0017-0000-0000-000032A2293E
Message-Id: <1548009445.3982.213.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901200151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-01-16 at 10:57 +0800, Jia Zhang wrote:
> According to [1], the structure of event log should be packed,
> and certain fields should be 32-bit unsigned integer. Fortunately,
> keeping natural alignment seems to make everything working as
> expected all the time.
> 
> [1] page 17,18 @https://trustedcomputinggroup.org/wp-content/uploads/TCG_EFI_Protocol_1_22_Final-v05.pdf
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index f6e7be0..d85d222 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -53,10 +53,10 @@ int main(int argc, char *argv[])
>  	struct {
>  		struct {
>  			u_int32_t pcr;
> -			int type;
> -			unsigned char digest[SHA_DIGEST_LENGTH];
> -			u_int16_t len;
> -		} header;
> +			u_int32_t type;
> +			u_int8_t digest[SHA_DIGEST_LENGTH];
> +			u_int32_t len;
> +		} header __attribute__ ((packed));
>  		char *data;
>  	} event;
>  	struct {

