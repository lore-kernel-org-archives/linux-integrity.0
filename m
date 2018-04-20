Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:55573 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbeDTEsb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 00:48:31 -0400
Date: Fri, 20 Apr 2018 07:48:27 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
Message-ID: <20180420044827.GA2848@linux.intel.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
 <20180405101210.GA21636@linux.intel.com>
 <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
 <20180407103610.GA22542@linux.intel.com>
 <1523284198.16421.196.camel@linux.vnet.ibm.com>
 <d7989ecd5e2d6463636ba291128b525b89cb2521.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d7989ecd5e2d6463636ba291128b525b89cb2521.camel@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Apr 10, 2018 at 03:31:09PM +0300, Jarkko Sakkinen wrote:
> On Mon, 2018-04-09 at 10:29 -0400, Mimi Zohar wrote:
> > If this change is acceptable, do you want to make the change or should Nayna
> > repost the patch?
> 
> No need. I'll move on to testing.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
