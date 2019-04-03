Return-Path: <SRS0=2lTb=SF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A04C4360F
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D2B20663
	for <linux-integrity@archiver.kernel.org>; Wed,  3 Apr 2019 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCUlM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:41:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfDCUlM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Apr 2019 16:41:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33KTNeq094742
        for <linux-integrity@vger.kernel.org>; Wed, 3 Apr 2019 16:41:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rn1rexegf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2019 16:41:10 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 21:41:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 21:41:06 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33Kf5ov55836846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 20:41:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F26142042;
        Wed,  3 Apr 2019 20:41:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 952314203F;
        Wed,  3 Apr 2019 20:41:04 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 20:41:04 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima-evm-utils: try to load digest by its alias
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 03 Apr 2019 16:41:04 -0400
In-Reply-To: <20190323014152.14701-3-vt@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
         <20190323014152.14701-3-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040320-0016-0000-0000-0000026AF68D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040320-0017-0000-0000-000032C704B1
Message-Id: <1554324064.3839.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-03-23 at 04:41 +0300, Vitaly Chikunov wrote:
> Primary names of the algorithms are different for OpenSSL and Kernel.
> Allow to use both of them.

Can we add a line here explaining the two names?  Perhaps something
like, "GOST R 34.11-2012 is the Russian national standard based on the
Streebog set of hash functions." 

> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

> ---
>  src/libimaevm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index bc7be1e..6783110 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -61,6 +61,7 @@
>  #include "imaevm.h"
>  #include "hash_info.h"
> 
> +/* Names that are primary for OpenSSL. */
>  const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_MD4]		= "md4",
>  	[PKEY_HASH_MD5]		= "md5",
> @@ -70,6 +71,12 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> +};
> +
> +/* Names that are primary for the kernel. */
> +const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_STREEBOG_256] = "streebog256",
>  	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };
> @@ -551,6 +558,11 @@ int get_hash_algo(const char *algo)
>  		    !strcmp(algo, pkey_hash_algo[i]))
>  			return i;
> 
> +	for (i = 0; i < PKEY_HASH__LAST; i++)
> +		if (pkey_hash_algo_kern[i] &&
> +		    !strcmp(algo, pkey_hash_algo_kern[i]))
> +			return i;
> +
>  	/* iterate over algorithms provided by kernel-headers */
>  	for (i = 0; i < HASH_ALGO__LAST; i++)
>  		if (hash_algo_name[i] &&

