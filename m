Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16170 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeDXQ17 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Apr 2018 12:27:59 -0400
Date: Tue, 24 Apr 2018 19:27:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v2 1/2] tpm: reduce poll sleep time in tpm_transmit()
Message-ID: <20180424162752.GC5119@linux.intel.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
 <20180417131246.434-2-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180417131246.434-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Apr 17, 2018 at 09:12:45AM -0400, Nayna Jain wrote:
> The TPM polling code in tpm_transmit sleeps in each loop iteration for
> 5 msecs. However, the TPM might return earlier, and thus waiting for
> 5 msecs adds an unnecessary delay. This patch reduces the polling sleep
> time in tpm_transmit() from 5 msecs to 1 msecs.

I'm not sure what TPM returning earlier has to do with this. TPM probably
never returns exactly in the spec defined timeout/duration. I just don't
understand reasoning in this paragraph.

> Additionally, this patch renames TPM_POLL_SLEEP and moves it to tpm.h as
> an enum value.
> 
> After this change, performance on a TPM 1.2 with an 8 byte burstcount
> for 1000 extends improved from ~14 sec to ~10.7 sec.

You cannot give absolute numbers without a context (platform, software).

> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

/Jarkko
