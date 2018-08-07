Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbeHGVZ7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Aug 2018 17:25:59 -0400
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
To: Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: jarkko.sakkinen@linux.intel.com, flihp@twobit.us,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
 <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
 <1533596748.3159.19.camel@HansenPartnership.com>
 <20180807182013.GC4960@ziepe.ca>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <83e71fcc-d97d-e690-08c2-939458c7fe0c@intel.com>
Date: Tue, 7 Aug 2018 12:09:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180807182013.GC4960@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 08/07/2018 11:20 AM, Jason Gunthorpe wrote:
> Doesn't lockdep complain when locks are left held after returning to
> user space? Even if it doesn't, that is a pretty ugly thing to do.

I didn't notice anything from lockdep during my testing,
but I will change it to release the lock before returning.
Will send v4 soon.
Thanks,
-- 
Tadeusz
