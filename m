Return-Path: <SRS0=GnzX=QG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EFEC282D7
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 12:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8E20882
	for <linux-integrity@archiver.kernel.org>; Wed, 30 Jan 2019 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfA3MfO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:35:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfA3MfO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jan 2019 07:35:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UCTYMZ126760
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jan 2019 07:35:13 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbaykua8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jan 2019 07:35:13 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 30 Jan 2019 12:35:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 12:35:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UCZ8UV60752114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 12:35:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E44E4204F;
        Wed, 30 Jan 2019 12:35:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D42A542041;
        Wed, 30 Jan 2019 12:35:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 12:35:07 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: remove redundant call to
 OpenSSL_add_all_algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jan 2019 07:34:57 -0500
In-Reply-To: <20190127023916.2425-1-vt@altlinux.org>
References: <20190127023916.2425-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19013012-0008-0000-0000-000002B7EEF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013012-0009-0000-0000-000022243592
Message-Id: <1548851697.20210.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300100
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-01-27 at 05:39 +0300, Vitaly Chikunov wrote:
> Because of call to OPENSSL_add_all_algorithms_conf() calling
> OpenSSL_add_all_algorithms() is not needed. There was not be any
> problems though because double initialization is permitted.
> ---
>  src/libimaevm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 7501303..b038d0c 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -995,7 +995,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
> 
>  static void libinit()
>  {
> -	OpenSSL_add_all_algorithms();
>  	OPENSSL_add_all_algorithms_conf();
>  	ERR_load_crypto_strings();
>  }

The only difference between the two calls seems to be reading the
system openssl.cnf file.  In the original call that is dependent on
OPENSSL_LOAD_CONF being defined.  Calling
OPENSSL_add_all_algorithms_conf(), forces reading the system
openssl.cnf.

Mimi

