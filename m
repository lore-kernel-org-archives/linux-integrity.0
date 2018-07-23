Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38584 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388133AbeGWWVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 18:21:48 -0400
Message-ID: <1532380412.4112.22.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Jul 2018 14:13:32 -0700
In-Reply-To: <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
         <20180723201956.GB26824@linux.intel.com>
         <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-07-23 at 13:53 -0700, Tadeusz Struk wrote:
> On 07/23/2018 01:19 PM, Jarkko Sakkinen wrote:
> > In this case I do not have any major evidence of any major benefit
> > *and* the change breaks the ABI.
> 
> As I said before - this does not break the ABI.

The current patch does, you even provided a use case in your last email
 (it's do command to get sizing followed by do command with correctly
sized buffer). 

However, if you tie it to O_NONBLOCK, it won't because no-one currently
opens the TPM device non blocking so it's an ABI conformant
discriminator of the uses.  Tying to O_NONBLOCK should be simple
because it's in file->f_flags.

James
