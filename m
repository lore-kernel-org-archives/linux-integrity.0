Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35465 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeFAOh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 10:37:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so11045223pge.2
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 07:37:59 -0700 (PDT)
Date: Fri, 1 Jun 2018 08:37:56 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for nonblocking operation
Message-ID: <20180601143756.GA1408@ziepe.ca>
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 31, 2018 at 04:29:09PM -0700, Tadeusz Struk wrote:
> The TCG SAPI specification [1] defines a set of functions, which allows
> applications to use the TPM device in either blocking or non-blocking fashion.
> Each command defined by the specification has a corresponding
> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> mode of operation. Currently the driver supports only blocking calls, which
> doesn't allow asynchronous operation. This patch changes it and adds support
> for nonblocking write and a new poll function to enable applications using
> the API as designed by the spec.
> The new functionality can be tested using standard TPM tools implemented
> in [2], with modified TCTI from [3].
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
> [2] https://github.com/tpm2-software/tpm2-tools
> [3] https://github.com/tstruk/tpm2-tss/tree/async
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
>  drivers/char/tpm/tpm-dev-common.c |  170 +++++++++++++++++++++++++++++++------
>  drivers/char/tpm/tpm-dev.c        |    1 
>  drivers/char/tpm/tpm-dev.h        |    9 +-
>  drivers/char/tpm/tpmrm-dev.c      |    1 
>  4 files changed, 149 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index e4a04b2d3c32..0f3378b5198a 100644
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -17,11 +17,46 @@
>   * License.
>   *
>   */
> +#include <linux/poll.h>
> +#include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
>  #include "tpm.h"
>  #include "tpm-dev.h"
>  
> +static DECLARE_WAIT_QUEUE_HEAD(tpm_dev_wait);
> +static struct workqueue_struct *tpm_dev_wq;
> +
> +struct tpm_dev_work {
> +	struct work_struct work;
> +	struct file_priv *priv;
> +	struct tpm_space *space;
> +	ssize_t resp_size;
> +	bool nonblocking;
> +};

There can only be one operation going at once, so why not put this in
the file_priv? Which might be needed because..

> +static void tpm_async_work(struct work_struct *work)
> +{
> +	struct tpm_dev_work *tpm_work =
> +		container_of(work, struct tpm_dev_work, work);
> +	struct file_priv *priv = tpm_work->priv;

What prevents priv from being freed at this point?

> @@ -82,10 +120,11 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off, struct tpm_space *space)
>  {
>  	struct file_priv *priv = file->private_data;
> -	size_t in_size = size;
> -	ssize_t out_size;
> +	struct tpm_dev_work *work;
> +	DECLARE_WAITQUEUE(wait, current);
> +	int ret = 0;

There is not really any reason to change the flow for the blocking
case, maybe just call the work function directly?

Also, it is getting confusing to have two things called 'work' (the
timer and the async executor)

> +__poll_t tpm_common_poll(struct file *file, poll_table *wait)
> +{
> +	struct file_priv *priv = file->private_data;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &tpm_dev_wait, wait);

Why a global wait queue? Should be in file_priv I'd think.

> +static int __init tpm_dev_common_init(void)
> +{
> +	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> +
> +	return !tpm_dev_wq ? -ENOMEM : 0;
> +}
> +
> +late_initcall(tpm_dev_common_init);
> +
> +static void __exit tpm_dev_common_exit(void)
> +{
> +	destroy_workqueue(tpm_dev_wq);
> +}

I wonder if it is worth creating this when the first file is
opened.. Lots of systems have TPMs but few use the userspace..

Jason
