Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5496 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755465AbeARRtG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 12:49:06 -0500
Date: Thu, 18 Jan 2018 19:49:01 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 3/9] tpm_tis_core: correctly wait for flags to
 become zero
Message-ID: <20180118174901.t2sxt6i2y43deumv@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-4-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-4-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:52PM +0100, Alexander Steffen wrote:
> According to TIS/PTP the dataAvail flag and the Expect flag in the STS
> register contain valid values if and only if the stsValid flag in the same
> register is set. Currently, the code first waits for the stsValid flag to

What is "the code"?

> be set and then looks at the other flags. This causes the STS register to
> be read twice, so that the stsValid flag might not be set anymore when the
> other flags are evaluated.

I can understand from this paragraph is that flags should be set atomically,
which makes sense.

> Other parts of the code already check both flags in a single operation
> within wait_for_tpm_stat. But the current implementation can only check for
> flags being set to 1, not 0. Therefore, add a parameter to
> wait_for_tpm_stat that allows to specify the expected value in addition to
> the selected flags and adapt all callers accordingly.

What are the "other parts of the code"?

> In addition, this now checks the dataAvail and Expect flags multiple times

What is "this"?

> within the specified timeout, so those flags no longer need to have the
> expected value right away. This is important for example when sending large
> amounts of data to the TPM, when the TPM might not process its I/O buffer
> fast enough for the flags to be set correctly when they are checked for the
> first time.

About the code change itself. Is there any play where you would not
bitwise or TPM_STS_VALID in mask and value parameters?

I guess I understand what you are doing but the commit message is
complete nonsense.

/Jarkko
