Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE064C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C519320835
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfBLQX7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:23:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726855AbfBLQX7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 11:23:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CGAPi3165657
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 11:23:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qm0xvja13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 11:23:57 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Feb 2019 16:23:54 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 16:23:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CGNpaT26935472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 16:23:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FE7A4053;
        Tue, 12 Feb 2019 16:23:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5DA7A4040;
        Tue, 12 Feb 2019 16:23:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Feb 2019 16:23:50 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: simplify digest alias handling
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 12 Feb 2019 11:23:40 -0500
In-Reply-To: <20190212001400.11107-1-vt@altlinux.org>
References: <20190212001400.11107-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021216-0028-0000-0000-00000347B93C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021216-0029-0000-0000-00002405D9E4
Message-Id: <1549988620.12743.272.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

Definitely a lot better.

> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index d9ffa13..ed77211 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -63,7 +63,7 @@
>  #include "imaevm.h"
>  #include "hash_info.h"
> 
> -const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> +const char *pkey_hash_algo[PKEY_HASH__LAST] = {

Dropping the "const"?

>  	[PKEY_HASH_MD4]		= "md4",
>  	[PKEY_HASH_MD5]		= "md5",
>  	[PKEY_HASH_SHA1]	= "sha1",
> @@ -72,8 +72,13 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> -	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
> -	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
> +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> +};
> +
> +const char *pkey_hash_algo_alias[PKEY_HASH__LAST] = {
> +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> +	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };
> 

If the upstream kernel name is defined as "streebog", the alias would
be "gost".

> @@ -615,15 +553,14 @@ int get_hash_algo(const char *algo)
>  	/* first iterate over builtin algorithms */
>  	for (i = 0; i < PKEY_HASH__LAST; i++)
>  		if (pkey_hash_algo[i] &&
> -		    !strmatch(algo, pkey_hash_algo[i]))
> +		    !strcmp(algo, pkey_hash_algo[i]))
>  			return i;
> 
>  	/* iterate over algorithms provided by kernel-headers */
> -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> -		if (hash_algo_name[i] &&
> -		    !algocmp(algo, hash_algo_name[i]))
> +	for (i = 0; i < PKEY_HASH__LAST; i++)
> +		if (pkey_hash_algo_alias[i] &&
> +		    !strcmp(algo, pkey_hash_algo_alias[i]))
>  			return i;
> -	}
> 

This doesn't look right.  The comments don't reflect the code.
Shouldn't there be 3 loops - pkey_hash_algo, pkey_hash_algo_alias, and
then the kernel header?

Mimi

