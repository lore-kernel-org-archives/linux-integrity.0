Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6283 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeE3LBR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 07:01:17 -0400
Date: Wed, 30 May 2018 14:01:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180530110112.GB14905@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
 <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > Ouch o_O Do you have a fixes tag for this one?
> > 
> 
> This one is quite tricky.
> The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> and the code back then was in drivers/char/tpm/tpm-interface.c file
> 
> Then there were two other commits that moved the code around:
> afdba32e2a9ea (tpm: Pull everything related to /dev/tpmX into tpm-dev.c)
> which moved it from drivers/char/tpm/tpm-interface.c into drivers/char/tpm/tpm-dev.c
> 
> and last one, ecb38e2f521b0 (tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c)
> which moved it from drivers/char/tpm/tpm-dev.c into tpm-common-dev.c
> 
> I have no idea how to tag it. Maybe we can use:
> Fixes: ecb38e2f521b0 ("tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c")
> 
> And then it probably needs to be back ported manually all the way back to abce9ac292e13.
> 
> Thanks,
> -- 
> Tadeusz

Thank you. I'll cc this to stable.

/Jarkko
