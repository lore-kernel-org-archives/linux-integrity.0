Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbeJGIGl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Oct 2018 04:06:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9710tDD164227
        for <linux-integrity@vger.kernel.org>; Sat, 6 Oct 2018 21:01:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2my83yg0qm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 06 Oct 2018 21:01:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 7 Oct 2018 02:01:16 +0100
Subject: Re: [PATCH] Open a new file instance if no read permissions on files
From: Mimi Zohar <zohar@linux.ibm.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date: Sat, 06 Oct 2018 21:01:01 -0400
In-Reply-To: <20181005214213.ickkfgu5a7tzzenk@merlin>
References: <20181005214213.ickkfgu5a7tzzenk@merlin>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538874061.4914.16.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-05 at 16:42 -0500, Goldwyn Rodrigues wrote:
> Open a new file instance as opposed to changing file->f_mode when
> the file is not readable.
> 
> This is done to accomodate overlayfs stacked file operations change. The
> real struct file is hidden behind the overlays struct file. So, any
> file->f_mode manipulations are not reflected on the real struct file.
> Open the file again, read andcalculate the hash.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 7e7e7e7c250a..3848cf208792 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -210,7 +210,7 @@ static int ima_calc_file_hash_atfm(struct file *file,
>  {
>  	loff_t i_size, offset;
>  	char *rbuf[2] = { NULL, };
> -	int rc, read = 0, rbuf_len, active = 0, ahash_rc = 0;
> +	int rc, rbuf_len, active = 0, ahash_rc = 0;
>  	struct ahash_request *req;
>  	struct scatterlist sg[1];
>  	struct crypto_wait wait;
> @@ -257,11 +257,6 @@ static int ima_calc_file_hash_atfm(struct file *file,
>  					  &rbuf_size[1], 0);
>  	}
>  
> -	if (!(file->f_mode & FMODE_READ)) {
> -		file->f_mode |= FMODE_READ;
> -		read = 1;
> -	}
> -
>  	for (offset = 0; offset < i_size; offset += rbuf_len) {
>  		if (!rbuf[1] && offset) {
>  			/* Not using two buffers, and it is not the first
> @@ -300,8 +295,6 @@ static int ima_calc_file_hash_atfm(struct file *file,
>  	/* wait for the last update request to complete */
>  	rc = ahash_wait(ahash_rc, &wait);
>  out3:
> -	if (read)
> -		file->f_mode &= ~FMODE_READ;
>  	ima_free_pages(rbuf[0], rbuf_size[0]);
>  	ima_free_pages(rbuf[1], rbuf_size[1]);
>  out2:
> @@ -336,7 +329,7 @@ static int ima_calc_file_hash_tfm(struct file *file,
>  {
>  	loff_t i_size, offset = 0;
>  	char *rbuf;
> -	int rc, read = 0;
> +	int rc;
>  	SHASH_DESC_ON_STACK(shash, tfm);
>  
>  	shash->tfm = tfm;
> @@ -357,11 +350,6 @@ static int ima_calc_file_hash_tfm(struct file *file,
>  	if (!rbuf)
>  		return -ENOMEM;
>  
> -	if (!(file->f_mode & FMODE_READ)) {
> -		file->f_mode |= FMODE_READ;
> -		read = 1;
> -	}
> -
>  	while (offset < i_size) {
>  		int rbuf_len;
>  
> @@ -378,8 +366,6 @@ static int ima_calc_file_hash_tfm(struct file *file,
>  		if (rc)
>  			break;
>  	}
> -	if (read)
> -		file->f_mode &= ~FMODE_READ;
>  	kfree(rbuf);
>  out:
>  	if (!rc)
> @@ -419,7 +405,7 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
>  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  {
>  	loff_t i_size;
> -	int rc;
> +	int read = 0, rc;
>  
>  	/*
>  	 * For consistency, fail file's opened with the O_DIRECT flag on
> @@ -431,15 +417,29 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
>  		return -EINVAL;
>  	}
>  
> +	if (!(file->f_mode & FMODE_READ)) {
> +		struct file *f;

I would define "struct file *f = file" above, at the beginning of
function, and "free(f)" below, without modifying "file".

> +		int flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT | O_NOCTTY | O_EXCL);

Doesn't O_RDONLY need to be added?
Please fix the line length.


> +		f = dentry_open(&file->f_path, flags, file->f_cred);
> +		if (IS_ERR(f))
> +			return PTR_ERR(f);
> +		read = 1;
> +		file = f;

With the above change, no need to modify "file".

Mimi

> +	}
> +
>  	i_size = i_size_read(file_inode(file));
>  
>  	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {
>  		rc = ima_calc_file_ahash(file, hash);
>  		if (!rc)
> -			return 0;
> +			goto out;
>  	}
>  
> -	return ima_calc_file_shash(file, hash);
> +	rc = ima_calc_file_shash(file, hash);
> +out:
> +	if (read)
> +		fput(file);
> +	return rc;
>  }
>  
>  /*
> 
