Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbdJOOIh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Oct 2017 10:08:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9FE8Tia012845
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:08:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dm79wtysp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:08:37 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 15 Oct 2017 15:08:34 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9FE8VSA22741218
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 14:08:32 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9FE8Uhp014065
        for <linux-integrity@vger.kernel.org>; Mon, 16 Oct 2017 01:08:30 +1100
Subject: Re: [PATCH V3 2/2] Add a bprm_interpreted security hook and call
 into IMA from it
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: james.l.morris@oracle.com, keescook@chromium.org, oleg@redhat.com
Date: Sun, 15 Oct 2017 10:08:25 -0400
In-Reply-To: <20171011191218.5274-2-mjg59@google.com>
References: <20171011191218.5274-1-mjg59@google.com>
         <20171011191218.5274-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508076505.3426.139.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-11 at 12:12 -0700, Matthew Garrett wrote:
> IMA has support for validating files during execution using the
> bprm_check functionality. However, this is called before new credentials
> have been applied to the task. The previous patch in this series added
> an additional IMA check in the bprm_committed_creds hook - however, if a
> file is handled by binfmt_misc or binfmt_script (or, in an extremely
> unlikely corner case, binfmt_em86), only the interpreter will be
> appraised since bprm_committed_creds is never called for the initial
> executable.

Even with this additional patch, there are still potentially missing measurements/appraisals as search_binary_handler is exported.  The original search_binary_handler is called twice, once for the original file and again for the interpreter.  With these patches, the security hooks are deferred, requiring calls in the specific binary handler.

For your usecase scenario this might be enough, but for the general case the security_bprm_check hooks would still be needed.

> This patch adds an additional bprm_interpreted hook and calls it from
> the end of the relevant binfmt implementations. It is effectively
> identical to the bprm_committed_creds hook, except that bprm->file
> points to the initial file rather than to the interpreter.

->load_binary() seems to do a lot more than just load the binary
handler.  There's a comment in load_elf_binary(), before the call to
arch_check_elf(), indicating this is the last opportunity to reject
the ELF.  Are you sure that deferring verifying the initial file like
this isn't too late?

Mimi

> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/binfmt_em86.c          | 31 ++++++++++++++++++++++---------
>  fs/binfmt_misc.c          | 11 +++++++----
>  fs/binfmt_script.c        | 45 +++++++++++++++++++++++++++++++--------------
>  include/linux/lsm_hooks.h |  7 +++++++
>  include/linux/security.h  |  1 +
>  security/security.c       | 11 +++++++++++
>  6 files changed, 79 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
> index dd2d3f0cd55d..e954ec123d27 100644
> --- a/fs/binfmt_em86.c
> +++ b/fs/binfmt_em86.c
> @@ -26,7 +26,7 @@ static int load_em86(struct linux_binprm *bprm)
>  {
>  	const char *i_name, *i_arg;
>  	char *interp;
> -	struct file * file;
> +	struct file *file, *old;
>  	int retval;
>  	struct elfhdr	elf_ex;
> 
> @@ -47,8 +47,7 @@ static int load_em86(struct linux_binprm *bprm)
>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>  		return -ENOENT;
> 
> -	allow_write_access(bprm->file);
> -	fput(bprm->file);
> +	old = bprm->file;
>  	bprm->file = NULL;
> 
>  	/* Unlike in the script case, we don't have to do any hairy
> @@ -72,11 +71,13 @@ static int load_em86(struct linux_binprm *bprm)
>  	bprm->argc++;
>  	if (i_arg) {
>  		retval = copy_strings_kernel(1, &i_arg, bprm);
> -		if (retval < 0) return retval; 
> +		if (retval < 0)
> +			goto ret;
>  		bprm->argc++;
>  	}
>  	retval = copy_strings_kernel(1, &i_name, bprm);
> -	if (retval < 0)	return retval;
> +	if (retval < 0)
> +		goto ret;
>  	bprm->argc++;
> 
>  	/*
> @@ -85,16 +86,28 @@ static int load_em86(struct linux_binprm *bprm)
>  	 * space, and we don't need to copy it.
>  	 */
>  	file = open_exec(interp);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> +	if (IS_ERR(file)) {
> +		retval = PTR_ERR(file);
> +		goto ret;
> +	}
> 
>  	bprm->file = file;
> 
>  	retval = prepare_binprm(bprm);
>  	if (retval < 0)
> -		return retval;
> +		goto ret;
> 
> -	return search_binary_handler(bprm);
> +	retval = search_binary_handler(bprm);
> +	if (retval < 0)
> +		goto ret;
> +
> +	bprm->file = old;
> +	retval = security_bprm_interpreted(bprm);
> +	bprm->file = file;
> +ret:
> +	allow_write_access(old);
> +	fput(old);
> +	return retval;
>  }
> 
>  static struct linux_binfmt em86_format = {
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 2a46762def31..81e6e02348f9 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -130,7 +130,7 @@ static Node *check_file(struct linux_binprm *bprm)
>  static int load_misc_binary(struct linux_binprm *bprm)
>  {
>  	Node *fmt;
> -	struct file *interp_file = NULL;
> +	struct file *interp_file = NULL, *old = bprm->file;
>  	int retval;
>  	int fd_binary = -1;
> 
> @@ -175,7 +175,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  		   regardless of the interpreter's permissions */
>  		would_dump(bprm, bprm->file);
> 
> -		allow_write_access(bprm->file);
>  		bprm->file = NULL;
> 
>  		/* mark the bprm that fd should be passed to interp */
> @@ -183,8 +182,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  		bprm->interp_data = fd_binary;
> 
>  	} else {
> -		allow_write_access(bprm->file);
> -		fput(bprm->file);
>  		bprm->file = NULL;
>  	}
>  	/* make argv[1] be the path to the binary */
> @@ -236,7 +233,13 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	if (retval < 0)
>  		goto error;
> 
> +	bprm->file = old;
> +	retval = security_bprm_interpreted(bprm);
> +	bprm->file = interp_file;
>  ret:
> +	allow_write_access(old);
> +	if (fd_binary < 0)
> +		fput(old);
>  	dput(fmt->dentry);
>  	return retval;
>  error:
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 7cde3f46ad26..f2bd2aa15702 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -13,12 +13,13 @@
>  #include <linux/file.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
> +#include <linux/security.h>
> 
>  static int load_script(struct linux_binprm *bprm)
>  {
>  	const char *i_arg, *i_name;
>  	char *cp;
> -	struct file *file;
> +	struct file *file, *old;
>  	int retval;
> 
>  	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
> @@ -38,8 +39,7 @@ static int load_script(struct linux_binprm *bprm)
>  	 * Sorta complicated, but hopefully it will work.  -TYT
>  	 */
> 
> -	allow_write_access(bprm->file);
> -	fput(bprm->file);
> +	old = bprm->file;
>  	bprm->file = NULL;
> 
>  	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
> @@ -54,8 +54,11 @@ static int load_script(struct linux_binprm *bprm)
>  			break;
>  	}
>  	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
> -	if (*cp == '\0')
> -		return -ENOEXEC; /* No interpreter name found */
> +	if (*cp == '\0') {
> +		retval = -ENOEXEC; /* No interpreter name found */
> +		goto ret;
> +	}
> +
>  	i_name = cp;
>  	i_arg = NULL;
>  	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
> @@ -76,37 +79,51 @@ static int load_script(struct linux_binprm *bprm)
>  	 */
>  	retval = remove_arg_zero(bprm);
>  	if (retval)
> -		return retval;
> +		goto ret;
>  	retval = copy_strings_kernel(1, &bprm->interp, bprm);
>  	if (retval < 0)
> -		return retval;
> +		goto ret;
>  	bprm->argc++;
>  	if (i_arg) {
>  		retval = copy_strings_kernel(1, &i_arg, bprm);
>  		if (retval < 0)
> -			return retval;
> +			goto ret;
>  		bprm->argc++;
>  	}
>  	retval = copy_strings_kernel(1, &i_name, bprm);
>  	if (retval)
> -		return retval;
> +		goto ret;
>  	bprm->argc++;
>  	retval = bprm_change_interp(i_name, bprm);
>  	if (retval < 0)
> -		return retval;
> +		goto ret;
> 
>  	/*
>  	 * OK, now restart the process with the interpreter's dentry.
>  	 */
>  	file = open_exec(i_name);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> +	if (IS_ERR(file)) {
> +		retval = PTR_ERR(file);
> +		goto ret;
> +	}
> 
>  	bprm->file = file;
>  	retval = prepare_binprm(bprm);
>  	if (retval < 0)
> -		return retval;
> -	return search_binary_handler(bprm);
> +		goto ret;
> +	retval = search_binary_handler(bprm);
> +	if (retval)
> +		goto ret;
> +	/*
> +	 * Allow for validation of the script as well as the interpreter
> +	 */
> +	bprm->file = old;
> +	retval = security_bprm_interpreted(bprm);
> +	bprm->file = file;
> +ret:
> +	allow_write_access(old);
> +	fput(old);
> +	return retval;
>  }
> 
>  static struct linux_binfmt script_format = {
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c9258124e417..fd23b4098098 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -75,6 +75,11 @@
>   *	linux_binprm structure.  This hook is a good place to perform state
>   *	changes on the process such as clearing out non-inheritable signal
>   *	state.  This is called immediately after commit_creds().
> + * @bprm_interpreted:
> + *	Validate the credentials of an executable that was interpreted via
> + *	binfmt_misc or binfmt_script. This occurs after the new credentials
> + *	have been committed to @current->cred, but @bprm->file points to the
> + *	original file rather than the interpreter that was used to execute it.
>   *
>   * Security hooks for filesystem operations.
>   *
> @@ -1383,6 +1388,7 @@ union security_list_options {
>  	int (*bprm_check_security)(struct linux_binprm *bprm);
>  	void (*bprm_committing_creds)(struct linux_binprm *bprm);
>  	void (*bprm_committed_creds)(struct linux_binprm *bprm);
> +	int (*bprm_interpreted)(struct linux_binprm *bprm);
> 
>  	int (*sb_alloc_security)(struct super_block *sb);
>  	void (*sb_free_security)(struct super_block *sb);
> @@ -1703,6 +1709,7 @@ struct security_hook_heads {
>  	struct list_head bprm_check_security;
>  	struct list_head bprm_committing_creds;
>  	struct list_head bprm_committed_creds;
> +	struct list_head bprm_interpreted;
>  	struct list_head sb_alloc_security;
>  	struct list_head sb_free_security;
>  	struct list_head sb_copy_data;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ad970a4f19f6..e48c38379c64 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -233,6 +233,7 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>  int security_bprm_committed_creds(struct linux_binprm *bprm);
> +int security_bprm_interpreted(struct linux_binprm *bprm);
>  int security_sb_alloc(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  int security_sb_copy_data(char *orig, char *copy);
> diff --git a/security/security.c b/security/security.c
> index c2c5017e3477..6b9cb108ff61 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -352,6 +352,17 @@ int security_bprm_committed_creds(struct linux_binprm *bprm)
>  	return ima_creds_check(bprm);
>  }
> 
> +int security_bprm_interpreted(struct linux_binprm *bprm)
> +{
> +	int ret;
> +
> +	ret = call_int_hook(bprm_interpreted, 0, bprm);
> +	if (ret)
> +		return ret;
> +
> +	return ima_creds_check(bprm);
> +}
> +
>  int security_sb_alloc(struct super_block *sb)
>  {
>  	return call_int_hook(sb_alloc_security, 0, sb);
