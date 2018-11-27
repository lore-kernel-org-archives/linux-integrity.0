Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B055C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF6208E7
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeK0Wyt (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:54:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730057AbeK0Wyt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Nov 2018 17:54:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARBhtUO130975
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 06:57:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p14a33emv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 06:57:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 27 Nov 2018 11:57:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 11:57:04 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARBv3fK5439900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 11:57:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA55AE04D;
        Tue, 27 Nov 2018 11:57:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6442AAE045;
        Tue, 27 Nov 2018 11:57:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 11:57:02 +0000 (GMT)
Subject: Re: [PATCH 3/3] ima-evm-utils: Allow to use Streebog hash function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 27 Nov 2018 06:56:51 -0500
In-Reply-To: <20181126043953.1126-3-vt@altlinux.org>
References: <20181126043953.1126-1-vt@altlinux.org>
         <20181126043953.1126-3-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112711-0008-0000-0000-000002993231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112711-0009-0000-0000-000022037632
Message-Id: <1543319811.3902.134.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2018-11-26 at 07:39 +0300, Vitaly Chikunov wrote:
> There are two methods of using GOST algorithms in OpenSSL: via config
> extension and via --engine option. Both require gost-engine to be
> installed.

Splitting this patch based on the "--engine" option, will make it
easier to review.

> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c    | 27 ++++++++++++++++++++++++---
>  src/imaevm.h    | 13 +++++++++++++
>  src/libimaevm.c | 15 +++++++++++----
>  3 files changed, 48 insertions(+), 7 deletions(-)

<snip>

> diff --git a/src/imaevm.h b/src/imaevm.h
> index 1bafaad..1a5ebbe 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -149,6 +149,7 @@ struct signature_hdr {
>  	char mpi[0];
>  } __packed;
> 
> +/* reflect enum hash_algo from include/uapi/linux/hash_info.h */
>  enum pkey_hash_algo {
>  	PKEY_HASH_MD4,
>  	PKEY_HASH_MD5,
> @@ -158,6 +159,18 @@ enum pkey_hash_algo {
>  	PKEY_HASH_SHA384,
>  	PKEY_HASH_SHA512,
>  	PKEY_HASH_SHA224,
> +	PKEY_HASH_RIPE_MD_128,
> +	PKEY_HASH_RIPE_MD_256,
> +	PKEY_HASH_RIPE_MD_320,
> +	PKEY_HASH_WP_256,
> +	PKEY_HASH_WP_384,
> +	PKEY_HASH_WP_512,
> +	PKEY_HASH_TGR_128,
> +	PKEY_HASH_TGR_160,
> +	PKEY_HASH_TGR_192,
> +	PKEY_HASH_SM3_256,
> +	PKEY_HASH_STREEBOG_256,
> +	PKEY_HASH_STREEBOG_512,
>  	PKEY_HASH__LAST
>  };
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 714f1ac..8f74660 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -50,6 +50,7 @@
>  #include <string.h>
>  #include <stdio.h>
> 
> +#include <openssl/crypto.h>
>  #include <openssl/pem.h>
>  #include <openssl/evp.h>
>  #include <openssl/x509.h>
> @@ -66,6 +67,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> +	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };

hash_info.h is now included in kernel-headers package.

Anyone using the hash_algo enumeration defined in hash_info.h, will
probably also want to use an associated algorithm name.  It would make
more sense to keep the hash_algo enumeration, hash_algo_name[], and
perhaps the hash_digest_size[] together.  Maybe using macros to keep
them in sync (eg. kernel_read_file_id/kernel_read_file_str).

As new algorithms are added to hash_info.h, nothing would need to be
done here in ima-evm-utils, other than updating the maximum digest
size.

What do you think?

Mimi

