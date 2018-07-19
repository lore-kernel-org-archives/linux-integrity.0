Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbeGSU5N (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Jul 2018 16:57:13 -0400
Subject: Re: [PATCH] tpm: add support for partial reads
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <1532020750.5396.4.camel@HansenPartnership.com>
 <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
 <1532026030.3198.2.camel@HansenPartnership.com>
 <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
 <1532029979.3198.4.camel@HansenPartnership.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <0b9f0bb5-6620-0499-6680-5ec595167f23@intel.com>
Date: Thu, 19 Jul 2018 13:12:19 -0700
MIME-Version: 1.0
In-Reply-To: <1532029979.3198.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/19/2018 12:52 PM, James Bottomley wrote:
> The ABI break is the error case as I outlined above.  We can't assume
> everyone uses the current interface without getting an error and one
> error and your hosed is a nasty failure case to change the interface
> to. 

Well, if there is a broken application out there that doesn't work today
it will not work after this change neither.

> Plus, if you assume everyone is passing 4k buffers, why would you
> even need the fragmentation case?

So that people don't need to do this anymore and we can run a
spec compliant TCTI on top of /dev/tpm<N>.

> 
>>> It might be possible to layer the behaviour you want compatibly
>>> into the current device structure (say an ioctl to switch to the
>>> fragment behaviour) but I've got to ask why we'd go to the
>>> complexity without a use case?
>> New IOCTL would add extra complexity, which isn't necessary.
> So what's wrong with fragmenting in the layer above the device driver
> (in userspace) and not actually changing the kernel?

Because it is much easier to implement in the driver, and
we can run a spec compliant TCTI on top of /dev/tpm<N>.

Thanks,
-- 
Tadeusz
