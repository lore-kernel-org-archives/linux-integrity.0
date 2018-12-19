Return-Path: <SRS0=H3qb=O4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20EFC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E75218C3
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Dec 2018 18:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeLSSPV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:15:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbeLSSPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Dec 2018 13:15:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJI8WsV093508
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 13:15:19 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pft323g1g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Dec 2018 13:15:19 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Dec 2018 18:15:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 18:15:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJIFCwO8847806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 18:15:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFAA211C054;
        Wed, 19 Dec 2018 18:15:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBA8911C052;
        Wed, 19 Dec 2018 18:15:11 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Dec 2018 18:15:11 +0000 (GMT)
Subject: Re: EVM: Permission denied with overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ignaz Forster <iforster@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Date:   Wed, 19 Dec 2018 13:15:11 -0500
In-Reply-To: <1545238601.2916.13.camel@HansenPartnership.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <1545238601.2916.13.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121918-0012-0000-0000-000002DB626C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121918-0013-0000-0000-000021110119
Message-Id: <1545243311.3954.22.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 08:56 -0800, James Bottomley wrote:
> On Wed, 2018-12-19 at 10:39 -0500, Mimi Zohar wrote:
> > Confirmed, in linux-4.18.y d_backing_inode returns the real i_ino,
> > but newer kernels do not.
> 
> Just so we're clear, this isn't an issue with d_backing_inode(), which
> hasn't changed since its introduction in 2015 and which always returns
> dentry->d_inode (it was originally a helper for unionfs which got
> merged even though unionfs didn't, which makes it and the comment about
> upper/lower totally misleading).  The problem is that overlayfs has
> changed the inode it places into d_inode.
> 
> >   This is a problem for EVM as the i_ino is included in the HMAC
> > calculation.
> 
> Isn't the solution always to use portable signatures for containers? 
> It's problematic to include inode and generation with an overlay
> because if you change the metadata it gets copied up => new inode
> number and generation on the upper filesystem but if we were always
> using the underlying inode number and generation, the signature would
> then be wrong on the copied up file.
> 
> At base, most container images are sets of tar files, which are not
> inode number preserving anyway, so even if we find a convoluted way to
> fix the above, the EVM signature has to be portable because otherwise
> its always wrong for container images.

Ignaz's use case was mutable files, not immutable files with file
signatures.  Prior to 4.19, EVM was calculating and verifying the file
HMAC properly.  With 4.19, it stopped working because the i_ino used
in calculating the HMAC value stored in security.evm, is not the same
 when verifying the HMAC value.

Mimi

