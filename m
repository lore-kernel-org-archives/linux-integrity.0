Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE9C04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6B920868
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLAGdE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:33:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeLAGdE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 01:33:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUJKtw4144434
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:22:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p37v3gvf2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:22:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Nov 2018 19:22:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 19:22:40 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUJMdUg2949468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 19:22:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C13A42041;
        Fri, 30 Nov 2018 19:22:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3A4242045;
        Fri, 30 Nov 2018 19:22:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.143])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 19:22:38 +0000 (GMT)
Subject: Re: [PATCH v2.1 6/7] ima-evm-utils: Extract digest algorithms from
 hash_info.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 30 Nov 2018 14:22:28 -0500
In-Reply-To: <20181129122759.16813-1-vt@altlinux.org>
References: <20181129122759.16813-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18113019-0028-0000-0000-0000032411FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113019-0029-0000-0000-000023E028E3
Message-Id: <1543605748.4216.74.camel@linux.ibm.com>
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

On Thu, 2018-11-29 at 15:27 +0300, Vitaly Chikunov wrote:
> If configured with "--with-kernel-headers=PATH" try to extract hash
> algorithms from "hash_info.h" from the kernel source tree or
> kernel-headers package located in the specified path. (Otherwise, it
> will be tried to get from the installed kernel.)
> 
> This also introduces two algorithm lists, one is built-in and another is
> from the kernel source. (They should never contain conflicting algorithm
> IDs by their append-only nature.) If the digest is not found in the
> built-in list it will be searched in the list from kernel's
> "hash_info.h".
> 
> This patch will allow evmctl to be just recompiled to work with digest
> algorithms introduced in the newer kernels.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changes since v1:
> - New patch.
> Changes since v2:
> - Mark PATH portion of "--with-kernel-headers=PATH" non-optional and
>   change description to reflect correct behavior.

Defaulting to the currently running kernel build tree would have been
nice.

> 
>  configure.ac      |  6 ++++++
>  src/Makefile.am   |  6 ++++++
>  src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
>  src/libimaevm.c   | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 98 insertions(+), 1 deletion(-)
>  create mode 100755 src/hash_info.gen
> 
> diff --git a/configure.ac b/configure.ac
> index a5b4288..60f3684 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -27,12 +27,18 @@ AC_HEADER_STDC
>  PKG_CHECK_MODULES(OPENSSL, [ openssl >= 0.9.8 ])
>  AC_SUBST(OPENSSL_CFLAGS)
>  AC_SUBST(OPENSSL_LIBS)
> +AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> 
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
> 
> +AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
> +	    [specifies the Linux kernel-headers package location or kernel root directory you want to use])],
> +	    [KERNEL_HEADERS="$withval"],
> +	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
> +
>  #debug support - yes for a while
>  PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>  if test $pkg_cv_enable_debug = yes; then
> diff --git a/src/Makefile.am b/src/Makefile.am
> index deb18fb..d74fc6f 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -9,6 +9,11 @@ libimaevm_la_LIBADD =  $(OPENSSL_LIBS)
> 
>  include_HEADERS = imaevm.h
> 
> +nodist_libimaevm_la_SOURCES = hash_info.h
> +BUILT_SOURCES = hash_info.h
> +hash_info.h: Makefile
> +	./hash_info.gen $(KERNEL_HEADERS) >$@
> +
>  bin_PROGRAMS = evmctl
> 
>  evmctl_SOURCES = evmctl.c
> @@ -18,5 +23,6 @@ evmctl_LDADD =  $(OPENSSL_LIBS) -lkeyutils libimaevm.la
> 
>  INCLUDES = -I$(top_srcdir) -include config.h
> 
> +CLEANFILES = hash_info.h
>  DISTCLEANFILES = @DISTCLEANFILES@
> 
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> new file mode 100755
> index 0000000..60fc750
> --- /dev/null
> +++ b/src/hash_info.gen
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +#
> +# Generate hash_info.h from kernel headers
> +#
> +# Copyright (C) 2018 <vt@altlinux.org>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2, or (at your option)
> +# any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +
> +KERNEL_HEADERS=$1
> +HASH_INFO_H=uapi/linux/hash_info.h
> +HASH_INFO=$KERNEL_HEADERS/include/$HASH_INFO_H
> +
> +# Allow to specify kernel-headers past include/
> +if [ ! -e $HASH_INFO ]; then
> +  HASH_INFO2=$KERNEL_HEADERS/$HASH_INFO_H
> +  if [ -e $HASH_INFO2 ]; then
> +    HASH_INFO=$HASH_INFO2
> +  fi
> +fi
> +
> +if [ ! -e $HASH_INFO ]; then
> +  echo "/* $HASH_INFO is not found */"
> +  HASH_INFO=/dev/null
> +else
> +  echo "/* $HASH_INFO is found */"
> +fi
> +
> +echo "enum hash_algo {"
> +grep HASH_ALGO_.*, $HASH_INFO
> +printf "\tHASH_ALGO__LAST\n"
> +echo "};"
> +
> +echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
> +sed -n 's/HASH_ALGO_\(.*\),/[HASH_ALGO_\1] = "\L\1\E",/p' $HASH_INFO
> +echo "};"

