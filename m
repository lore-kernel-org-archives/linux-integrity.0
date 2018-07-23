Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27112 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbeGWWlR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 18:41:17 -0400
Subject: Re: [PATCH] tpm: add support for partial reads
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
Date: Mon, 23 Jul 2018 14:38:08 -0700
MIME-Version: 1.0
In-Reply-To: <1532380412.4112.22.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 07/23/2018 02:13 PM, James Bottomley wrote:
> The current patch does, you even provided a use case in your last email
>  (it's do command to get sizing followed by do command with correctly
> sized buffer). 

The example I provided was: #1 send a command, #2 read the response header
(10 bytes), get the actual response size from the header and then #3 read
the full response (response size - size of the header bytes).

> 
> However, if you tie it to O_NONBLOCK, it won't because no-one currently
> opens the TPM device non blocking so it's an ABI conformant
> discriminator of the uses.  Tying to O_NONBLOCK should be simple
> because it's in file->f_flags.

I think that it might be an option. Especially that I have this on top of
the async patch. Let's discuss this when Jarkko is back.

Thanks,
-- 
Tadeusz
