Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37209 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFARRg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 13:17:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so3852703wmb.2
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 10:17:35 -0700 (PDT)
Date: Fri, 1 Jun 2018 11:17:31 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for nonblocking operation
Message-ID: <20180601171731.GF1408@ziepe.ca>
References: <152780934926.32219.7291994735609525171.stgit@tstruk-mobl1.jf.intel.com>
 <20180601143756.GA1408@ziepe.ca>
 <e631c9e7-fe2c-061b-fcb9-aea583285746@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e631c9e7-fe2c-061b-fcb9-aea583285746@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 01, 2018 at 09:55:52AM -0700, Tadeusz Struk wrote:
> On 06/01/2018 07:37 AM, Jason Gunthorpe wrote:
> >> +struct tpm_dev_work {
> >> +	struct work_struct work;
> >> +	struct file_priv *priv;
> >> +	struct tpm_space *space;
> >> +	ssize_t resp_size;
> >> +	bool nonblocking;
> >> +};
> > There can only be one operation going at once, so why not put this in
> > the file_priv? Which might be needed because..
> 
> I need the *space as well, which doesn't really belong to file_priv
> that's why I added this new struct. You are right the file_priv
> isn't really needed here. I used it to have the priv->data_pending
> but I can have just a ptr to data_pending in tpm_dev_work.

I mean in the sense that each file_priv can have exactly one async
work outstanding, so you can just add this struct to file_priv instead
of allocing it everytime..

Jason
