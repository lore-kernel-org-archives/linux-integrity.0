Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA047C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8886C21B18
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfBKR7a (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfBKR7a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BHnD99134591
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 12:59:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qkc6f5kvf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 12:59:28 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Feb 2019 17:59:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 17:59:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BHxO0Q46071888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 17:59:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EBD542047;
        Mon, 11 Feb 2019 17:59:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ED6742042;
        Mon, 11 Feb 2019 17:59:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.85])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 17:59:23 +0000 (GMT)
Subject: Re: [PATCH v3 7/7] ima-evm-utils: Try to load digest by its alias
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 11 Feb 2019 12:59:12 -0500
In-Reply-To: <20190211175248.22ighzenzvm5tddb@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
         <20181203033525.20431-7-vt@altlinux.org>
         <1549906738.12743.167.camel@linux.ibm.com>
         <20190211175248.22ighzenzvm5tddb@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021117-0020-0000-0000-000003158163
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021117-0021-0000-0000-000021669BBC
Message-Id: <1549907952.12743.173.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-11 at 20:52 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Feb 11, 2019 at 12:38:58PM -0500, Mimi Zohar wrote:
> > On Mon, 2018-12-03 at 06:35 +0300, Vitaly Chikunov wrote:
> > > For compatibility with older OpenSSL try to load digest by its alias if
> > > load by its proper name is failed.
> > > 
> > > This is configured in pkey_hash_algo by mentioning loadable alias first in the
> > > comma separated list of algo names.
> > 
> > After this patch, I can not verify the signature.  It's failing to
> > find the hash algorithm.
> 
> Yes, it's fixed in "ima-evm-utils: convert sign v2 from RSA to EVP_PKEY
> API". I didn't consider it a problem since streebog256 should not work
> for sign/verify anyway (since RSA should not support it). That EVP_PKEY
> patch which adds ability to sign/verify for Streebog also fixes above
> problem.

I've been having second thoughts about this patch in general, as it
made the hash algorithm comparison unnecessarily more complex for the
simple case.  As there hasn't been a new ima-evm-utils release with
patch, perhaps we should simple remove/revert it?

Mimi

> 
> > evmctl ima_sign -k <private key> -p -a streebog256 ./foo.txt  --xattr-user
> > evmctl ima_verify -k <public key>  ./foo.txt  --xattr-user
> > 
> > Mimi
> > 
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > > Changes since v1:
> > > - New patch.
> > > Changes since v2:
> > > - No changes.
> > > 
> > >  src/imaevm.h    |  1 +
> > >  src/libimaevm.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
> > >  2 files changed, 52 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/src/imaevm.h b/src/imaevm.h
> > > index c81bf21..795966a 100644
> > > --- a/src/imaevm.h
> > > +++ b/src/imaevm.h
> > > @@ -75,6 +75,7 @@
> > >  #define	DATA_SIZE	4096
> > >  #define SHA1_HASH_LEN   20
> > > 
> > > +#define MAX_DIGEST_NAME		32
> > >  #define MAX_DIGEST_SIZE		64
> > >  #define MAX_SIGNATURE_SIZE	1024
> > > 
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index cb4721b..7501303 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -41,6 +41,7 @@
> > >  /* should we use logger instead for library? */
> > >  #define USE_FPRINTF
> > > 
> > > +#define _GNU_SOURCE
> > >  #include <sys/types.h>
> > >  #include <sys/param.h>
> > >  #include <sys/stat.h>
> > > @@ -56,6 +57,7 @@
> > >  #include <openssl/pem.h>
> > >  #include <openssl/evp.h>
> > >  #include <openssl/x509.h>
> > > +#include <openssl/engine.h>
> > >  #include <openssl/err.h>
> > > 
> > >  #include "imaevm.h"
> > > @@ -70,8 +72,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> > >  	[PKEY_HASH_SHA384]	= "sha384",
> > >  	[PKEY_HASH_SHA512]	= "sha512",
> > >  	[PKEY_HASH_SHA224]	= "sha224",
> > > -	[PKEY_HASH_STREEBOG_256] = "streebog256",
> > > -	[PKEY_HASH_STREEBOG_512] = "streebog512",
> > > +	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
> > > +	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
> > >  };
> > > 
> > >  /*
> > > @@ -284,6 +286,35 @@ static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
> > >  	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
> > >  }
> > > 
> > > +/* Call EVP_get_digestbyname with provided name and with alias,
> > > + * which is first name in the comma separated list of names
> > > + * in pkey_hash_algo.
> > > + */
> > > +static const EVP_MD *get_digestbyname(const char *name)
> > > +{
> > > +	const EVP_MD *md;
> > > +
> > > +	md = EVP_get_digestbyname(params.hash_algo);
> > > +	if (!md) {
> > > +		char alias[MAX_DIGEST_NAME];
> > > +		int len;
> > > +		int algo_id;
> > > +		const char *algo_alias;
> > > +
> > > +		/* try to get algo by its alias */
> > > +		algo_id = get_hash_algo(params.hash_algo);
> > > +		algo_alias = get_hash_algo_by_id(algo_id);
> > > +		len = strchrnul(algo_alias, ',') - algo_alias;
> > > +		if (len < sizeof(alias)) {
> > > +			memcpy(alias, algo_alias, len);
> > > +			alias[len] = '\0';
> > > +			if (strcmp(params.hash_algo, alias))
> > > +				md = EVP_get_digestbyname(alias);
> > > +		}
> > > +	}
> > > +	return md;
> > > +}
> > > +
> > >  int ima_calc_hash(const char *file, uint8_t *hash)
> > >  {
> > >  	const EVP_MD *md;
> > > @@ -305,7 +336,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
> > >  		return err;
> > >  	}
> > > 
> > > -	md = EVP_get_digestbyname(params.hash_algo);
> > > +	md = get_digestbyname(params.hash_algo);
> > >  	if (!md) {
> > >  		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> > >  		return 1;
> > > @@ -561,6 +592,22 @@ static int algocmp(const char *a, const char *b)
> > >  	return *a || *b;
> > >  }
> > > 
> > > +static int strmatch(const char *needle, const char *haystack)
> > > +{
> > > +	int len = strlen(needle);
> > > +	const char *p = haystack;
> > > +	const char *t;
> > > +
> > > +	for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
> > > +		if (t - p == len &&
> > > +		    !strncmp(needle, p, len))
> > > +			return 0;
> > > +		if (!*t++)
> > > +			break;
> > > +	}
> > > +	return 1;
> > > +}
> > > +
> > >  int get_hash_algo(const char *algo)
> > >  {
> > >  	int i;
> > > @@ -568,7 +615,7 @@ int get_hash_algo(const char *algo)
> > >  	/* first iterate over builtin algorithms */
> > >  	for (i = 0; i < PKEY_HASH__LAST; i++)
> > >  		if (pkey_hash_algo[i] &&
> > > -		    !strcmp(algo, pkey_hash_algo[i]))
> > > +		    !strmatch(algo, pkey_hash_algo[i]))
> > >  			return i;
> > > 
> > >  	/* iterate over algorithms provided by kernel-headers */
> 

