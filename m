Return-Path: <SRS0=seDi=MX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E80C32788
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Oct 2018 15:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3C2075C
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Oct 2018 15:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F3C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeJKWv2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:51:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728396AbeJKWv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 18:51:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BFMvpr048601
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:23:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n26av95re-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:23:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 16:23:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 16:23:18 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9BFNH3t63504570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 15:23:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D05C11C05E;
        Thu, 11 Oct 2018 18:22:50 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EEA911C050;
        Thu, 11 Oct 2018 18:22:49 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.86.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 18:22:49 +0100 (BST)
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Date:   Thu, 11 Oct 2018 11:23:06 -0400
In-Reply-To: <20181004203007.217320-3-mjg59@google.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-3-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101115-0020-0000-0000-000002D2C624
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101115-0021-0000-0000-000021214114
Message-Id: <1539271386.11939.79.camel@linux.ibm.com>
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
Message-ID: <20181011152306.bk86EjNUKasMq8_4LQHcmgpCdKP71ugKEtxPJ0hV6eE@z>

On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> Some filesystems may be able to provide hashes in an out of band manner,
> and allowing them to do so is a performance win. This is especially true
> of FUSE-based filesystems where otherwise we recalculate the hash on
> every measurement. Make use of this by default, but provide a parameter
> to force recalculation rather than trusting the filesystem.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Support for not calculating the file hash would need to be finer
grained than this, probably on a per mount basis.  The default should
be for IMA to always calculate the file hash, unless explicitly told
not to.

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  security/integrity/ima/ima_crypto.c             | 11 +++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 92eb1f42240d..617ae0f83b14 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1612,6 +1612,11 @@
>  			different crypto accelerators. This option can be used
>  			to achieve best performance for particular HW.
> 
> +	ima.force_hash= [IMA] Force hash calculation in IMA
> +			Format: <bool>
> +			Always calculate hashes rather than trusting the
> +			filesystem to provide them to us.
> +
>  	init=		[KNL]
>  			Format: <full_path>
>  			Run specified binary instead of /sbin/init as init
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 7e7e7e7c250a..f25259b2b6ec 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -32,6 +32,10 @@ static unsigned long ima_ahash_minsize;
>  module_param_named(ahash_minsize, ima_ahash_minsize, ulong, 0644);
>  MODULE_PARM_DESC(ahash_minsize, "Minimum file size for ahash use");
> 
> +static bool ima_force_hash;
> +module_param_named(force_hash, ima_force_hash, bool_enable_only, 0644);
> +MODULE_PARM_DESC(force_hash, "Always calculate hashes");
> +
>  /* default is 0 - 1 page. */
>  static int ima_maxorder;
>  static unsigned int ima_bufsize = PAGE_SIZE;
> @@ -431,6 +435,13 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  		return -EINVAL;
>  	}
> 
> +	if (!ima_force_hash) {

IMA should never skip the file hash calculation if the filesystem is
an untrusted mount (eg. SB_I_UNTRUSTED_MOUNTER).

Mimi


> +		hash->length = hash_digest_size[hash->algo];
> +		rc = vfs_get_hash(file, hash->algo, hash->digest, hash->length);
> +		if (!rc)
> +			return 0;
> +	}
> +
>  	i_size = i_size_read(file_inode(file));
> 
>  	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {

