Return-Path: <SRS0=nno7=SR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA56C282DA
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Apr 2019 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9A7218A1
	for <linux-integrity@archiver.kernel.org>; Mon, 15 Apr 2019 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfDOVjA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:39:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfDOVjA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Apr 2019 17:39:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FLY3cG090536
        for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2019 17:38:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvy1e7q3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2019 17:38:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 15 Apr 2019 22:38:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 22:38:52 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FLcpOm47054916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 21:38:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E346AE045;
        Mon, 15 Apr 2019 21:38:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86DF5AE058;
        Mon, 15 Apr 2019 21:38:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 21:38:50 +0000 (GMT)
Subject: Re: [PATCH] kexec_buffer measure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prsriva02@gmail.com, linux-integrity@vger.kernel.org
Cc:     Prakhar Srivastava <prsriva@microsoft.com>
Date:   Mon, 15 Apr 2019 17:38:36 -0400
In-Reply-To: <20190412180829.15631-1-prsriva02@gmail.com>
References: <20190412180829.15631-1-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041521-0008-0000-0000-000002DA2139
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041521-0009-0000-0000-000022465710
Message-Id: <1555364316.4914.212.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-04-12 at 11:08 -0700, prsriva02@gmail.com wrote:
> From: Prakhar Srivastava <prsriva@microsoft.com>
> 
> This adds a generic buffer measure ima function hook.

A patch description should begin with a problem description or
motivation for the patch, before describing the solution. 

> The Buffer passed will be added to the sig field of the template if used.

Template fields are defined in ima_template.c  You can't simply re-use 
an existing field like this.

> The hash<algo configured>(buffer) is added as the IMA measurements, along side the buffer itself in hex.
>       For cmdline: kernel file name is prefixed to the cmdline to distinguish between callers.
> An enum is used to control what all buffers can be written to it.
> 
> Verified How:
> Replaced kernel on machine.
> read ima_measurement_log
> called kexec -s <with cmdline>
> read ima_measurement_log
>      - A new entry for the cmdline passed can be seen.
>      - HEX to text verified: http://www.unit-conversion.info/texttools/hexadecimal/
>      - Generated Hash for the text buffer and matched it with in IMA log

The kexec man page provides this information. I don't see the need for
these details here.

Please refer to section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for instructions on
writing a patch description.

> 
> Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>

> ---
>  include/linux/ima.h               |  21 ++++-
>  kernel/kexec_core.c               |  68 +++++++++++++++
>  kernel/kexec_file.c               |  18 ++++
>  kernel/kexec_internal.h           |   6 +-
>  security/integrity/ima/Kconfig    |  16 ++++
>  security/integrity/ima/ima_main.c | 135 ++++++++++++++++++++++++++++++
>  security/integrity/integrity.h    |   3 +
>  7 files changed, 264 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 7f6952f8d6aa..46c3b95b2637 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -14,6 +14,14 @@
>  #include <linux/kexec.h>
>  struct linux_binprm;
>  
> +#ifdef CONFIG_IMA_BUFFER_MEASURE
> +enum buffer_id{
> +	KEXEC_CMDLINE = 1
> +	// other buffer ids
> +	// KERNEL_VERSION

There are already two enumerations - kernel_read_file_id and
kernel_load_file_id.  Unless there are clear examples of other buffer
data, please don't define a new enumeration.

> +};
> +#endif
> +
>  #ifdef CONFIG_IMA
>  extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask, int opened);
> @@ -23,7 +31,10 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> -
> +#ifdef CONFIG_IMA_BUFFER_MEASURE
> +extern int ima_add_buffer_measure(const void *buff,
> +				loff_t size, enum buffer_id id);
> +#endif
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
> @@ -64,7 +75,13 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  {
>  	return;
>  }
> -
> +#ifndef CONFIG_IMA_BUFFER_MEASURE
> +static inline int ima_add_buffer_measure(const void *buff,
> +					loff_t size, enum buffer_id id)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_BUFFER_MEASURE */
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ae1a3ba24df5..7cf795794fda 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1151,3 +1151,71 @@ void __weak arch_kexec_protect_crashkres(void)
>  
>  void __weak arch_kexec_unprotect_crashkres(void)
>  {}
> +
> +#ifdef CONFIG_MEASURE_KEXEC_CMDLINE

In general "ifdef's" don't belong in C code.  Please refer to section
21) Conditional Compilation of Documentation/process/coding-style.rst
section.

Before posting patches, please run scripts/checkpatch.pl.

> +/**
> + * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
> + * that needs to be measured
> + * @outbuf - out buffer that contains the formated string
> + * @kernel_fd - the fild identifier for the kerenel image
> + * @cmdline_ptr - ptr to the cmdline buffer
> + * @cmdline_len - len of the buffer.
> + * 
> + * This generates a buffer in the format Kerenelfilename::cmdline
> + * 
> + * On success return 0.
> + * On failure return -EINVAL.
> +*/
> +int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
> +				const char __user *cmdline_ptr,
> +				unsigned long cmdline_len)
> +{
> +	int ret = -EINVAL;
> +	struct fd f = {};
> +	int size = 0;
> +	char *buf = NULL;
> +	char *temp_buf = NULL;
> +	char delimiter[] = "::";
> +
> +	if (!outbuf)
> +		goto out;
> +
> +	f = fdget(kernel_fd);
> +	if (!f.file)
> +		goto out;
> +
> +	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
> +			ARRAY_SIZE(delimiter)) -1;
> +
> +	buf = kzalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		goto out;
> +
> +	temp_buf = memdup_user(cmdline_ptr, cmdline_len);
> +	if (IS_ERR(temp_buf)) {
> +		kfree(buf);
> +		ret = PTR_ERR(temp_buf);
> +		goto out;
> +	}
> +
> +	memcpy(buf, f.file->f_path.dentry->d_name.name,
> +		f.file->f_path.dentry->d_name.len);
> +	memcpy(buf + f.file->f_path.dentry->d_name.len,
> +		delimiter, ARRAY_SIZE(delimiter) -1);
> +	memcpy(buf + f.file->f_path.dentry->d_name.len +
> +		ARRAY_SIZE(delimiter) - 1,
> +		temp_buf, cmdline_len -1);
> +
> +	*outbuf = buf;
> +	ret = size;
> +
> +	pr_debug("kexec cmdline buff: %s\n",buf);
> +
> +out:
> +	if (f.file)
> +		fdput(f);
> +
> +	kfree(temp_buf);
> +	return ret;
> +}
> +#endif
> \ No newline at end of file
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b118735fea9d..a3a839f2710d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -126,6 +126,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	int ret = 0;
>  	void *ldata;
>  	loff_t size;
> +#ifdef CONFIG_MEASURE_KEXEC_CMDLINE
> +	char *buff_to_measure = NULL;
> +	int buff_to_measure_size = 0;
> +#endif
>  
>  	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
>  				       &size, INT_MAX, READING_KEXEC_IMAGE);
> @@ -133,6 +137,16 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		return ret;
>  	image->kernel_buf_len = size;
>  
> +#ifdef CONFIG_MEASURE_KEXEC_CMDLINE
> +	/* IMA measures the cmdline passed to the next kernel*/
> +	buff_to_measure_size = kexec_cmdline_prepend_img_name(&buff_to_measure,
> +					kernel_fd, cmdline_ptr, cmdline_len);

The kexec kernel image pathname is already in the measurement list.
 There's no need for adding it again.

> +
> +	if (buff_to_measure_size > 0)
> +		ima_add_buffer_measure(buff_to_measure, buff_to_measure_size,
> +				KEXEC_CMDLINE);

This affects multiple kernel subsystems.  To simplify review, this
patch needs to be broken up.  Define a new IMA (or security) hook in
one patch.  In a separate patch, call that hook.  Refer to section "3)
Separate your changes" of Documentation/process/submitting-
patches.rst.

This call is in the wrong place.  It should be deferred to where the
boot command line is actually used.

       if (cmdline_len) {
                image->cmdline_buf = memdup_user(cmdline_ptr, cmdline_len);
                if (IS_ERR(image->cmdline_buf)) {
                        ret = PTR_ERR(image->cmdline_buf);
                        image->cmdline_buf = NULL;
                        goto out;
                }


> +#endif
> +
>  	/* IMA needs to pass the measurement list to the next kernel. */
>  	ima_add_kexec_buffer(image);
>  
> @@ -195,6 +209,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	image->image_loader_data = ldata;
>  out:
>  	/* In case of error, free up all allocated memory in this function */
> +#ifdef CONFIG_MEASURE_KEXEC_CMDLINE
> +	kfree(buff_to_measure);
> +#endif
> +
>  	if (ret)
>  		kimage_file_post_load_cleanup(image);
>  	return ret;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 799a8a452187..808aa2330cdb 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -11,7 +11,11 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
>  void kimage_terminate(struct kimage *image);
>  int kimage_is_destination_range(struct kimage *image,
>  				unsigned long start, unsigned long end);
> -
> +#ifdef CONFIG_MEASURE_KEXEC_CMDLINE
> +int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
> +				const char __user *cmdline_ptr,
> +				unsigned long cmdline_len);
> +#endif
>  extern struct mutex kexec_mutex;
>  
>  #ifdef CONFIG_KEXEC_FILE
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 370eb2f4dd37..349e5a818a5f 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -219,3 +219,19 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_BUFFER_MEASURE
> +	bool "IMA to measure buffers"
> +	depends on IMA=y
> +	depends on CRYPTO=y
> +	default n
> +	help
> +	  This enables buffer measurement in ima.
> +
> +config MEASURE_KEXEC_CMDLINE
> +	bool "Measure cmdline passed to KEXEC"
> +	depends on KEXEC_FILE=y
> +	depends on IMA_BUFFER_MEASURE =y
> +	default n
> +	help
> +		This measures the cmldine passed to kexec_file_load call.


IMA is policy based.  Neither of these Kconfig options should be
necessary.  Removing these Kconfig options, will remove the
unnecessary ifdefs throughout.

