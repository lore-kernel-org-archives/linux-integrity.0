Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61024 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdKZN4r (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 08:56:47 -0500
Date: Sun, 26 Nov 2017 15:56:41 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add explicit chip->ops locking for sysfs attributes.
Message-ID: <20171126135641.szdrrh2szzfowgew@linux.intel.com>
References: <1510867501-9498-1-git-send-email-linux@roeck-us.net>
 <20171120221323.252ki4nmmrymnty6@linux.intel.com>
 <20171120224523.GA26294@roeck-us.net>
 <20171120231728.GR29075@ziepe.ca>
 <20171120234947.zd5bekvqg5z5rp3i@linux.intel.com>
 <20171121182858.GA4895@roeck-us.net>
 <20171121185856.GG18272@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171121185856.GG18272@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 11:58:56AM -0700, Jason Gunthorpe wrote:
> On Tue, Nov 21, 2017 at 10:28:58AM -0800, Guenter Roeck wrote:
> 
> > I'll split the patch into two parts, and only add (hopefully)
> > non-controversial tpm2 attributes for now (which I think is durations
> > and timeouts). Or, in other words, I'll split the attributes into
> > two groups - one generic and one for tpm1.
> 
> Ok. Please look at new attributes you wish to add for tpm2 and see if
> they meet the modern sysfs sensibility of one value per file, etc.
> 
> Jason

In general: if something can be retrieved through /dev/tpm0, there is no
any sane reason to have a sysfs attribute for such.

/Jarkko
