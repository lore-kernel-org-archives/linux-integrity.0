Return-Path: <SRS0=1iot=RN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05801C43381
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE93820652
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 22:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfCJWcU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:32:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfCJWcU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Mar 2019 18:32:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2AMSuja039379
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 18:32:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5ba308md-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 18:32:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 10 Mar 2019 22:32:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Mar 2019 22:32:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2AMWDCg61210624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Mar 2019 22:32:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7BEAE072;
        Sun, 10 Mar 2019 22:32:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3827AE06F;
        Sun, 10 Mar 2019 22:32:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 Mar 2019 22:32:12 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: rework openssl init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 10 Mar 2019 18:32:02 -0400
In-Reply-To: <20190203174712.892-1-vt@altlinux.org>
References: <20190203174712.892-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031022-0008-0000-0000-000002CB0A6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031022-0009-0000-0000-00002237223E
Message-Id: <1552257122.6100.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903100174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Sun, 2019-02-03 at 20:47 +0300, Vitaly Chikunov wrote:
> Remove deprecated call to OpenSSL_add_all_algorithms().
> Allow to disable openssl config loading via configure
> `--disable-openssl-conf' option.
> Finish engine initialization properly by calling ENGINE_set_default(),
> as suggested by James Bottomley.
> 

Thanks, could you also display the status under "Give some feedback".

Mimi


> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> - v1 is "ima-evm-utils: remove redundant call to OpenSSL_add_all_algorithms"
> - everything is changed as suggested in mailing list, not just
>   redundant OpenSSL_add_all_algorithms() call is removed.
> 
>  configure.ac    | 6 ++++++
>  src/evmctl.c    | 1 +
>  src/libimaevm.c | 8 ++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 60f3684..ff8ac29 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -39,6 +39,12 @@ AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
>  	    [KERNEL_HEADERS="$withval"],
>  	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
> 
> +AC_ARG_ENABLE([openssl_conf],
> +	      [AS_HELP_STRING([--disable-openssl-conf], [disable loading of openssl config by libimaevm])],
> +	      if test "$enable_openssl_conf" = "no"; then
> +		AC_DEFINE(DISABLE_OPENSSL_CONF, 1, [Define to disable loading of openssl config by libimaevm.])
> +	      fi)
> +
>  #debug support - yes for a while
>  PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>  if test $pkg_cv_enable_debug = yes; then
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2e4d551..fa074c4 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1904,6 +1904,7 @@ int main(int argc, char *argv[])
>  				ENGINE_free(eng);
>  				eng = NULL;
>  			}
> +			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
>  			break;
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 799eeec..db27c6f 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -976,7 +976,11 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
> 
>  static void libinit()
>  {
> -	OpenSSL_add_all_algorithms();
> -	OPENSSL_add_all_algorithms_conf();
> +	OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS |
> +			    OPENSSL_INIT_ADD_ALL_DIGESTS |
> +#ifndef DISABLE_OPENSSL_CONF
> +			    OPENSSL_INIT_LOAD_CONFIG |
> +#endif
> +			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
>  	ERR_load_crypto_strings();
>  }

