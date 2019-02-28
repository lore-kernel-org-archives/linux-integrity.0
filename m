Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC79C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DB0218C3
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfB1QEO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:04:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730843AbfB1QEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Feb 2019 11:04:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SFxvKP004873
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 11:04:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxj3ejp61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 11:04:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 28 Feb 2019 16:04:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 16:04:07 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SG46XA6291608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 16:04:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44E2652059;
        Thu, 28 Feb 2019 16:04:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7EE0F52050;
        Thu, 28 Feb 2019 16:04:05 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 11:03:54 -0500
In-Reply-To: <20190226215034.68772-4-matthewgarrett@google.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <20190226215034.68772-4-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022816-4275-0000-0000-000003152B61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022816-4276-0000-0000-0000382372DA
Message-Id: <1551369834.10911.195.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-02-26 at 13:50 -0800, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> Some filesystems may be able to provide hashes in an out of band manner,
> and allowing them to do so is a performance win. This is especially true
> of FUSE-based filesystems where otherwise we recalculate the hash on
> every measurement.

To be more correct, please limit this statement to trusted mounted
fuse filesystem.

> Make use of this if policy says we should, but provide
> a parameter to force recalculation rather than trusting the filesystem.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Documentation/ABI/testing/ima_policy          |  5 +++-
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  security/integrity/ima/ima.h                  |  3 ++-
>  security/integrity/ima/ima_api.c              |  5 +++-
>  security/integrity/ima/ima_crypto.c           | 23 ++++++++++++++++++-
>  security/integrity/ima/ima_policy.c           |  8 ++++++-
>  security/integrity/ima/ima_template_lib.c     |  2 +-
>  security/integrity/integrity.h                |  1 +
>  8 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 09a5def7e28a..6a517282068d 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -24,7 +24,8 @@ Description:
>  				[euid=] [fowner=] [fsname=] [subtype=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
> -			option:	[[appraise_type=]] [permit_directio]
> +			option:	[[appraise_type=] [permit_directio]
> +			         [trust_vfs]]

Let's generalize "trust_vfs" a bit.  How about introducing
"collect_type=", with the default being reading and calculating the
file hash?

>  
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
> @@ -41,6 +42,8 @@ Description:
>  		lsm:  	are LSM specific
>  		option:	appraise_type:= [imasig]
>  			pcr:= decimal value
> +			permit_directio:= allow directio accesses
> +			trust_vfs:= trust VFS-provided hash values
>  
>  		default policy:
>  			# PROC_SUPER_MAGIC
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9a15..d3054a67e700 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1640,6 +1640,11 @@
>  			different crypto accelerators. This option can be used
>  			to achieve best performance for particular HW.
>  
> +	ima.force_hash= [IMA] Force hash calculation in IMA
> +			Format: <bool>
> +			Always calculate hashes rather than trusting the
> +			filesystem to provide them to us.

Unless the IMA policy specifically defines rules with "trust_vfs", the
default is to read the file, calculating the file hash.  I don't see a
need for this boot command line option.  I do think that "trust_vfs"
needs to be limited.  Perhaps limiting it to a specific mounted
filesystem?  Perhaps limiting it to systems requiring signed IMA
policies?

Mimi

> +
>  	init=		[KNL]
>  			Format: <full_path>
>  			Run specified binary instead of /sbin/init as init
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cc12f3449a72..24d9b3a3bfc0 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -133,7 +133,8 @@ int ima_fs_init(void);
>  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
>  			   const unsigned char *filename);
> -int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
> +int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
> +		       bool trust_vfs);
>  int ima_calc_buffer_hash(const void *buf, loff_t len,
>  			 struct ima_digest_data *hash);
>  int ima_calc_field_array_hash(struct ima_field_data *field_data,
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c7505fb122d4..0def9cf43549 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -206,6 +206,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  	int length;
>  	void *tmpbuf;
>  	u64 i_version;
> +	bool trust_vfs;
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
> @@ -225,10 +226,12 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  	/* Initialize hash digest to 0's in case of failure */
>  	memset(&hash.digest, 0, sizeof(hash.digest));
>  
> +	trust_vfs = iint->flags & IMA_TRUST_VFS;
> +
>  	if (buf)
>  		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
>  	else
> -		result = ima_calc_file_hash(file, &hash.hdr);
> +		result = ima_calc_file_hash(file, &hash.hdr, trust_vfs);
>  
>  	if (result && result != -EBADF && result != -EINVAL)
>  		goto out;
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index acf2c7df7145..94105089ad41 100644
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
> @@ -402,11 +406,14 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
>   * shash for the hash calculation.  If ahash fails, it falls back to using
>   * shash.
>   */
> -int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
> +int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
> +		       bool trust_vfs)
>  {
>  	loff_t i_size;
>  	int rc;
>  	struct file *f = file;
> +	struct dentry *dentry = file_dentry(file);
> +	struct inode *inode = d_backing_inode(dentry);
>  	bool new_file_instance = false, modified_flags = false;
>  
>  	/*
> @@ -419,6 +426,20 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * If policy says we should trust VFS-provided hashes, and
> +	 * we're not configured to force hashing, and if the
> +	 * filesystem is trusted, ask the VFS if it can obtain the
> +	 * hash without us having to calculate it ourself.
> +	 */
> +	if (trust_vfs && !ima_force_hash &&
> +	    !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER)) {
> +		hash->length = hash_digest_size[hash->algo];
> +		rc = vfs_get_hash(file, hash->algo, hash->digest, hash->length);
> +		if (!rc)
> +			return 0;
> +	}
> +
>  	/* Open a new file instance in O_RDONLY if we cannot read */
>  	if (!(file->f_mode & FMODE_READ)) {
>  		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index dcecb6aae5ec..af632c31f856 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -683,7 +683,7 @@ enum {
>  	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>  	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_err
> +	Opt_pcr, Opt_trust_vfs, Opt_err
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -718,6 +718,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_appraise_type, "appraise_type=%s"},
>  	{Opt_permit_directio, "permit_directio"},
>  	{Opt_pcr, "pcr=%s"},
> +	{Opt_trust_vfs, "trust_vfs"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -1060,6 +1061,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		case Opt_permit_directio:
>  			entry->flags |= IMA_PERMIT_DIRECTIO;
>  			break;
> +		case Opt_trust_vfs:
> +			entry->flags |= IMA_TRUST_VFS;
> +			break;
>  		case Opt_pcr:
>  			if (entry->action != MEASURE) {
>  				result = -EINVAL;
> @@ -1356,6 +1360,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  		seq_puts(m, "appraise_type=imasig ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
>  		seq_puts(m, "permit_directio ");
> +	if (entry->flags & IMA_TRUST_VFS)
> +		seq_puts(m, "trust_vfs ");
>  	rcu_read_unlock();
>  	seq_puts(m, "\n");
>  	return 0;
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 43752002c222..a36cdc6651b7 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -290,7 +290,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>  	inode = file_inode(event_data->file);
>  	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
>  	    ima_hash_algo : HASH_ALGO_SHA1;
> -	result = ima_calc_file_hash(event_data->file, &hash.hdr);
> +	result = ima_calc_file_hash(event_data->file, &hash.hdr, false);
>  	if (result) {
>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
>  				    event_data->filename, "collect_data",
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7de59f44cba3..a03f859c1602 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -36,6 +36,7 @@
>  #define IMA_NEW_FILE		0x04000000
>  #define EVM_IMMUTABLE_DIGSIG	0x08000000
>  #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> +#define IMA_TRUST_VFS		0x20000000
>  
>  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>  				 IMA_HASH | IMA_APPRAISE_SUBMASK)

