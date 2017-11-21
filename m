Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33158 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdKUS3C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 13:29:02 -0500
Date: Tue, 21 Nov 2017 10:28:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171121182858.GA4895@roeck-us.net>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
 <20171120231728.GR29075@ziepe.ca>
 <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 01:49:47AM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 20, 2017 at 04:17:28PM -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 20, 2017 at 02:45:23PM -0800, Guenter Roeck wrote:
> > 
> > > "tpm: Enable sysfs support for TPM2 devices
> > > 
> > > Access to chip->ops on TPM2 devices requires an explicit lock,
> > > since the pointer is set to NULL in tpm_class_shutdown().
> > > Implement that lock for sysfs access functions and enable sysfs
> > > support for TPM2 devices."
> > 
> > Wait.. one of the reasons we let it go with no sysfs for so long was
> > because there was not many sysfs files that were compatible with tpm2?
> > 
> > For TPM2 we have sort of had an API break of sorts from TPM1 in a
> > couple places around sysfs, and I would like to not re-introduce any
> > badly designed sysfs files for TPM2..
> > 
> > So.. When you apply this patch, what changes actually happen in the
> > sysfs directory?
> > 
> > Jason
> 
> Oops. I was too quick. This will cause all the TPM 1.x attributes
> added also for TPM 2.0. That's not a great idea. The tpm_dev_group
> should be only assigned for TPM 1.x devices. This commit should only
> enable addition of sysfs attributes for TPM 2.0 devices.
> 

After having a closer look, I agree. Sorry for my naivite.

I'll split the patch into two parts, and only add (hopefully)
non-controversial tpm2 attributes for now (which I think is durations
and timeouts). Or, in other words, I'll split the attributes into
two groups - one generic and one for tpm1.

Thanks,
Guenter
