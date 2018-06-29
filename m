Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:41528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbeF2Kf7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 06:35:59 -0400
Message-ID: <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
Subject: Re: [PATCH v8] tpm: separate cmd_ready/go_idle from runtime_pm
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Struk@vger.kernel.org, Tadeusz <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 29 Jun 2018 13:35:52 +0300
In-Reply-To: <20180628151333.14368-1-tomas.winkler@intel.com>
References: <20180628151333.14368-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-06-28 at 18:13 +0300, Tomas Winkler wrote:
> Fix tpm ptt initialization error:
> tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> 
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides a power saving, it's also a part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> When calling from nested context always use both flags:
> TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> tpm spaces and locality request recursive calls to tpm_transmit().
> TPM_TRANSMIT_RAW should never be used standalone as it will fail
> on double locking. While TPM_TRANSMIT_UNLOCKED standalone should be
> called from non-recursive locked contexts.
> 
> New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> streamline tpm_try_transmit code.
> 
> tpm_crb no longer needs own power saving functions and can drop using
> tpm_pm_suspend/resume.
> 
> This patch cannot be really separated from the locality fix.
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> 
> 
> Cc: stable@vger.kernel.org
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
