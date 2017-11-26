Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbdKZOOL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 09:14:11 -0500
Date: Sun, 26 Nov 2017 16:14:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171126141407.mdgabnlxu6ycc65b@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 01:49:23PM +0100, Javier Martinez Canillas wrote:
> Ok. Thanks a lot for your feedback. I already had that patch but didn't want
> to post it before knowing your opinion, I'll drop it now.
> 
> Philip,
> 
> I think this means that we can now fix this in user-space then? That was in
> fact my first suggestion in the filed tpm2-tools issue.

Thanks for anyway putting that patch out. I'll investigate it with time
and reconsider my position.

Philip, can you share your view. Adding also James.

/Jarkko
