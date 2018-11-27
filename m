Return-Path: <SRS0=wgLp=OG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF4EC43441
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA642082F
	for <linux-integrity@archiver.kernel.org>; Tue, 27 Nov 2018 12:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA642082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbeK0XDK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:03:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728998AbeK0XDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Nov 2018 18:03:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARBxMeZ042475
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 07:05:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p12nm0ayj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Nov 2018 07:05:26 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 27 Nov 2018 12:05:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 12:05:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARC5LYF1835498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 12:05:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B28394C046;
        Tue, 27 Nov 2018 12:05:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 958B14C04A;
        Tue, 27 Nov 2018 12:05:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 12:05:20 +0000 (GMT)
Subject: Re: [PATCH] IMA: Mask O_RDWR if FMODE_READ is set
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, amir73il@gmail.com
Date:   Tue, 27 Nov 2018 07:05:09 -0500
In-Reply-To: <20181126163847.xy3acvltyeb75nb4@merlin>
References: <20181126163847.xy3acvltyeb75nb4@merlin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112712-0016-0000-0000-0000022D5E62
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112712-0017-0000-0000-00003285B706
Message-Id: <1543320309.3902.137.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270106
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2018-11-26 at 10:38 -0600, Goldwyn Rodrigues wrote:
> A file can be opened with open(O_WRONLY | O_RDWR), so a FMORE_READ
> will not be set, and overlayfs will consider another copy_up() on the same
> file leading to a deadlock on mnt_want_write(). Fix it by masking
> O_RDWR while opening the file in read-only mode.

Shouldn't the open itself fail if both O_WRONLY and O_RDWR are
specified?

Mimi

> 
> 
> Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
> Fixes: a408e4a86b36 ("ima: open a new file instance if no read permissions")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index d9e7728027c6..2efa04e47ff0 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -422,7 +422,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  	/* Open a new file instance in O_RDONLY if we cannot read */
>  	if (!(file->f_mode & FMODE_READ)) {
>  		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
> -				O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
> +				O_RDWR | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);
>  		flags |= O_RDONLY;
>  		f = dentry_open(&file->f_path, flags, file->f_cred);
>  		if (IS_ERR(f)) {
> 

