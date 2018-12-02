Return-Path: <SRS0=SF38=OL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E122C04EB8
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1B02054F
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 14:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1B02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLBOrq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 09:47:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbeLBOrq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 09:47:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB2EhPUF105882
        for <linux-integrity@vger.kernel.org>; Sun, 2 Dec 2018 09:47:43 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p48bpyn84-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 02 Dec 2018 09:47:43 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 2 Dec 2018 14:47:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Dec 2018 14:47:39 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB2Elc5q56688834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Dec 2018 14:47:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F54CAE053;
        Sun,  2 Dec 2018 14:47:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB57AAE045;
        Sun,  2 Dec 2018 14:47:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.63])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  2 Dec 2018 14:47:37 +0000 (GMT)
Subject: Re: [PATCH v2.1 6/7] ima-evm-utils: Extract digest algorithms from
 hash_info.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 02 Dec 2018 09:47:26 -0500
In-Reply-To: <20181201034144.kcyxjmotj7mjfb5n@sole.flsd.net>
References: <20181129122759.16813-1-vt@altlinux.org>
         <1543605748.4216.74.camel@linux.ibm.com>
         <20181201034144.kcyxjmotj7mjfb5n@sole.flsd.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120214-0012-0000-0000-000002D37237
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120214-0013-0000-0000-00002108C4F1
Message-Id: <1543762046.4216.182.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2018-12-01 at 06:41 +0300, Vitaly Chikunov wrote:
> On Fri, Nov 30, 2018 at 02:22:28PM -0500, Mimi Zohar wrote:
> > On Thu, 2018-11-29 at 15:27 +0300, Vitaly Chikunov wrote:
> > > If configured with "--with-kernel-headers=PATH" try to extract hash
> > > algorithms from "hash_info.h" from the kernel source tree or
> > > kernel-headers package located in the specified path. (Otherwise, it
> > > will be tried to get from the installed kernel.)
> > > 
> > > This also introduces two algorithm lists, one is built-in and another is
> > > from the kernel source. (They should never contain conflicting algorithm
> > > IDs by their append-only nature.) If the digest is not found in the
> > > built-in list it will be searched in the list from kernel's
> > > "hash_info.h".
> > > 
> > > This patch will allow evmctl to be just recompiled to work with digest
> > > algorithms introduced in the newer kernels.
> > > 
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > > Changes since v1:
> > > - New patch.
> > > Changes since v2:
> > > - Mark PATH portion of "--with-kernel-headers=PATH" non-optional and
> > >   change description to reflect correct behavior.
> > 
> > Defaulting to the currently running kernel build tree would have been
> > nice.
> 
> It already does. As description states "(Otherwise, it will be tried to get
> from the installed kernel.)" Also:
> 
> > > +AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
> > > +	    [specifies the Linux kernel-headers package location or kernel root directory you want to use])],
> > > +	    [KERNEL_HEADERS="$withval"],
> > > +	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
> 
> if "--with-kernel-headers" is not specified it will default to
> `/lib/modules/$(uname -r)/source` which points to the kernel-headers or
> kernel source tree root.

I missed that.

<snip>

> > > +	/* first iterate over builtin algorithms */
> > >  	for (i = 0; i < PKEY_HASH__LAST; i++)
> > >  		if (pkey_hash_algo[i] &&
> > >  		    !strcmp(algo, pkey_hash_algo[i]))
> > >  			return i;
> > > 
> > > +	/* iterate over algorithms provided by kernel-headers */
> > > +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> > > +		if (hash_algo_name[i] &&
> > > +		    !algocmp(algo, hash_algo_name[i]))
> > > +			return i;
> > > +	}
> > 
> > Assuming the two lists are in sync, which they should be, "i" could be
> > set to PKEY_HASH__LAST.
> 
> Can not do that, since pkey_hash_algo is currently sparse array and could
> skip entries which are present in hash_algo_name.

Missed that too.

> 
> Note, that since "[PATCH v2 7/7] ima-evm-utils: Try to load digest by
> its alias" lists will have different semantics: the pkey_hash_algo list is
> compared algo names with strmatch which supports algo aliases, and the
> hash_algo_name list is compared using algocmp which does not compare
> non-alphanumeric chars such as `_` and `-`, so streebog-512, streebog_512
> or just streebog512 all would work (to match algo id).
> 
> Concluding, if you would not insist on parsing crypto/hash_info.c, I
> don't need fixing anything in this patch.

Agreed, the patch looks fine as is.

Mimi

