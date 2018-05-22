Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20992 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbeEVU0d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 16:26:33 -0400
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180522200723.GE3311@ziepe.ca>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <efc62fe0-dee5-9b40-4e6e-247c28993d87@intel.com>
Date: Tue, 22 May 2018 13:26:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180522200723.GE3311@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/22/2018 01:07 PM, Jason Gunthorpe wrote:
> I didn't see any reasn for data_pending to be an atomic, ever use case
> is near the buffer_mutex, can you respin this patch to just drop that
> completely and only manipulate it within the lock?

Yes, will do.
Thanks,
-- 
Tadeusz
