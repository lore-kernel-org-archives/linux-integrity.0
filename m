Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:30223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932800AbeFURRv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 13:17:51 -0400
Date: Thu, 21 Jun 2018 20:17:46 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        James.Bottomley@HansenPartnership.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
Message-ID: <20180621171746.GJ11859@linux.intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
 <20180619131046.GC5609@linux.intel.com>
 <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jun 19, 2018 at 05:45:35PM -0700, Tadeusz Struk wrote:
> Hi Jarkko,
> Thanks for reviewing the patch.
> There are applications/frameworks where a worker thread is not an option.
> Take for example the IoT use-cases and frameworks like IoT.js, or "Node.js for IoT".
> They are all single threaded, event-driven frameworks, using non-blocking I/O as the base of their processing model.
> Similarly embedded applications, which are basically just a single threaded event loop, quite often don't use threads because of resources constrains.
> 
> If your concern is that user space will not adopt to this, I can say that TSS library [1] is currently blocked on this feature, and we can not enable some of the use-cases mentioned above because of this.
> 
> Thanks,
> Tadeusz
> 
> [1] https://github.com/tpm2-software/tpm2-tss

I put this into "mathematical" terms. TPM is by nature is blocking. It
does not scale this way so you are essentially just simulating
non-blocking behaviour.

/Jarkko
