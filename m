Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:15850 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeFYQYh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jun 2018 12:24:37 -0400
Message-ID: <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 25 Jun 2018 19:24:32 +0300
In-Reply-To: <20180624205202.6597-1-tomas.winkler@intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-06-24 at 23:52 +0300, Tomas Winkler wrote:
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
> A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
> TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> tpm spaces and locality request recursive calls to tpm_transmit().
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
> Cc: stable@vger.kernel.org
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Please:

1. Remove NESTED.
2. Where you need call RAW | UNLOCKED.
3. Do not add __ prefix.

Should be simple changes to do.

/Jarkko