Almost perfectly matches crypto/hash_crypto.c!  Waiting to see if/how
the next patch addresses the differences...


> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 7b2b62c..cb4721b 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -50,6 +50,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <assert.h>
> +#include <ctype.h>
> 
>  #include <openssl/crypto.h>
>  #include <openssl/pem.h>
> @@ -58,6 +59,7 @@
>  #include <openssl/err.h>
> 
>  #include "imaevm.h"
> +#include "hash_info.h"
> 
>  const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_MD4]		= "md4",
> @@ -153,6 +155,17 @@ void dump(const void *ptr, int len)
>  	do_dump(stdout, ptr, len, true);
>  }
> 
> +const char *get_hash_algo_by_id(int algo)
> +{
> +	if (algo < PKEY_HASH__LAST)
> +	    return pkey_hash_algo[algo];
> +	if (algo < HASH_ALGO__LAST)
> +	    return hash_algo_name[algo];
> +
> +	log_err("digest %d not found\n", algo);
> +	return "unknown";
> +}
> +
>  int get_filesize(const char *filename)
>  {
>  	struct stat stats;
> @@ -528,15 +541,44 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>  	return 0;
>  }
> 
> +/* compare algo names case insensitively and ignoring separators */
> +static int algocmp(const char *a, const char *b)
> +{
> +	while (*a && *b) {
> +		int cha, chb;
> +
> +		cha = tolower((unsigned char)*a++);
> +		if (!isalnum(cha))
> +			continue;
> +		chb = tolower((unsigned char)*b++);
> +		if (!isalnum(chb)) {
> +			a--;
> +			continue;
> +		}
> +		if (cha != chb)
> +			return -1;
> +	}
> +	return *a || *b;
> +}
> +
>  int get_hash_algo(const char *algo)
>  {
>  	int i;
> 
> +	/* first iterate over builtin algorithms */
>  	for (i = 0; i < PKEY_HASH__LAST; i++)
>  		if (pkey_hash_algo[i] &&
>  		    !strcmp(algo, pkey_hash_algo[i]))
>  			return i;
> 
> +	/* iterate over algorithms provided by kernel-headers */
> +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> +		if (hash_algo_name[i] &&
> +		    !algocmp(algo, hash_algo_name[i]))
> +			return i;
> +	}

Assuming the two lists are in sync, which they should be, "i" could be
set to PKEY_HASH__LAST.

Mimi

> +
> +	log_info("digest %s not found, fall back to sha1\n", algo);
>  	return PKEY_HASH_SHA1;
>  }
> 
> @@ -611,7 +653,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
>  		return -1;
>  	}
>  	/* Use hash algorithm as retrieved from signature */
> -	params.hash_algo = pkey_hash_algo[sig_hash_algo];
> +	params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
> 
>  	/*
>  	 * Validate the signature based on the digest included in the

