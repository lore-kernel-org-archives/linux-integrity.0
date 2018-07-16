Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42553 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeGPUpq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Jul 2018 16:45:46 -0400
Date: Mon, 16 Jul 2018 23:16:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
Message-ID: <20180716201634.GA15123@linux.intel.com>
References: <1531328689.3260.8.camel@HansenPartnership.com>
 <1531329074.3260.9.camel@HansenPartnership.com>
 <20180711182120.GF23935@ziepe.ca>
 <1531336133.3260.16.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531336133.3260.16.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 11, 2018 at 12:08:53PM -0700, James Bottomley wrote:
> Yes, I wondered about this, but I don't understand the bus protocol
> well enough.  The tpm-interface:tpm_try_transmit() which throws the
> first ETIME says after we get that we send chip->ops->cancel() which
> tpm_tis simply translates to tpm_tis_ready() which also times out.  Is
> there a bigger hammer I can hit it with?

tpm_tis_ready() gets called twice and it is unsynced (no wait). Maybe
this confuses the chip somehow?

/Jarkko
