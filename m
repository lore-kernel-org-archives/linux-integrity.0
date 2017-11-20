Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdKTXtw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:49:52 -0500
Date: Tue, 21 Nov 2017 01:49:47 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
 <20171120231728.GR29075@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120231728.GR29075@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 20, 2017 at 04:17:28PM -0700, Jason Gunthorpe wrote:
> On Mon, Nov 20, 2017 at 02:45:23PM -0800, Guenter Roeck wrote:
> 
> > "tpm: Enable sysfs support for TPM2 devices
> > 
> > Access to chip->ops on TPM2 devices requires an explicit lock,
> > since the pointer is set to NULL in tpm_class_shutdown().
> > Implement that lock for sysfs access functions and enable sysfs
> > support for TPM2 devices."
> 
> Wait.. one of the reasons we let it go with no sysfs for so long was
> because there was not many sysfs files that were compatible with tpm2?
> 
> For TPM2 we have sort of had an API break of sorts from TPM1 in a
> couple places around sysfs, and I would like to not re-introduce any
> badly designed sysfs files for TPM2..
> 
> So.. When you apply this patch, what changes actually happen in the
> sysfs directory?
> 
> Jason

Oops. I was too quick. This will cause all the TPM 1.x attributes
added also for TPM 2.0. That's not a great idea. The tpm_dev_group
should be only assigned for TPM 1.x devices. This commit should only
enable addition of sysfs attributes for TPM 2.0 devices.

/Jarkko
