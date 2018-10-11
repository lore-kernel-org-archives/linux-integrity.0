Return-Path: <SRS0=seDi=MX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D60C32788
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BA32075C
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BA32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJKWuQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:50:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbeJKWuP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 18:50:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BFLZC8128228
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:22:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n289j2uy3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:22:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 16:22:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 16:22:30 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BFMT7O9306188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 15:22:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C1E64C052;
        Thu, 11 Oct 2018 18:22:05 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F66E4C046;
        Thu, 11 Oct 2018 18:22:04 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.86.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 18:22:04 +0100 (BST)
Subject: Re: [PATCH 1/3] VFS: Add a call to obtain a file's hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Thu, 11 Oct 2018 11:22:17 -0400
In-Reply-To: <20181004203007.217320-2-mjg59@google.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101115-4275-0000-0000-000002C844AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101115-4276-0000-0000-000037D37B60
Message-Id: <1539271337.11939.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181011152217.lgh3_OLlYLf6rynO3qKvIBV5V9NEhnBBwcefdrpX9Kw@z>

On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> IMA wants to know what the hash of a file is, and currently does so by
> reading the entire file and generating the hash. Some filesystems may
> have the ability to store the hash in a secure manner resistant to
> offline attacks (eg, filesystem-level file signing), and in that case
> it's a performance win for IMA to be able to use that rather than having
> to re-hash everything. This patch simply adds VFS-level support for
> calling down to filesystems.

This patch description starts out saying that IMA needs the file hash
without explaining why.  Without that explanation, simply extracting
the file hash included in the file signature might sound plausible,
but kind of defeats the purpose of IMA.

Mimi


> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  fs/read_write.c    | 24 ++++++++++++++++++++++++
>  include/linux/fs.h |  6 +++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 39b4a21dd933..9ba3ce4bb838 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -2081,3 +2081,27 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  	return ret;
>  }
>  EXPORT_SYMBOL(vfs_dedupe_file_range);
> +
> +/**
> + * vfs_gethash - obtain a file's hash
> + * @file:	file structure in question
> + * @hash_algo:	the hash algorithm requested
> + * @buf:	buffer to return the hash in
> + * @size:	size allocated for the buffer by the caller
> + *
> + * This function allows filesystems that support securely storing the hash
> + * of a file to return it rather than forcing the kernel to recalculate it.
> + * Filesystems that cannot provide guarantees about the hash being resistant
> + * to offline attack should not implement this functionality.
> + *
> + * Returns 0 on success, -EOPNOTSUPP if the filesystem doesn't support it.
> + */
> +int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
> +		 size_t size)
> +{
> +	if (!file->f_op->get_hash)
> +		return -EOPNOTSUPP;
> +
> +	return file->f_op->get_hash(file, hash, buf, size);
> +}
> +EXPORT_SYMBOL(vfs_get_hash);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6c0b4a1c22ff..540316cfd461 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -40,6 +40,7 @@
> 
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> +#include <uapi/linux/hash_info.h>
> 
>  struct backing_dev_info;
>  struct bdi_writeback;
> @@ -1764,6 +1765,8 @@ struct file_operations {
>  	int (*dedupe_file_range)(struct file *, loff_t, struct file *, loff_t,
>  			u64);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	int (*get_hash)(struct file *, enum hash_algo hash, uint8_t *buf,
> +			size_t size);
>  } __randomize_layout;
> 
>  struct inode_operations {
> @@ -1838,7 +1841,8 @@ extern int vfs_dedupe_file_range(struct file *file,
>  extern int vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  				     struct file *dst_file, loff_t dst_pos,
>  				     u64 len);
> -
> +extern int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
> +			size_t size);
> 
>  struct super_operations {
>     	struct inode *(*alloc_inode)(struct super_block *sb);

