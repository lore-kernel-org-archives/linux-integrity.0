Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:56251 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIJXic (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Sep 2018 19:38:32 -0400
Date: Mon, 10 Sep 2018 21:42:44 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tpm: retrieve digest size of unknown algorithms
 from TPM
Message-ID: <20180910184244.GC20225@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905114202.7757-1-roberto.sassu@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 05, 2018 at 01:41:59PM +0200, Roberto Sassu wrote:
> The TPM driver currently relies on the crypto subsystem to determine the
> digest size of supported TPM algorithms. In the future, TPM vendors might
> implement new algorithms in their chips, and those algorithms might not
> be supported by the crypto subsystem.
> 
> Usually, vendors provide patches for the new hardware, and likely
> the crypto subsystem will be updated before the new algorithm is
> introduced. However, old kernels might be updated later, after patches
> are included in the mainline kernel. This would leave the opportunity
> for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> are not extended.
> 
> This patch set provides a long term solution for this issue. If a TPM
> algorithm is not known by the crypto subsystem, the TPM driver retrieves
> the digest size from the TPM with a PCR read. All the PCR banks are
> extended, even if the algorithm is not yet supported by the crypto
> subsystem.

I'm sorry. I missed this before checking through the mails. In future,
please add me either to to-field so that they arrive to my inbox and
do not get filtered to linux-integrity folder, which I go through with
time at most once a week.

/Jarkko
