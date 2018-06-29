Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54018 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeF2Mah (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 08:30:37 -0400
Date: Fri, 29 Jun 2018 15:30:30 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Struk@linux.intel.com, Tadeusz <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180629123029.GA21735@linux.intel.com>
References: <20180628151333.14368-1-tomas.winkler@intel.com>
 <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 01:35:52PM +0300, Jarkko Sakkinen wrote:
> On Thu, 2018-06-28 at 18:13 +0300, Tomas Winkler wrote:
> > Fix tpm ptt initialization error:
> > tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> > 
> > We cannot use go_idle cmd_ready commands via runtime_pm handles
> > as with the introduction of localities this is no longer an optional
> > feature, while runtime pm can be not enabled.
> > Though cmd_ready/go_idle provides a power saving, it's also a part of
> > TPM2 protocol and should be called explicitly.
> > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > runtime pm support as it is not used by any driver.
> > 
> > When calling from nested context always use both flags:
> > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> > tpm spaces and locality request recursive calls to tpm_transmit().
> > TPM_TRANSMIT_RAW should never be used standalone as it will fail
> > on double locking. While TPM_TRANSMIT_UNLOCKED standalone should be
> > called from non-recursive locked contexts.
> > 
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > streamline tpm_try_transmit code.
> > 
> > tpm_crb no longer needs own power saving functions and can drop using
> > tpm_pm_suspend/resume.
> > 
> > This patch cannot be really separated from the locality fix.
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> > locality)
> > 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> > locality)
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Noticed that your author field is malformed (Should be "Tomas Winkler"
instead of "Winkler, Tomas") but I'll fix that.

/Jarkko
