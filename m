Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeFAQz6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 12:55:58 -0400
Subject: Re: [PATCH] tpm: add support for nonblocking operation
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180601143756.GA1408@ziepe.ca>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <e631c9e7-fe2c-061b-fcb9-aea583285746@intel.com>
Date: Fri, 1 Jun 2018 09:55:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180601143756.GA1408@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/01/2018 07:37 AM, Jason Gunthorpe wrote:
>> +struct tpm_dev_work {
>> +	struct work_struct work;
>> +	struct file_priv *priv;
>> +	struct tpm_space *space;
>> +	ssize_t resp_size;
>> +	bool nonblocking;
>> +};
> There can only be one operation going at once, so why not put this in
> the file_priv? Which might be needed because..

I need the *space as well, which doesn't really belong to file_priv
that's why I added this new struct. You are right the file_priv
isn't really needed here. I used it to have the priv->data_pending
but I can have just a ptr to data_pending in tpm_dev_work.

> 
>> +static void tpm_async_work(struct work_struct *work)
>> +{
>> +	struct tpm_dev_work *tpm_work =
>> +		container_of(work, struct tpm_dev_work, work);
>> +	struct file_priv *priv = tpm_work->priv;
> What prevents priv from being freed at this point?

The flush_work() that is currently missing from tpm_common_release() :)

> 
>> @@ -82,10 +120,11 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>>  			 size_t size, loff_t *off, struct tpm_space *space)
>>  {
>>  	struct file_priv *priv = file->private_data;
>> -	size_t in_size = size;
>> -	ssize_t out_size;
>> +	struct tpm_dev_work *work;
>> +	DECLARE_WAITQUEUE(wait, current);
>> +	int ret = 0;
> There is not really any reason to change the flow for the blocking
> case, maybe just call the work function directly?

That was my first idea, but then I thought it mighty be better to
have the same flow for both blocking and non-blocking.
I'm fine with doing it either way.

> 
> Also, it is getting confusing to have two things called 'work' (the
> timer and the async executor)
> 
>> +__poll_t tpm_common_poll(struct file *file, poll_table *wait)
>> +{
>> +	struct file_priv *priv = file->private_data;
>> +	__poll_t mask = 0;
>> +
>> +	poll_wait(file, &tpm_dev_wait, wait);
> Why a global wait queue? Should be in file_priv I'd think.

Right, I will move it to file_priv.

> 
>> +static int __init tpm_dev_common_init(void)
>> +{
>> +	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
>> +
>> +	return !tpm_dev_wq ? -ENOMEM : 0;
>> +}
>> +
>> +late_initcall(tpm_dev_common_init);
>> +
>> +static void __exit tpm_dev_common_exit(void)
>> +{
>> +	destroy_workqueue(tpm_dev_wq);
>> +}
> I wonder if it is worth creating this when the first file is
> opened.. Lots of systems have TPMs but few use the userspace.

I can do that.

Thanks for review Jason. I will send a v2 soon.
-- 
Tadeusz
