Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36273 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbdK0QC6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Nov 2017 11:02:58 -0500
Date: Mon, 27 Nov 2017 08:02:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171127160255.GA16884@roeck-us.net>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
 <20171120231728.GR29075@ziepe.ca>
 <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
 <20171121182858.GA4895@roeck-us.net>
 <20171121185856.GG18272@ziepe.ca>
 <20171126135641.szdrrh2szzfowgew@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171126135641.szdrrh2szzfowgew@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Nov 26, 2017 at 03:56:41PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 21, 2017 at 11:58:56AM -0700, Jason Gunthorpe wrote:
> > On Tue, Nov 21, 2017 at 10:28:58AM -0800, Guenter Roeck wrote:
> > 
> > > I'll split the patch into two parts, and only add (hopefully)
> > > non-controversial tpm2 attributes for now (which I think is durations
> > > and timeouts). Or, in other words, I'll split the attributes into
> > > two groups - one generic and one for tpm1.
> > 
> > Ok. Please look at new attributes you wish to add for tpm2 and see if
> > they meet the modern sysfs sensibility of one value per file, etc.
> > 
> > Jason
> 
> In general: if something can be retrieved through /dev/tpm0, there is no
> any sane reason to have a sysfs attribute for such.
> 

If I understand correctly, /dev/tpmX can be used to send any TPM command
to the chip. Given that, I translate your statement to mean that no sysfs
attribute will be accepted which sends a TPM command to the chip. This in
turn means that there is no neded to protect sysfs attributes with a lock
since any sysfs attribute requiring that lock will be rejected.

Thanks for the clarification. Please consider this patch abandoned.
It might be worthwhile mentioning that restriction in the code though -
the comment stating that TPM2 sysfs accesses are disabled due to lack
of locking is obvioulsy incorrect.

Guenter
