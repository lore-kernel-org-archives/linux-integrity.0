Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21876 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933000AbeCSVgG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 17:36:06 -0400
Date: Mon, 19 Mar 2018 23:35:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Philip Tricca <philip.b.tricca@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Should we handle TPM_RC_RETRY internally?
Message-ID: <20180319213536.GG14364@linux.intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
 <eaa8e31f-62cb-dcf0-a27f-87d993d2f3e4@redhat.com>
 <20180319044056.GD8769@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319044056.GD8769@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Mar 18, 2018 at 09:40:56PM -0700, Philip Tricca wrote:
> I can't say for sure but I'd imagine the implications of implementing a
> retry loop in the kernel are different than user space. We retry
> indefinitely but I would think having some bounded number of retries in
> the kernel would be prudent.

Yes, even if we would support handlig RC_RETRY we could not make promise
to the user space that this error code will never fall through.

/Jarkko
