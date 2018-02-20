Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58824 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750799AbeBTOdh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Feb 2018 09:33:37 -0500
Message-ID: <1519137213.9433.10.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 20 Feb 2018 09:33:33 -0500
In-Reply-To: <1519136646.4113.13.camel@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518805037.4640.27.camel@HansenPartnership.com>
         <1518807576.4475.3.camel@HansenPartnership.com>
         <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
         <1518810337.4475.16.camel@HansenPartnership.com>
         <1519136646.4113.13.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-02-20 at 16:24 +0200, Jarkko Sakkinen wrote:
> On Fri, 2018-02-16 at 11:45 -0800, James Bottomley wrote:
> > 
> > tsscreateek -cp -alg ec -noflush
> 
> Can you describe in high-level what this command does? I will rather
> add a test to my smoke test suite than depend on TSS implementations
> for various reasons. This seems like a good test case to add as
> part of it.

It's basically doing a create primary on the endorsement seed for an
elliptic curve key.  However, it first tries to get the seed template
and unique data from the correct NV index, and if that doesn't work it
uses the data defined in:

https://trustedcomputinggroup.org/tcg-ek-credential-profile-tpm-family-2-0/

to build a template and uses that.

I think what's happening is my Nuvoton recognises the template and
tries its derivation shortcut which causes a BUG_ON in its
implementation because no EC keys or certificate was provisioned in
this TPM.

James