> \ No newline at end of file
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2aebb7984437..6d1335601672 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -416,6 +416,141 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	return process_measurement(file, buf, size, MAY_READ, func, 0);
>  }
>  
> +#ifdef CONFIG_IMA_BUFFER_MEASURE
> +/**
> + * ima_update_template_sig_field - update the sig field with the
> + * buffer passed.
> + * @entry - template entry that needs to be edited.
> + * @buff - biffer that needs to be added to the sig field
> + * @size - length of the buffer
> + * 
> + * update the sig field of the template to contain the buffer.
> + * 
> +*/
> +void ima_update_template_sig_field(struct ima_template_entry *entry,
> +			const void *buff, loff_t size)

Each template field is defined in ima_template.c with operations to
initialize and display the field.  You can't just re-use an existing
field like this.

> +{
> +	int field_index = 0;
> +	struct buffer_data{
> +		uint8_t type;			/* xattr type */
> +		uint32_t buff_len;		/* Length of buffer added */
> +		char data[0];			/* Data buffer*/
> +	};
> +	struct buffer_data tmp_buff , *string_data = &tmp_buff;
> +
> +	string_data = kzalloc(size + sizeof(*string_data), GFP_KERNEL);
> +	if(IS_ERR(string_data))
> +		goto out;
> +
> +	if(!entry || !buff || size ==0)
> +		goto out;
> +
> +	string_data->type = IMA_BUFFER_ENCODED;
> +	string_data->buff_len = size;
> +	memcpy(string_data->data, buff, size);
> +
> +	for(field_index = 0; field_index < entry->template_desc->num_fields ;
> +			field_index++)
> +	{
> +		if(strcmp(entry->template_desc->fields[field_index]->field_id, "sig")
> +			 == 0)
> +		{
> +			entry->template_data[field_index].len =
> +					sizeof(*string_data) + string_data->buff_len;
> +			entry->template_data[field_index].data =
> +					kzalloc(entry->template_data[field_index].len, GFP_KERNEL);
> +			if(IS_ERR(entry->template_data[field_index].data))
> +			{
> +				entry->template_data[field_index].len = 0;
> +				kfree(entry->template_data[field_index].data);
> +				goto out;
> +			}
> +			memcpy(entry->template_data[field_index].data, string_data ,
> +				entry->template_data[field_index].len);
> +		}
> +		
> +	}
> +
> +out:
> +	kfree(string_data);
> +}
> +
> +/**
> + * ima_add_buffer_measure - Measure the buffer passed to ima log.
> + * (Instead of using the file hash the buffer hash is used).
> + * @buff - The buffer that needs to be added to the log
> + * @size - size of buffer(in bytes)
> + * @id - buffer id, this is differentiator for the various buffers
> + * that can be measured.
> + * 
> + * The buffer passed is added to the ima logs.
> + * If the sig template is used, then the sig field contains the buffer.
> + * 
> + * On success return 0.
> + * On error cases surface errors from ima calls.
> + */
> +int ima_add_buffer_measure(const void *buff, loff_t size,
> +				 enum buffer_id id)

Initially you might want to only measure the kexec boot command line,
but will you ever want to verify or audit log the boot command line
hash?  Perhaps LSMs would be interested in the boot command line.
 Should this be an LSM hook?

Mimi

> +{
> +	int ret = -EINVAL;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, NULL,
> +					    NULL, 0, NULL};
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +
> +	int violation = 0;
> +	char *name = NULL;
> +
> +	if (!buff || size ==0)
> +		goto err_out;
> +
> +	switch (id) {
> +		case KEXEC_CMDLINE:
> +			name = "kexec-cmdline";
> +			break;
> +		default:
> +			name = "unknown";
> +			goto err_out;
> +	}
> +
> +	memset(iint, 0, sizeof(*iint));
> +	memset(&hash, 0, sizeof(hash));
> +
> +	event_data.filename = name;
> +
> +	iint->ima_hash = &hash.hdr;
> +	iint->ima_hash->algo = ima_hash_algo;
> +	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +	ret = ima_calc_buffer_hash(buff, size, iint->ima_hash);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ima_update_template_sig_field(entry, buff, size);
> +
> +	ret = ima_store_template(entry, violation, NULL,
> +					buff, CONFIG_IMA_MEASURE_PCR_IDX);
> +	if (ret < 0) {
> +		ima_free_template_entry(entry);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	pr_err("Error in adding buffer measure: %d\n", ret);
> +	return ret;
> +}
> +#endif
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 24520b4ef3b0..85efa38b9f83 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -58,6 +58,9 @@ enum evm_ima_xattr_type {
>  	EVM_XATTR_HMAC,
>  	EVM_IMA_XATTR_DIGSIG,
>  	IMA_XATTR_DIGEST_NG,
> +#ifdef CONFIG_IMA_BUFFER_MEASURE
> +	IMA_BUFFER_ENCODED,
> +#endif
>  	IMA_XATTR_LAST
>  };
>  

