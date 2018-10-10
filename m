Return-Path: <SRS0=X323=MW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526CBC43441
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Oct 2018 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39C12085B
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Oct 2018 19:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39C12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJKC2U (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:28:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbeJKC2U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 22:28:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AIwmCm066631
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 15:04:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ntd3jkj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 15:04:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 10 Oct 2018 20:04:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 20:04:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9AJ4hCL66060428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 19:04:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E206342045;
        Wed, 10 Oct 2018 22:04:19 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 006984203F;
        Wed, 10 Oct 2018 22:04:19 +0100 (BST)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Oct 2018 22:04:18 +0100 (BST)
Subject: Re: [PATCH v2] Open a new file instance if no read permissions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        James Morris <jmorris@namei.org>
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date:   Wed, 10 Oct 2018 15:04:42 -0400
In-Reply-To: <20181009151233.lxgm5c73epofi6r3@merlin>
References: <20181009151233.lxgm5c73epofi6r3@merlin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101019-0012-0000-0000-000002B55104
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101019-0013-0000-0000-000020E9AB09
Message-Id: <1539198282.3585.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100177
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181010190442._UwOwNCxjWfkx2yfJOv3esDLH_vrqclk4fWV7DAwBzk@z>

Hi Goldwyn,

On Tue, 2018-10-09 at 10:12 -0500, Goldwyn Rodrigues wrote:
> Open a new file instance as opposed to changing file->f_mode when
> the file is not readable. This is done to accomodate
> overlayfs stacked file operations change. The real struct file is hidden
> behind the overlays struct file. So, any file->f_mode manipulations are
> not reflected on the real struct file. Open the file again in read mode
> if original file cannot be read, read and calculate the hash.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thanks!  I'm waiting for it to hit linux-next, before sending James
the linux-integrity pull request.

Mimi

