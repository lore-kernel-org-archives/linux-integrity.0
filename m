Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10587 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeAWNMI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jan 2018 08:12:08 -0500
Date: Tue, 23 Jan 2018 15:12:03 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        tpmdd-devel@lists.sourceforge.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: add longer timeouts for creation commands.
Message-ID: <20180123131203.bdhlqdqabhtwnipi@linux.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
 <20180123112731.3687-3-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123112731.3687-3-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 23, 2018 at 01:27:31PM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

>From where are these numbers are derived from?

Can you send 1/3 and 2/3 as a separate patch set with a cover
letter (with explanation) and this as a separate patch? This
is unrelated to first two changes albeit might make sense.

/Jarkko
