Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C8C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FBA21104
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 13:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FBA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeK1AbR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:31:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbeK1AbR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Nov 2018 19:31:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARDPTJC046832
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 08:33:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p157kvesr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 08:33:19 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 27 Nov 2018 13:33:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 13:33:15 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARDXEHt54722632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 13:33:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 668FCA405F;
        Tue, 27 Nov 2018 13:33:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08D4A4065;
        Tue, 27 Nov 2018 13:33:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.65])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 13:33:13 +0000 (GMT)
Subject: Re: [PATCH 3/3] ima-evm-utils: Allow to use Streebog hash function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 27 Nov 2018 08:33:03 -0500
In-Reply-To: <20181127130812.ad3t3uflxkagttuf@sole.flsd.net>
References: <20181126043953.1126-1-vt@altlinux.org>
         <20181126043953.1126-3-vt@altlinux.org>
         <1543319811.3902.134.camel@linux.ibm.com>
         <20181127130812.ad3t3uflxkagttuf@sole.flsd.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112713-4275-0000-0000-000002E7714E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112713-4276-0000-0000-000037F4AE76
Message-Id: <1543325583.3902.170.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270116
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2018-11-27 at 16:08 +0300, Vitaly Chikunov wrote:

> > hash_info.h is now included in kernel-headers package.
> 
> I think, first it should not be coincided with the new algo adding and
> being follow-up patch (if any).
> 
> > Anyone using the hash_algo enumeration defined in hash_info.h, will
> > probably also want to use an associated algorithm name.  It would make
> > more sense to keep the hash_algo enumeration, hash_algo_name[], and
> > perhaps the hash_digest_size[] together.  Maybe using macros to keep
> > them in sync (eg. kernel_read_file_id/kernel_read_file_str).
> 
> On the first sight this sounds good, but...
> 
> It sounds like it will require patching kernel's hash_info.h, so it will
> be not possible to transfer smoothly on the new scheme without breaking
> some compatibility (of the newer ima-evm-utils with older kernels).  Also,
> it is possible that ima-evm-utils is used on the older stable box (where some
> reliable and stable build system run) which does not have such modification
> and/or new algorithms in the kernel but willing to generate signatures.
> 
> So, I think code duplication between projects is good in this case.

The sooner the kernel's hash_info.h is updated, the better.  For the
time being, ima-evm-utils could define these definitions in a separate
file that is/isn't included based on autotools/buildtime option.

> 
> Some hash algorithms may be wished to be compatible with rsa pkcs1
> signature scheme, which is also defined in kernel in
> crypto/rsa-pkcs1pad.c and in ima-evm-utils in src/libimaevm.c so code
> duplication and adding algorithms in both sources will happen anyway.
> 
> Thanks,

There might be multiple problems, but fixing one is better than not
fixing either.

Mimi

