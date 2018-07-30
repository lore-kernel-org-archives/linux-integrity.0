Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:41144 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbeG3SIH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jul 2018 14:08:07 -0400
Date: Tue, 31 Jul 2018 02:32:15 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd 4.19 updates
In-Reply-To: <20180728142835.GA13620@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1807310231560.24834@namei.org>
References: <20180728142130.GA13541@linux.intel.com> <20180728142835.GA13620@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 28 Jul 2018, Jarkko Sakkinen wrote:

> Hi James,
> 
> Sorry, I pressed send before writing anything. Here is the summary:
> 
> * Migrated away from PM runtime as explicit cmdReady/goIdle trasactions
>   for every command is a spec requirement. PM runtime adds only a layer of
>   complexity on our case.
> * tpm_tis drivers can now specify the hwrng quality.
> * TPM 2.0 code uses now tpm_buf for constructing messages. I think Tomas
>   Winkler has done the same for TPM 1.2. I'll start digging those
>   changes from the patchwork in the near future.
> * Bug fixes and clean ups.


Thanks, pulled to next-tpm and next-testing.


-- 
James Morris
<jmorris@namei.org>
