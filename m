Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED468C64EB4
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB10D20660
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 21:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB10D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLAIS1 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:18:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbeLAIS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 03:18:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUL3foh132745
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 16:07:52 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p3attw632-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 16:07:51 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Nov 2018 21:07:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 21:07:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUL7l4l3080548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 21:07:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF32A4055;
        Fri, 30 Nov 2018 21:07:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7316DA4057;
        Fri, 30 Nov 2018 21:07:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.143])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 21:07:46 +0000 (GMT)
Subject: Re: [PATCH v2.1 6/7] ima-evm-utils: Extract digest algorithms from
 hash_info.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:07:35 -0500
In-Reply-To: <1543605748.4216.74.camel@linux.ibm.com>
References: <20181129122759.16813-1-vt@altlinux.org>
         <1543605748.4216.74.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18113021-0012-0000-0000-000002D2D3E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113021-0013-0000-0000-000021082301
Message-Id: <1543612055.4216.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300179
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2018-11-30 at 14:22 -0500, Mimi Zohar wrote:
> On Thu, 2018-11-29 at 15:27 +0300, Vitaly Chikunov wrote:
> > If configured with "--with-kernel-headers=PATH" try to extract hash
> > algorithms from "hash_info.h" from the kernel source tree or
> > kernel-headers package located in the specified path. (Otherwise, it
> > will be tried to get from the installed kernel.)
> > 
> > This also introduces two algorithm lists, one is built-in and another is
> > from the kernel source. (They should never contain conflicting algorithm
> > IDs by their append-only nature.) If the digest is not found in the
> > built-in list it will be searched in the list from kernel's
> > "hash_info.h".
> > 
> > This patch will allow evmctl to be just recompiled to work with digest
> > algorithms introduced in the newer kernels.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > Changes since v1:
> > - New patch.
> > Changes since v2:
> > - Mark PATH portion of "--with-kernel-headers=PATH" non-optional and
> >   change description to reflect correct behavior.
> Defaulting to the currently running kernel build tree would have been
> nice.

Then you could extract "hash_algo_name[]" from crypto/hash_info.c
directly.

Mimi

