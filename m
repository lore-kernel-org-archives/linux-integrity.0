Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:43663 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbdLFQk6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Dec 2017 11:40:58 -0500
Received: by mail-wm0-f50.google.com with SMTP id n138so8303382wmg.2
        for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2017 08:40:57 -0800 (PST)
Date: Wed, 6 Dec 2017 09:40:53 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Message-ID: <20171206164053.GA29584@ziepe.ca>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 06, 2017 at 01:34:35PM +0100, Paul Menzel wrote:

> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: A TPM error (2314) occurred
> continue selftest
> Dez 06 13:22:24 Ixpees kernel: tpm tpm0: TPM self test failed
> 
> Any idea what to do about those? If these are intentional, it'd be great to
> give some hint to the user, what effect this has.

The TPM driver shouldn't load if self test fails, and we don't expect
self test to ever fail.

So..
1) The TPM is busted? Assuming not since you probably used an
   earlier kernel?
2) The CRB driver is no longer executing command properly?
   My guess would be
     f5357413dbaa ("tpm/tpm_crb: Use start method value from ACPI table directly")
   Borked it.

   Maybe this TPM needed one of the workarounds and the
   restructuring broke it, or maybe it was working 'accidently' and
   got broke.
3) For some reason the core code is not handling commands correctly?
   Don't see any patches on that topic though.

Unless someone else has an idea, we may have to ask you to do a
bisection on this bug?

Jason
