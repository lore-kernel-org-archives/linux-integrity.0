Return-Path: <SRS0=1iot=RN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C0C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ABC207E0
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCJW0o (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:26:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726989AbfCJW0o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Mar 2019 18:26:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2AMOFSr057998
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 18:26:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r55xyac00-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 18:26:42 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 10 Mar 2019 22:26:40 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Mar 2019 22:26:38 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2AMQbnY37028016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Mar 2019 22:26:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CA14A404D;
        Sun, 10 Mar 2019 22:26:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FFD5A4051;
        Sun, 10 Mar 2019 22:26:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.170])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 Mar 2019 22:26:36 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: simplify digest alias handling
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 10 Mar 2019 18:26:25 -0400
In-Reply-To: <20190212224631.13398-1-vt@altlinux.org>
References: <20190212224631.13398-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031022-0008-0000-0000-000002CB0A2A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031022-0009-0000-0000-0000223721FB
Message-Id: <1552256785.6100.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903100173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Wed, 2019-02-13 at 01:46 +0300, Vitaly Chikunov wrote:
> - Make digest name search work just with simple strcmp() and three
>   arrays, dropping strmatch().
> - Remove get_digestbyname() which was doing two hash name resolving
>   attempts, reverting to use plain EVP_get_digestbyname(). This will
>   force the user to specify the proper hash name depending on what
>   OpenSSL provides, allowing to specify older hash name in older
>   OpenSSL.
> - Improve hash_info parser to produce hash_algo_name[] more resembling
>   what is in the kernel, making algocmp() not needed and removed.
> - Fix indent in get_hash_algo_by_id().

Thanks, this is a lot better.  As there isn't a "Signed-off-by", did
you want to squash this with the original patch - "Extract digest
algorithms from hash_info.h"?

Mimi

> ---
>  src/hash_info.gen |  8 ++++-
>  src/libimaevm.c   | 94 ++++++++++++-------------------------------------------
>  2 files changed, 27 insertions(+), 75 deletions(-)
> 
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> index 60fc750..54532ca 100755
> --- a/src/hash_info.gen
> +++ b/src/hash_info.gen
> @@ -39,5 +39,11 @@ printf "\tHASH_ALGO__LAST\n"
>  echo "};"
> 
>  echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
> -sed -n 's/HASH_ALGO_\(.*\),/[HASH_ALGO_\1] = "\L\1\E",/p' $HASH_INFO
> +sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
> +  while read a b; do
> +    # Normalize text hash name: if it contains underscore between
> +    # digits replace it with a dash, other underscores are removed.
> +    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
> +    printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
> +  done
>  echo "};"
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index d9ffa13..102d6fc 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -63,6 +63,7 @@
>  #include "imaevm.h"
>  #include "hash_info.h"
> 
> +/* Named that are primary for OpenSSL. */
>  const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_MD4]		= "md4",
>  	[PKEY_HASH_MD5]		= "md5",
> @@ -72,8 +73,14 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> -	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
> -	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
> +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
> +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> +};
> +
> +/* Names that are primary for the kernel. */
> +const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
> +	[PKEY_HASH_STREEBOG_256] = "streebog256",
> +	[PKEY_HASH_STREEBOG_512] = "streebog512",
>  };
> 
>  /*
> @@ -160,9 +167,9 @@ void dump(const void *ptr, int len)
>  const char *get_hash_algo_by_id(int algo)
>  {
>  	if (algo < PKEY_HASH__LAST)
> -	    return pkey_hash_algo[algo];
> +		return pkey_hash_algo[algo];
>  	if (algo < HASH_ALGO__LAST)
> -	    return hash_algo_name[algo];
> +		return hash_algo_name[algo];
> 
>  	log_err("digest %d not found\n", algo);
>  	return "unknown";
> @@ -286,35 +293,6 @@ static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
>  	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
>  }
> 
> -/* Call EVP_get_digestbyname with provided name and with alias,
> - * which is first name in the comma separated list of names
> - * in pkey_hash_algo.
> - */
> -static const EVP_MD *get_digestbyname(const char *name)
> -{
> -	const EVP_MD *md;
> -
> -	md = EVP_get_digestbyname(params.hash_algo);
> -	if (!md) {
> -		char alias[MAX_DIGEST_NAME];
> -		int len;
> -		int algo_id;
> -		const char *algo_alias;
> -
> -		/* try to get algo by its alias */
> -		algo_id = get_hash_algo(params.hash_algo);
> -		algo_alias = get_hash_algo_by_id(algo_id);
> -		len = strchrnul(algo_alias, ',') - algo_alias;
> -		if (len < sizeof(alias)) {
> -			memcpy(alias, algo_alias, len);
> -			alias[len] = '\0';
> -			if (strcmp(params.hash_algo, alias))
> -				md = EVP_get_digestbyname(alias);
> -		}
> -	}
> -	return md;
> -}
> -
>  int ima_calc_hash(const char *file, uint8_t *hash)
>  {
>  	const EVP_MD *md;
> @@ -336,7 +314,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>  		return err;
>  	}
> 
> -	md = get_digestbyname(params.hash_algo);
> +	md = EVP_get_digestbyname(params.hash_algo);
>  	if (!md) {
>  		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
>  		return 1;
> @@ -572,42 +550,6 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  	return 0;
>  }
> 
> -/* compare algo names case insensitively and ignoring separators */
> -static int algocmp(const char *a, const char *b)
> -{
> -	while (*a && *b) {
> -		int cha, chb;
> -
> -		cha = tolower((unsigned char)*a++);
> -		if (!isalnum(cha))
> -			continue;
> -		chb = tolower((unsigned char)*b++);
> -		if (!isalnum(chb)) {
> -			a--;
> -			continue;
> -		}
> -		if (cha != chb)
> -			return -1;
> -	}
> -	return *a || *b;
> -}
> -
> -static int strmatch(const char *needle, const char *haystack)
> -{
> -	int len = strlen(needle);
> -	const char *p = haystack;
> -	const char *t;
> -
> -	for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
> -		if (t - p == len &&
> -		    !strncmp(needle, p, len))
> -			return 0;
> -		if (!*t++)
> -			break;
> -	}
> -	return 1;
> -}
> -
>  int get_hash_algo(const char *algo)
>  {
>  	int i;
> @@ -615,15 +557,19 @@ int get_hash_algo(const char *algo)
>  	/* first iterate over builtin algorithms */
>  	for (i = 0; i < PKEY_HASH__LAST; i++)
>  		if (pkey_hash_algo[i] &&
> -		    !strmatch(algo, pkey_hash_algo[i]))
> +		    !strcmp(algo, pkey_hash_algo[i]))
> +			return i;
> +
> +	for (i = 0; i < PKEY_HASH__LAST; i++)
> +		if (pkey_hash_algo_kern[i] &&
> +		    !strcmp(algo, pkey_hash_algo_kern[i]))
>  			return i;
> 
>  	/* iterate over algorithms provided by kernel-headers */
> -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> +	for (i = 0; i < HASH_ALGO__LAST; i++)
>  		if (hash_algo_name[i] &&
> -		    !algocmp(algo, hash_algo_name[i]))
> +		    !strcmp(algo, hash_algo_name[i]))
>  			return i;
> -	}
> 
>  	log_info("digest %s not found, fall back to sha1\n", algo);
>  	return PKEY_HASH_SHA1;

