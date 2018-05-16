Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16201 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeEPOKm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 May 2018 10:10:42 -0400
Date: Wed, 16 May 2018 17:10:35 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v4 1/2] tpm: reduce poll sleep time in tpm_transmit()
Message-ID: <20180516141035.GA10304@linux.intel.com>
References: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
 <20180516055125.5685-2-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516055125.5685-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 16, 2018 at 01:51:24AM -0400, Nayna Jain wrote:
> tpm_try_transmit currently checks TPM status every 5 msecs between
> send and recv. It does so in a loop for the maximum timeout as defined
> in the TPM Interface Specification. However, the TPM may return before
> 5 msecs. Thus the polling interval for each iteration can be reduced,
> which improves overall performance. This patch changes the polling sleep
> time from 5 msecs to 1 msec.
> 
> Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
> moves it to tpm.h as an enum value.
> 
> After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.
> 
> [1] All tests are performed on an x86 based, locked down, single purpose
> closed system. It has Infineon TPM 1.2 using LPC Bus.

Already applied previous version of this.

/Jarkko
