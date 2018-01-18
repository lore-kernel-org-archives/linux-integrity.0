Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23187 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754513AbeARSpP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:45:15 -0500
Date: Thu, 18 Jan 2018 20:45:10 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] tpm-chip: Export TPM device to user space even
 when startup failed
Message-ID: <20180118184510.zamelyx7c7fo3alh@linux.intel.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-4-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214160614.11808-4-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:06:14PM +0100, Alexander Steffen wrote:
> When one of the commands during the auto_startup sequences does not return
> TPM_RC_SUCCESS, tpm_chip_register misleadingly returns ENODEV, even though
> a TPM device is definitely present.
> 
> An error response during those sequences is indeed unexpected, so to
> prevent subsequent errors, the kernel should not make use of the TPM
> device. But user space applications still might be able to communicate with
> the TPM, so they can be used to further diagnose and/or fix the problem. To
> allow this, with this patch the device is still exported to user space,
> even if a TPM error code has been received, but the kernel itself will not
> be allowed to use the device for anything.
> 
> This is not a hypothetical scenario, but there are devices in the wild that
> show this behavior. With this fix, those devices can be recovered from
> their failed state.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Agree with Jason's comments.

For SGX code that I've been upstreaming to arch/x86 tree the feedback
was that local variable declarations should be in line length order,
which makes sense to me i.e. startup_succesful should be the first
declaration.

why you need that variable anyway, cannot you deduce it from rc?

/Jarkko
