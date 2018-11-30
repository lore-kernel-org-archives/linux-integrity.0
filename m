Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD92C04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2474C20868
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2474C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLAGb6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:31:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbeLAGb6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 01:31:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUJIgao090883
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p3aax25je-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Nov 2018 19:21:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 19:21:35 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUJLYgB7471452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 19:21:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D59842045;
        Fri, 30 Nov 2018 19:21:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 070D642042;
        Fri, 30 Nov 2018 19:21:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.143])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 19:21:33 +0000 (GMT)
Subject: Re: [PATCH v2 4/7] ima-evm-utils: Allow using Streebog hash function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 30 Nov 2018 14:21:23 -0500
In-Reply-To: <20181128200610.21214-4-vt@altlinux.org>
References: <20181128200610.21214-1-vt@altlinux.org>
         <20181128200610.21214-4-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18113019-0016-0000-0000-0000022F451F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113019-0017-0000-0000-00003287B109
Message-Id: <1543605683.4216.71.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-11-28 at 23:06 +0300, Vitaly Chikunov wrote:
> This patch will allow using GOST algorithms from OpenSSL's
> gost-engine[1] via config extension (which is the usual way).
> 
> [1] https://github.com/gost-engine/engine
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changes since v1:
> - "--engine" option is removed into separate patch.

Thanks!

> 
>  src/evmctl.c    |  6 +++---
>  src/imaevm.h    | 13 +++++++++++++
>  src/libimaevm.c | 15 +++++++++++----
>  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9cbc2cb..f4b2e7d 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -388,7 +388,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> 
>  	md = EVP_get_digestbyname(params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname() failed\n");
> +		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
>  		return 1;
>  	}
> 
> @@ -1064,7 +1064,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
> 
>  	md = EVP_get_digestbyname(params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname() failed\n");
> +		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
>  		goto out;
>  	}
> 
> @@ -1653,7 +1653,7 @@ static void usage(void)
> 
>  	printf(
>  		"\n"
> -		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512\n"
> +		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
>  		"  -s, --imasig       make IMA signature\n"
>  		"  -d, --imahash      make IMA hash\n"
>  		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 2ebe7e7..c81bf21 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -152,6 +152,7 @@ struct signature_hdr {
>  	char mpi[0];
>  } __packed;
> 
> +/* reflect enum hash_algo from include/uapi/linux/hash_info.h */
>  enum pkey_hash_algo {
>  	PKEY_HASH_MD4,
>  	PKEY_HASH_MD5,
> @@ -161,6 +162,18 @@ enum pkey_hash_algo {
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
> index 34501ca..7b2b62c 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -51,6 +51,7 @@
>  #include <stdio.h>
>  #include <assert.h>
> 
> +#include <openssl/crypto.h>
>  #include <openssl/pem.h>
>  #include <openssl/evp.h>
>  #include <openssl/x509.h>
> @@ -67,6 +68,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> +	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };
> 
>  /*
> @@ -291,7 +294,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
> 
>  	md = EVP_get_digestbyname(params.hash_algo);
>  	if (!md) {
> -		log_err("EVP_get_digestbyname() failed\n");
> +		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
>  		return 1;
>  	}
> 
> @@ -509,14 +512,16 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
> 
>  	if (len < asn1->size || memcmp(out, asn1->data, asn1->size)) {
> -		log_err("%s: verification failed: %d\n", file, err);
> +		log_err("%s: verification failed: %d (asn1 mismatch)\n",
> +			file, err);
>  		return -1;
>  	}
> 
>  	len -= asn1->size;
> 
>  	if (len != size || memcmp(out + asn1->size, hash, len)) {
> -		log_err("%s: verification failed: %d\n", file, err);
> +		log_err("%s: verification failed: %d (digest mismatch)\n",
> +			file, err);
>  		return -1;
>  	}
> 
> @@ -528,7 +533,8 @@ int get_hash_algo(const char *algo)
>  	int i;
> 
>  	for (i = 0; i < PKEY_HASH__LAST; i++)
> -		if (!strcmp(algo, pkey_hash_algo[i]))
> +		if (pkey_hash_algo[i] &&
> +		    !strcmp(algo, pkey_hash_algo[i]))
>  			return i;
> 
>  	return PKEY_HASH_SHA1;
> @@ -901,5 +907,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
>  static void libinit()
>  {
>  	OpenSSL_add_all_algorithms();
> +	OPENSSL_add_all_algorithms_conf();
>  	ERR_load_crypto_strings();
>  }

